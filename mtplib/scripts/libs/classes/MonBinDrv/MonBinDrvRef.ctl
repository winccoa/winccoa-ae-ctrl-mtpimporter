// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpState/MtpState"
#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class MonBinDrvRef
 * @brief Represents the reference implementation for the MonBinDrv objects.
 */
class MonBinDrvRef : MtpViewRef
{
  private shape _rectError; //!< Reference to the error rectangle shape.
  private shape _rectLocked; //!< Reference to the locked rectangle shape.
  private shape _rectMode; //!< Reference to the mode rectangle shape.
  private shape _rectMotor; //!< Reference to the motor rectangle shape.
  private shape _rectDirection; //!< Reference to the direction rectangle shape.
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.

  private bool _staticError; //!< Indicates if a static error is active.
  private bool _dynamicError; //!< Indicates if a dynamic error is active.
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
   * @brief Constructor for MonBinDrvRef.
   *
   * @param viewModel A shared pointer to the MonBinDrv view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MonBinDrvRef(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnectUserData(this, setErrorCB, "_staticError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);
    classConnect(this, setEnabledCB, MtpViewRef::getViewModel(), MonBinDrv::enabledChanged);

    classConnectUserData(this, setLockedCB, "_permit", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::permitChanged);
    classConnectUserData(this, setLockedCB, "_interlock", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::interlockChanged);
    classConnectUserData(this, setLockedCB, "_protection", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::protectionChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MtpViewRef::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MtpViewRef::getViewModel().getState(), MtpState::operatorActiveChanged);

    classConnectUserData(this, setDirectionCB, "_forwardFeedbackSignal", MtpViewRef::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setDirectionCB, "_reverseFeedbackSignal", MtpViewRef::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);

    classConnectUserData(this, setMotorCB, "_forwardFeedbackSignal", MtpViewRef::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_reverseFeedbackSignal", MtpViewRef::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_forwardControl", MtpViewRef::getViewModel(), MonBinDrv::forwardControlChanged);
    classConnectUserData(this, setMotorCB, "_reverseControl", MtpViewRef::getViewModel(), MonBinDrv::reverseControlChanged);
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
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorStopped.svg]]";
    }
    else
    {
      _rectDisabled.visible = FALSE;

      setErrorCB("_staticError", _staticError);
      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
      setDirectionCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
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
    }

    if (_enabled)
    {
      if (_staticError || _dynamicError)
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
