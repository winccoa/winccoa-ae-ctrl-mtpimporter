// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_MonAnaDrv/MTP_MonAnaDrv"
#uses "classes/MTP_Monitor/MTP_Monitor"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_MonAnaDrvRef
 * @brief Represents the MTP_MonAnaDrvRef class.
 */
class MTP_MonAnaDrvRef : MTP_ViewRef
{
  protected shape _rectError; //!< Reference to the error rectangle shape.
  protected shape _rectLocked; //!< Reference to the locked rectangle shape.
  protected shape _rectMode; //!< Reference to the mode rectangle shape.
  protected shape _rectMotor; //!< Reference to the motor rectangle shape.
  protected shape _rectDirection; //!< Reference to the direction rectangle shape.
  protected shape _rectSource; //!< Reference to the source rectangle shape.
  protected shape _txtUnit; //!< Reference to the first unit text shape.
  protected shape _txtUnit2; //!< Reference to the second unit text shape.
  protected shape _txtRpm; //!< Reference to the RPM text shape.
  protected shape _txtRpmFbk; //!< Reference to the RPM feedback text shape.

  protected bool _staticError; //!< Indicates if a static error is active.
  private bool _dynamicError; //!< Indicates if a dynamic error is active.
  private bool _driveSafetyIndicator; //!< Indicates if the drive safety indicator is active.
  private bool _rpmAlarmHighActive; //!< Indicates if the RPM high alarm is active.
  private bool _rpmAlarmLowActive; //!< Indicates if the RPM low alarm is active.
  protected bool _sourceManualActive; //!< Indicates if the manual source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal source is active.

  protected bool _permit; //!< Indicates if the permit is active.
  private bool _interlock; //!< Indicates if the interlock is active.
  private bool _protection; //!< Indicates if the protection is active.

  protected bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.

  protected bool _forwardFeedbackSignal; //!< Indicates if the forward feedback signal is active.
  private bool _reverseFeedbackSignal; //!< Indicates if the reverse feedback signal is active.
  private bool _forwardControl; //!< Indicates if the forward control is active.
  private bool _reverseControl; //!< Indicates if the reverse control is active.

