// ----------------------------------
// Copyright © Siemens 2023-2025
// All rights reserved. Confidential.
// ----------------------------------

using Siemens.Automation.MTP.ScadaBusinessLogic.CommonRuleSet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    public class WinCCStringRuleSet: IScadaBasicSet
    {
        #region Constants
        private const int PREFIX_LENGTH = 5;
        private const int MAX_LENGTH = 128;
        private const int GROUP_LENGTH = 16;
        private const int TAG_NAME_PREFIX_LENGTH = 6; // Prefix: |Attr=
        private const int TAG_TABLE_NAME_LENGTH = 64; // As per NAMUR Standard
        private const int TAG_TABLE_WITH_PREFIX_AND_GROUP_LENGTH = PREFIX_LENGTH + GROUP_LENGTH + TAG_TABLE_NAME_LENGTH; // 85
        private const int TAG_NAME_LENGTH = MAX_LENGTH - TAG_TABLE_WITH_PREFIX_AND_GROUP_LENGTH - TAG_NAME_PREFIX_LENGTH; // 37
        private const int TAG_NAME_WITH_PREFIX_AND_GROUP_LENGTH = TAG_TABLE_WITH_PREFIX_AND_GROUP_LENGTH + TAG_NAME_PREFIX_LENGTH + TAG_NAME_LENGTH; // Adds up to 128,
        private const int SCREEN_NAME_LENGTH = MAX_LENGTH - PREFIX_LENGTH + GROUP_LENGTH;
        private const int SCREEN_NAME_WITH_PREFIX_AND_PIPE_LENGTH = MAX_LENGTH;
        private const int OBJECT_NAME_LENGTH = MAX_LENGTH;
        #endregion

        #region Global Variables
        private string stringType = string.Empty;
        #endregion

        #region Properties
        public string UnsupportedCharacters => "#$*%./:?[]~'\"`";
        public char ReplacingCharacter => "_"[0];
        public int MaxLength => SetType(MAX_LENGTH, nameof(MaxLength));
        public int GroupNameLength => SetType(GROUP_LENGTH, nameof(GroupNameLength));
        public int TagNamePrefixLength => SetType(TAG_NAME_PREFIX_LENGTH, nameof(TagNamePrefixLength));
        public int TagTableNameLength => SetType(TAG_TABLE_NAME_LENGTH, nameof(TagTableNameLength));
        public int TagTableNameWithPrefixAndGroupLength => SetType(TAG_TABLE_WITH_PREFIX_AND_GROUP_LENGTH, nameof(TagTableNameWithPrefixAndGroupLength));
        public int TagNameLength => SetType(TAG_NAME_LENGTH, nameof(TagNameLength));
        public int TagNameWithPrefixAndGroupLength => SetType(TAG_NAME_WITH_PREFIX_AND_GROUP_LENGTH, nameof(TagNameWithPrefixAndGroupLength));
        public int ScreenNameLength => SetType(SCREEN_NAME_LENGTH, nameof(ScreenNameLength));
        public int ScreenNameWithPrefixAndPipeLength => SetType(SCREEN_NAME_WITH_PREFIX_AND_PIPE_LENGTH, nameof(ScreenNameWithPrefixAndPipeLength));
        public int ObjectNameLength => SetType(OBJECT_NAME_LENGTH, nameof(ObjectNameLength));
        public string NameType => stringType;

        /// <summary>
        /// Function to set the value of String Type, used for logging.
        /// </summary>
        /// <param name="length"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        private int SetType(int length, string type)
        {
            stringType = type;
            return length;
        }
        #endregion
    }
}
