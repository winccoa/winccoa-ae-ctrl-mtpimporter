// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Procedure/MTP_Procedure"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/ContextMenu/ContextMenuConfig"
#uses "classes/ContextMenu/ContextMenuCustom"
#uses "classes/MTP_Services/Procedure"
#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_Services/MTP_Services"

/**
 * @class ServicesFaceplateHome
 * @brief Represents the ServicesFaceplateHome class.
 */
class ServicesFaceplateHome : MTP_ViewBase
{
  private shape _rectCurrentStateProcedure; //!< Reference to the current state procedure rectangle shape.
  private shape _rectStateBackground; //!< Reference to the current state background rectangle shape.
  private shape _rectAutomatic; //!< Reference to the automatic rectangle shape.
  private shape _rectOff; //!< Reference to the off rectangle shape.
  private shape _rectOperator; //!< Reference to the operator rectangle shape.
  private shape _rectExternal; //!< Reference to the external rectangle shape.
  private shape _rectInternal; //!< Reference to the internal rectangle shape.
  private shape _rectPlay; //!< Reference to the play rectangle shape.
  private shape _rectPause; //!< Reference to the pause rectangle shape.
  private shape _rectFinished; //!< Reference to the finished rectangle shape.
  private shape _rectHeld; //!< Reference to the held rectangle shape.
  private shape _rectStopped; //!< Reference to the stopped rectangle shape.
  private shape _rectExecutionStopped; //!< Reference to the execution stopped rectangle shape.
  private shape _rectReset; //!< Reference to the reset rectangle shape.
  private shape _rectCurrentProcedure; //!< Reference to the current procedure rectangle shape.
  private shape _txtCurrentProcedure; //!< Reference to the current procedure text shape.
  private shape _rectRequestedProcedure; //!< Reference to the requested procedure rectangle shape.
  private shape _txtRequestedProcedure; //!< Reference to the requested procedure text shape.
  private shape _rectRequestedProcedureInformation; //!< Reference to the requested procedure information rectangle shape.

  private bool _blinkingActive; //!< Indicates if blinking is active for state visualization.
  private bool _osLevelStation; //!< Indicates if the operating system is at station level.
  private bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateChannel; //!< Indicates the channel state for procedure states.
  private bool _stateOperatorActive; //!< Indicates if the operator mode is active.
  private bool _stateAutomaticActive; //!< Indicates if the automatic mode is active.
  private bool _srcExternalActive; //!< Indicates if the external source mode is active.
  private bool _srcInternalActive; //!< Indicates if the internal source mode is active.
  private uint _stateCurrent; //!< The current state value of the procedure.

  private bool _blinkThreadRunning; //!< Indicates if the blink thread is currently running.

  private vector<shared_ptr<Procedure> > _procedures; //!< The procedures instance.
  private shared_ptr<ContextMenuCustom> _contextMenu; //!< The context menu instance.
  private shared_ptr<ContextMenuConfig> _contextConfig; //!< The context config instance.

