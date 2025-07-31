// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpProcedure/MtpProcedure"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class Services
 * @brief Represents the Services class for managing monitored analog drive values.
 */
class Services : MtpViewModelBase
{
  private bool _configParamApplyOperator; //!< Indicates if the operator configuration parameter apply is active.
  private bool _configParamApplyInternal; //!< Indicates if the internal configuration parameter apply is active.
  private bool _reportValueFreeze; //!< Indicates if the report value freeze is active.
  private bool _configParamApplyExternal; //!< Indicates if the external configuration parameter apply is active.
  private bool _configParamApplyEnabled; //!< Indicates if the configuration parameter apply is enabled.
  private bool _procParamApplyInternal; //!< Indicates if the internal procedure parameter apply is active.
  private bool _procParamApplyOperator; //!< Indicates if the operator procedure parameter apply is active.
  private bool _procParamApplyExternal; //!< Indicates if the external procedure parameter apply is active.
  private bool _procParamApplyEnabled; //!< Indicates if the procedure parameter apply is enabled.
  private bool _srcExternalActive; //!< Indicates if the external source is active.
  private bool _srcInternalActive; //!< Indicates if the internal source is active.
  private bool _srcExternalOperator; //!< Indicates if the external operator source is active.
  private bool _srcInternalOperator; //!< Indicates if the internal operator source is active.
  private bool _srcInternalAutomatic; //!< Indicates if the internal automatic source is active.
  private bool _srcExternalAutomatic; //!< Indicates if the external automatic source is active.
  private bool _srcChannel; //!< Indicates the source channel state.
  private int _numberOfProcedure; //!< The number of procedures associated with the service.
  private long _commandOperator; //!< The operator command value.
  private long _commandInternal; //!< The internal command value.
  private long _commandExternal; //!< The external command value.
  private long _stateCurrent; //!< The current state value.
  private long _commandEnabled; //!< The command enabled value.
  private long _positionTextId; //!< The position text ID.
  private long _interactionQuestionId; //!< The interaction question ID.
  private string _interactionAdditionalInfo; //!< Additional information for interactions.
  private long _interactionAnswerId; //!< The interaction answer ID.

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpState> _state; //!< The state associated with the monitored value.
  private shared_ptr<MtpProcedure> _procedure; //!< The procedure associated with the monitored value.

