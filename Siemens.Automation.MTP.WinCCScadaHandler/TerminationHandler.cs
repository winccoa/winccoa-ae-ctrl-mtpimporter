// ----------------------------------
// Copyright © Siemens 2024-2025
// All rights reserved. Confidential.
// ----------------------------------

using ModuleTypePackage.Contract.HmiSet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpAttributeTables;
using ModuleTypePackage.Contract.CommunicationSet;
using System.Security.Permissions;
using ModuleTypePackage.Contract.Extensions;
using System.IO;
using ModuleTypePackage.Contract;
using System.Reflection;
using ModuleTypePackage.Contract.Attributes;
using System.Diagnostics;

namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    public class TerminationHandler
    {
        private int X;
        private int Y;
        private int ZIndex;
        private string RefId;
        private IEnumerable<IScadaMtpAttributeTable> allDataAssemblies;
        public TerminationHandler(Termination termination, IEnumerable<IScadaMtpAttributeTable> allDataAssemblies) 
        {
            this.X = termination.X;
            this.Y = termination.Y;
            this.ZIndex = termination.ZIndex;
            this.RefId = termination.RefId;
            this.allDataAssemblies = allDataAssemblies;
            test(termination);
        }

        private void test(Termination termination)
        {
            /*  var z = termination.Attributes.GetEnumerator();
              while (z.MoveNext())
              {
                  var attribute = z.Current;
                  attribute.
                 //Type typ = typeof(ModuleTypePackage.Contract.Attributes.IAttribute);
                  Type typ = typeof(ModuleTypePackage.Contract.Attributes.StringAttribute);
                  PropertyInfo fi = typ.GetProperty("Value", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                  var value = fi.GetValue(attribute);
                  using (StreamWriter writer = new StreamWriter("C:\\TestWinCC\\test.txt", true))
                  {   
                      writer.WriteLine(value);
                  }  
              }*/
        }
        private void addShape()
        {
            string panelName = "";
            foreach (var dataassembly in allDataAssemblies)
            {    
                string RefBaseSystemUnitPath = dataassembly.RefBaseSystemUnitPath.GetValue();
                if (dataassembly.RefId == RefId) 
                { 
                    panelName = RefBaseSystemUnitPath;
                }
                panelName = panelName != "" ? panelName.Substring(panelName.LastIndexOf('/') + 1) : "Placeholder";
            }



        }
    }
}
