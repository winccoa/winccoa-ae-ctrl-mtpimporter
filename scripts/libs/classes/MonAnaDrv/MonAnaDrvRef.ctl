// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class MonAnaDrvRef
 * @brief Represents the reference implementation for the MonAnaDrv objects.
 */
class MonAnaDrvRef : MtpViewRef
{
  private shape _rectError; //!< Reference to the error rectangle shape.
  private shape _rectLocked; //!< Reference to the locked rectangle shape.
  private shape _rectMode; //!< Reference to the mode rectangle shape.
  private shape _rectMotor; //!< Reference to the motor rectangle shape.
  private shape _rectDirection; //!< Reference to the direction rectangle shape.
  private shape _rectSource; //!< Reference to the source rectangle shape.
  private shape _txtUnit; //!< Reference to the first unit text shape.
  private shape _txtUnit2; //!< Reference to the second unit text shape.
  private shape _txtRpm; //!< Reference to the RPM text shape.
  private shape _txtRpmFbk; //!< Reference to the RPM feedback text shape.
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.

  private bool _staticError; //!< Indicates if a static error is active.
  private bool _dynamicError; //!< Indicates if a dynamic error is active.
  private bool _driveSafetyIndicator; //!< Indicates if the drive safety indicator is active.
  private bool _rpmAlarmHighActive; //!< Indicates if the RPM high alarm is active.
  private bool _rpmAlarmLowActive; //!< Indicates if the RPM low alarm is active.
  private bool _sourceManualActive; //!< Indicates if the manual source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal source is active.

  private bool _permit; //!< Indicates if the permit is active.
  private bool _interlock; //!< Indicates if the interlock is active.
  private bool _protection; //!< Indicates if the protection is active.

  private bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.

  private bool _forwardFeedbackSignal; //!< Indicates if the forward feedback signal is active.
  private bool _reverseFeedbackSignal; //!< Indicates if the reverse feedback signal is active.
  private bool _forwardControl; //!< Indicates if the forward control is active.
  private bool _reverseControl; //!< Indicates if the reverse control is active.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MonAnaDrvRef.
   *
   * @param viewModel A shared pointer to the MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MonAnaDrvRef(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setRpmFeedbackSignalCB, MtpViewRef::getViewModel(), MonAnaDrv::rpmFeedbackSignalChanged);
    classConnect(this, setRpmCB, MtpViewRef::getViewModel(), MonAnaDrv::rpmChanged);
    classConnect(this, setEnabledCB, MtpViewRef::getViewModel(), MonAnaDrv::enabledChanged);

