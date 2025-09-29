// ----------------------------------
// Copyright © Siemens 2023-2024
// All rights reserved. Confidential.
// ----------------------------------

using Siemens.Automation.MTP.ScadaBusinessLogic.StringValidator;
using Siemens.Automation.MTP.Services.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Siemens.Automation.MTP.WinCCScadaHandler.StringValidator
{
    internal class ValidatorHelper
    {
        private readonly IStringValidator m_stringValidator;
        private readonly ILoggingService m_loggingService;
        const string REGEX_PATTERN = @"\([0-9]+\)$"; // Regular expression pattern to match the last characters as digits enclosed in parentheses.

        public IStringValidator StringValidatorInstance => m_stringValidator;

        public ValidatorHelper(IStringValidator stringValidator, ILoggingService logginService = null)
        {
            m_stringValidator = stringValidator;
            m_loggingService = logginService;
        }

        public string ValidateReplaceAndLogCharacters(string str, bool logUnsupportedCharacter)
        {
            if (m_stringValidator != null && !string.IsNullOrEmpty(str))
            {
                string originalString = str;
                if (m_stringValidator.ValidateCharacters(str))
                {
                    str = m_stringValidator.ReplaceUnsupportedCharacters(str);
                }

                if (logUnsupportedCharacter)
                {
                    m_stringValidator.LogUnsupportedCharacters(originalString, m_loggingService);

                }
            }

            return str;
        }

        public string ValidateTruncateAndLogLength(string str, int maxLength, bool logInvalidLength)
        {
            if (m_stringValidator != null && !string.IsNullOrEmpty(str))
            {
                string originalString = str;
                if (!m_stringValidator.ValidateLength(str, maxLength))
                {
                    str = m_stringValidator.LimitStringLength(str, maxLength);
                }

                if (logInvalidLength)
                {
                    m_stringValidator.LogTruncatedLength(originalString, maxLength, m_loggingService);
                }
            }

            return str;
        }

        /// <summary>
        /// Increment the name if the name already exsisting in the list.
        /// </summary>
        /// <param name="listOfNames">List of string containing the names</param>
        /// <param name="name"></param>
        /// <param name="maxLength">Maximum length supported by the string</param>
        /// <returns></returns>
        public string IncrementDuplicateName(ICollection<string> listOfNames, string name, int maxLength)
        {
            int counter = 1;
            const bool isNameMTPGenerated = true;
            List<Tuple<string, bool>> tupleListOfNames = listOfNames.Select(s => new Tuple<string, bool>(s, isNameMTPGenerated)).ToList();
            const int bracketsLength = 2;

            while (listOfNames.Count > 0 && listOfNames.Any(nameFromList => nameFromList == name))
            {
                if (IsLastCharactersCounter(name) && tupleListOfNames.Any(x => x.Item1 == name && !x.Item2))
                {
                    name = RemoveLastCounterCharacters(name);
                }

                var leftOver = maxLength - name.Length;
                if (leftOver >= (bracketsLength + counter.ToString().Length))
                {
                    name = $"{name}({counter})";
                }
                else
                {
                    if (leftOver < 0)
                    {
                        name = name.Substring(0, maxLength);
                    }
                    name = name.Substring(0, (name.Length - bracketsLength - counter.ToString().Length) + leftOver);

                    name = $"{name}({counter})";
                }
                tupleListOfNames.Add(Tuple.Create(name, false));
                counter++;
            }
            return name;
        }

        /// <summary>
        /// Remove the last characters of the counter.
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        static string RemoveLastCounterCharacters(string str)
        {
            return Regex.Replace(str, REGEX_PATTERN, "");
        }
       

        /// <summary>
        /// Validate if the last characters of the string is counter.
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        private bool IsLastCharactersCounter(string str)
        {
            return Regex.IsMatch(str, REGEX_PATTERN);
        }
    }
}
