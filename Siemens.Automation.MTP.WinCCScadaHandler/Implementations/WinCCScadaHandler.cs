// ----------------------------------
// Copyright © Siemens 2024-2025
// All rights reserved. Confidential.
// ----------------------------------

using ModuleTypePackage.Contract;
using ModuleTypePackage.Contract.CommunicationSet;
using ModuleTypePackage.Contract.HmiSet;
using Siemens.Automation.MTP.HandlerContractor;
using Siemens.Automation.MTP.HandlerContractor.Enums;
using Siemens.Automation.MTP.ScadaBusinessLogic;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaHmiConnectionHandler;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpAttributes;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpAttributeTables;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpConfigurator;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpHandler;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpLocalizationHandler;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpMLTextBuilder;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpScreenItems;
using Siemens.Automation.MTP.ScadaBusinessLogic.StringValidator;
using Siemens.Automation.MTP.Services.Interface;
using Siemens.Automation.MTP.Settings.Settings.ImportSettings;
using Siemens.Automation.MTP.Settings.Settings.MTPSettings;
using Siemens.Automation.MTP.WinCCScadaHandler.Exceptions;
using Siemens.Automation.MTP.WinCCScadaHandler.Helpers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Xml;
using static System.Collections.Specialized.BitVector32;

namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    public class WinCCScadaHandler : IScadaMtpHandler, IScadaMtpLocalizationHandler, IProjectConfigHandler, IDeviceConfigHandler, IScadaPeaInventoryHandler, IScadaMtpPeaSymbolHandler
    {
        private readonly IMtpSettings m_MtpSettings;
        private readonly IIntegratorSettings m_ImportSettings;
        private readonly ILoggingService m_LoggingService;
        private IStringValidator stringValidator;
        private bool useTypeInAddress;
        private string configsPath = "";

        private static ScadaMtpLocalizationData localizedData = new ScadaMtpLocalizationData();

        const string MTP_GROUP_NAME = "@mtp";
        private readonly string projPath;
        private readonly string deviceName;

        private string opcServerName;

        private string asciiExePath;
        private string userName;
        private string password;

        public string panelPath = "";
        public int refID = 1;

        const string ALERT_HEADER =
                "ElementName\tTypeName\tDetailNr\t_alert_hdl.._type\t_alert_hdl.._l_limit\t_alert_hdl.._u_limit" +
                "\t_alert_hdl.._l_incl\t_alert_hdl.._u_incl\t_alert_hdl.._panel\t_alert_hdl.._panel_param\t_alert_hdl.._help\t_alert_hdl.._min_prio" +
                "\t_alert_hdl.._class\t_alert_hdl.._text\t_alert_hdl.._active\t_alert_hdl.._orig_hdl\t_alert_hdl.._ok_range\t_alert_hdl.._hyst_type" +
                "\t_alert_hdl.._hyst_time\t_alert_hdl.._multi_instance\t_alert_hdl.._l_hyst_limit\t_alert_hdl.._u_hyst_limit\t_alert_hdl.._text1\t_alert_hdl.._text0" +
                "\t_alert_hdl.._ack_has_prio\t_alert_hdl.._order\t_alert_hdl.._dp_pattern\t_alert_hdl.._dp_list\t_alert_hdl.._prio_pattern" +
                "\t_alert_hdl.._abbr_pattern\t_alert_hdl.._ack_deletes\t_alert_hdl.._non_ack\t_alert_hdl.._came_ack\t_alert_hdl.._pair_ack\t_alert_hdl.._both_ack" +
                "\t_alert_hdl.._impulse\t_alert_hdl.._filter_threshold\t_alert_hdl.._went_text\t_alert_hdl.._add_text\t_alert_hdl.._status64_pattern" +
                "\t_alert_hdl.._neg\t_alert_hdl.._status64_match\t_alert_hdl.._match\t_alert_hdl.._set";

        private static Dictionary<int, string> _alertPlaceHolders = new Dictionary<int, string>()
        {
            {0, "DPENAME"},
            {1, "TYPENAME"},
            {3, "ALERTTYPE"},
            {12, "ALERTCLASS"},
            {14, "1"},
            {15, "1"},
            {16, "0"},
            {22, "TEXT"}
        };

        /// <summary>
        /// WinCCUnifiedHandler Constructor
        /// </summary>
        /// <param name="projectPath">TIA Project path</param>
        /// <param name="deviceName">Device Name</param>
        /// <param name="mtpSettings">MTP Settings</param>
        /// <param name="importSettings">Import Settings</param>
        /// <param name="loggingServcie">Logging Service</param>
        /// <exception cref="ArgumentNullException"></exception>
        public WinCCScadaHandler(string projectPath, string deviceName, IMtpSettings mtpSettings, IIntegratorSettings importSettings, ILoggingService loggingService)
        {
            this.projPath = projectPath ?? throw new ArgumentNullException(nameof(projectPath));
            this.deviceName = deviceName ?? throw new ArgumentNullException(nameof(deviceName));
            this.m_MtpSettings = mtpSettings ?? throw new ArgumentNullException(nameof(mtpSettings));
            this.m_ImportSettings = importSettings ?? throw new ArgumentNullException(nameof(importSettings));
            this.m_LoggingService = loggingService ?? throw new ArgumentNullException(nameof(loggingService));

            string pathToXml;


            importSettings.AdditionalProperties.TryGetValue("WinCCOASettings", out pathToXml);
            configsPath = pathToXml ?? Path.Combine(projPath, "Data", "WinccOAMTPImporterConfgis.xml");
            XmlConfigReader.ReadConfigs(pathToXml, ref asciiExePath, ref userName, ref password, ref useTypeInAddress);

            importSettings.AdditionalProperties.TryGetValue("SupportedBlocksConfig", out pathToXml);
            pathToXml = pathToXml ?? Path.Combine(projPath, "Data", "Objects.xml");

            XmlConfigReader.FillDictionary(pathToXml);
        }

        public string BackendName => "WinCC OA Scada Handler";

        public IDeviceInformation DeviceInformation => new ScadaInformation(deviceName, m_LoggingService);

        public void ConnectScada(IOpcuaServerAssembly opcuaServerAssembly = null, bool validateConnection = true, HmiConnectType hmiConnectionTypeEnum = HmiConnectType.InstanceCreation) { }

        public void InitializeBackend() { }

        public void Create(IOpcuaServerAssembly opcuaServerAssembly, bool validateConnection = true)
        {
            opcServerName = opcuaServerAssembly.Name;
            OPCServer server = new OPCServer(opcuaServerAssembly, projPath, configsPath);

            if (opcuaServerAssembly is null)
            {
                throw new ArgumentNullException(nameof(opcuaServerAssembly));
            }

            try
            {
                CreateTagTableGroup();
                CreateScreenGroup(projPath, opcuaServerAssembly);
            }

            catch (Exception ex)
            {
                throw new InvalidOperationException("Unable to establish a connection to WinCC OA!", ex);
            }
        }

        public void Delete() { }

        public void DeleteMtpAttributeTables(IEnumerable<IScadaMtpAttributeTable> mtpAttributeTables)
        {
            string pathDpList = projPath + @"/dplist/Vorlage.AnaMon.ascii";
            using (StreamWriter writer = new StreamWriter(pathDpList))
            {
                writer.WriteLine("V 3");
                writer.WriteLine("Action\tElementName");
                foreach (var attributeTable in mtpAttributeTables)
                {
                    writer.WriteLine("D\t" + attributeTable.Name);
                }
                writer.WriteLine("I");
            }

            DpTypeHelper.ImportAscii(pathDpList, asciiExePath, userName, password);
        }

        public void DeleteMtpScreenItems(IEnumerable<IScadaMtpScreenItem> mtpScreenItems)
        {
            //how to get opcServerName here to replace the "1"?
            string mtpPanelsDirectory = projPath + "\\panels\\" + MTP_GROUP_NAME;
            string mtpPanelDirectory = mtpPanelsDirectory + "\\" + "1";

            try
            {
                if (Directory.Exists(mtpPanelDirectory))
                {
                    Directory.Delete(mtpPanelDirectory, true);
                }
            }
            catch (IOException ioExp)
            {
                Console.WriteLine(ioExp.Message);
            }
        }

        public void DisconnectScada() { }

        public void Dispose() => GC.SuppressFinalize(this);

        public void DisposeBackend() { }

        public void GenerateMtpAttributeTables(IEnumerable<IScadaMtpAttributeTable> mtpAttributeTables, bool configureAlarm = false, IEnumerable<IScadaMtpLocalizationTexts> mtpMultiLanguageTexts = null)
        {
            var alertTemplate = string.Join("\t", Enumerable.Range(0, 45).Select(i => _alertPlaceHolders.ContainsKey(i) ? _alertPlaceHolders[i] : string.Empty));

            var alertEntries = new List<string> { ALERT_HEADER };
            var usedDpe = new HashSet<string>(StringComparer.Ordinal);

            var procedureNames = new HashSet<string>(StringComparer.Ordinal);
            var parameterNames = new HashSet<string>(StringComparer.Ordinal);
            foreach (var t in mtpAttributeTables)
            {
                var dt = t.RefBaseSystemUnitPath.Elements.LastOrDefault();
                if (string.Equals(dt, "ProcedureHealthView", StringComparison.Ordinal))
                    procedureNames.Add(t.Name);
                if (dt.Contains("ServParam"))
                    parameterNames.Add(t.Name);
            }

            var allTables = new List<TableSections>();

            foreach (var attributeTable in mtpAttributeTables)
            {
                var dpType = attributeTable.RefBaseSystemUnitPath.Elements.LastOrDefault();
                if (!DpTypeHelper.CheckIfTypeRegistered(dpType))
                {
                    m_LoggingService.LogError("Unsupported type: " + dpType, new Exception("Usupported type " + dpType));
                    continue;
                }

                var sections = new TableSections(attributeTable.Name, dpType);

                var presentDpes = new HashSet<string>(StringComparer.Ordinal);
                var dpLinks = new List<string>(); // links for THIS table
                var parameters = new List<string>();
                string lastAddressPattern = string.Empty;
                string lastEditablePart = string.Empty;

                foreach (var attribute in attributeTable.GetAllAttributes())
                {
                    if (!string.IsNullOrEmpty(attribute.Name) && attribute.Name.IndexOf("DaAsObj", StringComparison.Ordinal) >= 0)
                        continue;

                    var linked = attribute as ScadaMtpLinkedObject;

                    if (linked != null && procedureNames.Contains(linked.TagPrefix))
                    {
                        dpLinks.Add(linked.TagPrefix);
                    }
                    if (linked != null && parameterNames.Contains(linked.TagPrefix))
                    {
                        parameters.Add(linked.TagPrefix);
                    }

                    var eqIdx = attribute.Name.IndexOf('=');
                    if (eqIdx < 0) continue;
                    var sAttribute = attribute.Name.Substring(eqIdx + 1);

                    presentDpes.Add(sAttribute);

                    var elementName = attributeTable.Name + "." + sAttribute;

                    if (configureAlarm &&
                        !usedDpe.Contains(elementName) &&
                        DpTypeHelper.TryGetAlertClass(dpType, sAttribute, out string alertClass))
                    {
                        var alertRow = alertTemplate
                            .Replace("DPENAME", elementName)
                            .Replace("TYPENAME", dpType)
                            .Replace("ALERTTYPE", "12")
                            .Replace("ALERTCLASS", alertClass)
                            .Replace("TEXT", elementName);
                        usedDpe.Add(elementName);
                        alertEntries.Add(alertRow);
                    }

                    sections.Originals.Add(elementName + "\t" + dpType + "\t" + (Convert.ToString(attribute.InitialValue) ?? string.Empty));
                    if (DpTypeHelper.DPESWithoutAddress.Contains(dpType + "." + sAttribute)) continue;

                    sections.Distrib.Add(elementName + "\t" + dpType + "\t56");

                    var access = string.Equals(attribute.Access, "Read", StringComparison.OrdinalIgnoreCase) ? "\\4" : "\\7";
                    var dpAddress = (attribute.NameSpace ?? string.Empty).Replace("\"", "\\\"");

                    /*This part was for work with WinCC OA as server*/
                    
                    //var dpAddress = Regex.Replace((attribute.NameSpace ?? string.Empty).Replace("\"", ""), @"\bns=[^;]+(?=;s=)", "ns=2", RegexOptions.IgnoreCase);
                    dpAddress = dpAddress.Replace("ns=3", "ns=2");

                    lastAddressPattern = dpAddress;
                    lastEditablePart = sAttribute;

                    var addrRef = "\"" + opcServerName + "$$1$1$" + dpAddress + "\"";

                    var transformation = AddressHelper.GetTransformationType(dpType, sAttribute);

                    addrRef = (useTypeInAddress) ? AddressHelper.AdaptAdderess(addrRef, dpType) : addrRef;
                    sections.Address.Add(elementName + "\t" + dpType + "\t16\t" + addrRef + "\t" + access + $"\t_5s\t1\t{transformation}\tOPCUA");
                }

                if (DpTypeHelper.ExistingElements.TryGetValue(dpType, out var typeDpes))
                {
                    foreach (var dpe in typeDpes.Where(d => !presentDpes.Contains(d)))
                    {
                        var elementName = attributeTable.Name + "." + dpe;

                        if (configureAlarm &&
                            !usedDpe.Contains(elementName) &&
                            DpTypeHelper.TryGetAlertClass(dpType, dpe, out string alertClass2))
                        {
                            var alertRow = alertTemplate
                                .Replace("DPENAME", elementName)
                                .Replace("TYPENAME", dpType)
                                .Replace("ALERTTYPE", "12")
                                .Replace("ALERTCLASS", alertClass2)
                                .Replace("TEXT", elementName);
                            usedDpe.Add(elementName);
                            alertEntries.Add(alertRow);
                        }

                        if (dpe == "procedures")
                        {
                            HashSet<string> idSet;
                            var originalValue = (DpTypeHelper.DPIDS.TryGetValue(dpType, out idSet) && idSet.Contains(dpe))
                                ? string.Join(",", dpLinks)
                                : string.Empty;
                            sections.Originals.Add(elementName + "\t" + dpType + "\t" + originalValue);
                        }

                        if (dpe == "parameters" || dpe == "configParameters")
                        {
                            HashSet<string> idSet;
                            var originalValue = (DpTypeHelper.DPIDS.TryGetValue(dpType, out idSet) && idSet.Contains(dpe))
                                ? string.Join(",", parameters)
                                : string.Empty;
                            sections.Originals.Add(elementName + "\t" + dpType + "\t" + originalValue);
                        }

                        if (dpe == "tagName")
                        {
                            string tmp = attributeTable.Name.Split('|').LastOrDefault().Replace("_",".");
                            var originalValue = LocalizationHelper.GetLocalizedString(tmp);
                            sections.Originals.Add(elementName + "\t" + dpType + "\t" + originalValue);
                        }

                        if(dpe == "Name")
                        {
                            string tmp = (attributeTable.GetAllAttributes().Last() as ScadaMtpDataAssembly).TagName;
                            var originalValue = LocalizationHelper.GetLocalizedName(tmp) ?? LocalizationHelper.GetLocalizedString(tmp);
                            sections.Originals.Add(elementName + "\t" + dpType + "\t" + originalValue);
                        }

                        if (DpTypeHelper.DPESWithoutAddress.Contains(dpType + "." + dpe)) continue;

                        sections.Distrib.Add(elementName + "\t" + dpType + "\t56");


                        string substituted = (string.IsNullOrEmpty(lastAddressPattern) || string.IsNullOrEmpty(lastEditablePart))
                            ? string.Empty
                            : lastAddressPattern.Replace($"\\\"mtpData\\\".\\\"{lastEditablePart}\\\"", $"\\\"{dpe}\\\"");

                        /*This part was for work with WinCC OA as server*/
                        
                        /*string substituted = (string.IsNullOrEmpty(lastAddressPattern) || string.IsNullOrEmpty(lastEditablePart))
                           ? string.Empty
                           : lastAddressPattern.Replace($"mtpData.{lastEditablePart}", $"{dpe}");*/
                        

                        var addrRef2 = "\"" + opcServerName + "$$1$1$" + substituted + "\"";
                        sections.Address.Add(elementName + "\t" + dpType + "\t16\t" + addrRef2 + "\t\\4\t_5s\t1\t750\tOPCUA");
                    }
                }

                allTables.Add(sections);
            }

            CreateAndImportASCII(allTables, alertEntries, configureAlarm);
        }

        public void GenerateMtpScreenItems(IPackageInformationObject packageInformation, IEnumerable<IScadaMtpScreenInfo> mtpScreenItems,
            IEnumerable<IScadaMtpAttributeTable> attributeTables, SymbolType symbolType, bool IsMigrateProject)
        {
            _ = packageInformation ?? throw new ArgumentNullException(nameof(packageInformation));
            _ = mtpScreenItems ?? throw new ArgumentNullException(nameof(mtpScreenItems));
            _ = attributeTables ?? throw new ArgumentNullException(nameof(attributeTables));

            try
            {
                foreach (var screen in mtpScreenItems)
                {
                    //panelPath += "\\" + screen.Name.Replace("|", "_") + ".xml";
                    string panelName = panelPath + "\\" + screen.Name.Replace("|", "_") + ".xml";
                    //How to get screen Size?

                    if (!File.Exists(panelName))
                    {
                        Panel panel = new Panel(panelName, screen.Name);
                    }
                    CreateScreenPictures(packageInformation.PeaInformation.DefaultValue, attributeTables, m_LoggingService, screen, panelName);
                }
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("Error occured while generating WinCC OA Panel!", ex);
            }

            return;
        }

        public List<string> GetAvailableConnectionNames()
        {
            return new List<string>();
        }

        public SymbolType GetSymbolType()
        {
            return SymbolType.NotSet;
        }

        public IStringValidator InitializeStringValidator()
        {
            try
            {
                if (stringValidator == null)
                {
                    stringValidator = new StringValidator.StringValidator(new WinCCStringRuleSet());
                }
                return stringValidator;
            }
            catch (WinCCScadaBackendHandlerException wccubhex)
            {
                throw new NullReferenceException();
            }
        }

        public bool IsBackendWithUI() => false;

        public bool IsDeviceMtpSupported(string deviceName = "") => true;

        public bool IsSessionActive() => true;


        public void RegisterAssemblyResolver() { }

        public void SaveProject(string operation) { }

        public void SwitchBackendUIMode() { }

        public void ImportLocalizationData(IPackageInformationObject packageInformationObject, ScadaMtpLocalizationData scadaMtpLocalizationData)
        {
            LocalizationHelper.AddLocalizedStrings(scadaMtpLocalizationData.ScadaMtpMultiLanguageTexts);
            LocalizationHelper.AddLocalizedStrings(scadaMtpLocalizationData.ScadaMtpProcedureList);

            var t = LocalizationHelper._localizationCache;

            var t2 = LocalizationHelper.firstTextNames;

            localizedData = scadaMtpLocalizationData;
        }

        public void RemoveLocalizationData(InstanceDeletedEventArgs eventArgs)
        {
            return;
        }

        public void DoProjectConfiguration()
        {
            return;
        }

        public void UndoProjectConfiguration()
        {
            return;
        }

        public void ConfigureDevice()
        {
            return;
        }

        public void UndoDeviceConfiguration()
        {
            return;
        }

        public void AddInstanceToPeaInventory(string instanceName, uint instanceIndex)
        {
            return;
        }

        public void RemoveInstanceFromPeaInventory(uint instanceIndex)
        {
            return;
        }

        public void AddPeavalidationSymbol(IEnumerable<IScadaMtpAttributeTable> attributeTable)
        {
            return;
        }

        public void RemovePeavalidationSymbol()
        {
            return;
        }

        private void CreateAndImportASCII(List<TableSections> allTables, List<string> alertEntries, bool configureAlarm)
        {
            var pathDp = Path.Combine(projPath, "dplist", "dp.txt");

            var alertDpPath = Path.Combine(projPath, "dplist", "alerts.txt");
            var dir = Path.GetDirectoryName(pathDp);
            if (!string.IsNullOrEmpty(dir)) Directory.CreateDirectory(dir);

            var lines = new List<string>(8192);

            foreach (var t in allTables)
            {
                lines.Add("DpName\tTypeName\tID");
                lines.Add(t.TableName + "\t" + t.DpType);
                lines.Add(string.Empty);

                lines.Add("ElementName\tTypeName\t_original.._value");
                lines.AddRange(t.Originals);
                lines.Add(string.Empty);
            }
            File.WriteAllLines(pathDp, lines);

            foreach (var t in allTables)
            {
                lines.Add("ElementName\tTypeName\t_distrib.._type\t_distrib.._driver");
                lines.AddRange(t.Distrib);
                lines.Add(string.Empty);
            }
            File.WriteAllLines(pathDp, lines);

            foreach (var t in allTables)
            {
                lines.Add("ElementName\tTypeName\t_address.._type\t_address.._reference\t_address.._direction\t_address.._poll_group\t_address.._active\t_address.._datatype\t_address.._drv_ident");
                lines.AddRange(t.Address);
            }
            File.WriteAllLines(pathDp, lines);

            DpTypeHelper.ImportAscii(pathDp, asciiExePath, userName, password);

            if (configureAlarm && alertEntries.Count > 1)
            {
                var dir2 = Path.GetDirectoryName(alertDpPath);
                if (!string.IsNullOrEmpty(dir2)) Directory.CreateDirectory(dir2);

                File.WriteAllLines(alertDpPath, alertEntries);
                DpTypeHelper.ImportAscii(alertDpPath, asciiExePath, userName, password);
            }
        }

        private void CreateTagTableGroup()
        {
            string pathDpList = projPath + @"/dplist/dpDyn.txt";

            string pathToXml;
            m_ImportSettings.AdditionalProperties.TryGetValue("DataStructure", out pathToXml);
            pathToXml = pathToXml ?? Path.Combine(projPath, "Data", "DataStructureMTP.xml");

            var dpTypeGenerator = new DpTypeHelper();
            dpTypeGenerator.GenarateASCII(pathToXml, pathDpList);

            DpTypeHelper.ImportAscii(pathDpList, asciiExePath, userName, password);
        }

        // Helper: holds per-table sections for assembly
        private sealed class TableSections
        {
            public readonly string TableName;
            public readonly string DpType;
            public readonly List<string> Originals = new List<string>(256);
            public readonly List<string> Distrib = new List<string>(256);
            public readonly List<string> Address = new List<string>(512);

            public TableSections(string tableName, string dpType)
            {
                TableName = tableName;
                DpType = dpType;
            }
        }

        private void CreateScreenGroup(string projPath, IBaseObject opcuaServerAssembly)
        {
            string path = projPath + @"\panels\" + MTP_GROUP_NAME;
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            path += @"\" + opcuaServerAssembly.Name;

            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            panelPath = path;
        }

        private void CreateScreenPictures(string peaPrefix, 
            IEnumerable<IScadaMtpAttributeTable> allDataAssemblies, 
            ILoggingService loggingService, 
            IScadaMtpScreenItem screen,
            string panelPath)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(panelPath);

            foreach (var picture in screen.GetAllPictureItems())
            {
                bool shapeExists = doc.SelectNodes("//shape[@Name='" + picture.Name + "']").Count != 0;
                bool referenceExists = doc.SelectNodes("//reference[@Name='" + picture.Name + "']").Count != 0;
                if (!shapeExists && !referenceExists)
                {
                    CreateGraphicObject(peaPrefix, allDataAssemblies, loggingService, picture, panelPath);
                }
                refID++;
            }
        }

        private void CreateGraphicObject(string peaPrefix, 
            IEnumerable<IScadaMtpAttributeTable> allDataAssemblies,
            ILoggingService loggingService, 
            IPictureItem picture,
            string panelPath)
        {
            switch (picture)
            {
                case VisualObject visObj:
                    VisualObjectHandler visualObjectHandler = new VisualObjectHandler(visObj, allDataAssemblies, refID, panelPath);

                    break;
                case MeasurementLine ml:
                    ConnectionHandler measurementLine = new ConnectionHandler(ml, panelPath);

                    break;
                case Pipe pipe:
                    ConnectionHandler pipeLine = new ConnectionHandler(pipe, panelPath);

                    break;
                case FunctionLine fcLine:
                    ConnectionHandler functionLine = new ConnectionHandler(fcLine, panelPath);

                    break;
            }
        }
    }
}
