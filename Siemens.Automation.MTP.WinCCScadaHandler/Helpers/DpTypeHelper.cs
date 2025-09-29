using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Xml.Linq;

namespace Siemens.Automation.MTP.WinCCScadaHandler.Helpers
{
    internal class DpTypeHelper
    {
        private static Dictionary<string, int> _mapDataType = new Dictionary<string, int>
        {
            { "struct", 1 },
            { "Uint", 20 },
            { "int", 21 },
            { "float", 22 },
            { "bool", 23 },
            { "bit32", 24},
            { "string", 25 },
            { "dyn_dpid_str", 38 },
            { "dyn_dpid", 29 },
            { "langString",  42 },
            { "long", 54 }
        };

        public static HashSet<string> _registeredTypes = new HashSet<string>();

        private static Dictionary<string, Dictionary<string, string>> _alerts = new Dictionary<string, Dictionary<string, string>>();

        public static Dictionary<string, HashSet<string>> ExistingElements = new Dictionary<string, HashSet<string>>();

        public static Dictionary<string, HashSet<string>> DPIDS = new Dictionary<string, HashSet<string>>();

        public static HashSet<string> DPESWithoutAddress = new HashSet<string>();

        public static Dictionary<string, Dictionary<string, string>> _dpTypeStructure = new Dictionary<string, Dictionary<string, string>>();

        //TODO: separate the method
        public void GenarateASCII(string pathToXml, string outputPath)
        {
            XDocument doc = XDocument.Load(pathToXml);
            var types = doc.Descendants("Type");

            FillDpTypeStructure(types);

            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.AppendLine("# DpType");
            foreach (var type in types)
            {
                stringBuilder.AppendLine("TypeName");
                string typeName = type.Attribute("typeName").Value;
                stringBuilder.AppendLine($"{typeName}.{typeName}\t{_mapDataType["struct"]}#1");

                _registeredTypes.Add(typeName);
                if (!_alerts.ContainsKey(typeName))
                {
                    _alerts.Add(typeName, new Dictionary<string, string>());
                    ExistingElements.Add(typeName, new HashSet<string>());
                    DPIDS.Add(typeName, new HashSet<string>());
                }

                var elemnts = type.Element("Elements");
                foreach (var elem in elemnts?.Elements("Element"))
                {
                    try
                    {
                        string elementName = elem.Value;
                        var dpeType = elem.Attribute("type").Value;
                        stringBuilder.AppendLine($"\t{elem.Value}\t{_mapDataType[dpeType]}");
                        ExistingElements[typeName].Add(elementName);
                        if (dpeType == "dyn_dpid_str" || dpeType == "dyn_dpid")
                        {
                            DPIDS[typeName].Add(elementName);
                        }
                        if (dpeType == "dyn_dpid_str" || dpeType == "dyn_dpid" || dpeType == "langString")
                        {
                            DPESWithoutAddress.Add($"{typeName}.{elementName}");
                        }
                    }
                    catch
                    {
                        throw new System.Exception($"{elem.Attribute("type").Value} not found ");
                    }

                    string ac = elem.Attribute("AC")?.Value;
                    if (ac != null)
                    {
                        if (!_alerts[typeName].ContainsKey(elem.Value))
                            _alerts[typeName].Add(elem.Value, ac);
                    }
                }

                stringBuilder.AppendLine("");
            }

            var res = stringBuilder.ToString();

            File.WriteAllText(outputPath, res, Encoding.UTF8);
        }

        public static bool CheckIfTypeRegistered(string type) => _registeredTypes.Contains(type);

        public static bool TryGetAlertClass(string type, string element, out string alertClass)
        {
            alertClass = null;
            if (!_alerts.ContainsKey(type) || !_alerts[type].ContainsKey(element))
            {
                return false;
            }
            alertClass = _alerts[type][element];
            return true;
        }

        public static string GetDpeType(string typeName, string elementName)
        {
            if (_dpTypeStructure.ContainsKey(typeName) && _dpTypeStructure[typeName].ContainsKey(elementName))
            {
                return _dpTypeStructure[typeName][elementName];
            }
            return null;
        }

        public static void ImportAscii(string path, string asciiExePath, string userName, string password)
        {
            ProcessStartInfo ProcessInfo = new ProcessStartInfo("cmd.exe", $"/c {asciiExePath} -currentproj -in {path} -user {userName}:{password}");
            ProcessInfo.CreateNoWindow = true;
            ProcessInfo.UseShellExecute = true;
            ProcessInfo.WindowStyle = ProcessWindowStyle.Hidden;
            Process Process = Process.Start(ProcessInfo);
            Process.WaitForExit();
        }

        private static void FillDpTypeStructure(IEnumerable<XElement> types)
        {
            foreach (var type in types)
            {
                string typeName = type.Attribute("typeName").Value;
                if (!_dpTypeStructure.ContainsKey(typeName))
                {
                    _dpTypeStructure.Add(typeName, new Dictionary<string, string>());
                }
                var elemnts = type.Element("Elements");
                foreach (var elem in elemnts?.Elements("Element"))
                {
                    try
                    {
                        string elementName = elem.Value;
                        var dpeType = elem.Attribute("type").Value;
                        if (_dpTypeStructure.ContainsKey(elementName))
                        {
                            _dpTypeStructure[typeName].Add(elementName, dpeType);
                        }
                        else
                        {
                            _dpTypeStructure[typeName][elementName] =  dpeType;
                        }

                    }
                    catch
                    {
                        throw new System.Exception($"{elem.Attribute("type").Value} not found ");
                    }
                }
            }
        }
    }
}
