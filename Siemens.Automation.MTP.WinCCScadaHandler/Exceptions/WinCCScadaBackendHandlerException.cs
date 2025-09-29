// ----------------------------------
// Copyright © Siemens 2023-2024
// All rights reserved. Confidential.
// ----------------------------------

using System;
using System.Globalization;
using System.Runtime.Serialization;

namespace Siemens.Automation.MTP.WinCCScadaHandler.Exceptions
{
    [Serializable]
    public class WinCCScadaBackendHandlerException : Exception
    {
        /// <summary>
        /// Create new WinCCUnifiedBackendHandlerException
        /// </summary>
        public WinCCScadaBackendHandlerException() { }

        /// <summary>
        /// Create new WinCCUnifiedBackendHandlerException
        /// </summary>
        /// <param name="message"></param>
        public WinCCScadaBackendHandlerException(string message) : base(message)
        {
        }

        /// <summary>
        /// Create new WinCCUnifiedBackendHandlerException
        /// </summary>
        /// <param name="message"></param>
        /// <param name="innerException"></param>
        public WinCCScadaBackendHandlerException(string message, Exception innerException) : base(message, innerException)
        {
        }

        /// <summary>
        /// Create new WinCCUnifiedBackendHandlerException
        /// </summary>
        /// <param name="message"></param>
        /// <param name="args"></param>
        public WinCCScadaBackendHandlerException(string message, params object[] args)
            : base(string.Format(CultureInfo.InvariantCulture, message, args))
        {
        }

        /// <summary>
        /// Create new WinCCUnifiedBackendHandlerException
        /// </summary>
        /// <param name="message">Message as format string</param>
        /// <param name="innerException">Exception which caused this exception</param>
        /// <param name="args">format arguments to create message</param>
        public WinCCScadaBackendHandlerException(string message, Exception innerException, params object[] args)
            : base(string.Format(CultureInfo.InvariantCulture, message, args), innerException)
        {
        }

        protected WinCCScadaBackendHandlerException(SerializationInfo info, StreamingContext context) : base(info, context) { }
    }
}
