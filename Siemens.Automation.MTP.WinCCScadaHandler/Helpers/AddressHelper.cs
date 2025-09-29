using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Siemens.Automation.MTP.WinCCScadaHandler.Helpers
{
    internal class AddressHelper
    {
        static Dictionary<string, int> _tranformations = new Dictionary<string, int>
        {
            { "None", 750 },
            { "BOOLEAN", 751 },
            { "SBYTE", 752 },
            { "BYTE", 753 },
            { "INT16", 754 },
            { "UINT16", 755 },
            { "INT32", 756 },
            { "UINT32", 757 },
            { "INT64", 758 },
            { "UINT64", 759 },
            { "FLOAT", 760 },
            { "DOUBLE", 761 },
            { "STRING", 762 },
            { "DATETIME", 763 },
            { "GUID", 764 },
            { "BYTE_STRING", 765 },
            { "XMLELEMENT", 766 },
            { "NODEID", 767 },
            { "LOCALIZEDTEXT", 768 }
        };

        public static int GetTransformationType(string dpType, string element)
        {
            var variableType = DpTypeHelper.GetDpeType(dpType, element);
            var tmp = DpTypeHelper._dpTypeStructure;
            if (string.IsNullOrEmpty(variableType))
            {
                return 750; // Default None
            }
            if (_tranformations.ContainsKey(variableType.ToUpper()))
            {
                return _tranformations[variableType.ToUpper()];
            }

            return 750;
        }

        public static string AdaptAdderess(string address, string dptype)
        {
            if (string.IsNullOrEmpty(address) || string.IsNullOrEmpty(dptype))
                return address;

            // 1) Escaped quotes: ;s=\"A\".\"B\".\"C\" -> append to B
            const string escapedPattern = @"(;s=\\""[^\\\""]+\\""\\.\\"")([^\\\""]+)(\\\"")";
            string updated = Regex.Replace(
                address,
                escapedPattern,
                m => m.Groups[1].Value + m.Groups[2].Value + dptype + m.Groups[3].Value,
                RegexOptions.CultureInvariant
            );
            if (updated != address) return updated;

            // 2) Real quotes: ;s="A"."B"."C" -> append to B
            const string plainPattern = @"(;s=""[^""]+""\."")([^""]+)("")";
            updated = Regex.Replace(
                address,
                plainPattern,
                m => m.Groups[1].Value + m.Groups[2].Value + dptype + m.Groups[3].Value,
                RegexOptions.CultureInvariant
            );
            if (updated != address) return updated;

            // 3) Fallback manual parse (supports both styles)
            int s = address.IndexOf(";s=", StringComparison.Ordinal);
            if (s < 0) return address;
            int i = s + 3; // after ";s="

            // Heuristic: if we see \" soon after ;s=, treat it as escaped form
            bool looksEscaped = address.IndexOf("\\\"", i, StringComparison.Ordinal) >= 0;

            if (looksEscaped)
            {
                // segment #1 open
                int a1 = address.IndexOf("\\\"", i, StringComparison.Ordinal);
                if (a1 < 0) return address;
                // segment #1 close
                int b1 = address.IndexOf("\\\"", a1 + 2, StringComparison.Ordinal);
                if (b1 < 0) return address;
                // segment #2 open
                int a2 = address.IndexOf("\\\"", b1 + 2, StringComparison.Ordinal);
                if (a2 < 0) return address;
                // segment #2 close
                int b2 = address.IndexOf("\\\"", a2 + 2, StringComparison.Ordinal);
                if (b2 < 0) return address;

                // Insert before the closing \" of segment #2
                return address.Substring(0, b2) + dptype + address.Substring(b2);
            }
            else
            {
                // Real-quote form
                int a1 = address.IndexOf('"', i);
                if (a1 < 0) return address;
                int b1 = address.IndexOf('"', a1 + 1);
                if (b1 < 0) return address;
                int a2 = address.IndexOf('"', b1 + 1);
                if (a2 < 0) return address;
                int b2 = address.IndexOf('"', a2 + 1);
                if (b2 < 0) return address;

                return address.Substring(0, b2) + dptype + address.Substring(b2);
            }
        }
    }
}