  /**
   * @brief Constructor for MTP_MonAnaDrvRef.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_MonAnaDrvRef(shared_ptr<MTP_MonAnaDrv> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setRpmFeedbackSignalCB, MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::rpmFeedbackSignalChanged);
    classConnect(this, setRpmCB, MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::rpmChanged);

    classConnectUserData(this, setErrorCB, "_staticError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);
    classConnectUserData(this, setErrorCB, "_driveSafetyIndicator", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::driveSafetyIndicatorChanged);
    classConnectUserData(this, setErrorCB, "_rpmAlarmHighActive", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::rpmAlarmHighActiveChanged);
    classConnectUserData(this, setErrorCB, "_rpmAlarmLowActive", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::rpmAlarmLowActiveChanged);

    classConnectUserData(this, setLockedCB, "_permit", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::permitChanged);
    classConnectUserData(this, setLockedCB, "_interlock", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::interlockChanged);
    classConnectUserData(this, setLockedCB, "_protection", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::protectionChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MTP_ViewRef::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MTP_ViewRef::getViewModel().getState(), MTP_State::operatorActiveChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::internalActiveChanged);

    classConnectUserData(this, setDirectionCB, "_forwardFeedbackSignal", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setDirectionCB, "_reverseFeedbackSignal", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::reverseFeedbackSignalChanged);

    classConnectUserData(this, setMotorCB, "_forwardFeedbackSignal", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_reverseFeedbackSignal", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_forwardControl", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::forwardControlChanged);
    classConnectUserData(this, setMotorCB, "_reverseControl", MTP_ViewRef::getViewModel(), MTP_MonAnaDrv::reverseControlChanged);
    classConnectUserData(this, setMotorCB, "_staticError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setMotorCB, "_dynamicError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);

    _staticError =  MTP_ViewRef::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MTP_ViewRef::getViewModel().getMonitor().getDynamicError();
    _permit =  MTP_ViewRef::getViewModel().getSecurity().getPermit();
    _interlock =  MTP_ViewRef::getViewModel().getSecurity().getInterlock();
    _protection =  MTP_ViewRef::getViewModel().getSecurity().getProtection();
    _stateOffActive =  MTP_ViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MTP_ViewRef::getViewModel().getState().getOperatorActive();
    _forwardFeedbackSignal =  MTP_ViewRef::getViewModel().getForwardFeedbackSignal();
    _reverseFeedbackSignal =  MTP_ViewRef::getViewModel().getReverseFeedbackSignal();
    _forwardControl =  MTP_ViewRef::getViewModel().getForwardControl();
    _reverseControl =  MTP_ViewRef::getViewModel().getReverseControl();
    _driveSafetyIndicator = MTP_ViewRef::getViewModel().getDriveSafetyIndicator();
    _rpmAlarmHighActive = MTP_ViewRef::getViewModel().getRpmAlarmHighActive();
    _rpmAlarmLowActive = MTP_ViewRef::getViewModel().getRpmAlarmLowActive();
    _sourceManualActive = MTP_ViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MTP_ViewRef::getViewModel().getSource().getInternalActive();

    setUnit(MTP_ViewRef::getViewModel().getRpmUnit());
    setErrorCB("_staticError", _staticError);
    setLockedCB("_permit", _permit);
    setModeCB("_stateOffActive", _stateOffActive);
    setSourceCB("_sourceManualActive", _sourceManualActive);
    setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
    setDirectionCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
    setRpmFeedbackSignalCB(MTP_ViewRef::getViewModel().getRpmFeedbackSignal());
    setRpmCB(MTP_ViewRef::getViewModel().getRpm());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    _rectError = MTP_ViewRef::extractShape("_rectError");
    _rectLocked = MTP_ViewRef::extractShape("_rectLocked");
    _rectMode = MTP_ViewRef::extractShape("_rectMode");
    _rectMotor = MTP_ViewRef::extractShape("_rectMotor");
    _rectDirection = MTP_ViewRef::extractShape("_rectDirection");
    _rectSource = MTP_ViewRef::extractShape("_rectSource");
    _txtUnit = MTP_ViewRef::extractShape("_txtUnit");
    _txtUnit2 = MTP_ViewRef::extractShape("_txtUnit2");
    _txtRpm = MTP_ViewRef::extractShape("_txtRpm");
    _txtRpmFbk = MTP_ViewRef::extractShape("_txtRpmFbk");
  }

  /**
   * @brief Sets the unit for the reference.
   *
   * @param unit A shared pointer to the MTP_Unit object representing the unit.
   */
  protected void setUnit(shared_ptr<MTP_Unit> unit)
  {
    if (_txtUnit.enabled())
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
  protected void setRpmFeedbackSignalCB(const float &rpmFbk)
  {
    if (_txtRpmFbk.enabled())
    {
      _txtRpmFbk.text = rpmFbk;
    }
  }

  /**
   * @brief Sets the RPM value for the reference.
   *
   * @param rpm The float RPM value to be set.
   */
  protected void setRpmCB(const float &rpm)
  {
    if (_txtRpm.enabled())
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
  protected void setErrorCB(const string &varName, const bool &error)
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

    if (_rectError.enabled())
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
  protected void setLockedCB(const string &varName, const bool &locked)
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

    if (_rectLocked.enabled())
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
  protected void setDirectionCB(const string &varName, const bool &direction)
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

    if (_rectDirection.enabled())
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
  protected void setModeCB(const string &varName, const bool &mode)
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

    if (_rectMode.enabled())
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
  protected void setSourceCB(const string &varName, const bool &source)
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

    if (_rectSource.enabled())
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
  protected void setMotorCB(const string &varName, const bool &motor)
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

    if (_rectMotor.enabled())
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
