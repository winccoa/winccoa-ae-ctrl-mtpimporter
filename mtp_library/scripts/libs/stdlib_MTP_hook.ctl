/*
@author Andreas Gruber
Function returns the element to be shown as sumalarm on a symbol
@param dp ... Datapoint
@return (string) ... Element relative to DP
*/
string hook_mtp_getAlertElement(string dp)
{
  return "";
}

/*
@author Andreas Gruber
Function returns the element to be checked for invalid on a symbol
@param dp ... Datapoint
@return (string) ... Element relative to DP
*/
string hook_mtp_getInvalidElement(string dp)
{
  if (dpTypeName(dp)=="STDLIB_regler")
    return "STA.ist";
  else
    return "state.val";
}

/*
@author Andreas Gruber
Function returns the node to be checked for the default operation mode on a symbol
@param dp ... Datapoint
@return (string) ... Node relative to DP
*/
string hook_mtp_getOperationModeElement(string dp)
{
  return "operationMode";
}

/*
@author Andreas Gruber
Function will be called automatically on a value change of the connected DPEs of an infoArea
of a symbol. If its wanted to change the default calculation of the iconID, it can be done here.
If its a projectwide change, change the hook function in stdlib_hook_project
@param aParams[1] ... InfoAreaNr
@param aParams[2] ... Mapping containing all DPEs of the infoArea and their values
@return (int) ... -1 use default implementation, >=0 iconID for the given InfoArea
*/
int hook_mtp_alterInfoAreaDisplay(anytype aParams)
{
  int InfoAreaNr = aParams[1];
  mapping dpesForInfoArea=aParams[2];

//  if (InfoAreaNr==5)

  return -1;
}

/*
@author Andreas Gruber
Function returns the element to be shown for InfoArea-Icon display on a symbol
@param aParams ... anytype must contain dyn_anytype with [1] is a Datapoint an [2] is the number of the infoArea
@return (dyn_string) ... DPEs which need to be connected for this infoArea
*/
dyn_string hook_mtp_getInfoAreaDPEs(anytype aParams)
{
  // get parameters from anytype
  string sDp = aParams[1];
  sDp = dpSubStr(sDp, DPSUB_SYS_DP_EL);
  int iInfoAreaNr = aParams[2];
  bool bUsePanelGlobalVariables=aParams[3];  //Workaround for AjaxWebUi - we cannot use panel global variables for callbacks
  bool bLocalInfoAreaUseDefault=TRUE;

  string stemp, sOperationMode="";
  int iType;

  dyn_string dsDPE;
  string sAddDot="";
  if(sDp[strlen(sDp)-1]!=".")
    sAddDot=".";
  if (DebugInfos) DebugN("hook_getInfoAreaDPEs", sDp, sAddDot, strlen(sDp), sDp[strlen(sDp)-1]);



  sOperationMode=hook_getOperationModeElement(sDp);

  switch (iInfoAreaNr)
  {
    case 1: if (dpExists(sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr))
              dynAppend(dsDPE, sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr);  // default handling
            break;
    case 2: if (dpExists(sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr))
              dynAppend(dsDPE, sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr);  // default handling
            break;
    case 3: if (gUseNotes && dpExists (sDp+sAddDot+"general.note"))  // if notes are used and the DPE exists, dont use default handling for this infoArea
            {
              dynAppend(dsDPE, sDp+sAddDot+"general.note");
              bLocalInfoAreaUseDefault=false;
            }
            else
            {
              if (dpExists(sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr))
                dynAppend(dsDPE, sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr);
            }
            break;
    case 4: if (dpExists(sDp+sAddDot+sOperationMode+".auto") && dpExists(sDp+sAddDot+sOperationMode+".manual") &&
                dpExists(sDp+sAddDot+sOperationMode+".local") && dpExists(sDp+sAddDot+sOperationMode+".remote"))  // if OperationMode DPEs exists, dont use default handling for this infoArea
            {
              dynAppend(dsDPE, sDp+sAddDot+sOperationMode+".auto");
              dynAppend(dsDPE, sDp+sAddDot+sOperationMode+".manual");
              dynAppend(dsDPE, sDp+sAddDot+sOperationMode+".local");
              dynAppend(dsDPE, sDp+sAddDot+sOperationMode+".remote");
              bLocalInfoAreaUseDefault=false;
            }
            else
            {
              if (dpExists(sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr))
                dynAppend(dsDPE, sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr);
            }
            break;
    case 5: stemp=hook_getInvalidElement(sDp);
            if (dpExists(sDp+sAddDot+stemp))  // if invalid DPE exists, dont use default handling for this infoArea
            {
              dynAppend(dsDPE, sDp+sAddDot+hook_getInvalidElement(sDp)+":_original.._invalid");
              bLocalInfoAreaUseDefault=false;
            }
            else
            {
              if (dpExists(sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr))
                dynAppend(dsDPE, sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr);
            }
            break;
    case 6: stemp=hook_getAlertElement(sDp);
            if (dpExists(sDp+sAddDot+stemp))  // if alert DPE exists, dont use default handling for this infoArea
            {
              dpGet(sDp+sAddDot+stemp+":_alert_hdl.._type", iType);  // check also if there is an _alert_hdl
              if (iType!=0)
              {
                dynAppend(dsDPE, sDp+sAddDot+stemp+":_alert_hdl.._act_state_color");
                bLocalInfoAreaUseDefault=false;
              }
            }
             if (bLocalInfoAreaUseDefault==true)
            {
              if (dpExists(sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr))
                dynAppend(dsDPE, sDp+sAddDot+"infoArea.mode_"+iInfoAreaNr);
            }
            break;
    default: break;
  }

  if (bUsePanelGlobalVariables)
    dbInfoAreaUseDefault[iInfoAreaNr]=bLocalInfoAreaUseDefault;
  else //Workaround for AjaxWebUi - we cannot use panel global variables for callbacks
    dynAppend(dsDPE,(string)((int) bLocalInfoAreaUseDefault));

  return dsDPE;
}

