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

class MonBinDrvRef : MtpViewRef
{
  private shape _rectError;
  private shape _rectLocked;
  private shape _rectMode;
  private shape _rectMotor;
  private shape _rectDirection;

  private bool _staticError;
  private bool _dynamicError;
  private bool _permit;
  private bool _interlock;
  private bool _protection;

  private bool _stateOffActive;
  private bool _stateOperatorActive;

  private bool _forwardFeedbackSignal;
  private bool _reverseFeedbackSignal;
  private bool _forwardControl;
  private bool _reverseControl;

  public MonBinDrvRef(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnectUserData(this, setErrorCB, "_staticError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

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

    setErrorCB("_staticError", _staticError);
    setLockedCB("_permit", _permit);
    setModeCB("_stateOffActive", _stateOffActive);
    setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
    setDirectionCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
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

    if (_staticError || _dynamicError)
    {
      _rectError.fill = "[pattern,[tile,any,MTP_Icones/Error.svg]]";
      _rectError.visible = TRUE;
      return;
    }
    else
    {
      _rectError.visible = FALSE;
    }
  }

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

    if (!_permit || !_interlock || !_protection)
    {
      _rectLocked.fill = "[pattern,[tile,any,MTP_Icones/locked_.svg]]";
      _rectLocked.visible = TRUE;
      return;
    }
    else
    {
      _rectLocked.visible = FALSE;
    }
  }

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

    if (_forwardFeedbackSignal && !_reverseFeedbackSignal)
    {
      _rectDirection.fill = "[pattern,[tile,any,MTP_Icones/Play.svg]]";
      _rectDirection.visible = TRUE;
      return;
    }
    else if (_reverseFeedbackSignal && !_forwardFeedbackSignal)
    {
      _rectDirection.fill = "[pattern,[tile,any,MTP_Icones/Play_2.svg]]";
      _rectDirection.visible = TRUE;
      return;
    }
    else
    {
      _rectDirection.visible = FALSE;
    }
  }

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

    if (_stateOffActive)
    {
      _rectMode.fill = "[pattern,[tile,any,MTP_Icones/Power.svg]]";
      _rectMode.visible = TRUE;
      return;
    }
    else if (_stateOperatorActive)
    {
      _rectMode.fill = "[pattern,[tile,any,MTP_Icones/Manual_1.svg]]";
      _rectMode.visible = TRUE;
    }
    else
    {
      _rectMode.visible = FALSE;
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
};