  /**
    * @brief Constructor for the Services object.
    *
    * @param dp The data point of the Services.
    */
  public Services(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".CommandOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CommandOp"));
    }

    if (!dpExists(getDp() + ".CommandInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CommandInt"));
    }

    if (!dpExists(getDp() + ".CommandExt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CommandExt"));
    }

    if (!dpExists(getDp() + ".ProcedureOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcedureOp"));
    }

    if (!dpExists(getDp() + ".ProcedureInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcedureInt"));
    }

    if (!dpExists(getDp() + ".ProcedureExt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcedureExt"));
    }

    if (!dpExists(getDp() + ".StateCur"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".StateCur"));
    }

    if (!dpExists(getDp() + ".CommandEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CommandEn"));
    }

    if (!dpExists(getDp() + ".ProcedureCur"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcedureCur"));
    }

    if (!dpExists(getDp() + ".ProcedureReq"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcedureReq"));
    }

    if (!dpExists(getDp() + ".PosTextID"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosTextID"));
    }

    if (!dpExists(getDp() + ".InteractQuestionID"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".InteractQuestionID"));
    }

    if (!dpExists(getDp() + ".InteractAddInfo"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".InteractAddInfo"));
    }

    if (!dpExists(getDp() + ".InteractAnswerID"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".InteractAnswerID"));
    }

    if (!dpExists(getDp() + ".SrcChannel"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SrcChannel"));
    }

    if (!dpExists(getDp() + ".SrcExtAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SrcExtAut"));
    }

    if (!dpExists(getDp() + ".SrcIntAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SrcIntAut"));
    }

    if (!dpExists(getDp() + ".SrcIntOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SrcIntOp"));
    }

    if (!dpExists(getDp() + ".SrcExtOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SrcExtOp"));
    }

    if (!dpExists(getDp() + ".SrcIntAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SrcIntAct"));
    }

    if (!dpExists(getDp() + ".SrcExtAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SrcExtAct"));
    }

    if (!dpExists(getDp() + ".ProcParamApplyEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcParamApplyEn"));
    }

    if (!dpExists(getDp() + ".ProcParamApplyExt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcParamApplyExt"));
    }

    if (!dpExists(getDp() + ".ProcParamApplyOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcParamApplyOp"));
    }

    if (!dpExists(getDp() + ".ProcParamApplyInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProcParamApplyInt"));
    }

    if (!dpExists(getDp() + ".ConfigParamApplyEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ConfigParamApplyEn"));
    }

    if (!dpExists(getDp() + ".ConfigParamApplyExt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ConfigParamApplyExt"));
    }

    if (!dpExists(getDp() + ".ConfigParamApplyOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ConfigParamApplyOp"));
    }

    if (!dpExists(getDp() + ".ConfigParamApplyInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ConfigParamApplyInt"));
    }

    if (!dpExists(getDp() + ".ReportValueFreeze"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ReportValueFreeze"));
    }

    if (!dpExists(getDp() + ".numberOfProcedure"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".numberOfProcedure"));
    }

    dpGet(getDp() + ".CommandOp", _commandOperator,
          getDp() + ".CommandEn", _commandEnabled,
          getDp() + ".PosTextID", _positionTextId,
          getDp() + ".InteractQuestionID", _interactionQuestionId,
          getDp() + ".InteractAddInfo", _interactionAdditionalInfo,
          getDp() + ".InteractAnswerID", _interactionAnswerId,
          getDp() + ".SrcIntOp", _srcInternalOperator,
          getDp() + ".SrcExtOp", _srcExternalOperator,
          getDp() + ".ProcParamApplyOp", _procParamApplyOperator,
          getDp() + ".ConfigParamApplyOp", _configParamApplyOperator,
          getDp() + ".numberOfProcedure", _numberOfProcedure);

    dpConnect(this, setCommandInternalCB, getDp() + ".CommandInt");
    dpConnect(this, setCommandExternalCB, getDp() + ".CommandExt");
    dpConnect(this, setCurrentStateCB, getDp() + ".StateCur");
    dpConnect(this, setSourceChannelCB, getDp() + ".SrcChannel");
    dpConnect(this, setSourceExternalAutomaticCB, getDp() + ".SrcExtAut");
    dpConnect(this, setSourceInternalAutomaticCB, getDp() + ".SrcIntAut");
    dpConnect(this, setSourceInternalActiveCB, getDp() + ".SrcIntAct");
    dpConnect(this, setSourceExternalActiveCB, getDp() + ".SrcExtAct");
    dpConnect(this, setProcParamApplyEnabledCB, getDp() + ".ProcParamApplyEn");
    dpConnect(this, setProcParamApplyExternalCB, getDp() + ".ProcParamApplyExt");
    dpConnect(this, setProcParamApplyInternalCB, getDp() + ".ProcParamApplyInt");
    dpConnect(this, setConfigParamApplyEnabledCB, getDp() + ".ConfigParamApplyEn");
    dpConnect(this, setConfigParamApplyExternalCB, getDp() + ".ConfigParamApplyExt");
    dpConnect(this, setConfigParamApplyInternalCB, getDp() + ".ConfigParamApplyInt");
    dpConnect(this, setReportValueFreezeCB, getDp() + ".ReportValueFreeze");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _state = new MtpState(getDp() + ".StateChannel", getDp() + ".StateOffAut", getDp() + ".StateOpAut", getDp() + ".StateAutAut", getDp() + ".StateOffOp", getDp() + ".StateOpOp", getDp() + ".StateAutOp", getDp() + ".StateOpAct", getDp() + ".StateAutAct", getDp() + ".StateOffAct");
    _procedure = new MtpProcedure(getDp() + ".ProcedureOp", getDp() + ".ProcedureInt", getDp() + ".ProcedureExt", getDp() + ".ProcedureCur", getDp() + ".ProcedureReq");
  }