    classConnectUserData(this, setErrorCB, "_staticError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);
    classConnectUserData(this, setErrorCB, "_driveSafetyIndicator", MtpViewRef::getViewModel(), MonAnaDrv::driveSafetyIndicatorChanged);
    classConnectUserData(this, setErrorCB, "_rpmAlarmHighActive", MtpViewRef::getViewModel(), MonAnaDrv::rpmAlarmHighActiveChanged);
    classConnectUserData(this, setErrorCB, "_rpmAlarmLowActive", MtpViewRef::getViewModel(), MonAnaDrv::rpmAlarmLowActiveChanged);

    classConnectUserData(this, setLockedCB, "_permit", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::permitChanged);
    classConnectUserData(this, setLockedCB, "_interlock", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::interlockChanged);
    classConnectUserData(this, setLockedCB, "_protection", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::protectionChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MtpViewRef::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MtpViewRef::getViewModel().getState(), MtpState::operatorActiveChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MtpViewRef::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MtpViewRef::getViewModel().getSource(), MtpSource::internalActiveChanged);

    classConnectUserData(this, setDirectionCB, "_forwardFeedbackSignal", MtpViewRef::getViewModel(), MonAnaDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setDirectionCB, "_reverseFeedbackSignal", MtpViewRef::getViewModel(), MonAnaDrv::reverseFeedbackSignalChanged);

    classConnectUserData(this, setMotorCB, "_forwardFeedbackSignal", MtpViewRef::getViewModel(), MonAnaDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_reverseFeedbackSignal", MtpViewRef::getViewModel(), MonAnaDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_forwardControl", MtpViewRef::getViewModel(), MonAnaDrv::forwardControlChanged);
    classConnectUserData(this, setMotorCB, "_reverseControl", MtpViewRef::getViewModel(), MonAnaDrv::reverseControlChanged);
    classConnectUserData(this, setMotorCB, "_staticError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setMotorCB, "_dynamicError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    _staticError =  MtpViewRef::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MtpViewRef::getViewModel().getMonitor().getDynamicError();
    _permit =  MtpViewRef::getViewModel().getSecurity().getPermit();
    _interlock =  MtpViewRef::getViewModel().getSecurity().getInterlock();
    _protection =  MtpViewRef::getViewModel().getSecurity().getProtection();
    _stateOffActive =  MtpViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MtpViewRef::getViewModel().getState().getOperatorActive();
    _forwardFeedbackSignal =  MtpViewRef::getViewModel().getForwardFeedbackSignal();
    _reverseFeedbackSignal =  MtpViewRef::getViewModel().getReverseFeedbackSignal();
    _forwardControl =  MtpViewRef::getViewModel().getForwardControl();
    _reverseControl =  MtpViewRef::getViewModel().getReverseControl();
    _driveSafetyIndicator = MtpViewRef::getViewModel().getDriveSafetyIndicator();
    _rpmAlarmHighActive = MtpViewRef::getViewModel().getRpmAlarmHighActive();
    _rpmAlarmLowActive = MtpViewRef::getViewModel().getRpmAlarmLowActive();
    _sourceManualActive = MtpViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MtpViewRef::getViewModel().getSource().getInternalActive();

    setEnabledCB(MtpViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  * @details This method overrides the base class method to extract the shapes.
  */
  protected void initializeShapes() override
  {
    _rectError = MtpViewRef::extractShape("_rectError");
    _rectLocked = MtpViewRef::extractShape("_rectLocked");
    _rectMode = MtpViewRef::extractShape("_rectMode");
    _rectMotor = MtpViewRef::extractShape("_rectMotor");
    _rectDirection = MtpViewRef::extractShape("_rectDirection");
    _rectSource = MtpViewRef::extractShape("_rectSource");
    _txtUnit = MtpViewRef::extractShape("_txtUnit");
    _txtUnit2 = MtpViewRef::extractShape("_txtUnit2");
    _txtRpm = MtpViewRef::extractShape("_txtRpm");
    _txtRpmFbk = MtpViewRef::extractShape("_txtRpmFbk");
    _rectDisabled = MtpViewRef::extractShape("_rectDisabled");
  }

  /**
  * @brief Sets the enabled state for the reference.
  *
  * @param enabled The bool enabled value to be set.
  */
  private void setEnabledCB(const long &enabled)
  {
    _enabled = enabled;

    if (!enabled)
    {
      _rectDisabled.visible = TRUE;

      _rectError.visible = FALSE;
      _rectLocked.visible = FALSE;
      _rectMode.visible = FALSE;
      _rectDirection.visible = FALSE;
      _rectSource.visible = FALSE;
      _txtUnit.text = "undefined";
      _txtRpm.text = "0,00";
      _txtUnit2.text = "undefined";
      _txtRpmFbk.text = "0,00";
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorStopped.svg]]";
    }
    else
    {
      _rectDisabled.visible = FALSE;

      setUnit(MtpViewRef::getViewModel().getRpmUnit());
      setErrorCB("_staticError", _staticError);
      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setSourceCB("_sourceManualActive", _sourceManualActive);
      setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
      setDirectionCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
      setRpmFeedbackSignalCB(MtpViewRef::getViewModel().getRpmFeedbackSignal());
      setRpmCB(MtpViewRef::getViewModel().getRpm());
    }
  }

  /**
   * @brief Sets the unit for the reference.
   *
   * @param unit A shared pointer to the MtpUnit object representing the unit.
   */
  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    if (_enabled)
    {
      _txtUnit.text = unit.toString();
      _txtUnit2.text = unit.toString();
    }
  }

  /**
   * @brief Sets the RPM feedback signal for the reference.
   *
   * @param rpmFbk The float RPM feedback value to be set.
   */
  private void setRpmFeedbackSignalCB(const float &rpmFbk)
  {
    if (_enabled)
    {
      _txtRpmFbk.text = rpmFbk;
    }
  }

  /**
   * @brief Sets the RPM value for the reference.
   *
   * @param rpm The float RPM value to be set.
   */
  private void setRpmCB(const float &rpm)
  {
    if (_enabled)
    {
      _txtRpm.text = rpm;
    }
  }

  /**
   * @brief Sets the error status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param error The error state to be set.
   */
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

      case "_driveSafetyIndicator":
        _driveSafetyIndicator = error;
        break;

      case "_rpmAlarmHighActive":
        _rpmAlarmHighActive = error;
        break;

