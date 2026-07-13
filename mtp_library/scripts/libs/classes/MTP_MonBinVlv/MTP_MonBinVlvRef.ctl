// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_Monitor/MTP_Monitor"
#uses "classes/MTP_MonBinVlv/MTP_MonBinVlv"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_MonBinVlvRef
 * @brief Represents the MTP_MonBinVlvRef class.
 */
class MTP_MonBinVlvRef : MTP_ViewRef
{
  protected shape _rectError; //!< Reference to the error rectangle shape.
  protected shape _rectLocked; //!< Reference to the locked rectangle shape.
  protected shape _rectMode; //!< Reference to the mode rectangle shape.
  protected shape _rectValve; //!< Reference to the valve rectangle shape.

  protected bool _staticError; //!< Indicates if a static error is active.
  private bool _dynamicError; //!< Indicates if a dynamic error is active.
  protected bool _permit; //!< Indicates if the permit is active.
  private bool _interlock; //!< Indicates if the interlock is active.
  private bool _protection; //!< Indicates if the protection is active.

  protected bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.
  protected bool _openCheckbackSignal; //!< Indicates if the open checkback signal is active.
  private bool _closeCheckbackSignal; //!< Indicates if the close checkback signal is active.
  private bool _valveControl; //!< Indicates if the valve control is active.

  /**
   * @brief Constructor for MTP_MonBinVlvRef.
   *
   * @param viewModel A shared pointer to the MTP_MonBinVlv view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_MonBinVlvRef(shared_ptr<MTP_MonBinVlv> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnectUserData(this, setErrorCB, "_staticError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);

    classConnectUserData(this, setLockedCB, "_permit", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::permitChanged);
    classConnectUserData(this, setLockedCB, "_interlock", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::interlockChanged);
    classConnectUserData(this, setLockedCB, "_protection", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::protectionChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MTP_ViewRef::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MTP_ViewRef::getViewModel().getState(), MTP_State::operatorActiveChanged);

    classConnectUserData(this, setValveCB, "_openCheckbackSignal", MTP_ViewRef::getViewModel(), MTP_MonBinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_closeCheckbackSignal", MTP_ViewRef::getViewModel(), MTP_MonBinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_valveControl", MTP_ViewRef::getViewModel(), MTP_MonBinVlv::valveControlChanged);
    classConnectUserData(this, setValveCB, "_staticError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setValveCB, "_dynamicError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);

    _staticError =  MTP_ViewRef::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MTP_ViewRef::getViewModel().getMonitor().getDynamicError();
    _permit =  MTP_ViewRef::getViewModel().getSecurity().getPermit();
    _interlock =  MTP_ViewRef::getViewModel().getSecurity().getInterlock();
    _protection =  MTP_ViewRef::getViewModel().getSecurity().getProtection();
    _stateOffActive =  MTP_ViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MTP_ViewRef::getViewModel().getState().getOperatorActive();
    _openCheckbackSignal = MTP_ViewRef::getViewModel().getOpenCheckbackSignal();
    _closeCheckbackSignal = MTP_ViewRef::getViewModel().getCloseCheckbackSignal();
    _valveControl = MTP_ViewRef::getViewModel().getValveControl();

    setErrorCB("_staticError", _staticError);
    setLockedCB("_permit", _permit);
    setModeCB("_stateOffActive", _stateOffActive);
    setValveCB("_openCheckbackSignal", _openCheckbackSignal);
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    _rectError = MTP_ViewRef::extractShape("_rectError");
    _rectLocked = MTP_ViewRef::extractShape("_rectLocked");
    _rectMode = MTP_ViewRef::extractShape("_rectMode");
    _rectValve = MTP_ViewRef::extractShape("_rectValve");
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
    }

    if (_rectError.enabled())
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
   * @brief Sets the valve status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param valve The valve state to be set.
   */
  protected void setValveCB(const string &varName, const bool &valve)
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

    if (_rectValve.enabled())
    {
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
  }
};