#event commandInternalChanged(const long &commandInternal) //!< Event triggered when the internal command value changes.
#event commandExternalChanged(const long &commandExternal) //!< Event triggered when the external command value changes.
#event currentStateChanged(const long &stateCurrent) //!< Event triggered when the current state value changes.
#event sourceChannelChanged(const bool &srcChannel) //!< Event triggered when the source channel state changes.
#event sourceExternalAutomaticChanged(const bool &srcExternalAutomatic) //!< Event triggered when the external automatic source state changes.
#event sourceInternalAutomaticChanged(const bool &srcInternalAutomatic) //!< Event triggered when the internal automatic source state changes.
#event sourceInternalActiveChanged(const bool &srcInternalActive) //!< Event triggered when the internal active source state changes.
#event sourceExternalActiveChanged(const bool &srcExternalActive) //!< Event triggered when the external active source state changes.
#event procParamApplyEnabledChanged(const bool &procParamApplyEnabled) //!< Event triggered when the procedure parameter apply enabled state changes.
#event procParamApplyExternalChanged(const bool &procParamApplyExternal) //!< Event triggered when the external procedure parameter apply state changes.
#event procParamApplyInternalChanged(const bool &procParamApplyInternal) //!< Event triggered when the internal procedure parameter apply state changes.
#event configParamApplyEnabledChanged(const bool &configParamApplyEnabled) //!< Event triggered when the configuration parameter apply enabled state changes.
#event configParamApplyExternalChanged(const bool &configParamApplyExternal) //!< Event triggered when the external configuration parameter apply state changes.
#event configParamApplyInternalChanged(const bool &configParamApplyInternal) //!< Event triggered when the internal configuration parameter apply state changes.
#event reportValueFreezeChanged(const bool &reportValueFreeze) //!< Event triggered when the report value freeze state changes.

  /**
   * @brief Retrieves the operator configuration parameter apply state.
   * @return The operator configuration parameter apply state as a boolean.
   */
  public bool getConfigParamApplyOperator()
  {
    return _configParamApplyOperator;
  }

  /**
   * @brief Retrieves the internal configuration parameter apply state.
   * @return The internal configuration parameter apply state as a boolean.
   */
  public bool getConfigParamApplyInternal()
  {
    return _configParamApplyInternal;
  }

  /**
   * @brief Retrieves the report value freeze state.
   * @return The report value freeze state as a boolean.
   */
  public bool getReportValueFreeze()
  {
    return _reportValueFreeze;
  }

  /**
   * @brief Retrieves the external configuration parameter apply state.
   * @return The external configuration parameter apply state as a boolean.
   */
  public bool getConfigParamApplyExternal()
  {
    return _configParamApplyExternal;
  }

  /**
   * @brief Retrieves the configuration parameter apply enabled state.
   * @return The configuration parameter apply enabled state as a boolean.
   */
  public bool getConfigParamApplyEnabled()
  {
    return _configParamApplyEnabled;
  }

  /**
   * @brief Retrieves the internal procedure parameter apply state.
   * @return The internal procedure parameter apply state as a boolean.
   */
  public bool getProcParamApplyInternal()
  {
    return _procParamApplyInternal;
  }

  /**
   * @brief Retrieves the operator procedure parameter apply state.
   * @return The operator procedure parameter apply state as a boolean.
   */
  public bool getProcParamApplyOperator()
  {
    return _procParamApplyOperator;
  }

  /**
   * @brief Retrieves the external procedure parameter apply state.
   * @return The external procedure parameter apply state as a boolean.
   */
  public bool getProcParamApplyExternal()
  {
    return _procParamApplyExternal;
  }

  /**
   * @brief Retrieves the procedure parameter apply enabled state.
   * @return The procedure parameter apply enabled state as a boolean.
   */
  public bool getProcParamApplyEnabled()
  {
    return _procParamApplyEnabled;
  }

  /**
   * @brief Retrieves the external active source state.
   * @return The external active source state as a boolean.
   */
  public bool getSrcExternalActive()
  {
    return _srcExternalActive;
  }

  /**
   * @brief Retrieves the internal active source state.
   * @return The internal active source state as a boolean.
   */
  public bool getSrcInternalActive()
  {
    return _srcInternalActive;
  }

  /**
   * @brief Retrieves the external operator source state.
   * @return The external operator source state as a boolean.
   */
  public bool getSrcExternalOperator()
  {
    return _srcExternalOperator;
  }

  /**
   * @brief Retrieves the internal operator source state.
   * @return The internal operator source state as a boolean.
   */
  public bool getSrcInternalOperator()
  {
    return _srcInternalOperator;
  }

  /**
   * @brief Retrieves the internal automatic source state.
   * @return The internal automatic source state as a boolean.
   */
  public bool getSrcInternalAutomatic()
  {
    return _srcInternalAutomatic;
  }

  /**
   * @brief Retrieves the external automatic source state.
   * @return The external automatic source state as a boolean.
   */
  public bool getSrcExternalAutomatic()
  {
    return _srcExternalAutomatic;
  }

  /**
   * @brief Retrieves the source channel state.
   * @return The source channel state as a boolean.
   */
  public bool getSrcChannel()
  {
    return _srcChannel;
  }

  /**
   * @brief Retrieves the number of procedures.
   * @return The number of procedures as an integer.
   */
  public int getNumberOfProcedure()
  {
    return _numberOfProcedure;
  }

  /**
   * @brief Retrieves the operator command value.
   * @return The operator command value as a long.
   */
  public long getCommandOperator()
  {
    return _commandOperator;
  }

  /**
   * @brief Retrieves the internal command value.
   * @return The internal command value as a long.
   */
  public long getCommandInternal()
  {
    return _commandInternal;
  }

  /**
   * @brief Retrieves the external command value.
   * @return The external command value as a long.
   */
  public long getCommandExternal()
  {
    return _commandExternal;
  }

  /**
   * @brief Retrieves the current state value.
   * @return The current state value as a long.
   */
  public long getCurrentState()
  {
    return _stateCurrent;
  }

  /**
   * @brief Retrieves the command enabled value.
   * @return The command enabled value as a long.
   */
  public long getCommandEnabled()
  {
    return _commandEnabled;
  }

  /**
   * @brief Retrieves the position text ID.
   * @return The position text ID as a long.
   */
  public long getPositionTextId()
  {
    return _positionTextId;
  }

  /**
   * @brief Retrieves the interaction question ID.
   * @return The interaction question ID as a long.
   */
  public long getInteractionQuestionId()
  {
    return _interactionQuestionId;
  }

  /**
   * @brief Retrieves the interaction additional information.
   * @return The interaction additional information as a string.
   */
  public string getInteractionAdditionalInfo()
  {
    return _interactionAdditionalInfo;
  }

  /**
   * @brief Retrieves the interaction answer ID.
   * @return The interaction answer ID as a long.
   */
  public long getInteractionAnswerId()
  {
    return _interactionAnswerId;
  }

  /**
   * @brief Retrieves the quality code associated with the service.
   * @return The shared pointer to the MtpQualityCode instance.
   */
  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the operational state level information.
   * @return The shared pointer to the MtpOsLevel instance.
   */
  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Retrieves the state information for the service.
   * @return The shared pointer to the MtpState instance.
   */
  public shared_ptr<MtpState> getState()
  {
    return _state;
  }

  /**
   * @brief Retrieves the procedure information for the service.
   * @return The shared pointer to the MtpProcedure instance.
   */
  public shared_ptr<MtpProcedure> getProcedure()
  {
    return _procedure;
  }

  /**
   * @brief Sets the operator configuration parameter apply state.
   * @details Updates the operator configuration parameter apply state and writes it to the data point.
   *
   * @param configParamApplyOperator The new operator configuration parameter apply state.
   */
  public void setConfigParamApplyOperator(const bool &configParamApplyOperator)
  {
    _configParamApplyOperator = configParamApplyOperator;
    dpSet(getDp() + ".ConfigParamApplyOp", _configParamApplyOperator);
  }

  /**
   * @brief Sets the operator procedure parameter apply state.
   * @details Updates the operator procedure parameter apply state and writes it to the data point.
   *
   * @param procParamApplyOperator The new operator procedure parameter apply state.
   */
  public void setProcParamApplyOperator(const bool &procParamApplyOperator)
  {
    _procParamApplyOperator = procParamApplyOperator;
    dpSet(getDp() + ".ProcParamApplyOp", _procParamApplyOperator);
  }

  /**
   * @brief Sets the external operator source state.
   * @details Updates the external operator source state and writes it to the data point.
   *
   * @param srcExternalOperator The new external operator source state.
   */
  public void setSrcExternalOperator(const bool &srcExternalOperator)
  {
    _srcExternalOperator = srcExternalOperator;
    dpSet(getDp() + ".SrcExtOp", _srcExternalOperator);
  }

  /**
   * @brief Sets the internal operator source state.
   * @details Updates the internal operator source state and writes it to the data point.
   *
   * @param srcInternalOperator The new internal operator source state.
   */
  public void setSrcInternalOperator(const bool &srcInternalOperator)
  {
    _srcInternalOperator = srcInternalOperator;
    dpSet(getDp() + ".SrcIntOp", _srcInternalOperator);
  }

  /**
   * @brief Sets the operator command value.
   * @details Updates the operator command value and writes it to the data point.
   *
   * @param commandOperator The new operator command value.
   */
  public void setCommandOperator(const long &commandOperator)
  {
    _commandOperator = commandOperator;
    dpSet(getDp() + ".CommandOp", _commandOperator);
  }

  /**
   * @brief Callback function to set the internal command value.
   * @details Updates the internal command value and triggers the commandInternalChanged event.
   *
   * @param dpe The data point element.
   * @param commandInternal The new internal command value.
   */
  private void setCommandInternalCB(const string &dpe, const long &commandInternal)
  {
    _commandInternal = commandInternal;
    commandInternalChanged(_commandInternal);
  }

  /**
   * @brief Callback function to set the external command value.
   * @details Updates the external command value and triggers the commandExternalChanged event.
   *
   * @param dpe The data point element.
   * @param commandExternal The new external command value.
   */
  private void setCommandExternalCB(const string &dpe, const long &commandExternal)
  {
    _commandExternal = commandExternal;
    commandExternalChanged(_commandExternal);
  }

  /**
   * @brief Callback function to set the current state value.
   * @details Updates the current state value and triggers the currentStateChanged event.
   *
   * @param dpe The data point element.
   * @param stateCurrent The new current state value.
   */
  private void setCurrentStateCB(const string &dpe, const long &stateCurrent)
  {
    _stateCurrent = stateCurrent;
    currentStateChanged(_stateCurrent);
  }

  /**
   * @brief Callback function to set the source channel state.
   * @details Updates the source channel state and triggers the sourceChannelChanged event.
   *
   * @param dpe The data point element.
   * @param srcChannel The new source channel state.
   */
  private void setSourceChannelCB(const string &dpe, const bool &srcChannel)
  {
    _srcChannel = srcChannel;
    sourceChannelChanged(_srcChannel);
  }

  /**
   * @brief Callback function to set the external automatic source state.
   * @details Updates the external automatic source state and triggers the sourceExternalAutomaticChanged event.
   *
   * @param dpe The data point element.
   * @param srcExternalAutomatic The new external automatic source state.
   */
  private void setSourceExternalAutomaticCB(const string &dpe, const bool &srcExternalAutomatic)
  {
    _srcExternalAutomatic = srcExternalAutomatic;
    sourceExternalAutomaticChanged(_srcExternalAutomatic);
  }

  /**
   * @brief Callback function to set the internal automatic source state.
   * @details Updates the internal automatic source state and triggers the sourceInternalAutomaticChanged event.
   *
   * @param dpe The data point element.
   * @param srcInternalAutomatic The new internal automatic source state.
   */
  private void setSourceInternalAutomaticCB(const string &dpe, const bool &srcInternalAutomatic)
  {
    _srcInternalAutomatic = srcInternalAutomatic;
    sourceInternalAutomaticChanged(_srcInternalAutomatic);
  }

  /**
   * @brief Callback function to set the internal active source state.
   * @details Updates the internal active source state and triggers the sourceInternalActiveChanged event.
   *
   * @param dpe The data point element.
   * @param srcInternalActive The new internal active source state.
   */
  private void setSourceInternalActiveCB(const string &dpe, const bool &srcInternalActive)
  {
    _srcInternalActive = srcInternalActive;
    sourceInternalActiveChanged(_srcInternalActive);
  }

  /**
   * @brief Callback function to set the external active source state.
   * @details Updates the external active source state and triggers the sourceExternalActiveChanged event.
   *
   * @param dpe The data point element.
   * @param srcExternalActive The new external active source state.
   */
  private void setSourceExternalActiveCB(const string &dpe, const bool &srcExternalActive)
  {
    _srcExternalActive = srcExternalActive;
    sourceExternalActiveChanged(_srcExternalActive);
  }

  /**
   * @brief Callback function to set the procedure parameter apply enabled state.
   * @details Updates the procedure parameter apply enabled state and triggers the procParamApplyEnabledChanged event.
   *
   * @param dpe The data point element.
   * @param procParamApplyEnabled The new procedure parameter apply enabled state.
   */
  private void setProcParamApplyEnabledCB(const string &dpe, const bool &procParamApplyEnabled)
  {
    _procParamApplyEnabled = procParamApplyEnabled;
    procParamApplyEnabledChanged(_procParamApplyEnabled);
  }

  /**
   * @brief Callback function to set the external procedure parameter apply state.
   * @details Updates the external procedure parameter apply state and triggers the procParamApplyExternalChanged event.
   *
   * @param dpe The data point element.
   * @param procParamApplyExternal The new external procedure parameter apply state.
   */
  private void setProcParamApplyExternalCB(const string &dpe, const bool &procParamApplyExternal)
  {
    _procParamApplyExternal = procParamApplyExternal;
    procParamApplyExternalChanged(_procParamApplyExternal);
  }

  /**
   * @brief Callback function to set the internal procedure parameter apply state.
   * @details Updates the internal procedure parameter apply state and triggers the procParamApplyInternalChanged event.
   *
   * @param dpe The data point element.
   * @param procParamApplyInternal The new internal procedure parameter apply state.
   */
  private void setProcParamApplyInternalCB(const string &dpe, const bool &procParamApplyInternal)
  {
    _procParamApplyInternal = procParamApplyInternal;
    procParamApplyInternalChanged(_procParamApplyInternal);
  }

  /**
   * @brief Callback function to set the configuration parameter apply enabled state.
   * @details Updates the configuration parameter apply enabled state and triggers the configParamApplyEnabledChanged event.
   *
   * @param dpe The data point element.
   * @param configParamApplyEnabled The new configuration parameter apply enabled state.
   */
  private void setConfigParamApplyEnabledCB(const string &dpe, const bool &configParamApplyEnabled)
  {
    _configParamApplyEnabled = configParamApplyEnabled;
    configParamApplyEnabledChanged(_configParamApplyEnabled);
  }

  /**
   * @brief Callback function to set the external configuration parameter apply state.
   * @details Updates the external configuration parameter apply state and triggers the configParamApplyExternalChanged event.
   *
   * @param dpe The data point element.
   * @param configParamApplyExternal The new external configuration parameter apply state.
   */
  private void setConfigParamApplyExternalCB(const string &dpe, const bool &configParamApplyExternal)
  {
    _configParamApplyExternal = configParamApplyExternal;
    configParamApplyExternalChanged(_configParamApplyExternal);
  }

  /**
   * @brief Callback function to set the internal configuration parameter apply state.
   * @details Updates the internal configuration parameter apply state and triggers the configParamApplyInternalChanged event.
   *
   * @param dpe The data point element.
   * @param configParamApplyInternal The new internal configuration parameter apply state.
   */
  private void setConfigParamApplyInternalCB(const string &dpe, const bool &configParamApplyInternal)
  {
    _configParamApplyInternal = configParamApplyInternal;
    configParamApplyInternalChanged(_configParamApplyInternal);
  }

  /**
   * @brief Callback function to set the report value freeze state.
   * @details Updates the report value freeze state and triggers the reportValueFreezeChanged event.
   *
   * @param dpe The data point element.
   * @param reportValueFreeze The new report value freeze state.
   */
  private void setReportValueFreezeCB(const string &dpe, const bool &reportValueFreeze)
  {
    _reportValueFreeze = reportValueFreeze;
    reportValueFreezeChanged(_reportValueFreeze);
  }
};