      case "_rpmAlarmLowActive":
        _rpmAlarmLowActive = error;
        break;
    }

    if (_enabled)
    {
      if (!_driveSafetyIndicator || _staticError || _dynamicError || _rpmAlarmHighActive || _rpmAlarmLowActive)
      {
        _rectError.fill = "[pattern,[fit,any,MTP_Icones/Error.svg]]";
        _rectError.visible = TRUE;
        return;
      }
      else
      {
        _rectError.visible = FALSE;
      }
    }
  }

  /**
   * @brief Sets the locked status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param locked The locked state to be set.
   */
  private void setLockedCB(const string &varName, const bool &locked)
  {
    switch (varName)
    {
      case "_permit":
        _permit = locked;
        break;

      case "_interlock":
        _interlock = locked;
        break;

      case "_protection":
        _protection = locked;
        break;
    }

    if (_enabled)
    {
      if (!_permit || !_interlock || !_protection)
      {
        _rectLocked.fill = "[pattern,[fit,any,MTP_Icones/locked_.svg]]";
        _rectLocked.visible = TRUE;
        return;
      }
      else
      {
        _rectLocked.visible = FALSE;
      }
    }
  }

  /**
   * @brief Sets the direction status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param direction The direction state to be set.
   */
  private void setDirectionCB(const string &varName, const bool &direction)
  {
    switch (varName)
    {
      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = direction;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = direction;
        break;
    }

    if (_enabled)
    {
      if (_forwardFeedbackSignal && !_reverseFeedbackSignal)
      {
        _rectDirection.fill = "[pattern,[fit,any,MTP_Icones/Play.svg]]";
        _rectDirection.visible = TRUE;
        return;
      }
      else if (_reverseFeedbackSignal && !_forwardFeedbackSignal)
      {
        _rectDirection.fill = "[pattern,[fit,any,MTP_Icones/Play_2.svg]]";
        _rectDirection.visible = TRUE;
        return;
      }
      else
      {
        _rectDirection.visible = FALSE;
      }
    }
  }

  /**
   * @brief Sets the mode status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param mode The mode state to be set.
   */
  private void setModeCB(const string &varName, const bool &mode)
  {
    switch (varName)
    {
      case "_stateOffActive":
        _stateOffActive = mode;
        break;

      case "_stateOperatorActive":
        _stateOperatorActive = mode;
        break;
    }

    if (_enabled)
    {
      if (_stateOffActive)
      {
        _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Power.svg]]";
        _rectMode.visible = TRUE;
        return;
      }
      else if (_stateOperatorActive)
      {
        _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Manual_1.svg]]";
        _rectMode.visible = TRUE;
      }
      else
      {
        _rectMode.visible = FALSE;
      }
    }
  }

  /**
   * @brief Sets the source status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param source The source state to be set.
   */
  private void setSourceCB(const string &varName, const bool &source)
  {
    switch (varName)
    {
      case "_sourceManualActive":
        _sourceManualActive = source;
        break;

      case "_sourceInternalActive":
        _sourceInternalActive = source;
        break;
    }

    if (_enabled)
    {
      if (_sourceManualActive)
      {
        _rectSource.fill = "[pattern,[fit,any,MTP_Icones/Manual__2.svg]]";
        _rectSource.visible = TRUE;
        return;
      }
      else if (_sourceInternalActive)
      {
        _rectSource.fill = "[pattern,[fit,any,MTP_Icones/internal.svg]]";
        _rectSource.visible = TRUE;
      }
      else
      {
        _rectSource.visible = FALSE;
      }
    }
  }

  /**
   * @brief Sets the motor status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param motor The motor state to be set.
   */
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

    if (_enabled)
    {
      if (((_forwardFeedbackSignal && _forwardControl) || (_reverseFeedbackSignal && _reverseControl)) && !_dynamicError && !_staticError)
      {
        _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorRun.svg]]";
        _rectMotor.visible = TRUE;
        return;
      }
      else if (!_forwardFeedbackSignal && !_forwardControl && !_reverseFeedbackSignal && !_reverseControl && !_dynamicError && !_staticError)
      {
        _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorStopped.svg]]";
        _rectMotor.visible = TRUE;
      }
      else if (((_forwardFeedbackSignal && !_reverseFeedbackSignal) || (!_forwardFeedbackSignal && _reverseFeedbackSignal)) && !_forwardControl && !_reverseControl && !_dynamicError && !_staticError)
      {
        _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorMfwdStopped.svg]]";
        _rectMotor.visible = TRUE;
      }
      else if (((_forwardControl && !_reverseControl) || (!_forwardControl && _reverseControl)) && !_forwardFeedbackSignal && !_reverseFeedbackSignal && !_dynamicError && !_staticError)
      {
        _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorMfwdStarted.svg]]";
        _rectMotor.visible = TRUE;
      }
      else if ((_forwardFeedbackSignal && _reverseFeedbackSignal) || _dynamicError || _staticError)
      {
        _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorUnknown.svg]]";
        _rectMotor.visible = TRUE;
      }
      else
      {
        _rectMotor.visible = FALSE;
      }
    }
  }
};