  /**
   * @brief Constructor for ServicesFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_Services view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServicesFaceplateHome(shared_ptr<MTP_Services> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setCurrentStateCB, MTP_ViewBase::getViewModel(), MTP_Services::currentStateChanged);
    classConnect(this, setCurrentProcedureCB, MTP_ViewBase::getViewModel().getProcedure(), MTP_Procedure::currentChanged);
    classConnect(this, setRequestedProcedureCB, MTP_ViewBase::getViewModel().getProcedure(), MTP_Procedure::requestedChanged);
    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    //Buttons:
    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MTP_ViewBase::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    classConnectUserData(this, setSourceExternalCB, "_srcExternalActive", MTP_ViewBase::getViewModel(), MTP_Services::sourceExternalActiveChanged);
    classConnectUserData(this, setSourceExternalCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);

    classConnectUserData(this, setSourceInternalCB, "_srcInternalActive", MTP_ViewBase::getViewModel(), MTP_Services::sourceInternalActiveChanged);
    classConnectUserData(this, setSourceInternalCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);

    classConnectUserData(this, setStartCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setStartCB, "_stateCurrent", MTP_ViewBase::getViewModel(), MTP_Services::currentStateChanged);

    classConnectUserData(this, setPauseCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setPauseCB, "_stateCurrent", MTP_ViewBase::getViewModel(), MTP_Services::currentStateChanged);

    classConnectUserData(this, setFinishCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setFinishCB, "_stateCurrent", MTP_ViewBase::getViewModel(), MTP_Services::currentStateChanged);

    classConnectUserData(this, setHoldCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setHoldCB, "_stateCurrent", MTP_ViewBase::getViewModel(), MTP_Services::currentStateChanged);

    classConnectUserData(this, setStopCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setStopCB, "_stateCurrent", MTP_ViewBase::getViewModel(), MTP_Services::currentStateChanged);

    classConnectUserData(this, setAbortCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setAbortCB, "_stateCurrent", MTP_ViewBase::getViewModel(), MTP_Services::currentStateChanged);

    classConnectUserData(this, setResetCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setResetCB, "_stateCurrent", MTP_ViewBase::getViewModel(), MTP_Services::currentStateChanged);

    _procedures = MTP_ViewBase::getViewModel().getProcedures();
    _blinkingActive = FALSE;
    _blinkThreadRunning = FALSE;
    _stateOffActive =  MTP_ViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MTP_ViewBase::getViewModel().getState().getChannel();
    _stateOperatorActive =  MTP_ViewBase::getViewModel().getState().getOperatorActive();
    _stateAutomaticActive = MTP_ViewBase::getViewModel().getState().getAutomaticActive();
    _srcExternalActive = MTP_ViewBase::getViewModel().getSrcExternalActive();
    _srcInternalActive = MTP_ViewBase::getViewModel().getSrcInternalActive();
    _stateCurrent = MTP_ViewBase::getViewModel().getCurrentState();

    setCurrentStateCB(MTP_ViewBase::getViewModel().getCurrentState());
    setCurrentProcedureCB(MTP_ViewBase::getViewModel().getProcedure().getCurrent());
    setRequestedProcedureCB(MTP_ViewBase::getViewModel().getProcedure().getRequested());
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setSourceExternalCB("_srcExternalActive", _srcExternalActive);
    setSourceInternalCB("_srcInternalActive", _srcInternalActive);
    setStartCB("_stateOperatorActive", _stateOperatorActive);
    setPauseCB("_stateOperatorActive", _stateOperatorActive);
    setFinishCB("_stateOperatorActive", _stateOperatorActive);
    setHoldCB("_stateOperatorActive", _stateOperatorActive);
    setStopCB("_stateOperatorActive", _stateOperatorActive);
    setAbortCB("_stateOperatorActive", _stateOperatorActive);
    setResetCB("_stateOperatorActive", _stateOperatorActive);

    _contextConfig = new ContextMenuConfig();
  }

  /**
   * @brief Opens the custom procedures popupmenu.
   */
  public void proceduresPopUp()
  {
    int answer;

    _contextConfig.Clear();
    _contextConfig.AddPushButton("NOT_SELECTED", 0, 1);

    for (int i = 0; i < _procedures.count(); i++)
    {
      _contextConfig.AddPushButton(_procedures.at(i).getName(), i + 1, 1);
    }

    _contextMenu = new ContextMenuCustom(_contextConfig, _rectRequestedProcedureInformation.name());
    answer = _contextMenu.Open();

    if (answer == -1)
    {
      return;
    }

    MTP_ViewBase::getViewModel().getProcedure().setOperator(answer);
  }

  /**
     * @brief Activates the start command for the procedure.
     */
  public void activateStart()
  {
    MTP_ViewBase::getViewModel().setCommandOperator(4);
  }

  /**
     * @brief Activates the pause command for the procedure.
     */
  public void activatePause()
  {
    MTP_ViewBase::getViewModel().setCommandOperator(64);
  }

  /**
     * @brief Activates the finish command for the procedure.
     */
  public void activateFinish()
  {
    MTP_ViewBase::getViewModel().setCommandOperator(1024);
  }

  /**
     * @brief Activates the hold command for the procedure.
     */
  public void activateHold()
  {
    MTP_ViewBase::getViewModel().setCommandOperator(16);
  }

