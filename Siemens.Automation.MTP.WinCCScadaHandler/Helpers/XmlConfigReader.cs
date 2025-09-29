
using System.Collections.Generic;
using System.Xml.Linq;

namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    internal class XmlConfigReader
    {
        private static Dictionary<string, string> _panelRefs;

        public static void ReadConfigs(string pathToXml, ref string asciiPath, ref string userName, ref string password, ref bool useTypeInAddress)
        {
            XDocument doc = XDocument.Load(pathToXml);
            XElement root = doc.Element("Configs");

            asciiPath = root.Element("PathToASCIIExe")?.Value ?? "WCCOAascii";
            userName = root.Element("UserName")?.Value ?? "root";
            password = root.Element("Password")?.Value ?? "";
            string useType = root.Element("UseTypeInAddress")?.Value ?? "false";
            useTypeInAddress = bool.Parse(useType);
        }

        public static void FillDictionary(string pathToXml)
        {
            _panelRefs = new Dictionary<string, string>();
            XDocument doc = XDocument.Load(pathToXml);
            var types = doc.Descendants("Type");
            foreach (var type in types) 
            {
                var key = type.Attribute("type").Value;
                _panelRefs[key] = type.Value;
            }
        }

        public static string GetPanelRef(string panelName)
        {
            if (_panelRefs != null && _panelRefs.ContainsKey(panelName))
            {
                return _panelRefs[panelName];
            }

            return null;
        }
    }
}
