// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpView/MtpViewBase"

class MonBinVlvFaceplateHome : MtpViewBase
{
  private shape _refWqc;
  private shape _rectAutomatic;
  private shape _rectError;
  private shape _rectErrorInformation;
  private shape _rectLock;
  private shape _rectMaintenance;
  private shape _rectOff;
  private shape _rectOperator;
  private shape _rectPermission;
  private shape _rectProtection;
  private shape _rectReset;
  private shape _rectSafetyPosition;
  private shape _rectSafetyPositionInformation;
  private shape _rectValve;
  private shape _rectValveClose;
  private shape _rectValveOpen;
  private shape _rectValveCloseAut;
  private shape _rectValveOpenAut;
  private shape _txtError;
  private shape _txtLock;
  private shape _txtMaintenance;
  private shape _txtPermission;
  private shape _txtProtection;
  private shape _txtSafetyPosition;

  private bool _openCheckbackSignal;
  private bool _closeCheckbackSignal;
  private bool _valveControl;
  private bool _staticError;
  private bool _dynamicError;
  private bool _monitorEnabled;

  private bool _safetypositionActive;
  private bool _safetypositionEnabled;

  private bool _stateAutomaticActive;
  private bool _openAutomatic;
  private bool _closeAutomatic;

  private bool _permissionEnabled;
  private bool _permit;
  private bool _interlockEnabled;
  private bool _interlock;
  private bool _protectionEnabled;
  private bool _protection;