/*
@author Andreas Gruber
Function returns if an element has an active peripheral address
@param DPE ... Datapoint Element
@return (bool) ... active address?
*/
bool hook_mtp_hasDpeAnActiveAdress(string DPE)
{
  int iAddress;
  bool bRet=false;

  dpGet(DPE + ":_address.._type", iAddress);
  if (iAddress!=0)
  {
    dpGet(DPE + ":_address.._active", bRet);
  }

  return bRet;
}
/*
@author Michael Schmit
function which creates the PopUpMenu
@return the menue Entry for the PopUpMenu
@param sParams ... Parameter
*/
dyn_anytype hook_mtp_fillPopUpMenu(anytype aParams)
{
  string dp = aParams[1];
  dyn_string dsMenueEntry = aParams[2];
  dyn_string dsFunction = aParams[3];
//   dynAppend(dsMenueEntry,"PUSH_BUTTON");
//   dynAppend(dsMenueEntry,"add-On"+","+6+",  " + TRUE);
//   dynAppend(dsFunction,"OpenDpMonitor(\""+dp+"\");");
  aParams[2]=dsMenueEntry;
  aParams[3]=dsFunction;
  return aParams;
}

/*
@author Christian Lichtenberger
Gets a list of dpes to connect to for enabeling rule
@param sDpe ... Datapoint Element
@return ... list of datapoint elements
*/
dyn_string hook_mtp_addEnableRuleDpes(string sDpe)
{
  return makeDynString();
}

/*
@author Christian Lichtenberger
Gets a list of dpes to connect to for visible rule
@param sDpe ... Datapoint Element
@return ... list of datapoint elements
*/
dyn_string hook_mtp_addVisibleRuleDpes(string sDpe)
{
  return makeDynString();
}

/*
@author Christian Lichtenberger
Gets a list of dpes to connect to for highlighting rule
@param sDpe ... Datapoint Element
@return ... list of datapoint elements
*/
dyn_string hook_mtp_addHighlightRuleDpes(string sDpe)
{
  return makeDynString();
}

/*
@author Christian Lichtenberger
Function returns if an element is enabled
@param aParams[1] ... Datapoint Element
@param aParams[2] ... Connect DPEs
@param aParams[3] ... Conncet Values
@return (bool) ... enable or not
*/
bool hook_mtp_libEnableElementarySymbol(dyn_anytype aParams)
{
  return true;
}

/*
@author Christian Lichtenberger
Function returns if an element is visible
@param aParams[1] ... Datapoint Element
@param aParams[2] ... Connect DPEs
@param aParams[3] ... Conncet Values
@return (bool) ... visible or not
*/
bool hook_mtp_libVisibleElementarySymbol(dyn_anytype aParams)
{
  return true;
}

/*
@author Christian Lichtenberger
Function returns if an element is hightlighted
@param aParams[1] ... Datapoint Element
@param aParams[2] ... Connect DPEs
@param aParams[3] ... Conncet Values
@return (bool) ... highlight or not
*/
bool hook_mtp_libHighlightElementarySymbol(dyn_anytype aParams)
{
  return false;
}

/*
@author Michael Schmit
Function returns if license is available
@return (bool) ... available or not
*/
bool hook_mtp_libLicenseAvailable(string dp = "")
{
  //for Example return true if you have the license for the "advS7"
  //return getLicenseOption("advS7");
  return true;
}

/*
@author Markus Trummer
function which gives the headline used in the faceplates
@return the headline text
@param sDp ... datapoint
*/
langString hook_mtp_faceplateHeadline(string sDp)
{
  langString lsHeadline;
  //define headline if you library needs to specify, or use project settings from function hook_faceplateHeadline() in stdlib_project.ctl

  lsHeadline = dpGetDescription(sDp);

  return lsHeadline;
}

/*
@author Markus Trummer
function which gives the window title used in the faceplates
@return the window title text
@param sDp ... datapoint
*/
langString hook_mtp_faceplateWindowTitle(string sDp)
{
  langString lsWindowTitle;
  //define window title if you library needs to specify, or use project settings from function hook_faceplateWindowTitle() in stdlib_project.ctl

  lsWindowTitle = dpGetAlias(sDp);
  if ( lsWindowTitle == "" ) lsWindowTitle = dpSubStr(sDp, DPSUB_SYS_DP);
  //if alias is empty - name of instance

  return lsWindowTitle;
}

/*
@author Markus Trummer
function for adding and removing faceplate tabs before opening the faceplate
@param sDp ... datapoint for which the faceplate will be opened
@param &ds_panels ... panels which will be opend
@param &ds_pfad ... paths of the panels
*/
void hook_mtp_faceplateTabsToOpen (string sDp, dyn_string &ds_panels, dyn_string &ds_pfad)
{
  int size = ds_panels.count();

  for (int i = size - 1; i >= 0; i--)
  {
    if (ds_panels.at(i).contains("setting_") || patternMatch("*_*", ds_panels.at(i)))
    {
      if (patternMatch("*_*", ds_panels.at(i))) //remove if, same panel name without "_"
      {
        string sBasicPanel = substr(ds_panels.at(i), 0, strpos(ds_panels.at(i), "_")) + substr(ds_panels.at(i), strpos(ds_panels.at(i), "."));
        if (dynContains(ds_panels, sBasicPanel) < 1)
          continue;
      }
      ds_panels.removeAt(i);
      ds_pfad.removeAt(i);
    }
  }
}
