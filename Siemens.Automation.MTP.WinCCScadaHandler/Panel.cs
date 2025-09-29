using ModuleTypePackage.Contract.Extensions;
using ModuleTypePackage.Contract.HmiSet;
// ----------------------------------
// Copyright © Siemens 2024-2025
// All rights reserved. Confidential.
// ----------------------------------

using System.Xml;


namespace Siemens.Automation.MTP.WinCCScadaHandler
{
    public class Panel
    {
        private string path;
        string panelName;

        public Panel(string panelPath, string panelName)
        {
            this.panelName = panelName;
            this.path = panelPath;

            createPanel(path);
        }

        //Version number and panel size hardcoded --> need to fix
        public void createPanel(string panelPath)
        {
            XmlDocument doc = new XmlDocument();
            XmlDeclaration xmlDeclaration = doc.CreateXmlDeclaration("1.0", "UTF-8", null);
            XmlElement root = doc.DocumentElement;
            doc.InsertBefore(xmlDeclaration, root);

            XmlElement panel = doc.CreateElement(string.Empty, "panel", string.Empty);
            panel.SetAttribute("version", "14");
            doc.InsertAfter(panel, xmlDeclaration);

            XmlElement properties = doc.CreateElement(string.Empty, "properties", string.Empty);
            doc.SelectSingleNode("panel").AppendChild(properties);

            XmlElement propName = doc.CreateElement(string.Empty, "prop", string.Empty);
            propName.SetAttribute("name", "Name");
            doc.SelectSingleNode("//properties").AppendChild(propName);

            XmlElement propLang = doc.CreateElement(string.Empty, "prop", string.Empty);
            propLang.SetAttribute("name", "en_US.utf8");
            propName.AppendChild(propLang);

            XmlElement propSize = doc.CreateElement(string.Empty, "prop", string.Empty);
            propSize.SetAttribute("name", "Size");
            propSize.InnerText = "1500 700";
            properties.InsertAfter(propSize, propName);

            XmlElement propBackColor = doc.CreateElement(string.Empty, "prop", string.Empty);
            propBackColor.SetAttribute("name", "BackColor");
            propBackColor.InnerText = "_3DFace";
            properties.InsertAfter(propBackColor, propSize);

            XmlElement propRefPoint = doc.CreateElement(string.Empty, "prop", string.Empty);
            propRefPoint.SetAttribute("name", "RefPoint");
            propRefPoint.InnerText = "0 0";
            properties.InsertAfter(propRefPoint, propBackColor);

            XmlElement propInit = doc.CreateElement(string.Empty, "prop", string.Empty);
            propInit.SetAttribute("name", "InitAndTermRef");
            propInit.InnerText = "True";
            properties.InsertAfter(propInit, propRefPoint);

            XmlElement propSendClick = doc.CreateElement(string.Empty, "prop", string.Empty);
            propSendClick.SetAttribute("name", "SendClick");
            propSendClick.InnerText = "False";
            properties.InsertAfter(propSendClick, propInit);

            XmlElement propRefFileName = doc.CreateElement(string.Empty, "prop", string.Empty);
            propRefFileName.SetAttribute("name", "RefFileName");
            properties.InsertAfter(propRefFileName, propSendClick);

            XmlElement propDPI = doc.CreateElement(string.Empty, "prop", string.Empty);
            propDPI.SetAttribute("name", "DPI");
            propDPI.InnerText = "120";
            properties.InsertAfter(propDPI, propRefFileName);

            XmlElement propLayout = doc.CreateElement(string.Empty, "prop", string.Empty);
            propLayout.SetAttribute("name", "layoutType");
            propLayout.InnerText = "None";
            properties.InsertAfter(propLayout, propDPI);

            XmlElement events = doc.CreateElement(string.Empty, "events", string.Empty);
            panel.InsertAfter(events, properties);

            XmlElement shapes = doc.CreateElement(string.Empty, "shapes", string.Empty);
            panel.InsertAfter(shapes, events);

            doc.Save(panelPath);
        }
    }
}


       