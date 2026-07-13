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
#uses "classes/MTP_MonAnaVlv/MTP_MonAnaVlv"
#uses "classes/MTP_Monitor/MTP_Monitor"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_MonAnaVlvRef
 * @brief Represents the MTP_MonAnaVlvRef class.
 */
class MTP_MonAnaVlvRef : MTP_ViewRef
{
  protected shape _rectError; //!< Reference to the error rectangle shape.
  protected shape _rectLocked; //!< Reference to the locked rectangle shape.
  protected shape _rectMode; //!< Reference to the mode rectangle shape.
  protected shape _rectValve; //!< Reference to the motor rectangle shape.
  protected shape _rectDirection; //!< Reference to the direction rectangle shape.
  protected shape _rectSource; //!< Reference to the source rectangle shape.
  protected shape _txtUnit; //!< Reference to the first unit text shape.
  protected shape _txtUnit2; //!< Reference to the second unit text shape.
  protected shape _txtPosition; //!< Reference to the RPM text shape.
  protected shape _txtPositionFbk; //!< Reference to the RPM feedback text shape.

  protected bool _staticError; //!< Indicates if a static error is active.
  private bool _dynamicError; //!< Indicates if a dynamic error is active.
  private bool _monitorPositionError; //!< Indicates if the monitor position error is active.
  protected bool _sourceManualActive; //!< Indicates if the manual source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal source is active.

  protected bool _permit; //!< Indicates if the permit is active.
  private bool _interlock; //!< Indicates if the interlock is active.
  private bool _protection; //!< Indicates if the protection is active.

  protected bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.

  protected bool _openFeedbackSignal;
  private bool _closeFeedbackSignal; //!< Indicates if the close feedback signal is active.
  private bool _openActive; //!< Indicates if the open is active.
  private bool _closeActive; //!< Indicates if the close is active.

  /**
   * @brief Constructor for MTP_MonAnaVlvRef.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaVlv view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_MonAnaVlvRef(shared_ptr<MTP_MonAnaVlv> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setPositionFeedbackCB, MTP_ViewRef::getViewModel(), MTP_MonAnaVlv::positionFeedbackChanged);
    classConnect(this, setPositionCB, MTP_ViewRef::getViewModel(), MTP_MonAnaVlv::positionChanged);

    classConnectUserData(this, setErrorCB, "_staticError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);
    classConnectUserData(this, setErrorCB, "_monitorPositionError", MTP_ViewRef::getViewModel(), MTP_MonAnaVlv::monitorPositionErrorChanged);

    classConnectUserData(this, setLockedCB, "_permit", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::permitChanged);
    classConnectUserData(this, setLockedCB, "_interlock", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::interlockChanged);
    classConnectUserData(this, setLockedCB, "_protection", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::protectionChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MTP_ViewRef::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MTP_ViewRef::getViewModel().getState(), MTP_State::operatorActiveChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::internalActiveChanged);

    classConnectUserData(this, setValveCB, "_openFeedbackSignal", MTP_ViewRef::getViewModel(), MTP_MonAnaVlv::openFeedbackChanged);
    classConnectUserData(this, setValveCB, "_monitorPositionError", MTP_ViewRef::getViewModel(), MTP_MonAnaVlv::monitorPositionErrorChanged);
    classConnectUserData(this, setValveCB, "_closeFeedbackSignal", MTP_ViewRef::getViewModel(), MTP_MonAnaVlv::closeFeedbackChanged);
    classConnectUserData(this, setValveCB, "_openActive", MTP_ViewRef::getViewModel(), MTP_MonAnaVlv::openActiveChanged);
    classConnectUserData(this, setValveCB, "_closeActive", MTP_ViewRef::getViewModel(), MTP_MonAnaVlv::closeActiveChanged);
    classConnectUserData(this, setValveCB, "_staticError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setValveCB, "_dynamicError", MTP_ViewRef::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);

    _staticError =  MTP_ViewRef::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MTP_ViewRef::getViewModel().getMonitor().getDynamicError();
    _permit =  MTP_ViewRef::getViewModel().getSecurity().getPermit();
    _interlock =  MTP_ViewRef::getViewModel().getSecurity().getInterlock();
    _protection =  MTP_ViewRef::getViewModel().getSecurity().getProtection();
    _stateOffActive =  MTP_ViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MTP_ViewRef::getViewModel().getState().getOperatorActive();
    _openFeedbackSignal =  MTP_ViewRef::getViewModel().getOpenFeedback();
    _monitorPositionError =  MTP_ViewRef::getViewModel().getMonitorPositionError();
    _closeFeedbackSignal =  MTP_ViewRef::getViewModel().getCloseFeedback();
    _openActive =  MTP_ViewRef::getViewModel().getOpenActive();
    _closeActive =  MTP_ViewRef::getViewModel().getCloseActive();
    _sourceManualActive = MTP_ViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MTP_ViewRef::getViewModel().getSource().getInternalActive();

    setUnit(MTP_ViewRef::getViewModel().getPositionUnit());
    setErrorCB("_staticError", _staticError);
    setLockedCB("_permit", _permit);
    setModeCB("_stateOffActive", _stateOffActive);
    setSourceCB("_sourceManualActive", _sourceManualActive);
    setValveCB("_openFeedbackSignal", _openFeedbackSignal);
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
    _rectSource = MTP_ViewRef::extractShape("_rectSource");
    _txtUnit = MTP_ViewRef::extractShape("_txtUnit");
    _txtUnit2 = MTP_ViewRef::extractShape("_txtUnit2");
    _txtPosition = MTP_ViewRef::extractShape("_txtPosition");
    _txtPositionFbk = MTP_ViewRef::extractShape("_txtPositionFbk");
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
   * @brief Sets the Position feedback signal for the reference.
   *
   * @param rpmFbk The float Position feedback value to be set.
   */
  protected void setPositionFeedbackCB(const float &positionFbk)
  {
    if (_txtPositionFbk.enabled())
    {
      _txtPositionFbk.text = positionFbk;
    }
  }

