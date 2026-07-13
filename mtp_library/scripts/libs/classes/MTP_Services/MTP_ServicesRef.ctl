// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Services/MTP_Services"
#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_ServicesRef
 * @brief Represents the MTP_ServicesRef class.
 */
class MTP_ServicesRef : MTP_ViewRef
{
  protected shape _rectCurrentState; //!< Reference to the current state rectangle shape.
  protected shape _rectStateBackground; //!< Reference to the current state background rectangle shape.
  protected shape _rectSource; //!< Reference to the source rectangle shape.
  protected shape _rectMode; //!< Reference to the mode rectangle shape.
  protected shape _txtCurrentProcedure; //!< Reference to the current procedure text shape.

  protected bool _blinkingActive; //!< Indicates if blinking is active.
  protected bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.
  private bool _stateAutomaticActive; //!< Indicates if the automatic state is active.

  protected bool _srcExternalActive; //!< Indicates if the external source is active.
  private bool _srcInternalActive; //!< Indicates if the internal source is active.

  private bool _blinkThreadRunning; //!< Indicates if the blink thread is currently running.

  /**
   * @brief Constructor for MTP_ServicesRef.
   *
   * @param viewModel A shared pointer to the MTP_Services view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_ServicesRef(shared_ptr<MTP_Services> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setCurrentStateCB, MTP_ViewRef::getViewModel(), MTP_Services::currentStateChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MTP_ViewRef::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MTP_ViewRef::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setModeCB, "_stateAutomaticActive", MTP_ViewRef::getViewModel().getState(), MTP_State::automaticActiveChanged);

    classConnectUserData(this, setSourceCB, "_srcExternalActive", MTP_ViewRef::getViewModel(), MTP_Services::sourceExternalActiveChanged);
    classConnectUserData(this, setSourceCB, "_srcInternalActive", MTP_ViewRef::getViewModel(), MTP_Services::sourceInternalActiveChanged);
    classConnectUserData(this, setSourceCB, "_stateAutomaticActive", MTP_ViewRef::getViewModel().getState(), MTP_State::automaticActiveChanged);

    _blinkingActive = FALSE;
    _blinkThreadRunning = FALSE;
    _stateOffActive =  MTP_ViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MTP_ViewRef::getViewModel().getState().getOperatorActive();
    _stateAutomaticActive =  MTP_ViewRef::getViewModel().getState().getAutomaticActive();
    _srcExternalActive =  MTP_ViewRef::getViewModel().getSrcExternalActive();
    _srcInternalActive =  MTP_ViewRef::getViewModel().getSrcInternalActive();

    setModeCB("_stateOffActive", _stateOffActive);
    setSourceCB("_srcExternalActive", _srcExternalActive);
    setCurrentStateCB(MTP_ViewRef::getViewModel().getCurrentState());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    _rectCurrentState = MTP_ViewRef::extractShape("_rectCurrentState");
    _rectStateBackground = MTP_ViewRef::extractShape("_rectStateBackground");
    _rectSource = MTP_ViewRef::extractShape("_rectSource");
    _rectMode = MTP_ViewRef::extractShape("_rectMode");
    _txtCurrentProcedure = MTP_ViewRef::extractShape("_txtCurrentProcedure");
  }

  /**
  * @brief Sets the current state for the reference.
  *
  * @param currentState The uint current state value to be set.
  */
  protected void setCurrentStateCB(const uint &currentState)
  {
    if (_rectCurrentState.enabled())
    {
      switch (currentState)
      {
        case 16:
          _blinkingActive = FALSE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreyCircle.svg]]";
          _rectCurrentState.visible = TRUE;
          break;

        case 32768:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreyCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 8:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 64:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
          break;

        case 4096:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 16384:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 128:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/RedCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 4:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/RedCircle.svg]]";
          break;

        case 65536:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 131072:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
          break;

        case 8192:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/YellowCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 32:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/YellowCircle.svg]]";
          break;

        case 1024:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/YellowCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 2048:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/YellowCircle.svg]]";
          break;

        case 256:
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/RedCircle.svg]]";
          _blinkingActive = TRUE;

          if (!_blinkThreadRunning)
          {
            _blinkThreadRunning = TRUE;
            startThread(this, "blinkThread");
          }

          break;

        case 512:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = TRUE;
          _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped.svg]]";
          _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/RedCircle.svg]]";
          break;

        default:
          _blinkingActive = FALSE;
          _rectCurrentState.visible = FALSE;
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

      case "_stateAutomaticActive":
        _stateAutomaticActive = mode;
        break;
    }

    if (_stateOffActive && _rectMode.enabled())
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Power.svg]]";
      _rectMode.visible = TRUE;
      return;
    }
    else if (_stateOperatorActive && _rectMode.enabled())
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Manual_1.svg]]";
      _rectMode.visible = TRUE;
    }
    else if (_stateAutomaticActive && _rectMode.enabled())
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
  protected void setSourceCB(const string &varName, const bool &source)
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

    if (_srcExternalActive && _stateAutomaticActive && _rectSource.enabled())
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/ExternalSource.svg]]";
      _rectSource.visible = TRUE;
      return;
    }
    else if (_srcInternalActive && _stateAutomaticActive && _rectSource.enabled())
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
  */
  private void blinkThread()
  {
    while (_blinkingActive)
    {
      _rectCurrentState.visible = !_rectCurrentState.visible;
      delay(0, 500);
    }

    _rectCurrentState.visible = TRUE;
    _blinkThreadRunning = FALSE;
  }
};
