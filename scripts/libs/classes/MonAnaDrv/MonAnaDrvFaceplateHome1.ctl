// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpBarIndicator/MtpBarIndicator"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewBase"

class MonAnaDrvFaceplateHome : MtpViewBase
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

  private bool _stateOffActive;
  private bool _stateChannel;
  private bool _stateOperatorActive;
  private bool _stateAutomaticActive;

  private bool _forwardFeedbackSignal;
  private bool _reverseFeedbackSignal;
  private bool _forwardControl;
  private bool _reverseControl;
  private bool _staticError;
  private bool _dynamicError;
  private bool _monitorEnabled;

  private bool _permissionEnabled;
  private bool _permit;
  private bool _interlockEnabled;
  private bool _interlock;
  private bool _protectionEnabled;
  private bool _protection;

  private bool _driveSafetyIndicator;
  private bool _rpmAlarmHighActive;
  private bool _rpmAlarmLowActive;

  private shared_ptr<MtpBarIndicator> _refBarIndicator;  //!< Reference to the bar indicator for displaying values.

  public MonAnaDrvFaceplateHome(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MtpBarIndicator::setValueCustomLimit, MtpViewBase::getViewModel(), MonAnaDrv::rpmChanged);
    classConnectUserData(this, setErrorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);
    classConnect(this, setSafetyPositionActiveCB, MtpViewBase::getViewModel(), MonAnaDrv::safetyPositionActiveChanged);
    classConnect(this, setMotorProtectionCB, MtpViewBase::getViewModel(), MonAnaDrv::driveSafetyIndicatorChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);

    //Security:
    classConnectUserData(this, setSecurityCB, "_permissionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permissionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_permit", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permitChanged);
    classConnectUserData(this, setSecurityCB, "_interlockEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_interlock", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockChanged);
    classConnectUserData(this, setSecurityCB, "_protectionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_protection", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionChanged);

    //Motor Icon:
    classConnectUserData(this, setMotorCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonAnaDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonAnaDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_forwardControl", MtpViewBase::getViewModel(), MonAnaDrv::forwardControlChanged);
    classConnectUserData(this, setMotorCB, "_reverseControl", MtpViewBase::getViewModel(), MonAnaDrv::reverseControlChanged);
    classConnectUserData(this, setMotorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setMotorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

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
    classConnectUserData(this, setResetCB, "_rpmAlarmHighActive", MtpViewBase::getViewModel(), MonAnaDrv::rpmAlarmHighActiveChanged);
    classConnectUserData(this, setResetCB, "_rpmAlarmLowActive", MtpViewBase::getViewModel(), MonAnaDrv::rpmAlarmLowActiveChanged);
    classConnectUserData(this, setResetCB, "_driveSafetyIndicator",  MtpViewBase::getViewModel(), MonAnaDrv::driveSafetyIndicatorChanged);

    _staticError =  MtpViewBase::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MtpViewBase::getViewModel().getMonitor().getDynamicError();
    _forwardFeedbackSignal =  MtpViewBase::getViewModel().getForwardFeedbackSignal();
    _reverseFeedbackSignal =  MtpViewBase::getViewModel().getReverseFeedbackSignal();
    _forwardControl =  MtpViewBase::getViewModel().getForwardControl();
    _reverseControl =  MtpViewBase::getViewModel().getReverseControl();
    _monitorEnabled = MtpViewBase::getViewModel().getMonitor().getEnabled();

    _driveSafetyIndicator =  MtpViewBase::getViewModel().getDriveSafetyIndicator();
    _rpmAlarmHighActive =  MtpViewBase::getViewModel().getRpmAlarmHighActive();
    _rpmAlarmLowActive =  MtpViewBase::getViewModel().getRpmAlarmLowActive();

    _stateOffActive =  MtpViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MtpViewBase::getViewModel().getState().getChannel();
    _stateOperatorActive =  MtpViewBase::getViewModel().getState().getOperatorActive();
    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();

    _permissionEnabled =  MtpViewBase::getViewModel().getSecurity().getPermissionEnabled();
    _permit =  MtpViewBase::getViewModel().getSecurity().getPermit();
    _interlockEnabled =  MtpViewBase::getViewModel().getSecurity().getInterlockEnabled();
    _interlock =  MtpViewBase::getViewModel().getSecurity().getInterlock();
    _protectionEnabled =  MtpViewBase::getViewModel().getSecurity().getProtectionEnabled();
    _protection =  MtpViewBase::getViewModel().getSecurity().getProtection();

    _refBarIndicator.setAlertHighShape(FALSE, MtpViewBase::getViewModel().getRpmMax());
    _refBarIndicator.setAlertLowShape(FALSE, MtpViewBase::getViewModel().getRpmMin());
    _refBarIndicator.setScale(MtpViewBase::getViewModel().getRpmScaleMin(), MtpViewBase::getViewModel().getRpmScaleMax());
    _refBarIndicator.hideUnit();
    _refBarIndicator.hideValue();

    _refBarIndicator.setValueCustomLimit(MtpViewBase::getViewModel().getRpm());
    setSafetyPositionActiveCB(MtpViewBase::getViewModel().getSafetyPositionActive());
    setMotorProtectionCB(_driveSafetyIndicator);
    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setErrorCB("_staticError", _staticError);
    setSecurityCB("_permissionEnabled", _permissionEnabled);
    setResetCB("_stateOperatorActive", _stateOperatorActive);
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

  protected void initializeShapes()
  {
    _refBarIndicator = MtpViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();

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
      _rectMotorProtection.fill = "[pattern,[fit,any,MTP_Icones/Error.svg]]";
      _rectMotorProtection.sizeAsDyn = makeDynInt(25, 25);
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

      case "_rpmAlarmHighActive":
        _rpmAlarmHighActive = reset;
        break;

      case "_rpmAlarmLowActive":
        _rpmAlarmLowActive = reset;
        break;

      case "_driveSafetyIndicator":
        _driveSafetyIndicator = reset;
        break;
    }

    if (_stateOperatorActive && ((_protectionEnabled && !_protection) || _staticError || _dynamicError || _rpmAlarmHighActive || _rpmAlarmLowActive || !_driveSafetyIndicator))
    {
      _rectReset.fill = "[pattern,[fit,any,MTP_Icones/reset_2.svg]]";
    }
    else
    {
      _rectReset.fill = "[pattern,[fit,any,MTP_Icones/reset_1.svg]]";
    }

    _rectReset.transparentForMouse = (_rectReset.fill == "[pattern,[fit,any,MTP_Icones/reset_1.svg]]");
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
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/Error.svg]]";
      _rectError.sizeAsDyn = makeDynInt(25, 25);
    }
    else if (!_monitorEnabled)
    {
      _rectError.visible = FALSE;
      _txtError.visible = FALSE;
      _rectErrorInformation.visible = FALSE;
    }
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
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
      return;
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
};