  public MonBinVlvFaceplateHome(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setValveCB, "_openCheckbackSignal", MtpViewBase::getViewModel(), MonBinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_closeCheckbackSignal", MtpViewBase::getViewModel(), MonBinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_valveControl", MtpViewBase::getViewModel(), MonBinVlv::valveControlChanged);
    classConnectUserData(this, setValveCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setValveCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnectUserData(this, setErrorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnectUserData(this, setSafetyPositionActiveCB, "_safetypositionActive", MtpViewBase::getViewModel(), MonBinVlv::safetyPositionActiveChanged);
    classConnectUserData(this, setSafetyPositionActiveCB, "_safetypositionEnabled", MtpViewBase::getViewModel(), MonBinVlv::safetyPositionEnabledChanged);

    classConnectUserData(this, setAutomaticPreviewLineCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_openAutomatic", MtpViewBase::getViewModel(), MonBinVlv::openAutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_closeAutomatic", MtpViewBase::getViewModel(), MonBinVlv::closeAutomaticChanged);

    classConnectUserData(this, setSecurityCB, "_permissionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permissionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_permit", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permitChanged);
    classConnectUserData(this, setSecurityCB, "_interlockEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_interlock", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockChanged);
    classConnectUserData(this, setSecurityCB, "_protectionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_protection", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionChanged);

    _staticError =  MtpViewBase::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MtpViewBase::getViewModel().getMonitor().getDynamicError();
    _openCheckbackSignal = MtpViewBase::getViewModel().getOpenCheckbackSignal();
    _closeCheckbackSignal = MtpViewBase::getViewModel().getCloseCheckbackSignal();
    _valveControl = MtpViewBase::getViewModel().getValveControl();
    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();
    _openAutomatic =  MtpViewBase::getViewModel().getOpenAutomatic();
    _closeAutomatic =  MtpViewBase::getViewModel().getCloseAutomatic();
    _monitorEnabled = MtpViewBase::getViewModel().getMonitor().getEnabled();

    _permissionEnabled =  MtpViewBase::getViewModel().getSecurity().getPermissionEnabled();
    _permit =  MtpViewBase::getViewModel().getSecurity().getPermit();
    _interlockEnabled =  MtpViewBase::getViewModel().getSecurity().getInterlockEnabled();
    _interlock =  MtpViewBase::getViewModel().getSecurity().getInterlock();
    _protectionEnabled =  MtpViewBase::getViewModel().getSecurity().getProtectionEnabled();
    _protection =  MtpViewBase::getViewModel().getSecurity().getProtection();

    setValveCB("_openCheckbackSignal", _openCheckbackSignal);
    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setErrorCB("_staticError", _staticError);
    setSafetyPositionActiveCB("_safetypositionActive", _safetypositionActive);
    setAutomaticPreviewLineCB("_stateAutomaticActive", _stateAutomaticActive);
    setSecurityCB("_permissionEnabled", _permissionEnabled);
  }

  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectErrorInformation = MtpViewBase::extractShape("_rectErrorInformation");
    _rectLock = MtpViewBase::extractShape("_rectLock");
    _rectMaintenance = MtpViewBase::extractShape("_rectMaintenance");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _rectPermission = MtpViewBase::extractShape("_rectPermission");
    _rectProtection = MtpViewBase::extractShape("_rectProtection");
    _rectReset = MtpViewBase::extractShape("_rectReset");
    _rectSafetyPosition = MtpViewBase::extractShape("_rectSafetyPosition");
    _rectSafetyPositionInformation = MtpViewBase::extractShape("_rectSafetyPositionInformation");
    _rectValve = MtpViewBase::extractShape("_rectValve");
    _rectValveClose = MtpViewBase::extractShape("_rectValveClose");
    _rectValveOpen = MtpViewBase::extractShape("_rectValveOpen");
    _rectValveCloseAut = MtpViewBase::extractShape("_rectValveCloseAut");
    _rectValveOpenAut = MtpViewBase::extractShape("_rectValveOpenAut");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtLock = MtpViewBase::extractShape("_txtLock");
    _txtMaintenance = MtpViewBase::extractShape("_txtMaintenance");
    _txtPermission = MtpViewBase::extractShape("_txtPermission");
    _txtProtection = MtpViewBase::extractShape("_txtProtection");
    _txtSafetyPosition = MtpViewBase::extractShape("_txtSafetyPosition");
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  private void setSecurityCB(const string &varName, const bool &security)
  {
    switch (varName)
    {
      case "_permissionEnabled":
        _permissionEnabled = security;
        break;

      case "_permit":
        _permit = security;
        break;

      case "_interlockEnabled":
        _interlockEnabled = security;
        break;

      case "_interlock":
        _interlock = security;
        break;

      case "_protectionEnabled":
        _protectionEnabled = security;
        break;

      case "_protection":
        _protection = security;
        break;
    }

    if (_permissionEnabled && _permit)
    {
      _rectPermission.visible = TRUE;
      _txtPermission.visible = TRUE;
      _rectPermission.fill = "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]";
    }
    else if (_permissionEnabled && !_permit)
    {
      _rectPermission.visible = TRUE;
      _txtPermission.visible = TRUE;
      _rectPermission.fill = "[pattern,[fit,any,MTP_Icones/Locked_2.svg]]";
    }
    else
    {
      _rectPermission.visible = FALSE;
      _txtPermission.visible = FALSE;
    }

    if (_interlockEnabled && _interlock)
    {
      _rectLock.visible = TRUE;
      _txtLock.visible = TRUE;
      _rectLock.fill = "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]";
    }
    else if (_interlockEnabled && !_interlock)
    {
      _rectLock.visible = TRUE;
      _txtLock.visible = TRUE;
      _rectLock.fill = "[pattern,[fit,any,MTP_Icones/Locked_2.svg]]";
    }
    else
    {
      _rectLock.visible = FALSE;
      _txtLock.visible = FALSE;
    }

    if (_protectionEnabled && _protection)
    {
      _rectProtection.visible = TRUE;
      _txtProtection.visible = TRUE;
      _rectProtection.fill = "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]";
    }
    else if (_protectionEnabled && !_protection)
    {
      _rectProtection.visible = TRUE;
      _txtProtection.visible = TRUE;
      _rectProtection.fill = "[pattern,[fit,any,MTP_Icones/Locked_2.svg]]";
    }
    else
    {
      _rectProtection.visible = FALSE;
      _txtProtection.visible = FALSE;
    }
  }

  private void setAutomaticPreviewLineCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_openAutomatic":
        _openAutomatic = state;
        break;

      case "_closeAutomatic":
        _closeAutomatic = state;
        break;
    }

