
using System;
using System.Collections.Generic;
using System.Xml.Linq;

namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    internal class XmlConfigReader
    {
        private static Dictionary<string, string> _configs;
        private static Dictionary<string, string> _panelRefs;

        public static void ReadConfigs(string pathToXml)
        {
            _configs = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            XDocument doc = XDocument.Load(pathToXml);
            XElement root = doc.Element("Configs");

            if (root == null)
                return;

            foreach (XElement element in root.Elements())
            {
                _configs[element.Name.LocalName] = element.Value;
            }
        }

        public static string GetStringValue(string key, string defaultValue = "")
        {
            if (_configs != null && _configs.TryGetValue(key, out string value))
            {
                return value;
            }
            return defaultValue;
        }

        public static bool GetBoolValue(string key, bool defaultValue = false)
        {
            if (_configs != null && _configs.TryGetValue(key, out string value))
            {
                if (bool.TryParse(value, out bool result))
                {
                    return result;
                }
            }
            return defaultValue;
        }

        public static int GetIntValue(string key, int defaultValue = 0)
        {
            if (_configs != null && _configs.TryGetValue(key, out string value))
            {
                if (int.TryParse(value, out int result))
                {
                    return result;
                }
            }
            return defaultValue;
        }

        public static double GetDoubleValue(string key, double defaultValue = 0.0)
        {
            if (_configs != null && _configs.TryGetValue(key, out string value))
            {
                if (double.TryParse(value, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out double result))
                {
                    return result;
                }
            }
            return defaultValue;
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
