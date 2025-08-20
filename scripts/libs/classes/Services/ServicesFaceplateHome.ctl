// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/ContextMenu/ContextMenuConfig"
#uses "classes/ContextMenu/ContextMenuCustom"
#uses "classes/Services/Procedure"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpProcedure/MtpProcedure"
#uses "classes/Services/Services"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class ServicesFaceplateHome
 * @brief Represents the home faceplate for Services objects, managing the UI for procedure states and controls.
 */
class ServicesFaceplateHome : MtpViewBase
{
  private shape _rectCurrentStateProcedure; //!< Reference to the current state procedure rectangle shape.
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
  private long _stateCurrent; //!< The current state value of the procedure.

  private vector<shared_ptr<Procedure> > _procedures;
  private shared_ptr<ContextMenuCustom> _contextMenu;
  private shared_ptr<ContextMenuConfig> _contextConfig;

  /**
   * @brief Constructor for ServicesFaceplateHome.
   * @details Initializes the faceplate by connecting callbacks to view model events, setting initial states, and configuring UI elements.
   *
   * @param viewModel A shared pointer to the Services view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServicesFaceplateHome(shared_ptr<Services> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setCurrentStateCB, MtpViewBase::getViewModel(), Services::currentStateChanged);
    classConnect(this, setCurrentProcedureCB, MtpViewBase::getViewModel().getProcedure(), MtpProcedure::currentChanged);
    classConnect(this, setRequestedProcedureCB, MtpViewBase::getViewModel().getProcedure(), MtpProcedure::requestedChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);

    //Buttons:
    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MtpViewBase::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setSourceExternalCB, "_srcExternalActive", MtpViewBase::getViewModel(), Services::sourceExternalActiveChanged);
    classConnectUserData(this, setSourceExternalCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);

    classConnectUserData(this, setSourceInternalCB, "_srcInternalActive", MtpViewBase::getViewModel(), Services::sourceInternalActiveChanged);
    classConnectUserData(this, setSourceInternalCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);

    classConnectUserData(this, setStartCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setStartCB, "_stateCurrent", MtpViewBase::getViewModel(), Services::currentStateChanged);

    classConnectUserData(this, setPauseCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setPauseCB, "_stateCurrent", MtpViewBase::getViewModel(), Services::currentStateChanged);

    classConnectUserData(this, setFinishCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setFinishCB, "_stateCurrent", MtpViewBase::getViewModel(), Services::currentStateChanged);

    classConnectUserData(this, setHoldCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setHoldCB, "_stateCurrent", MtpViewBase::getViewModel(), Services::currentStateChanged);

    classConnectUserData(this, setStopCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setStopCB, "_stateCurrent", MtpViewBase::getViewModel(), Services::currentStateChanged);

    classConnectUserData(this, setAbortCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setAbortCB, "_stateCurrent", MtpViewBase::getViewModel(), Services::currentStateChanged);

    classConnectUserData(this, setResetCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setResetCB, "_stateCurrent", MtpViewBase::getViewModel(), Services::currentStateChanged);

    _procedures = MtpViewBase::getViewModel().getProcedures();
    _blinkingActive = FALSE;
    _stateOffActive =  MtpViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MtpViewBase::getViewModel().getState().getChannel();
    _stateOperatorActive =  MtpViewBase::getViewModel().getState().getOperatorActive();
    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();
    _srcExternalActive = MtpViewBase::getViewModel().getSrcExternalActive();
    _srcInternalActive = MtpViewBase::getViewModel().getSrcInternalActive();
    _stateCurrent = MtpViewBase::getViewModel().getCurrentState();

    setCurrentStateCB(MtpViewBase::getViewModel().getCurrentState());
    setCurrentProcedureCB(MtpViewBase::getViewModel().getProcedure().getCurrent());
    setRequestedProcedureCB(MtpViewBase::getViewModel().getProcedure().getRequested());
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
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

    MtpViewBase::getViewModel().getProcedure().setRequested(answer);
  }

  /**
     * @brief Activates the start command for the procedure.
     * @details Sends a start command (value 4) to the view model's command operator.
     */
  public void activateStart()
  {
    MtpViewBase::getViewModel().setCommandOperator(4);
  }

  /**
     * @brief Activates the pause command for the procedure.
     * @details Sends a pause command (value 32) to the view model's command operator.
     */
  public void activatePause()
  {
    MtpViewBase::getViewModel().setCommandOperator(64);
  }

  /**
     * @brief Activates the finish command for the procedure.
     * @details Sends a finish command (value 1024) to the view model's command operator.
     */
  public void activateFinish()
  {
    MtpViewBase::getViewModel().setCommandOperator(1024);
  }

  /**
     * @brief Activates the hold command for the procedure.
     * @details Sends a hold command (value 512) to the view model's command operator.
     */
  public void activateHold()
  {
    MtpViewBase::getViewModel().setCommandOperator(16);
  }

  /**
   * @brief Activates the stop command for the procedure.
   * @details Sends a stop command (value 128) to the view model's command operator.
   */
  public void activateStop()
  {
    MtpViewBase::getViewModel().setCommandOperator(8);
  }

