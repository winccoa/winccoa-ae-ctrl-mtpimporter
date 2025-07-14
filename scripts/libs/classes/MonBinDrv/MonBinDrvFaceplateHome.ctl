// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewBase"

class MonBinDrvFaceplateHome : MtpViewBase
{
  private shape _refWqc;
  private shape _rectAutomatic;
  private shape _rectError;
  private shape _rectErrorInformation;
  private shape _rectForward;
  private shape _rectForwardAut;
  private shape _rectLock;
  private shape _rectMotor;
  private shape _rectMotorProtection;
  private shape _rectOff;
  private shape _rectOperator;
  private shape _rectPermission;
  private shape _rectProtection;
  private shape _rectReset;
  private shape _rectReverse;
  private shape _rectReverseAut;
  private shape _rectSafetyPosition;
  private shape _rectSafetyPositionInformation;
  private shape _rectStop;
  private shape _rectStopAut;
  private shape _txtError;
  private shape _txtLock;
  private shape _txtMotorProtection;
  private shape _txtPermission;
  private shape _txtProtection;
  private shape _txtSafetyPosition;

  private bool _forwardFeedbackSignal;
  private bool _reverseFeedbackSignal;
  private bool _forwardControl;
  private bool _reverseControl;
  private bool _staticError;
  private bool _dynamicError;
  private bool _monitorEnabled;
  private bool _stateAutomaticActive;
  private bool _forwardAutomatic;
  private bool _stopAutomatic;
  private bool _reverseAutomatic;

  private bool _permissionEnabled;
  private bool _permit;
  private bool _interlockEnabled;
  private bool _interlock;
  private bool _protectionEnabled;
  private bool _protection;

  private bool _stateOffActive;
  private bool _stateChannel;
  private bool _stateOperatorActive;
  private bool _driveSafetyIndicator;

