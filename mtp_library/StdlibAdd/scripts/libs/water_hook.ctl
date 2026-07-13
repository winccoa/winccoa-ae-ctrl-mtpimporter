#uses "stdlib_hook"

/*
  Automatically generated on 2026.01.26 13:56:57.005 with Stdlib Development Panel
*/

string hook_water_getAlertElement(string &dp)
{
  return hook_stdlib_getAlertElement(dp);
}

string hook_water_getInvalidElement(string &dp)
{
  return hook_stdlib_getInvalidElement(dp);
}

string hook_water_getOperationModeElement(string &dp)
{
  return hook_stdlib_getOperationModeElement(dp);
}

int hook_water_alterInfoAreaDisplay(anytype &aParams)
{
  return hook_stdlib_alterInfoAreaDisplay(aParams);
}

dyn_string hook_water_getInfoAreaDPEs(anytype &aParams)
{
  return hook_stdlib_getInfoAreaDPEs(aParams);
}

bool hook_water_hasDpeAnActiveAdress(string &DPE)
{
  return hook_stdlib_hasDpeAnActiveAdress(DPE);
}

dyn_anytype hook_water_fillPopUpMenu(anytype &aParams)
{
  return hook_stdlib_fillPopUpMenu(aParams);
}

dyn_string hook_water_addEnableRuleDpes(string &sDpe)
{
  return hook_stdlib_addEnableRuleDpes(sDpe);
}

dyn_string hook_water_addVisibleRuleDpes(string &sDpe)
{
  return hook_stdlib_addVisibleRuleDpes(sDpe);
}

dyn_string hook_water_addHighlightRuleDpes(string &sDpe)
{
  return hook_stdlib_addHighlightRuleDpes(sDpe);
}

bool hook_water_libEnableElementarySymbol(dyn_anytype &aParams)
{
  return hook_stdlib_libEnableElementarySymbol(aParams);
}

bool hook_water_libVisibleElementarySymbol(dyn_anytype &aParams)
{
  int i;
  if (dpTypeName(aParams[1]) == "WATER_pump"
      && patternMatch("*.alarm.error", aParams[1]))
  {
    dpGet(dpSubStr(aParams[1], DPSUB_DP_EL) +
          ":_address.._type", i);
    return i; //i=0 for no address config
  }
  return hook_stdlib_libVisibleElementarySymbol(aParams);
}

bool hook_water_libHighlightElementarySymbol(dyn_anytype &aParams)
{
  return hook_stdlib_libHighlightElementarySymbol(aParams);
}

bool hook_water_libLicenseAvailable(string s="")
{
  return hook_stdlib_libLicenseAvailable();
}

langString hook_water_faceplateHeadline(string &sDp)
{
  return hook_stdlib_faceplateHeadline(sDp);
}

langString hook_water_faceplateWindowTitle(string &sDp)
{
  return hook_stdlib_faceplateWindowTitle(sDp);
}