  /**
     * @brief Activates the abort command for the procedure.
     * @details Sends an abort command (value 256) to the view model's command operator.
     */
  public void activateAbort()
  {
    MtpViewBase::getViewModel().setCommandOperator(256);
  }

  /**
   * @brief Activates the reset command for the procedure.
   * @details Sends a reset command (value 2) to the view model's command operator.
   */
  public void activateReset()
  {
    MtpViewBase::getViewModel().setCommandOperator(2);
  }

  /**
   * @brief Activates the off state.
   * @details Calls the setOffOperator method on the view model's state.
   */
  public void activateStateOff()
  {
    MtpViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  /**
   * @brief Activates the operator mode.
   * @details Calls the setOperatorOperator method on the view model's state.
   */
  public void activateStateOperator()
  {
    MtpViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  /**
   * @brief Activates the automatic mode.
   * @details Calls the setAutomaticOperator method on the view model's state.
   */
  public void activateStateAutomatic()
  {
    MtpViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  /**
  * @brief Activates the external mode.
  * @details Calls the setSrcExternalOperator method on the view model's state.
  */
  public void activateExternalMode()
  {
    MtpViewBase::getViewModel().setSrcExternalOperator(TRUE);
  }

  /**
  * @brief Activates the internal mode.
  * @details Calls the setSrcInternalOperator method on the view model's state.
  */
  public void activateInternalMode()
  {
    MtpViewBase::getViewModel().setSrcInternalOperator(TRUE);
  }

  /**
  * @brief Initializes the private shapes used in the faceplate.
  * @details This method overrides the base class method to extract the required private shapes.
  */
  protected void initializeShapes()
  {
    _rectCurrentStateProcedure = MtpViewBase::extractShape("_rectCurrentStateProcedure");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _rectExternal = MtpViewBase::extractShape("_rectExternal");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _rectPlay = MtpViewBase::extractShape("_rectPlay");
    _rectPause = MtpViewBase::extractShape("_rectPause");
    _rectFinished = MtpViewBase::extractShape("_rectFinished");
    _rectHeld = MtpViewBase::extractShape("_rectHeld");
    _rectStopped = MtpViewBase::extractShape("_rectStopped");
    _rectExecutionStopped = MtpViewBase::extractShape("_rectExecutionStopped");
    _rectReset = MtpViewBase::extractShape("_rectReset");
    _rectCurrentProcedure = MtpViewBase::extractShape("_rectCurrentProcedure");
    _txtCurrentProcedure = MtpViewBase::extractShape("_txtCurrentProcedure");
    _rectRequestedProcedure = MtpViewBase::extractShape("_rectRequestedProcedure");
    _txtRequestedProcedure = MtpViewBase::extractShape("_txtRequestedProcedure");
    _rectRequestedProcedureInformation = MtpViewBase::extractShape("_rectRequestedProcedureInformation");
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
   * @details Updates the reset button's appearance based on operator state and current state.
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
   * @details Updates the abort button's appearance based on operator state and current state.
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
   * @details Updates the stop button's appearance based on operator state and current state.
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
   * @details Updates the hold button's appearance based on operator state and current state.
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
   * @details Updates the finish button's appearance based on operator state and current state.
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
     * @details Updates the pause button's appearance based on operator state and current state.
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
   * @details Updates the start button's appearance based on operator state and current state.
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
   * @details Updates the external source button's appearance based on external and automatic states.
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
   * @details Updates the internal source button's appearance based on internal and automatic states.
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
   * @param currentProcedure The long current procedure value to be set.
   */
  private void setCurrentProcedureCB(const long &currentProcedure)
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
  * @param currentProcedure The long current procedure value to be set.
  */
  private void setRequestedProcedureCB(const long &requestedProcedure)
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
  * @param currentState The long current state value to be set.
  */
  private void setCurrentStateCB(const long &currentState)
  {
    switch (currentState)
    {
      case 16:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
        _rectCurrentStateProcedure.visible = TRUE;
        break;

      case 32768:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 8:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 64:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
        break;

      case 4096:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 16384:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureRunning.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 128:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 4:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureStopped.svg]]";
        break;

      case 65536:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 131072:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
        break;

      case 8192:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 32:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedurePaused.svg]]";
        break;

      case 1024:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 2048:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureHeld.svg]]";
        break;

      case 256:
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped.svg]]";
        _blinkingActive = TRUE;
        startThread(this, "blinkThread");
        break;

      case 512:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.visible = TRUE;
        _rectCurrentStateProcedure.fill = "[pattern,[fit,any,MTP_Icones/ProcedureExecutionStopped.svg]]";
        break;

      default:
        _blinkingActive = FALSE;
        _rectCurrentStateProcedure.visible = FALSE;
    }
  }

  /**
  * @brief Thread function to handle the blinking effect.
  * @details Toggles the visibility of the _rectCurrentStateProcedure shape every 250ms while _blinkingActive
  * is true. Uses delay to control timing and runs in a separate thread.
  */
  private void blinkThread()
  {
    while (_blinkingActive)
    {
      _rectCurrentStateProcedure.visible = !_rectCurrentStateProcedure.visible;
      delay(0, 250);
    }

    _rectCurrentStateProcedure.visible = TRUE;
  }
};
