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
#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class MonBinVlvRef
 * @brief Represents the reference implementation for the MonBinVlv objects.
 */
class MonBinVlvRef : MtpViewRef
{
  private shape _rectError; //!< Reference to the error rectangle shape.
  private shape _rectLocked; //!< Reference to the locked rectangle shape.
  private shape _rectMode; //!< Reference to the mode rectangle shape.
  private shape _rectValve; //!< Reference to the valve rectangle shape.

  private bool _staticError; //!< Indicates if a static error is active.
  private bool _dynamicError; //!< Indicates if a dynamic error is active.
  private bool _permit; //!< Indicates if the permit is active.
  private bool _interlock; //!< Indicates if the interlock is active.
  private bool _protection; //!< Indicates if the protection is active.

  private bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.
  private bool _openCheckbackSignal; //!< Indicates if the open checkback signal is active.
  private bool _closeCheckbackSignal; //!< Indicates if the close checkback signal is active.
  private bool _valveControl; //!< Indicates if the valve control is active.

  /**
   * @brief Constructor for MonBinVlvRef.
   *
   * @param viewModel A shared pointer to the MonBinVlv view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MonBinVlvRef(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnectUserData(this, setErrorCB, "_staticError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnectUserData(this, setLockedCB, "_permit", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::permitChanged);
    classConnectUserData(this, setLockedCB, "_interlock", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::interlockChanged);
    classConnectUserData(this, setLockedCB, "_protection", MtpViewRef::getViewModel().getSecurity(), MtpSecurity::protectionChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MtpViewRef::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MtpViewRef::getViewModel().getState(), MtpState::operatorActiveChanged);

    classConnectUserData(this, setValveCB, "_openCheckbackSignal", MtpViewRef::getViewModel(), MonBinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_closeCheckbackSignal", MtpViewRef::getViewModel(), MonBinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_valveControl", MtpViewRef::getViewModel(), MonBinVlv::valveControlChanged);
    classConnectUserData(this, setValveCB, "_staticError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setValveCB, "_dynamicError", MtpViewRef::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    _staticError =  MtpViewRef::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MtpViewRef::getViewModel().getMonitor().getDynamicError();
    _permit =  MtpViewRef::getViewModel().getSecurity().getPermit();
    _interlock =  MtpViewRef::getViewModel().getSecurity().getInterlock();
    _protection =  MtpViewRef::getViewModel().getSecurity().getProtection();
    _stateOffActive =  MtpViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MtpViewRef::getViewModel().getState().getOperatorActive();
    _openCheckbackSignal = MtpViewRef::getViewModel().getOpenCheckbackSignal();
    _closeCheckbackSignal = MtpViewRef::getViewModel().getCloseCheckbackSignal();
    _valveControl = MtpViewRef::getViewModel().getValveControl();

    setErrorCB("_staticError", _staticError);
    setLockedCB("_permit", _permit);
    setModeCB("_stateOffActive", _stateOffActive);
    setValveCB("_openCheckbackSignal", _openCheckbackSignal);
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
    _rectValve = MtpViewRef::extractShape("_rectValve");
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

  /**
   * @brief Sets the valve status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param valve The valve state to be set.
   */
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
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvOpen.svg]]";
      _rectValve.visible = TRUE;
      return;
    }
    else if (_closeCheckbackSignal && !_valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvStopped.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (!_openCheckbackSignal && !_closeCheckbackSignal && _valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStarted.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (!_openCheckbackSignal && !_closeCheckbackSignal && !_valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStopped.svg]]";
      _rectValve.visible = TRUE;
    }
    else if ((_openCheckbackSignal && _closeCheckbackSignal) || _dynamicError || _staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvUknownState.svg]]";
      _rectValve.visible = TRUE;
    }
    else
    {
      _rectValve.visible = FALSE;
    }
  }
};