    if (!_stateAutomaticActive && _openAutomatic)
    {
      _rectValveOpenAut.visible = TRUE;
      _rectValveCloseAut.visible = FALSE;
    }
    else if (!_stateAutomaticActive && _closeAutomatic)
    {
      _rectValveOpenAut.visible = FALSE;
      _rectValveCloseAut.visible = TRUE;
    }
    else
    {
      _rectValveOpenAut.visible = FALSE;
      _rectValveCloseAut.visible = FALSE;
    }
  }

  private void setSafetyPositionActiveCB(const string &varName, const bool &value)
  {
    switch (varName)
    {
      case "_safetypositionActive":
        _safetypositionActive = value;
        break;

      case "_safetypositionEnabled":
        _safetypositionEnabled = value;
        break;
    }

    if (_safetypositionActive && _safetypositionEnabled)
    {
      _rectSafetyPosition.visible = TRUE;
      _txtSafetyPosition.visible = TRUE;
      _rectSafetyPositionInformation.visible = TRUE;
      _rectSafetyPosition.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
      _rectSafetyPosition.sizeAsDyn = makeDynInt(25, 25);
    }
    else if (!_safetypositionActive && _safetypositionEnabled)
    {
      _rectSafetyPosition.visible = TRUE;
      _txtSafetyPosition.visible = TRUE;
      _rectSafetyPositionInformation.visible = TRUE;
      _rectSafetyPosition.fill = "[pattern,[fit,any,MTP_Icones/GreyOk.svg]]";
      _rectSafetyPosition.sizeAsDyn = makeDynInt(30, 25);
    }
    else
    {
      _rectSafetyPosition.visible = FALSE;
      _txtSafetyPosition.visible = FALSE;
      _rectSafetyPositionInformation.visible = FALSE;
    }
  }

  private void setErrorCB(const string &varName, const bool &error)
  {
    switch (varName)
    {
      case "_staticError":
        _staticError = error;
        break;

      case "_dynamicError":
        _dynamicError = error;
        break;
    }

    if (_monitorEnabled && !_staticError && !_dynamicError)
    {
      _rectError.visible = TRUE;
      _txtError.visible = TRUE;
      _rectErrorInformation.visible = TRUE;
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectError.sizeAsDyn = makeDynInt(30, 25);
    }
    else if (_monitorEnabled && (_staticError || _dynamicError))
    {
      _rectError.visible = TRUE;
      _txtError.visible = TRUE;
      _rectErrorInformation.visible = TRUE;
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/Mainenance_2.svg]]";
      _rectError.sizeAsDyn = makeDynInt(25, 25);
    }
    else if (!_monitorEnabled)
    {
      _rectError.visible = FALSE;
      _txtError.visible = FALSE;
      _rectErrorInformation.visible = FALSE;
    }
  }

  private void setValveCB(const string &varName, const bool &valve)
  {
    switch (varName)
    {
      case "_staticError":
        _staticError = valve;
        break;

      case "_dynamicError":
        _dynamicError = valve;
        break;

      case "_openCheckbackSignal":
        _openCheckbackSignal = valve;
        break;

      case "_closeCheckbackSignal":
        _closeCheckbackSignal = valve;
        break;

      case "_valveControl":
        _valveControl = valve;
        break;
    }

    if (_openCheckbackSignal && _valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[tile,any,MTP_Icones/ValvOpen.svg]]";
      _rectValve.visible = TRUE;
      return;
    }
    else if (_closeCheckbackSignal && !_valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[tile,any,MTP_Icones/ValvStopped.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (!_openCheckbackSignal && !_closeCheckbackSignal && _valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[tile,any,MTP_Icones/ValvMfwdStarted.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (!_openCheckbackSignal && !_closeCheckbackSignal && !_valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[tile,any,MTP_Icones/ValvMfwdStopped.svg]]";
      _rectValve.visible = TRUE;
    }
    else if ((_openCheckbackSignal && _closeCheckbackSignal) || _dynamicError || _staticError)
    {
      _rectValve.fill = "[pattern,[tile,any,MTP_Icones/ValvUknownState.svg]]";
      _rectValve.visible = TRUE;
    }
    else
    {
      _rectValve.visible = FALSE;
    }
  }
};
