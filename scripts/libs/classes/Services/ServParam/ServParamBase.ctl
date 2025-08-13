// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "std"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"

/**
 * @class ServParamBase
 * @brief Represents the base class for managing service parameters in the MTP system.
 */
class ServParamBase
{
  private string _dp; //!< The data point associated with the service parameter.
  private langString _name; //!< The name of the service parameter.
  private bool _applyEnabled; //!< Indicates if the apply functionality is enabled.
  private bool _applyExternal; //!< Indicates if the external apply functionality is active.
  private bool _applyInternal; //!< Indicates if the internal apply functionality is active.
  private bool _stateChannel; //!< The state channel of the MTP object.
  private bool _stateOffAutomatic; //!< Indicates if the MTP object is in off automatic mode.
  private bool _stateOperatorAutomatic; //!< Indicates if the MTP object is in operator automatic mode.
  private bool _stateAutomaticAutomatic; //!< Indicates if the MTP object is in automatic automatic mode.
  private bool _stateOperatorActive; //!< Indicates if the operator mode is active.
  private bool _stateAutomaticActive; //!< Indicates if the automatic mode is active.
  private bool _stateOffActive; //!< Indicates if the off mode is active.
  private bool _sourceChannel; //!< Indicates the source channel state.
  private bool _sourceExternalAutomatic; //!< Indicates if the external automatic source is active.
  private bool _sourceInternalAutomatic; //!< Indicates if the internal automatic source is active.
  private bool _sourceExternalActive; //!< Indicates if the external active source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal active source is active.
  private anytype _valueExternal; //!< The external value of the service parameter.
  private anytype _valueInternal; //!< The internal value of the service parameter.
  private anytype _valueRequested; //!< The requested value of the service parameter.
  private anytype _valueFeedback; //!< The feedback value of the service parameter.

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the service parameter.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the service parameter.

