// ----------------------------------
// Copyright © Siemens 2023-2024
// All rights reserved. Confidential.
// ----------------------------------

using System;
using System.Linq;
using System.Text;
using Siemens.Automation.MTP.ScadaBusinessLogic.CommonRuleSet;
using Siemens.Automation.MTP.ScadaBusinessLogic.StringValidator;
using Siemens.Automation.MTP.Services.Interface;

namespace Siemens.Automation.MTP.WinCCScadaHandler.StringValidator
{
    public class StringValidator : IStringValidator
    {
        private readonly IScadaBasicSet m_stringType;
        public IScadaBasicSet LengthType { get { return m_stringType; } }
        public StringValidator(IScadaBasicSet basicRuleSet)
        {
            m_stringType = basicRuleSet;
        }

        public bool ValidateCharacters(string str)
        {
            var matchingCharacters = str.Where(charA => m_stringType.UnsupportedCharacters.Contains(charA));

            return matchingCharacters.Any();
        }

        public bool ValidateLength(string str, int maxLength)
        {
            _ = str ?? throw new ArgumentNullException(nameof(str));
            var strLength = str.Length;
            if (strLength > maxLength)
            {
                return false;
            }
            return true;
        }

        public string ReplaceUnsupportedCharacters(string replacingString)
        {
            foreach (var character in from char character in m_stringType.UnsupportedCharacters
                                      where replacingString.Contains(character.ToString())
                                      select character.ToString())
            {
                replacingString = replacingString.Replace(character.ToString(), m_stringType.ReplacingCharacter.ToString());
            }

            return replacingString;
        }

        private string GetUnsupportedCharacters(string str)
        {
            StringBuilder specialCharacters = new StringBuilder();
            foreach (var character in from char character in m_stringType.UnsupportedCharacters
                                      where str.Contains(character.ToString())
                                      select character.ToString())
            {
                specialCharacters.Append(character.ToString());
            }

            return specialCharacters.ToString();
        }

        public string LimitStringLength(string stringToLimit, int maxLength)
        {
            if (!string.IsNullOrEmpty(stringToLimit) && stringToLimit.Length > maxLength)
            {
                stringToLimit = stringToLimit.Substring(0, maxLength - 1) + m_stringType.ReplacingCharacter;
            }

            return stringToLimit;
        }

        public void LogTruncatedLength(string str, int maxLength, ILoggingService loggingService = null)
        {
            string originalString = str;
            if (!string.IsNullOrEmpty(str) && str.Length > maxLength)
            {
                str = LimitStringLength(str, maxLength);
                string starMsg = $"'{originalString}, length: {originalString.Length} is exceeding the maximim length of {maxLength}'";
                string newLengthMsg = $"'New value: {str}'";

                loggingService?.LogInformation(starMsg);
                loggingService?.LogInformation(newLengthMsg);
            }
        }

        public void LogUnsupportedCharacters(string str, ILoggingService loggingService = null)
        {
            if (!string.IsNullOrEmpty(str))
            {
                string unSupportedChars = GetUnsupportedCharacters(str);
                if (unSupportedChars.Length > 0)
                {
                    string logMsg = GetLoggingMessage(str, unSupportedChars);
                    loggingService?.LogInformation(logMsg);
                }

            }
        }


        private string GetLoggingMessage(string str, string unsupportedCharacters)
        {
            if (nameof(m_stringType.GroupNameLength) == m_stringType.NameType)
            {
                return $"'Group Name / Instance Name: '{str}' contains Unsupported Characters: {unsupportedCharacters}";
            }
            else if (nameof(m_stringType.TagTableNameLength) == m_stringType.NameType || nameof(m_stringType.TagTableNameWithPrefixAndGroupLength) == m_stringType.NameType)
            {
                return $"'Tag Table Name: '{str}' contains Unsupported Characters: {unsupportedCharacters}";
            }
            else if (nameof(m_stringType.TagNameLength) == m_stringType.NameType || nameof(m_stringType.TagNameWithPrefixAndGroupLength) == m_stringType.NameType)
            {
                return $"'Tag Name: '{str}' contains Unsupported Characters: {unsupportedCharacters}";
            }
            else if (nameof(m_stringType.ScreenNameLength) == m_stringType.NameType)
            {
                return $"'Screen Name: '{str}' contains Unsupported Characters: {unsupportedCharacters}";
            }
            else if (nameof(m_stringType.ObjectNameLength) == m_stringType.NameType)
            {
                return $"'Object Name: '{str}' contains Unsupported Characters: {unsupportedCharacters}";
            }
            else
            {
                return $"'{str}' contains Unsupported Characters: {unsupportedCharacters}";
            }
        }
    }
}
