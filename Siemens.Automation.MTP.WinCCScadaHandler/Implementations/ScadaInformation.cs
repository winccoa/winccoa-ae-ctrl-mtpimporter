// ----------------------------------
// Copyright © Siemens 2023-2025
// All rights reserved. Confidential.
// ----------------------------------

using Siemens.Automation.MTP.ScadaBusinessLogic;
using System;
using System.Collections.Generic;
using Siemens.Automation.MTP.Services.Interface;

namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    internal class ScadaInformation : IDeviceInformation
    {
        private readonly string _scadaName;
        private string _scadaVersion;
        private string _message;
        private readonly string _device;
        private IDeviceSupportResult _scadaSupportResult;
        private readonly ILoggingService _loggingService;

        public string DeviceName { get => _scadaName; }
        public string DeviceVersion { get => _scadaVersion; }
        public string Message { get => _message; }
        IDeviceSupportResult IDeviceInformation.ScadaSupportResult { get => _scadaSupportResult; }

        internal ScadaInformation(string device, ILoggingService loggingService)
        {
            _device = device ?? throw new ArgumentNullException(nameof(device));
            _loggingService = loggingService ?? throw new ArgumentNullException(nameof(loggingService));
            _scadaName = _device;
            PrepareScadaInformation();
        }

        private void PrepareScadaInformation()
        {
            _scadaSupportResult = new ScadaSupportResult(_device);
            _scadaVersion = GetScadaVersion();
        }

        private string GetScadaVersion()
        {
            const string currentDeviceVersion = "V3.2";

            return currentDeviceVersion;
        }
    }

    internal class ScadaSupportResult : IDeviceSupportResult
    {
        private readonly string _device;
        private bool _isSupported;
        private string _message;

        public bool IsSupported => _isSupported;
        public string Message => _message;
        public List<string> SupportedDevices => SetSupportedDevices();
        internal ScadaSupportResult(string device)
        {
            _device = device ?? throw new ArgumentNullException(nameof(device));
            IsDeviceSupported();
            SetSupportedDevices();
        }

        private void IsDeviceSupported()
        {
            // No check performed
            _isSupported = true;
            return;
        }

        private static List<string> SetSupportedDevices()
        {
            //Need to be adapted 
            List<string> supportedDevices = new List<string>();

            return supportedDevices;
        }
    }
}