  /**
   * @brief Activates the stop command for the procedure.
   */
  public void activateStop()
  {
    MTP_ViewBase::getViewModel().setCommandOperator(8);
  }

  /**
     * @brief Activates the abort command for the procedure.
     */
  public void activateAbort()
  {
    MTP_ViewBase::getViewModel().setCommandOperator(256);
  }

  /**
   * @brief Activates the reset command for the procedure.
   */
  public void activateReset()
  {
    MTP_ViewBase::getViewModel().setCommandOperator(2);
  }

  /**
   * @brief Activates the off state.
   */
  public void activateStateOff()
  {
    MTP_ViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  /**
   * @brief Activates the operator mode.
   */
  public void activateStateOperator()
  {
    MTP_ViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  /**
   * @brief Activates the automatic mode.
   */
  public void activateStateAutomatic()
  {
    MTP_ViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  /**
  * @brief Activates the external mode.
  */
  public void activateExternalMode()
  {
    MTP_ViewBase::getViewModel().setSrcExternalOperator(TRUE);
  }

  /**
  * @brief Activates the internal mode.
  */
  public void activateInternalMode()
  {
    MTP_ViewBase::getViewModel().setSrcInternalOperator(TRUE);
  }

  /**
  * @brief Initializes the private shapes used in the faceplate.
  */
  protected void initializeShapes()
  {
    _rectCurrentStateProcedure = MTP_ViewBase::extractShape("_rectCurrentStateProcedure");
    _rectStateBackground = MTP_ViewBase::extractShape("_rectStateBackground");
    _rectAutomatic = MTP_ViewBase::extractShape("_rectAutomatic");
    _rectOff = MTP_ViewBase::extractShape("_rectOff");
    _rectOperator = MTP_ViewBase::extractShape("_rectOperator");
    _rectExternal = MTP_ViewBase::extractShape("_rectExternal");
    _rectInternal = MTP_ViewBase::extractShape("_rectInternal");
    _rectPlay = MTP_ViewBase::extractShape("_rectPlay");
    _rectPause = MTP_ViewBase::extractShape("_rectPause");
    _rectFinished = MTP_ViewBase::extractShape("_rectFinished");
    _rectHeld = MTP_ViewBase::extractShape("_rectHeld");
    _rectStopped = MTP_ViewBase::extractShape("_rectStopped");
    _rectExecutionStopped = MTP_ViewBase::extractShape("_rectExecutionStopped");
    _rectReset = MTP_ViewBase::extractShape("_rectReset");
    _rectCurrentProcedure = MTP_ViewBase::extractShape("_rectCurrentProcedure");
    _txtCurrentProcedure = MTP_ViewBase::extractShape("_txtCurrentProcedure");
    _rectRequestedProcedure = MTP_ViewBase::extractShape("_rectRequestedProcedure");
    _txtRequestedProcedure = MTP_ViewBase::extractShape("_txtRequestedProcedure");
    _rectRequestedProcedureInformation = MTP_ViewBase::extractShape("_rectRequestedProcedureInformation");
  }

  /**
  * @brief Callback function to update the operational station level and reset button states.
  *
  * @param oslevel The new operational station level state.
  */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setStateOffActiveCB("", FALSE);
    setOperatorActiveCB("", FALSE);
    setAutomaticActiveCB("", FALSE);
  }

  /**
   * @brief Callback function to update the reset button state.
   *
   * @param varName The variable name ("_stateOperatorActive" or "_stateCurrent") indicating which state is updated.
   * @param reset The new state value.
   */
  private void setResetCB(const string &varName, const anytype &reset)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = reset;
        break;

      case "_stateCurrent":
        _stateCurrent = reset;
        break;
    }

    if (_stateOperatorActive && _stateCurrent == 32768)
    {
      _rectReset.fill = "[pattern,[fit,any,MTP_Icones/reset_2.svg]]";
    }
    else
    {
      _rectReset.fill = "[pattern,[fit,any,MTP_Icones/reset_1.svg]]";
    }

    //_rectReset.transparentForMouse = (_rectReset.fill == "[pattern,[fit,any,MTP_Icones/reset_2.svg]]");
  }