  /**
    * @brief Constructor for the ServParamBase object.
    *
    * @param dp The data point of the service parameter.
    */
  protected ServParamBase(const string &dp)
  {
    _dp = dp;

    if (!dpExists(_dp))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dp));
    }

    if (!dpExists(_dp + ".ApplyEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".ApplyEn"));
    }

    if (!dpExists(_dp + ".ApplyExt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".ApplyExt"));
    }

    if (!dpExists(_dp + ".ApplyInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".ApplyInt"));
    }

    if (!dpExists(_dp + ".SrcChannel"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".SrcChannel"));
    }

    if (!dpExists(_dp + ".SrcExtAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".SrcExtAut"));
    }

    if (!dpExists(_dp + ".SrcIntAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".SrcIntAut"));
    }

    if (!dpExists(_dp + ".SrcExtAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".SrcExtAct"));
    }

    if (!dpExists(_dp + ".SrcIntAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".SrcIntAct"));
    }

    if (!dpExists(_dp + ".VExt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".VExt"));
    }

    if (!dpExists(_dp + ".VInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".VInt"));
    }

    if (!dpExists(_dp + ".VReq"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".VReq"));
    }

    if (!dpExists(_dp + ".VFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".VFbk"));
    }

    if (!dpExists(_dp + ".Name"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".Name"));
    }

    if (!dpExists(_dp + ".StateChannel"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".StateChannel"));
    }

    if (!dpExists(_dp + ".StateOffAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".StateOffAut"));
    }

    if (!dpExists(_dp + ".StateOpAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".StateOpAut"));
    }

    if (!dpExists(_dp + ".StateAutAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".StateAutAut"));
    }

    if (!dpExists(_dp + ".StateOffAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".StateOffAct"));
    }

    if (!dpExists(_dp + ".StateOpAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".StateOpAct"));
    }

    if (!dpExists(_dp + ".StateAutAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".StateAutAct"));
    }

    dpGet(_dp + ".Name", _name);

    dpConnect(this, setApplyEnabledCB, _dp + ".ApplyEn");
    dpConnect(this, setApplyExternalCB, _dp + ".ApplyExt");
    dpConnect(this, setApplyInternalCB, _dp + ".ApplyInt");
    dpConnect(this, setSourceChannelCB, _dp + ".SrcChannel");
    dpConnect(this, setSourceExternalAutomaticCB, _dp + ".SrcExtAut");
    dpConnect(this, setSourceInternalAutomaticCB, _dp + ".SrcIntAut");
    dpConnect(this, setSourceExternalActiveCB, _dp + ".SrcExtAct");
    dpConnect(this, setSourceInternalActiveCB, _dp + ".SrcIntAct");
    dpConnect(this, setValueExternalCB, _dp + ".VExt");
    dpConnect(this, setValueInternalCB, _dp + ".VInt");
    dpConnect(this, setValueRequestedCB, _dp + ".VReq");
    dpConnect(this, setValueFeedbackCB, _dp + ".VFbk");
    dpConnect(this, setStateChannelCB, _dp + ".StateChannel");
    dpConnect(this, setStateOffAutomaticCB, _dp + ".StateOffAut");
    dpConnect(this, setStateOperatorAutomaticCB, _dp + ".StateOpAut");
    dpConnect(this, setStateAutomaticAutomaticCB, _dp + ".StateAutAut");
    dpConnect(this, setStateOperatorActiveCB, _dp + ".StateOpAct");
    dpConnect(this, setStateAutomaticActiveCB, _dp + ".StateAutAct");
    dpConnect(this, setStateOffActiveCB, _dp + ".StateOffAct");

    _wqc = new MtpQualityCode(_dp + ".WQC");
    _osLevel = new MtpOsLevel(_dp + ".OSLevel");
  }

#event applyEnabledChanged(const bool &applyEnabled) //!< Event triggered when the applyEnabled state changes.
#event applyExternalChanged(const bool &applyExternal) //!< Event triggered when the applyExternal state changes.
#event applyInternalChanged(const bool &applyInternal) //!< Event triggered when the applyInternal state changes.
#event sourceChannelChanged(const bool &sourceChannel) //!< Event triggered when the sourceChannel state changes.
#event sourceExternalAutomaticChanged(const bool &sourceExternalAutomatic) //!< Event triggered when the sourceExternalAutomatic state changes.
#event sourceInternalAutomaticChanged(const bool &sourceInternalAutomatic) //!< Event triggered when the sourceInternalAutomatic state changes.
#event sourceInternalActiveChanged(const bool &sourceInternalActive) //!< Event triggered when the sourceInternalActive state changes.
#event sourceExternalActiveChanged(const bool &sourceExternalActive) //!< Event triggered when the sourceExternalActive state changes.
#event valueExternalChanged(const bool &valueExternal) //!< Event triggered when the valueExternal state changes.
#event valueInternalChanged(const bool &valueInternal) //!< Event triggered when the valueInternal state changes.
#event valueRequestedChanged(const bool &valueRequested) //!< Event triggered when the valueRequested state changes.
#event valueFeedbackChanged(const bool &valueFeedback) //!< Event triggered when the valueFeedback state changes.
#event stateOffActiveChanged(const bool &active) //!< Event triggered when the off active state changes.
#event stateOperatorActiveChanged(const bool &active) //!< Event triggered when the operator active state changes.
#event stateAutomaticActiveChanged(const bool &active) //!< Event triggered when the automatic active state changes.
#event stateChannelChanged(const bool &channel) //!< Event triggered when the channel state changes.
#event stateOffAutomaticChanged(const bool &automatic) //!< Event triggered when the off automatic state changes.
#event stateOperatorAutomaticChanged(const bool &automatic) //!< Event triggered when the operator automatic state changes.
#event stateAutomaticAutomaticChanged(const bool &automatic) //!< Event triggered when the automatic automatic state changes.

  /**
     * @brief Retrieves the data point associated with the service parameter.
     * @return The data point as a string.
     */
  public string getDp()
  {
    return _dp;
  }

  /**
   * @brief Retrieves the apply enabled state.
   * @return The apply enabled state as a boolean.
   */
  public bool getApplyEnabled()
  {
    return _applyEnabled;
  }

  /**
   * @brief Retrieves the external apply state.
   * @return The external apply state as a boolean.
   */
  public bool getApplyExternal()
  {
    return _applyExternal;
  }

  /**
   * @brief Retrieves the internal apply state.
   * @return The internal apply state as a boolean.
   */
  public bool getApplyInternal()
  {
    return _applyInternal;
  }

  /**
   * @brief Retrieves the source channel state.
   * @return The source channel state as a boolean.
   */
  public bool getSourceChannel()
  {
    return _sourceChannel;
  }

  /**
   * @brief Retrieves the external automatic source state.
   * @return The external automatic source state as a boolean.
   */
  public bool getSourceExternalAutomatic()
  {
    return _sourceExternalAutomatic;
  }

  /**
   * @brief Retrieves the internal automatic source state.
   * @return The internal automatic source state as a boolean.
   */
  public bool getSourceInternalAutomatic()
  {
    return _sourceInternalAutomatic;
  }

  /**
   * @brief Retrieves the internal active source state.
   * @return The internal active source state as a boolean.
   */
  public bool getSourceInternalActive()
  {
    return _sourceInternalActive;
  }

  /**
   * @brief Retrieves the external active source state.
   * @return The external active source state as a boolean.
   */
  public bool getSourceExternalActive()
  {
    return _sourceExternalActive;
  }

  /**
   * @brief Retrieves the external value of the service parameter.
   * @return The external value as an anytype.
   */
  protected anytype getValueExternal()
  {
    return _valueExternal;
  }

  /**
   * @brief Retrieves the internal value of the service parameter.
   * @return The internal value as an anytype.
   */
  protected anytype getValueInternal()
  {
    return _valueInternal;
  }

  /**
   * @brief Retrieves the requested value of the service parameter.
   * @return The requested value as an anytype.
   */
  protected anytype getValueRequested()
  {
    return _valueRequested;
  }

  /**
   * @brief Retrieves the feedback value of the service parameter.
   * @return The feedback value as an anytype.
   */
  protected anytype getValueFeedback()
  {
    return _valueFeedback;
  }

  /**
   * @brief Retrieves the name of the service parameter.
   * @return The name as a string.
   */
  public string getName()
  {
    return _name;
  }

  /**
     * @brief Retrieves the current state channel state.
     * @return True if the channel is automatic, false if the channel is operator.
     */
  public bool getStateChannel()
  {
    return _stateChannel;
  }

  /**
     * @brief Retrieves the operating mode state off automatic.
     * @return True if off automatic, false otherwise.
     */
  public bool getStateOffAutomatic()
  {
    return _stateOffAutomatic;
  }

  /**
     * @brief Retrieves the operating mode state operator automatic.
     * @return True if operator automatic, false otherwise.
     */
  public bool getStateOperatorAutomatic()
  {
    return _stateOperatorAutomatic;
  }

  /**
     * @brief Retrieves the operating mode state automatic automatic.
     * @return True if automatic automatic, false otherwise.
     */
  public bool getStateAutomaticAutomatic()
  {
    return _stateAutomaticAutomatic;
  }

  /**
     * @brief Retrieves the active state of the operator mode.
     * @return True if operator mode is active, false otherwise.
     */
  public bool getStateOperatorActive()
  {
    return _stateOperatorActive;
  }

  /**
     * @brief Retrieves the active state of the automatic mode.
     * @return True if automatic mode is active, false otherwise.
     */
  public bool getStateAutomaticActive()
  {
    return _stateAutomaticActive;
  }

  /**
     * @brief Retrieves the active state of the off mode.
     * @return True if off mode is active, false otherwise.
     */
  public bool getStateOffActive()
  {
    return _stateOffActive;
  }

  /**
  * @brief Retrieves the quality code (WQC) associated with this object.
  *
  * @return The shared pointer to the MtpQualityCode instance.
  */
  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the operating system level information.
   *
   * @return The shared pointer to the MtpOsLevel instance.
   */
  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Sets the external value of the service parameter.
   * @details Updates the external value and writes it to the data point.
   *
   * @param valueExternal The new external value.
   */
  protected void setValueExternal(const anytype &valueExternal)
  {
    _valueExternal = valueExternal;
    dpSet(_dp + ".VExt", _valueExternal);
  }

  /**
   * @brief Sets the internal value of the service parameter.
   * @details Updates the internal value and writes it to the data point.
   *
   * @param valueInternal The new internal value.
   */
  protected void setValueInternal(const anytype &valueInternal)
  {
    _valueInternal = valueInternal;
    dpSet(_dp + ".VInt", _valueInternal);
  }

  /**
   * @brief Sets the requested value of the service parameter.
   * @details Updates the requested value and writes it to the data point.
   *
   * @param valueRequested The new requested value.
   */
  protected void setValueRequested(const anytype &valueRequested)
  {
    _valueRequested = valueRequested;
    dpSet(_dp + ".VReq", _valueRequested);
  }

  /**
   * @brief Sets the feedback value of the service parameter.
   * @details Updates the feedback value and writes it to the data point.
   *
   * @param valueFeedback The new feedback value.
   */
  protected void setValueFeedback(const anytype &_valueFeedback)
  {
    _valueFeedback = _valueFeedback;
    dpSet(_dp + ".VFbk", _valueFeedback);
  }

  /**
   * @brief Callback function to set the apply enabled state.
   * @details Updates the apply enabled state and triggers the applyEnabledChanged event.
   *
   * @param dpe The data point element.
   * @param applyEnabled The new apply enabled state.
   */
  private void setApplyEnabledCB(const string &dpe, const bool &applyEnabled)
  {
    _applyEnabled = applyEnabled;
    applyEnabledChanged(_applyEnabled);
  }

  /**
   * @brief Callback function to set the external apply state.
   * @details Updates the external apply state and triggers the applyExternalChanged event.
   *
   * @param dpe The data point element.
   * @param applyExternal The new external apply state.
   */
  private void setApplyExternalCB(const string &dpe, const bool &applyExternal)
  {
    _applyExternal = applyExternal;
    applyExternalChanged(_applyExternal);
  }

  /**
   * @brief Callback function to set the internal apply state.
   * @details Updates the internal apply state and triggers the applyInternalChanged event.
   *
   * @param dpe The data point element.
   * @param applyInternal The new internal apply state.
   */
  private void setApplyInternalCB(const string &dpe, const bool &applyInternal)
  {
    _applyInternal = applyInternal;
    applyInternalChanged(_applyInternal);
  }

  /**
   * @brief Callback function to set the source channel state.
   * @details Updates the source channel state and triggers the sourceChannelChanged event.
   *
   * @param dpe The data point element.
   * @param sourceChannel The new source channel state.
   */
  private void setSourceChannelCB(const string &dpe, const bool &sourceChannel)
  {
    _sourceChannel = sourceChannel;
    sourceChannelChanged(_sourceChannel);
  }

  /**
   * @brief Callback function to set the external automatic source state.
   * @details Updates the external automatic source state and triggers the sourceExternalAutomaticChanged event.
   *
   * @param dpe The data point element.
   * @param sourceExternalAutomatic The new external automatic source state.
   */
  private void setSourceExternalAutomaticCB(const string &dpe, const bool &sourceExternalAutomatic)
  {
    _sourceExternalAutomatic = sourceExternalAutomatic;
    sourceExternalAutomaticChanged(_sourceExternalAutomatic);
  }

  /**
   * @brief Callback function to set the internal automatic source state.
   * @details Updates the internal automatic source state and triggers the sourceInternalAutomaticChanged event.
   *
   * @param dpe The data point element.
   * @param sourceInternalAutomatic The new internal automatic source state.
   */
  private void setSourceInternalAutomaticCB(const string &dpe, const bool &sourceInternalAutomatic)
  {
    _sourceInternalAutomatic = sourceInternalAutomatic;
    sourceInternalAutomaticChanged(_sourceInternalAutomatic);
  }

  /**
   * @brief Callback function to set the internal active source state.
   * @details Updates the internal active source state and triggers the sourceInternalActiveChanged event.
   *
   * @param dpe The data point element.
   * @param sourceInternalActive The new internal active source state.
   */
  private void setSourceInternalActiveCB(const string &dpe, const bool &sourceInternalActive)
  {
    _sourceInternalActive = sourceInternalActive;
    sourceInternalActiveChanged(_sourceInternalActive);
  }

  /**
   * @brief Callback function to set the external active source state.
   * @details Updates the external active source state and triggers the sourceExternalActiveChanged event.
   *
   * @param dpe The data point element.
   * @param sourceExternalActive The new external active source state.
   */
  private void setSourceExternalActiveCB(const string &dpe, const bool &sourceExternalActive)
  {
    _sourceExternalActive = sourceExternalActive;
    sourceExternalActiveChanged(_sourceExternalActive);
  }

  /**
   * @brief Callback function to set the external value.
   * @details Updates the external value and triggers the valueExternalChanged event.
   *
   * @param dpe The data point element.
   * @param valueExternal The new external value.
   */
  private void setValueExternalCB(const string &dpe, const bool &valueExternal)
  {
    _valueExternal = valueExternal;
    valueExternalChanged(_valueExternal);
  }

  /**
   * @brief Callback function to set the internal value.
   * @details Updates the internal value and triggers the valueInternalChanged event.
   *
   * @param dpe The data point element.
   * @param valueInternal The new internal value.
   */
  private void setValueInternalCB(const string &dpe, const bool &valueInternal)
  {
    _valueInternal = valueInternal;
    valueInternalChanged(_valueInternal);
  }

  /**
   * @brief Callback function to set the requested value.
   * @details Updates the requested value and triggers the valueRequestedChanged event.
   *
   * @param dpe The data point element.
   * @param valueRequested The new requested value.
   */
  private void setValueRequestedCB(const string &dpe, const bool &valueRequested)
  {
    _valueRequested = valueRequested;
    valueRequestedChanged(_valueRequested);
  }

  /**
   * @brief Callback function to set the feedback value.
   * @details Updates the feedback value and triggers the valueFeedbackChanged event.
   *
   * @param dpe The data point element.
   * @param valueFeedback The new feedback value.
   */
  private void setValueFeedbackCB(const string &dpe, const bool &valueFeedback)
  {
    _valueFeedback = valueFeedback;
    valueFeedbackChanged(_valueFeedback);
  }

  /**
     * @brief Callback function to set the state of the channel.
     * @details Updates the channel state and triggers the stateChannelChanged event.
     *
     * @param dpe The data point element.
     * @param channel The new channel state.
     */
  private void setStateChannelCB(const string &dpe, const bool &channel)
  {
    _stateChannel = channel;
    stateChannelChanged(_stateChannel);
  }

  /**
     * @brief Callback function to set the state of the off automatic mode.
     * @details Updates the off automatic state and triggers the stateOffAutomaticChanged event.
     *
     * @param dpe The data point element.
     * @param offAutomatic The new off automatic state.
     */
  private void setStateOffAutomaticCB(const string &dpe, const bool &offAutomatic)
  {
    _stateOffAutomatic = offAutomatic;
    stateOffAutomaticChanged(_stateOffAutomatic);
  }

  /**
     * @brief Callback function to set the state of the operator automatic mode.
     * @details Updates the operator automatic state and triggers the stateOperatorAutomaticChanged event.
     *
     * @param dpe The data point element.
     * @param operatorAutomatic The new operator automatic state.
     */
  private void setStateOperatorAutomaticCB(const string &dpe, const bool &operatorAutomatic)
  {
    _stateOperatorAutomatic = operatorAutomatic;
    stateOperatorAutomaticChanged(_stateOperatorAutomatic);
  }

  /**
     * @brief Callback function to set the state of the automatic automatic mode.
     * @details Updates the automatic automatic state and triggers the stateAutomaticAutomaticChanged event.
     *
     * @param dpe The data point element.
     * @param automaticAutomatic The new automatic automatic state.
     */
  private void setStateAutomaticAutomaticCB(const string &dpe, const bool &automaticAutomatic)
  {
    _stateAutomaticAutomatic = automaticAutomatic;
    stateAutomaticAutomaticChanged(_stateAutomaticAutomatic);
  }

  /**
     * @brief Callback function to set the active state of the operator mode.
     * @details Updates the operator active state and triggers the stateOperatorActiveChanged event.
     *
     * @param dpe The data point element.
     * @param operatorActive The new operator active state.
     */
  private void setStateOperatorActiveCB(const string &dpe, const bool &operatorActive)
  {
    _stateOperatorActive = operatorActive;
    stateOperatorActiveChanged(_stateOperatorActive);
  }

  /**
   * @brief Callback function to set the active state of the automatic mode.
   * @details Updates the automatic active state and triggers the stateAutomaticActiveChanged event.
   *
   * @param dpe The data point element.
   * @param automaticActive The new automatic active state.
   */
  private void setStateAutomaticActiveCB(const string &dpe, const bool &automaticActive)
  {
    _stateAutomaticActive = automaticActive;
    stateAutomaticActiveChanged(_stateAutomaticActive);
  }

  /**
     * @brief Callback function to set the active state of the off mode.
     * @details Updates the off active state and triggers the stateOffActiveChanged event.
     *
     * @param dpe The data point element.
     * @param offActive The new off active state.
     */
  private void setStateOffActiveCB(const string &dpe, const bool &offActive)
  {
    _stateOffActive = offActive;
    stateOffActiveChanged(_stateOffActive);
  }
};
