// ----------------------------------
// Copyright © Siemens 2024-2025
// All rights reserved. Confidential.
// ----------------------------------

using ModuleTypePackage.Contract.Extensions;
using ModuleTypePackage.Contract.HmiSet;
using System;
using System.Collections.Generic;
using System.Xml;
using Siemens.Automation.MTP.ScadaBusinessLogic.ScadaMtpAttributeTables;


namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    public class VisualObjectHandler
    {
        private string RefId;
        private string Name;
        private int Width;
        private int Height;
        private int X;
        private int Y;
        private int ZIndex;
        private int Rotation;
        private string eClassClassificationClass;
        private bool isDynamic;
        private string projPath;
        private IEnumerable<IScadaMtpAttributeTable> allDataAssemblies;


        public VisualObjectHandler(VisualObject visObj, IEnumerable<IScadaMtpAttributeTable> allDataAssemblies, int id, string projPath) {
            this.RefId = visObj.RefId;
            this.Name = visObj.Name;
            this.X = visObj.X;
            this.Y = visObj.Y;
            this.ZIndex = visObj.ZIndex;
            this.Rotation = visObj.Rotation;
            this.isDynamic = visObj.RefId == "" ? false : true;
            this.projPath = projPath;
            this.allDataAssemblies = allDataAssemblies;

            if (!isDynamic)
            { 
            string mainGroup = "0" + visObj.EClassClassificationClass.ToTuple().Value.MainGroup.ToTuple().Value.ToString();
            string segment = "0" + visObj.EClassClassificationClass.ToTuple().Value.Segment.ToTuple().Value.ToString();
            string group = "0" + visObj.EClassClassificationClass.ToTuple().Value.Group.ToTuple().Value.ToString();
            string subGroup = "0" + visObj.EClassClassificationClass.ToTuple().Value.SubGroup.ToTuple().Value.ToString();
            this.eClassClassificationClass = segment.Substring(segment.Length - 2) + "-" +
                                             mainGroup.Substring(mainGroup.Length - 2) + "-" +
                                             group.Substring(group.Length - 2) + "-" +
                                             subGroup.Substring(subGroup.Length - 2);
            }
            CreateShape(isDynamic, id);
        }


        public void CreateShape(bool isDynamic, int id)
        {
            string panelName ="";
            string dpName = "";
            string[] childPanelSize;


            if (isDynamic)
            {
                foreach (var dataassembly in allDataAssemblies)
                {
                    string RefBaseSystemUnitPath = dataassembly.RefBaseSystemUnitPath.GetValue();
                    if (dataassembly.RefId == RefId)
                    {
                        panelName = RefBaseSystemUnitPath;
                        dpName = dataassembly.Name;
                    }
                    panelName = panelName != "" ? panelName.Substring(panelName.LastIndexOf('/') + 1) : "Placeholder";
                }
            }
            else if (!isDynamic)
            {
                panelName = eClassClassificationClass;
            }
            else
            {
                panelName = "Placeholder";
            }

            panelName = XmlConfigReader.GetPanelRef(panelName) ?? $"MTP_Objects/{panelName}.pnl";

            double widthRation = (double)Width / (double)200.0;
            double heightRation = (double)Height / (double)200.0; 
            XmlDocument doc = new XmlDocument();
            doc.Load(projPath);

            XmlElement reference = doc.CreateElement(string.Empty, "reference", string.Empty);
            reference.SetAttribute("referenceId", id + "");
            reference.SetAttribute("Name", Name);
            reference.SetAttribute("parentSerial", "-1");
            XmlNode shapes = doc.SelectSingleNode("//shapes");
            shapes.AppendChild(reference);

            XmlElement properties = doc.CreateElement(string.Empty, "properties", string.Empty);
            reference.AppendChild(properties);

            XmlElement propFile = doc.CreateElement(string.Empty, "prop", string.Empty);
            propFile.SetAttribute("name", "FileName");
            propFile.InnerText = panelName;
            properties.AppendChild(propFile);

            XmlElement propLocation = doc.CreateElement(string.Empty, "prop", string.Empty);
            propLocation.SetAttribute("name", "Location");
            propLocation.InnerText = X + " " + Y;
            properties.InsertAfter(propLocation, propFile);

            XmlElement propGeometry = doc.CreateElement(string.Empty, "prop", string.Empty);
            properties.InsertAfter(propGeometry, propLocation);

            XmlElement propDollarParameters = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDollarParameters.SetAttribute("name", "dollarParameters");
            properties.InsertAfter(propDollarParameters, propGeometry);

            XmlElement propLayout = doc.CreateElement(string.Empty, "prop", string.Empty);
            propLayout.SetAttribute("name", "layoutAlignment");
            propLayout.InnerText = "AlignNone";
            properties.InsertAfter(propLayout, propDollarParameters);

            XmlElement propDollarParameter = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDollarParameter.SetAttribute("name", "dollarParameter");
            propDollarParameters.AppendChild(propDollarParameter);

            XmlElement propDollarParameterName = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDollarParameterName.SetAttribute("name", "Dollar");
            propDollarParameterName.InnerText = "$dp";
            propDollarParameter.AppendChild(propDollarParameterName);

            XmlElement propDollarParameterValue = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDollarParameterValue.SetAttribute("name", "Value");
            propDollarParameterValue.InnerText = dpName;
            propDollarParameter.InsertAfter(propDollarParameterValue, propDollarParameterName);

            XmlElement propDollarParameter2 = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDollarParameter2.SetAttribute("name", "dollarParameter");
            propDollarParameters.AppendChild(propDollarParameter2);

            XmlElement propDollarParameterName2 = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDollarParameterName2.SetAttribute("name", "Dollar");
            propDollarParameterName2.InnerText = "$dpRotation";
            propDollarParameter2.AppendChild(propDollarParameterName2);

            XmlElement propDollarParameterValue2 = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDollarParameterValue2.SetAttribute("name", "Value");
            propDollarParameterValue2.InnerText = Rotation.ToString();
            propDollarParameter2.InsertAfter(propDollarParameterValue2, propDollarParameterName2);

            doc.Save(projPath);
        }
    }
}