  /**
   * @brief Callback function to update the abort button state.
   *
   * @param varName The variable name ("_stateOperatorActive" or "_stateCurrent") indicating which state is updated.
   * @param abort The new state value.
   */
  private void setAbortCB(const string &varName, const anytype &abort)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = abort;
        break;

      case "_stateCurrent":
        _stateCurrent = abort;
        break;
    }

    if (_stateOperatorActive && _stateCurrent == 512)
    {
      _rectExecutionStopped.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped_rounded1.svg]]";
    }
    else if (_stateOperatorActive && _stateCurrent == 256)
    {
      _rectExecutionStopped.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped_rounded2.svg]]";
    }
    else
    {
      _rectExecutionStopped.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped_rounded3.svg]]";
    }

    //_rectExecutionStopped.transparentForMouse = (_rectExecutionStopped.fill == "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped_rounded1.svg]]");
  }

  /**
   * @brief Callback function to update the stop button state.
   *
   * @param varName The variable name ("_stateOperatorActive" or "_stateCurrent") indicating which state is updated.
   * @param stop The new state value.
   */
  private void setStopCB(const string &varName, const anytype &stop)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = stop;
        break;

      case "_stateCurrent":
        _stateCurrent = stop;
        break;
    }

    if (_stateOperatorActive && _stateCurrent == 4)
    {
      _rectStopped.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped_rounded1.svg]]";
    }
    else if (_stateOperatorActive && _stateCurrent == 128)
    {
      _rectStopped.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped_rounded2.svg]]";
    }
    else
    {
      _rectStopped.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped_rounded3.svg]]";
    }

    //_rectStopped.transparentForMouse = (_rectStopped.fill == "[pattern,[fit,any,MTP_Icones/ProcedureStopped_rounded1.svg]]");
  }

  /**
   * @brief Callback function to update the hold button state.
   *
   * @param varName The variable name ("_stateOperatorActive" or "_stateCurrent") indicating which state is updated.
   * @param hold The new state value.
   */
  private void setHoldCB(const string &varName, const anytype &hold)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = hold;
        break;

      case "_stateCurrent":
        _stateCurrent = hold;
        break;
    }

    if (_stateOperatorActive && _stateCurrent == 2048)
    {
      _rectHeld.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld_rounded1.svg]]";
    }
    else if (_stateOperatorActive && _stateCurrent == 1024)
    {
      _rectHeld.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld_rounded2.svg]]";
    }
    else
    {
      _rectHeld.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld_rounded3.svg]]";
    }

    //_rectHeld.transparentForMouse = (_rectHeld.fill == "[pattern,[fit,any,MTP_Icones/ProcedureHeld_rounded1.svg]]");
  }

  /**
   * @brief Callback function to update the finish button state.
   *
   * @param varName The variable name ("_stateOperatorActive" or "_stateCurrent") indicating which state is updated.
   * @param finish The new state value.
   */
  private void setFinishCB(const string &varName, const anytype &finish)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = finish;
        break;

      case "_stateCurrent":
        _stateCurrent = finish;
        break;
    }

    if (_stateOperatorActive && _stateCurrent == 131072)
    {
      _rectFinished.fill = "[pattern,[fit,any,MTP_Icones/ProcedureFinished_rounded1.svg]]";
    }
    else if (_stateOperatorActive && _stateCurrent == 65536)
    {
      _rectFinished.fill = "[pattern,[fit,any,MTP_Icones/ProcedureFinished_rounded2.svg]]";
    }
    else
    {
      _rectFinished.fill = "[pattern,[fit,any,MTP_Icones/ProcedureFinished_rounded3.svg]]";
    }

    //_rectFinished.transparentForMouse = (_rectFinished.fill == "[pattern,[fit,any,MTP_Icones/ProcedureFinished_rounded1.svg]]");
  }

  /**
     * @brief Callback function to update the pause button state.
     *
     * @param varName The variable name ("_stateOperatorActive" or "_stateCurrent") indicating which state is updated.
     * @param pause The new state value.
     */
  private void setPauseCB(const string &varName, const anytype &pause)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = pause;
        break;

      case "_stateCurrent":
        _stateCurrent = pause;
        break;
    }

    if (_stateOperatorActive && _stateCurrent == 32)
    {
      _rectPause.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused_rounded1.svg]]";
    }
    else if (_stateOperatorActive && _stateCurrent == 8192)
    {
      _rectPause.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused_rounded2.svg]]";
    }
    else
    {
      _rectPause.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused_rounded3.svg]]";
    }

    //_rectPause.transparentForMouse = (_rectPause.fill == "[pattern,[fit,any,MTP_Icones/ProcedurePaused_rounded1.svg]]");
  }

  /**
   * @brief Callback function to update the start button state.
   *
   * @param varName The variable name ("_stateOperatorActive" or "_stateCurrent") indicating which state is updated.
   * @param start The new state value.
   */
  private void setStartCB(const string &varName, const anytype &start)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = start;
        break;

      case "_stateCurrent":
        _stateCurrent = start;
        break;
    }

    if (_stateOperatorActive && (_stateCurrent == 64 || _stateCurrent == 4096 || _stateCurrent == 16384))
    {
      _rectPlay.fill = "[pattern,[fit,any,MTP_Icones/forward_1_rounded_green.svg]]";
    }
    else if (_stateOperatorActive && _stateCurrent == 8)
    {
      _rectPlay.fill = "[pattern,[fit,any,MTP_Icones/forward_2_rounded_green.svg]]";
    }
    else
    {
      _rectPlay.fill = "[pattern,[fit,any,MTP_Icones/forward_5_rounded.svg]]";
    }

    //_rectPlay.transparentForMouse = (_rectPlay.fill == "[pattern,[fit,any,MTP_Icones/ExternalSource3_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the external source mode button state.
   *
   * @param varName The variable name ("_srcExternalActive" or "_stateAutomaticActive") indicating which state is updated.
   * @param ext The new state value.
   */
  private void setSourceExternalCB(const string &varName, const bool &ext)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = ext;
        break;

      case "_srcExternalActive":
        _srcExternalActive = ext;
        break;
    }

    if (_srcExternalActive)
    {
      _rectExternal.fill = "[pattern,[fit,any,MTP_Icones/ExternalSource1_rounded.svg]]";
    }
    else if (!_srcExternalActive && !_stateAutomaticActive)
    {
      _rectExternal.fill = "[pattern,[fit,any,MTP_Icones/ExternalSource3_rounded.svg]]";
    }
    else
    {
      _rectExternal.fill = "[pattern,[fit,any,MTP_Icones/ExternalSource2_rounded.svg]]";
    }

    _rectExternal.transparentForMouse = (_rectExternal.fill == "[pattern,[fit,any,MTP_Icones/ExternalSource3_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the internal source mode button state.
   *
   * @param varName The variable name ("_srcInternalActive" or "_stateAutomaticActive") indicating which state is updated.
   * @param internal The new state value.
   */
  private void setSourceInternalCB(const string &varName, const bool &internal)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = internal;
        break;

      case "_srcInternalActive":
        _srcInternalActive = internal;
        break;
    }

    if (_srcInternalActive)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/InternalSource1_rounded.svg]]";
    }
    else if (!_srcInternalActive && !_stateAutomaticActive)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/InternalSource3_rounded.svg]]";
    }
    else
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/InternalSource2_rounded.svg]]";
    }

    _rectInternal.transparentForMouse = (_rectInternal.fill == "[pattern,[fit,any,MTP_Icones/InternalSource3_rounded.svg]]");
  }

  /**
    * @brief Callback function to update the automatic mode button state.
    *
    * @param varName The name of the variable to set.
    * @param state The new state value.
    */
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

    if ((_stateAutomaticActive && _stateChannel) || (!_stateChannel && _stateAutomaticActive && !_osLevelStation))
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]";
    }
    else if (_stateAutomaticActive && !_stateChannel && _osLevelStation)
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_2_rounded.svg]]";
    }
    else
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_3_rounded.svg]]";
    }

    _rectAutomatic.transparentForMouse = (_rectAutomatic.fill == "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the operator mode button state.
   *
   * @param varName The name of the variable to set.
   * @param state The new state value.
   */
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

    if ((_stateOperatorActive && _stateChannel) || (!_stateChannel && _stateOperatorActive && !_osLevelStation))
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_1_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_stateChannel && _osLevelStation)
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_2_rounded.svg]]";
    }
    else
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_3_rounded.svg]]";
    }

    _rectOperator.transparentForMouse = (_rectOperator.fill == "[pattern,[fit,any,MTP_Icones/Operator_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the off state button.
   *
   * @param varName The name of the variable to set.
   * @param state The new state value.
   */
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

    if ((_stateOffActive && _stateChannel) || (!_stateChannel && _stateOffActive && !_osLevelStation))
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]";
    }
    else if (_stateOffActive && !_stateChannel && _osLevelStation)
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_3_rounded.svg]]";
    }
    else
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_1_rounded.svg]]";
    }

    _rectOff.transparentForMouse = (_rectOff.fill == "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]");
  }

  /**
   * @brief Sets the current procedure for the reference.
   *
   * @param currentProcedure The uint current procedure value to be set.
   */
  private void setCurrentProcedureCB(const uint &currentProcedure)
  {
    if (currentProcedure != 0)
    {
      _rectCurrentProcedure.fill = "[pattern,[fit,any,MTP_Icones/CurrentProcedureOn.svg]]";
      _txtCurrentProcedure.text = _procedures.at(currentProcedure - 1).getName();
    }
    else
    {
      _rectCurrentProcedure.fill = "[pattern,[fit,any,MTP_Icones/CurrentProcedureOff.svg]]";
      _txtCurrentProcedure.text = "";
    }
  }

  /**
  * @brief Sets the current procedure for the reference.
  *
  * @param currentProcedure The uint current procedure value to be set.
  */
  private void setRequestedProcedureCB(const uint &requestedProcedure)
  {
    if (requestedProcedure != 0)
    {
      _rectRequestedProcedure.fill = "[pattern,[fit,any,MTP_Icones/RequestedProcedureOn.svg]]";
      _txtRequestedProcedure.text =  _procedures.at(requestedProcedure - 1).getName();
    }
    else
    {
      _rectRequestedProcedure.fill = "[pattern,[fit,any,MTP_Icones/RequestedProcedureOff.svg]]";
      _txtRequestedProcedure.text = "NOT_SELECTED";
    }
  }

  /**
  * @brief Sets the current state for the reference.
  *
  * @param currentState The uint current state value to be set.
  */
  private void setCurrentStateCB(const uint &currentState)
  {
    switch (currentState)
    {
      case 16:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreyCircle.svg]]";
        _rectCurrentStateProcedure.visible = TRUE;
        break;

      case 32768:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreyCircle.svg]]";
        _blinkingActive = TRUE;

        if (!_blinkThreadRunning)
        {
          _blinkThreadRunning = TRUE;
          startThread(this, "blinkThread");
        }

        break;

      case 8:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
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
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
        break;

      case 4096:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
        _blinkingActive = TRUE;

        if (!_blinkThreadRunning)
        {
          _blinkThreadRunning = TRUE;
          startThread(this, "blinkThread");
        }

        break;

      case 16384:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
        _blinkingActive = TRUE;

        if (!_blinkThreadRunning)
        {
          _blinkThreadRunning = TRUE;
          startThread(this, "blinkThread");
        }

        break;

      case 128:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped.svg]]";
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
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/RedCircle.svg]]";
        break;

      case 65536:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
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
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/GreenCircle.svg]]";
        break;

      case 8192:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused.svg]]";
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
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/YellowCircle.svg]]";
        break;

      case 1024:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld.svg]]";
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
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/YellowCircle.svg]]";
        break;

      case 256:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped.svg]]";
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
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped.svg]]";
        _rectStateBackground.fill = "[pattern,[fit,any,MTP_Icones/RedCircle.svg]]";
        break;

      default:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.visible = FALSE;
    }
  }

  /**
  * @brief Thread function to handle the blinking effect.
  */
  private void blinkThread()
  {
    while (_blinkingActive)
    {
      _rectCurrentStateProcedure.visible = !_rectCurrentStateProcedure.visible;
      delay(0, 500);
    }

    _rectCurrentStateProcedure.visible = TRUE;
    _blinkThreadRunning = FALSE;
  }
};