  /**
   * @brief Sets the Position value for the reference.
   *
   * @param rpm The float Position value to be set.
   */
  protected void setPositionCB(const float &position)
  {
    if (_txtPosition.enabled())
    {
      _txtPosition.text = position;
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

      case "_monitorPositionError":
        _monitorPositionError = error;
        break;
    }

    if (_rectError.enabled())
    {
      if (_monitorPositionError || _staticError || _dynamicError)
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
   * @brief Sets the valve status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param valve The valve state to be set.
   */
  protected void setValveCB(const string &varName, const bool &valve)
  {
    switch (varName)
    {
      case "_openFeedbackSignal":
        _openFeedbackSignal = valve;
        break;

      case "_monitorPositionError":
        _monitorPositionError = valve;
        break;

      case "_closeFeedbackSignal":
        _closeFeedbackSignal = valve;
        break;

      case "_openActive":
        _openActive = valve;
        break;

      case "_closeActive":
        _closeActive = valve;
        break;

      case "_staticError":
        _staticError = valve;
        break;

      case "_dynamicError":
        _dynamicError = valve;
        break;
    }

    if (_rectValve.enabled())
    {
      if (_openFeedbackSignal && !_dynamicError && !_staticError && !_monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvOpen.svg]]";
        _rectValve.visible = TRUE;
        return;
      }
      else if (_closeFeedbackSignal && !_dynamicError && !_staticError && !_monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvStopped.svg]]";
        _rectValve.visible = TRUE;
      }
      else if (_openActive && !_dynamicError && !_staticError && !_monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStarted.svg]]";
        _rectValve.visible = TRUE;
      }
      else if (!_openFeedbackSignal && !_closeFeedbackSignal && _closeActive && !_dynamicError && !_staticError && !_monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStopped.svg]]";
        _rectValve.visible = TRUE;
      }
      else if ((_openFeedbackSignal && _closeFeedbackSignal) || _dynamicError || _staticError || _monitorPositionError)
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