  public MonBinDrvFaceplateHome(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setMotorCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_forwardControl", MtpViewBase::getViewModel(), MonBinDrv::forwardControlChanged);
    classConnectUserData(this, setMotorCB, "_reverseControl", MtpViewBase::getViewModel(), MonBinDrv::reverseControlChanged);
    classConnectUserData(this, setMotorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setMotorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnectUserData(this, setErrorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnectUserData(this, setAutomaticPreviewLineCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_forwardAutomatic", MtpViewBase::getViewModel(), MonBinDrv::forwardAutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_stopAutomatic", MtpViewBase::getViewModel(), MonBinDrv::stopAutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_reverseAutomatic", MtpViewBase::getViewModel(), MonBinDrv::reverseAutomaticChanged);

    classConnectUserData(this, setSecurityCB, "_permissionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permissionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_permit", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permitChanged);
    classConnectUserData(this, setSecurityCB, "_interlockEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_interlock", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockChanged);
    classConnectUserData(this, setSecurityCB, "_protectionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_protection", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionChanged);

    classConnect(this, setMotorProtectionCB, MtpViewBase::getViewModel(), MonBinDrv::driveSafetyIndicatorChanged);
    classConnect(this, setSafetyPositionActiveCB, MtpViewBase::getViewModel(), MonBinDrv::safetyPositionActiveChanged);

    //Buttons:
    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MtpViewBase::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setResetCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setResetCB, "_protectionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionEnabledChanged);
    classConnectUserData(this, setResetCB, "_protection", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionChanged);
    classConnectUserData(this, setResetCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setResetCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);
    classConnectUserData(this, setResetCB, "_driveSafetyIndicator",  MtpViewBase::getViewModel(), MonBinDrv::driveSafetyIndicatorChanged);

    classConnectUserData(this, setReverseCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setReverseCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setReverseCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setReverseCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setReverseCB, "_reverseControl", MtpViewBase::getViewModel(), MonBinDrv::reverseControlChanged);

    classConnectUserData(this, setStopCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setStopCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setStopCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setStopCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setStopCB, "_reverseControl", MtpViewBase::getViewModel(), MonBinDrv::reverseControlChanged);
    classConnectUserData(this, setStopCB, "_forwardControl", MtpViewBase::getViewModel(), MonBinDrv::forwardControlChanged);

    classConnectUserData(this, setForwardCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setForwardCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setForwardCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setForwardCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setForwardCB, "_forwardControl", MtpViewBase::getViewModel(), MonBinDrv::forwardControlChanged);

    _stateOffActive =  MtpViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MtpViewBase::getViewModel().getState().getChannel();
    _stateOperatorActive =  MtpViewBase::getViewModel().getState().getOperatorActive();
    _driveSafetyIndicator =  MtpViewBase::getViewModel().getDriveSafetyIndicator();

    _staticError =  MtpViewBase::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MtpViewBase::getViewModel().getMonitor().getDynamicError();
    _forwardFeedbackSignal =  MtpViewBase::getViewModel().getForwardFeedbackSignal();
    _reverseFeedbackSignal =  MtpViewBase::getViewModel().getReverseFeedbackSignal();
    _forwardControl =  MtpViewBase::getViewModel().getForwardControl();
    _reverseControl =  MtpViewBase::getViewModel().getReverseControl();
    _monitorEnabled = MtpViewBase::getViewModel().getMonitor().getEnabled();
    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();
    _forwardAutomatic =  MtpViewBase::getViewModel().getForwardAutomatic();
    _stopAutomatic =  MtpViewBase::getViewModel().getStopAutomatic();
    _reverseAutomatic =  MtpViewBase::getViewModel().getReverseAutomatic();

    _permissionEnabled =  MtpViewBase::getViewModel().getSecurity().getPermissionEnabled();
    _permit =  MtpViewBase::getViewModel().getSecurity().getPermit();
    _interlockEnabled =  MtpViewBase::getViewModel().getSecurity().getInterlockEnabled();
    _interlock =  MtpViewBase::getViewModel().getSecurity().getInterlock();
    _protectionEnabled =  MtpViewBase::getViewModel().getSecurity().getProtectionEnabled();
    _protection =  MtpViewBase::getViewModel().getSecurity().getProtection();

    setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setErrorCB("_staticError", _staticError);
    setMotorProtectionCB(MtpViewBase::getViewModel().getDriveSafetyIndicator());
    setAutomaticPreviewLineCB("_stateAutomaticActive", _stateAutomaticActive);
    setSafetyPositionActiveCB(MtpViewBase::getViewModel().getSafetyPositionActive());
    setSecurityCB("_permissionEnabled", _permissionEnabled);

    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setResetCB("_stateOperatorActive", _stateOperatorActive);
    setReverseCB("_stateOperatorActive", _stateOperatorActive);
    setStopCB("_stateOperatorActive", _stateOperatorActive);
    setForwardCB("_stateOperatorActive", _stateOperatorActive);
  }

  public void activateStateOff()
  {
    MtpViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  public void activateStateOperator()
  {
    MtpViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  public void activateStateAutomatic()
  {
    MtpViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  public void activateReset()
  {
    MtpViewBase::getViewModel().setResetOperator(TRUE);
  }

  public void activateReverse()
  {
    MtpViewBase::getViewModel().setReverseOperator(TRUE);
  }

  public void activateStop()
  {
    MtpViewBase::getViewModel().setStopOperator(TRUE);
  }

  public void activateForward()
  {
    MtpViewBase::getViewModel().setForwardOperator(TRUE);
  }

  public void openErrorInformation()
  {
    MtpViewBase::openChildPanel("object_parts/MonBinDrv/MonBinDrvFaceplateErrorInformation.xml", "Error Information");
  }

  public void openSafetyPositionInformation()
  {
    MtpViewBase::openChildPanel("object_parts/MonBinDrv/MonBinDrvFaceplateSafetyPositionInformation.xml", "SafetyPosition Information");
  }

  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectErrorInformation = MtpViewBase::extractShape("_rectErrorInformation");
    _rectForward = MtpViewBase::extractShape("_rectForward");
    _rectForwardAut = MtpViewBase::extractShape("_rectForwardAut");
    _rectLock = MtpViewBase::extractShape("_rectLock");
    _rectMotor = MtpViewBase::extractShape("_rectMotor");
    _rectMotorProtection = MtpViewBase::extractShape("_rectMotorProtection");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _rectPermission = MtpViewBase::extractShape("_rectPermission");
    _rectProtection = MtpViewBase::extractShape("_rectProtection");
    _rectReset = MtpViewBase::extractShape("_rectReset");
    _rectReverse = MtpViewBase::extractShape("_rectReverse");
    _rectReverseAut = MtpViewBase::extractShape("_rectReverseAut");
    _rectSafetyPosition = MtpViewBase::extractShape("_rectSafetyPosition");
    _rectSafetyPositionInformation = MtpViewBase::extractShape("_rectSafetyPositionInformation");
    _rectStop = MtpViewBase::extractShape("_rectStop");
    _rectStopAut = MtpViewBase::extractShape("_rectStopAut");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtLock = MtpViewBase::extractShape("_txtLock");
    _txtMotorProtection = MtpViewBase::extractShape("_txtMotorProtection");
    _txtPermission = MtpViewBase::extractShape("_txtPermission");
    _txtProtection = MtpViewBase::extractShape("_txtProtection");
    _txtSafetyPosition = MtpViewBase::extractShape("_txtSafetyPosition");
  }

  private void setResetCB(const string &varName, const bool &reset)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = reset;
        break;

      case "_protectionEnabled":
        _protectionEnabled = reset;
        break;

      case "_protection":
        _protection = reset;
        break;

      case "_staticError":
        _staticError = reset;
        break;

      case "_dynamicError":
        _dynamicError = reset;
        break;

      case "_driveSafetyIndicator":
        _driveSafetyIndicator = reset;
        break;
    }

    if (_stateOperatorActive && ((_protectionEnabled && !_protection) || _staticError || _dynamicError || !_driveSafetyIndicator))
    {
      _rectReset.fill = "[pattern,[fit,any,MTP_Icones/reset_2.svg]]";
    }
    else
    {
      _rectReset.fill = "[pattern,[fit,any,MTP_Icones/reset_1.svg]]";
    }

    _rectReset.transparentForMouse = (_rectReset.fill == "[pattern,[fit,any,MTP_Icones/reset_1.svg]]");
  }

  private void setAutomaticActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if (_stateAutomaticActive && _stateChannel)
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]";
    }
    else if (_stateAutomaticActive && !_stateChannel)
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_2_rounded.svg]]";
    }
    else
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_3_rounded.svg]]";
    }

    _rectAutomatic.transparentForMouse = (_rectAutomatic.fill == "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]");
  }


  private void setOperatorActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if (_stateOperatorActive && _stateChannel)
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/operator_1.svg]]";
    }
    else if (_stateOperatorActive && !_stateChannel)
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/operator_2.svg]]";
    }
    else
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/operator_3.svg]]";
    }

    _rectOperator.transparentForMouse = (_rectOperator.fill == "[pattern,[fit,any,MTP_Icones/operator_1.svg]]");
  }

  private void setStateOffActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOffActive":
        _stateOffActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if (_stateOffActive && _stateChannel)
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]";
    }
    else if (_stateOffActive && !_stateChannel)
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_3_rounded.svg]]";
    }
    else
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_1_rounded.svg]]";
    }

    _rectOff.transparentForMouse = (_rectOff.fill == "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]");
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

  private void setMotorProtectionCB(const bool &_driveSafetyIndicator)
  {
    if (_driveSafetyIndicator)
    {
      _rectMotorProtection.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectMotorProtection.sizeAsDyn = makeDynInt(30, 25);
    }
    else
    {
      _rectMotorProtection.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectMotorProtection.sizeAsDyn = makeDynInt(30, 25);
    }
  }

  private void setSafetyPositionActiveCB(const bool &safetypositionActive)
  {
    if (safetypositionActive)
    {
      _rectSafetyPosition.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
      _rectSafetyPosition.sizeAsDyn = makeDynInt(25, 25);
    }
    else
    {
      _rectSafetyPosition.fill = "[pattern,[fit,any,MTP_Icones/GreyOk.svg]]";
      _rectSafetyPosition.sizeAsDyn = makeDynInt(30, 25);
    }
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  private void setAutomaticPreviewLineCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_forwardAutomatic":
        _forwardAutomatic = state;
        break;

      case "_stopAutomatic":
        _stopAutomatic = state;
        break;

      case "_reverseAutomatic":
        _reverseAutomatic = state;
        break;
    }

    if (!_stateAutomaticActive && _forwardAutomatic)
    {
      _rectForwardAut.visible = TRUE;
      _rectStopAut.visible = FALSE;
      _rectReverseAut.visible = FALSE;
    }
    else if (!_stateAutomaticActive && _stopAutomatic)
    {
      _rectForwardAut.visible = FALSE;
      _rectStopAut.visible = TRUE;
      _rectReverseAut.visible = FALSE;
    }
    else if (!_stateAutomaticActive && _reverseAutomatic)
    {
      _rectForwardAut.visible = FALSE;
      _rectStopAut.visible = FALSE;
      _rectReverseAut.visible = TRUE;
    }
    else
    {
      _rectForwardAut.visible = FALSE;
      _rectStopAut.visible = FALSE;
      _rectReverseAut.visible = FALSE;
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
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectError.sizeAsDyn = makeDynInt(30, 25);
    }
    else if (!_monitorEnabled)
    {
      _rectError.visible = FALSE;
      _txtError.visible = FALSE;
      _rectErrorInformation.visible = FALSE;
    }
  }

  private void setMotorCB(const string &varName, const bool &motor)
  {
    switch (varName)
    {
      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = motor;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = motor;
        break;

      case "_forwardControl":
        _forwardControl = motor;
        break;

      case "_reverseControl":
        _reverseControl = motor;
        break;

      case "_staticError":
        _staticError = motor;
        break;

      case "_dynamicError":
        _dynamicError = motor;
        break;
    }

    if (((_forwardFeedbackSignal && _forwardControl) || (_reverseFeedbackSignal && _reverseControl)) && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorRun.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if (!_forwardFeedbackSignal && !_forwardControl && !_reverseFeedbackSignal && !_reverseControl && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorStopped.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if (((_forwardFeedbackSignal && !_reverseFeedbackSignal) || (!_forwardFeedbackSignal && _reverseFeedbackSignal)) && !_forwardControl && !_reverseControl && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorMfwdStopped.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if (((_forwardControl && !_reverseControl) || (!_forwardControl && _reverseControl)) && !_forwardFeedbackSignal && !_reverseFeedbackSignal && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorMfwdStarted.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if ((_forwardFeedbackSignal && _reverseFeedbackSignal) || _dynamicError || _staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorUnknown.svg]]";
      _rectMotor.visible = TRUE;
    }
    else
    {
      _rectMotor.visible = FALSE;
    }
  }

  private void setReverseCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = state;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = state;
        break;

      case "_reverseControl":
        _reverseControl = state;
        break;
    }

    if (_stateAutomaticActive && _reverseFeedbackSignal && !_forwardFeedbackSignal)
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_1_rounded.svg]]";
    }
    else if (_stateOperatorActive && _reverseFeedbackSignal && !_forwardFeedbackSignal)
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_2_rounded.svg]]";
    }
    else if (_stateAutomaticActive && _reverseControl && !_reverseFeedbackSignal)
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_3_rounded.svg]]";
    }
    else if (_stateOperatorActive && _reverseControl && !_reverseFeedbackSignal)
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_4_rounded.svg]]";
    }
    else
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_5_rounded.svg]]";
    }

    _rectReverse.transparentForMouse = (_rectReverse.fill == "[pattern,[fit,any,MTP_Icones/revers_1_rounded.svg]]");
  }

  private void setStopCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = state;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = state;
        break;

      case "_reverseControl":
        _reverseControl = state;
        break;

      case "_forwardControl":
        _forwardControl = state;
        break;
    }

    if (_stateAutomaticActive && !_reverseFeedbackSignal && !_forwardFeedbackSignal)
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_1.svg]]";
    }
    else if (_stateOperatorActive && !_reverseFeedbackSignal && !_forwardFeedbackSignal)
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_2.svg]]";
    }
    else if (_stateAutomaticActive && !_reverseControl && !_forwardControl)
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_3.svg]]";
    }
    else if (_stateOperatorActive && !_reverseControl && !_forwardControl)
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_4.svg]]";
    }
    else
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_5.svg]]";
    }

    _rectStop.transparentForMouse = (_rectStop.fill == "[pattern,[fit,any,MTP_Icones/stop_1.svg]]");
  }

  private void setForwardCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = state;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = state;
        break;

      case "_forwardControl":
        _forwardControl = state;
        break;
    }

    if (_stateAutomaticActive && !_reverseFeedbackSignal && _forwardFeedbackSignal)
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_1_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_reverseFeedbackSignal && _forwardFeedbackSignal)
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_2_rounded.svg]]";
    }
    else if (_stateAutomaticActive && _forwardControl && !_forwardFeedbackSignal)
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_3_rounded.svg]]";
    }
    else if (_stateOperatorActive && _forwardControl && !_forwardFeedbackSignal)
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_4_rounded.svg]]";
    }
    else
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_5_rounded.svg]]";
    }

    _rectForward.transparentForMouse = (_rectForward.fill == "[pattern,[fit,any,MTP_Icones/forward_1_rounded.svg]]");
  }
};
