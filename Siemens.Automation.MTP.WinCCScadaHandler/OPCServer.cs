// ----------------------------------
// Copyright © Siemens 2024-2025
// All rights reserved. Confidential.
// ----------------------------------

using ModuleTypePackage.Contract.CommunicationSet;
using Siemens.Automation.MTP.WinCCScadaHandler.Helpers;
using System.IO;

namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    public class OPCServer
    {
        private string dpName;
        private string endpoint;
        private string filePath;

        private string asciiExePath;
        private string userName;
        private string password;

        public OPCServer(IOpcuaServerAssembly opcuaServerAssembly, string projPath, string pathToXml)
        {
            this.dpName = "_" + opcuaServerAssembly.Name;
            this.endpoint = opcuaServerAssembly.Endpoint;
            this.filePath = projPath + @"/dplist/opcUA.txt";

            createDplFile(filePath);

            bool dummy = false;
            XmlConfigReader.ReadConfigs(pathToXml, ref asciiExePath, ref userName, ref password, ref dummy);

            DpTypeHelper.ImportAscii(filePath, asciiExePath, userName, password);
        }

        public void createDplFile(string filePath)
        {
            using (StreamWriter writer = new StreamWriter(filePath))
            {
                writer.WriteLine("DpName\tTypeName\tID");
                writer.WriteLine(dpName + "\t_OPCUAServer");
                writer.WriteLine("");
                writer.WriteLine("ElementName\tTypeName\t_original.._value");
                writer.WriteLine(dpName + ".Config.ConnInfo" + "\t_OPCUAServer\t" + endpoint);
                writer.WriteLine(dpName + ".Config.ReconnectTimer" + "\t_OPCUAServer\t" + "10");
                writer.WriteLine(dpName + ".Config.Active" + "\t_OPCUAServer\t" + "1");

                writer.WriteLine("");

                writer.WriteLine("DpName\tTypeName\tID");
                writer.WriteLine("_5s" + "\t_PollGroup");
                writer.WriteLine("");
                writer.WriteLine("ElementName\tTypeName\t_original.._value");
                writer.WriteLine("_5s.SyncTime" + "\t_PollGroup\t" + "");
                writer.WriteLine("_5s.SyncMode" + "\t_PollGroup\t" + "0");
                writer.WriteLine("_5s.Active" + "\t_PollGroup\t" + "1");
                writer.WriteLine("_5s.PollInterval" + "\t_PollGroup\t" + "5000");
            }
        }
    }
}


       