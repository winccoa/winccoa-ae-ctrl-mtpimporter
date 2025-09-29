﻿using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpMLTextBuilder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Siemens.Automation.MTP.WinCCScadaHandler.Helpers
{
    internal class LocalizationHelper
    {
        public static readonly Dictionary<Guid, string> _localizationCache = new Dictionary<Guid, string>();

        public static readonly Dictionary<string, Guid> firstTextNames = new Dictionary<string, Guid>();

        public static readonly Dictionary<string, Guid> lastTextNames = new Dictionary<string, Guid>();

        public static readonly Dictionary<string, string> _names = new Dictionary<string, string>();

        public static string GetLocalizedString(string key)
        {
            var id = firstTextNames.TryGetValue(key, out var firstId) ? firstId :
                     lastTextNames.TryGetValue(key, out var lastId) ? lastId :
                     Guid.Empty;
            _localizationCache.TryGetValue(id, out var res);
            return res;
        }

        public static void AddLocalizedStrings(IEnumerable<IScadaMtpLocalizationList> texts)
        {
            foreach (var text in texts)
            {
                var keys =  text.MultiLanguageText.Keys;
                List<string> values = new List<string>();
                values.Add($"lt:{keys.Count()}");
                string keyForDict = text.DefaultValue;
                foreach (var key in keys)
                {
                    var value = text.MultiLanguageText[key];
                    var k = key.Value.Replace('-', '_');

                    if (!OaLanguageMap.ContainsKey(k))
                    {
                        continue;
                    }
                    var tmp = OaLanguageMap[k];
                    values.Add($"LANG:{OaLanguageMap[k].ToString()} \"{value}\"");
                }

                var fullValue = string.Join(" ", values);

                if(!_names.ContainsKey(keyForDict))
                {
                    _names.Add(keyForDict, fullValue);
                }
                else
                {
                    _names[keyForDict] = fullValue;
                }
            }
        }

        public static string GetLocalizedName(string key)
        {
            _names.TryGetValue(key, out var res);
            return res;
        }

        public static void AddLocalizedStrings(IEnumerable<IScadaMtpLocalizationTexts> texts)
        {
            foreach (var text in texts)
            {
                var keys = text.TagName.Keys;
                List<string> values = new List<string>();
                values.Add($"lt:{keys.Count()}");
                var id = Guid.NewGuid();

                var firstValue = text.TagName?.FirstOrDefault().Value ?? string.Empty;
                bool newEntry = false;
                if (!string.IsNullOrEmpty(firstValue))
                {
                    if (!firstTextNames.ContainsKey(firstValue))
                    {
                        firstTextNames.Add(firstValue, id);
                        newEntry = true;
                    }
                }

                var lastValue = text.TagName?.LastOrDefault().Value ?? string.Empty;
                if (!string.IsNullOrEmpty(lastValue))
                {
                    if(!lastTextNames.ContainsKey(lastValue))
                    {
                        lastTextNames.Add(lastValue, id);
                        newEntry = true;    
                    }
                }

                foreach (var key in keys)
                {
                    var value = text.TagName[key];
                    var k = key.Value.Replace('-','_');
                    
                    if (!OaLanguageMap.ContainsKey(k))
                    {
                        newEntry = false;
                        continue;
                    }
                    newEntry = true;
                    var tmp = OaLanguageMap[k];
                    values.Add($"LANG:{OaLanguageMap[k].ToString()} \"{value}\"");
                }

                var fullValue = string.Join(" ", values);

                if(newEntry)
                {
                    _localizationCache.Add(id, fullValue);
                }
            }
        }

        static Dictionary<string, int> OaLanguageMap = new Dictionary<string, int>
        {
            { "undefined", 65534 },
            { "de_AT_iso88591", 0 },
            { "en_US_iso88591", 1 },
            { "hu_HU_iso88592", 2 },
            { "jp_JP_euc", 3 },
            { "zh_CN_gb2312", 4 },
            { "en_GB_iso88591", 5 },
            { "nl_NL_iso88591", 6 },
            { "tr_TR_iso88599", 7 },
            { "it_IT_iso88591", 8 },
            { "fr_FR_iso88591", 9 },
            { "es_ES_iso88591", 10 },
            { "de_DE_iso88591", 11 },
            { "el_GR_iso88597", 12 },
            { "iw_IL_iso88598", 13 },
            { "fr_CA_iso88591", 14 },
            { "da_DK_iso88591", 15 },
            { "fi_FI_iso88591", 16 },
            { "no_NO_iso88591", 17 },
            { "pt_PT_iso88591", 18 },
            { "sv_SE_iso88591", 19 },
            { "is_IS_iso88591", 20 },
            { "cs_CZ_iso88592", 21 },
            { "pl_PL_iso88592", 22 },
            { "ro_RO_iso88592", 23 },
            { "hr_HR_iso88592", 24 },
            { "sk_SK_iso88592", 25 },
            { "sl_SI_iso88592", 26 },
            { "ru_RU_iso88595", 27 },
            { "bg_BG_iso88595", 28 },
            { "ar_SA_iso88596", 29 },
            { "zh_TW_big5", 30 },
            { "ko_KR_CP949", 31 },
            { "ja_JP_sjis", 32 },
            { "th_TH_CP874", 33 },
            { "de_CH_iso88591", 34 },
            { "fr_CH_iso88591", 35 },
            { "it_CH_iso88591", 36 },
            { "fa_IR", 37 },
            { "vi_VN_tcvn", 38 },
            { "id_ID_iso88591", 39 },
            { "lt_LT_iso885913", 40 },
            { "posix", 254 },
            { "meta_iso88591", 255 },
            { "neutral_iso88591", 65535 },
            { "de_AT", 10000 },
            { "en_US", 10001 },
            { "hu_HU", 10002 },
            { "jp_JP", 10003 },
            { "zh_CN", 10004 },
            { "en_GB", 10005 },
            { "nl_NL", 10006 },
            { "tr_TR", 10007 },
            { "it_IT", 10008 },
            { "fr_FR", 10009 },
            { "es_ES", 10010 },
            { "de_DE", 10011 },
            { "el_GR", 10012 },
            { "iw_IL", 10013 },
            { "fr_CA", 10014 },
            { "da_DK", 10015 },
            { "fi_FI", 10016 },
            { "no_NO", 10017 },
            { "pt_PT", 10018 },
            { "sv_SE", 10019 },
            { "is_IS", 10020 },
            { "cs_CZ", 10021 },
            { "pl_PL", 10022 },
            { "ro_RO", 10023 },
            { "hr_HR", 10024 },
            { "sk_SK", 10025 },
            { "sl_SI", 10026 },
            { "ru_RU", 10027 },
            { "bg_BG", 10028 },
            { "ar_SA", 10029 },
            { "zh_TW", 10030 },
            { "ko_KR", 10031 },
            { "ja_JP", 10032 },
            { "th_TH", 10033 },
            { "de_CH", 10034 },
            { "fr_CH", 10035 },
            { "it_CH", 10036 },
            { "vi_VN", 10038 },
            { "id_ID", 10039 },
            { "lt_LT", 10040 },
            { "ka_GE", 10041 },
            { "ms_MY", 10042 },
            { "sr_SR", 10043 },
            { "pt_BR", 10044 },
            { "es_AR", 10045 },
            { "es_BO", 10046 },
            { "es_CL", 10047 },
            { "es_CO", 10048 },
            { "es_CR", 10049 },
            { "es_CU", 10050 },
            { "es_DO", 10051 },
            { "es_EC", 10052 },
            { "es_GT", 10053 },
            { "es_HN", 10054 },
            { "es_MX", 10055 },
            { "es_NI", 10056 },
            { "es_PA", 10057 },
            { "es_PE", 10058 },
            { "es_PR", 10059 },
            { "es_PY", 10060 },
            { "es_SV", 10061 },
            { "es_UY", 10062 },
            { "es_VE", 10063 },
            { "my_MM", 10064 },
            { "km_KH", 10065 },
            { "uk_UA", 10066 },
            { "sq_AL", 10067 },
            { "mk_MK", 10068 },
            { "lv_LV", 10069 },
            { "kn_IN", 10070 },
            { "hi_IN", 10071 },
            { "af_ZA", 10072 },
            { "ar_DZ", 10073 },
            { "ar_EG", 10074 },
            { "be_BY", 10075 },
            { "bn_BD", 10076 },
            { "bs_BA", 10077 },
            { "ca_ES", 10078 },
            { "et_EE", 10079 },
            { "he_IL", 10080 },
            { "hy_AM", 10081 },
            { "kk_KZ", 10082 },
            { "lo_LA", 10083 },
            { "mn_MN", 10085 },
            { "nb_NO", 10086 },
            { "nn_NO", 10087 },
            { "si_LK", 10088 },
            { "tg_TJ", 10089 },
            { "tk_TM", 10090 },
            { "uz_UZ", 10091 }};
    }
}
