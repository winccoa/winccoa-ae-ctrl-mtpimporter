// ----------------------------------
// Copyright © Siemens 2024-2025
// All rights reserved. Confidential.
// ----------------------------------

using ModuleTypePackage.Contract.HmiSet;
using System.Xml;

namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    public class ConnectionHandler
    {
        string[] edgePath;
        string lineType;
        string name;

        public ConnectionHandler(MeasurementLine line, string panelPath)
        {
            this.edgePath= line.EdgePath.Replace(',', ' ').Split(';');
            this.lineType = "dashed";
            this.name = line.Name;
            addShape(panelPath);
        }

        public ConnectionHandler(FunctionLine line, string panelPath)
        {
            this.edgePath = line.EdgePath.Replace(',', ' ').Split(';');
            this.lineType = "solid";
            this.name = line.Name;
            addShape(panelPath);
        }

        public ConnectionHandler(Pipe line, string panelPath)
        {
            this.edgePath = line.EdgePath.Replace(',', ' ').Split(';');
            this.lineType = "solid";
            this.name = line.Name;
            addShape(panelPath);
        }



        public void addShape(string path)
        {

            XmlDocument doc = new XmlDocument();
            doc.Load(path);

            XmlElement shape = doc.CreateElement(string.Empty, "shape", string.Empty);
            shape.SetAttribute("layerID", "0");
            shape.SetAttribute("Name", name);
            shape.SetAttribute("shapeType", "POLYGON");
            XmlNode shapes = doc.SelectSingleNode("//shapes");
            shapes.AppendChild(shape);

            XmlElement properties = doc.CreateElement(string.Empty, "properties", string.Empty);
            shape.AppendChild(properties);

            XmlElement propEnable = doc.CreateElement(string.Empty, "prop", string.Empty);
            propEnable.SetAttribute("name", "Enable");
            propEnable.InnerText = "True";
            properties.AppendChild(propEnable);

            XmlElement propVisible = doc.CreateElement(string.Empty, "prop", string.Empty);
            propVisible.SetAttribute("name", "Visible");
            propVisible.InnerText = "True";
            properties.InsertAfter(propVisible, propEnable);

            XmlElement propForeColor = doc.CreateElement(string.Empty, "prop", string.Empty);
            propForeColor.SetAttribute("name", "ForeColor");
            propForeColor.InnerText = "{0,0,0}";
            properties.InsertAfter(propForeColor, propVisible);

            XmlElement propBackColor = doc.CreateElement(string.Empty, "prop", string.Empty);
            propBackColor.SetAttribute("name", "BackColor");
            propBackColor.InnerText = "_Transparent";
            properties.InsertAfter(propBackColor, propForeColor);

            XmlElement propLayoutAlignment = doc.CreateElement(string.Empty, "prop", string.Empty);
            propLayoutAlignment.SetAttribute("name", "layoutAlignment");
            propLayoutAlignment.InnerText = "AlignNone";
            properties.InsertAfter(propLayoutAlignment, propBackColor);

            XmlElement propSnapMode = doc.CreateElement(string.Empty, "prop", string.Empty);
            propSnapMode.SetAttribute("name", "snapMode");
            propSnapMode.InnerText = "Point";
            properties.InsertAfter(propSnapMode, propLayoutAlignment);

            XmlElement propDashBackColor = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDashBackColor.SetAttribute("name", "DashBackColor");
            propDashBackColor.InnerText = "_Transparent";
            properties.InsertAfter(propDashBackColor, propSnapMode);

            XmlElement propAntiAliased = doc.CreateElement(string.Empty, "prop", string.Empty);
            propAntiAliased.SetAttribute("name", "AntiAliased");
            propAntiAliased.InnerText = "True";
            properties.InsertAfter(propAntiAliased, propDashBackColor);

            XmlElement propLineType = doc.CreateElement(string.Empty, "prop", string.Empty);
            propLineType.SetAttribute("name", "LineType");
            propLineType.InnerText = "[" + lineType + ",oneColor,JoinBevel,CapProjecting,2]";
            properties.InsertAfter(propLineType, propAntiAliased);

            XmlElement propBorderZoomable = doc.CreateElement(string.Empty, "prop", string.Empty);
            propBorderZoomable.SetAttribute("name", "BorderZoomable");
            propBorderZoomable.InnerText = "False";
            properties.InsertAfter(propBorderZoomable, propLineType);

            XmlElement propFillType = doc.CreateElement(string.Empty, "prop", string.Empty);
            propFillType.SetAttribute("name", "FillType");
            propFillType.InnerText = "[solid]";
            properties.InsertAfter(propFillType, propBorderZoomable);

            XmlElement propClosed = doc.CreateElement(string.Empty, "prop", string.Empty);
            propClosed.SetAttribute("name", "Closed");
            propClosed.InnerText = "False";
            properties.InsertAfter(propClosed, propFillType);

            XmlElement propPoints = doc.CreateElement(string.Empty, "prop", string.Empty);
            propPoints.SetAttribute("name", "Points");
            properties.InsertAfter(propPoints, propClosed);

            for (int i = 0; i < edgePath.Length; i++)
            {
                XmlElement propLocation = doc.CreateElement(string.Empty, "prop", string.Empty);
                propLocation.SetAttribute("name", "Location");
                propLocation.InnerText = edgePath[i];
                propPoints.AppendChild(propLocation);
            }

            doc.Save(path);

        }



    }
}
