// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpState/MtpState"
#uses "classes/Services/Services"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class ServicesRef
 * @brief Represents the reference implementation for the Services objects.
 */
class ServicesRef : MtpViewRef
{
  private shape _rectCurrentState; //!< Reference to the current state rectangle shape.
  private shape _rectSource; //!< Reference to the source rectangle shape.
  private shape _rectMode; //!< Reference to the mode rectangle shape.
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private shape _txtCurrentProcedure; //!< Reference to the current procedure text shape.

  private bool _blinkingActive; //!< Indicates if blinking is active.
  private bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.
  private bool _stateAutomaticActive; //!< Indicates if the automatic state is active.
  private bool _enabled; //!< Indicates if enabled is active.

  private bool _srcExternalActive; //!< Indicates if the external source is active.
  private bool _srcInternalActive; //!< Indicates if the internal source is active.

  /**
   * @brief Constructor for ServicesRef.
   *
   * @param viewModel A shared pointer to the Services view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public ServicesRef(shared_ptr<Services> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setCurrentStateCB, MtpViewRef::getViewModel(), Services::currentStateChanged);
    classConnect(this, setEnabledCB, MtpViewRef::getViewModel(), Services::enabledChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MtpViewRef::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MtpViewRef::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setModeCB, "_stateAutomaticActive", MtpViewRef::getViewModel().getState(), MtpState::automaticActiveChanged);

    classConnectUserData(this, setSourceCB, "_srcExternalActive", MtpViewRef::getViewModel(), Services::sourceExternalActiveChanged);
    classConnectUserData(this, setSourceCB, "_srcInternalActive", MtpViewRef::getViewModel(), Services::sourceInternalActiveChanged);
    classConnectUserData(this, setSourceCB, "_stateAutomaticActive", MtpViewRef::getViewModel().getState(), MtpState::automaticActiveChanged);

    _blinkingActive = FALSE;
    _stateOffActive =  MtpViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MtpViewRef::getViewModel().getState().getOperatorActive();
    _stateAutomaticActive =  MtpViewRef::getViewModel().getState().getAutomaticActive();
    _srcExternalActive =  MtpViewRef::getViewModel().getSrcExternalActive();
    _srcInternalActive =  MtpViewRef::getViewModel().getSrcInternalActive();

    setEnabledCB(MtpViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  * @details This method overrides the base class method to extract the shapes.
  */
  protected void initializeShapes() override
  {
    _rectCurrentState = MtpViewRef::extractShape("_rectCurrentState");
    _rectSource = MtpViewRef::extractShape("_rectSource");
    _rectMode = MtpViewRef::extractShape("_rectMode");
    _rectDisabled = MtpViewRef::extractShape("_rectDisabled");
    _txtCurrentProcedure = MtpViewRef::extractShape("_txtCurrentProcedure");
  }

  /**
  * @brief Sets the current state for the reference.
  *
  * @param currentState The long current state value to be set.
  */
  private void setCurrentStateCB(const long &currentState)
  {
    if (_enabled)
    {
      switch (currentState)
      {
        case 16:
          _blinkingActive = FALSE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
          _rectCurrentState.visible = TRUE;
          break;

        case 32768:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 8:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 64:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
          break;

        case 4096:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 16384:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 128:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 4:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped.svg]]";
          break;

        case 65536:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 131072:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
          break;

        case 8192:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 32:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused.svg]]";
          break;

        case 1024:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 2048:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld.svg]]";
          break;

        case 256:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped.svg]]";
          _blinkingActive = TRUE;
          startThread(this, "blinkThread");
          break;

        case 512:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped.svg]]";
          break;

        default:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = FALSE;
      }
    }
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
      _rectMode.visible = FALSE;
      _rectSource.visible = FALSE;
      _blinkingActive = FALSE;
      _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
      _rectCurrentState.visible = TRUE;
      _txtCurrentProcedure.visible = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;
      _txtCurrentProcedure.visible = TRUE;

      setModeCB("_stateOffActive", _stateOffActive);
      setSourceCB("_srcExternalActive", _srcExternalActive);
      setCurrentStateCB(MtpViewRef::getViewModel().getCurrentState());
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

      case "_stateAutomaticActive":
        _stateAutomaticActive = mode;
        break;
    }

    if (_stateOffActive && _enabled)
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Power.svg]]";
      _rectMode.visible = TRUE;
      return;
    }
    else if (_stateOperatorActive && _enabled)
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Manual_1.svg]]";
      _rectMode.visible = TRUE;
    }
    else if (_stateAutomaticActive && _enabled)
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/internal.svg]]";
      _rectMode.visible = TRUE;
    }
    else
    {
      _rectMode.visible = FALSE;
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
      case "_srcExternalActive":
        _srcExternalActive = source;
        break;

      case "_srcInternalActive":
        _srcInternalActive = source;
        break;

      case "_stateAutomaticActive":
        _stateAutomaticActive = source;
        break;
    }

    if (_srcExternalActive && _stateAutomaticActive && _enabled)
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/ExternalSource.svg]]";
      _rectSource.visible = TRUE;
      return;
    }
    else if (_srcInternalActive && _stateAutomaticActive && _enabled)
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/InternalSource.svg]]";
      _rectSource.visible = TRUE;
    }
    else
    {
      _rectSource.visible = FALSE;
    }
  }

  /**
  * @brief Thread function to handle the blinking effect.
  * @details Toggles the visibility of the _rectCurrentState shape every 250ms while _blinkingActive
  * is true. Uses delay to control timing and runs in a separate thread.
  */
  private void blinkThread()
  {
    while (_blinkingActive)
    {
      _rectCurrentState.visible = !_rectCurrentState.visible;
      delay(0, 250);
    }

    _rectCurrentState.visible = TRUE;
  }
};
