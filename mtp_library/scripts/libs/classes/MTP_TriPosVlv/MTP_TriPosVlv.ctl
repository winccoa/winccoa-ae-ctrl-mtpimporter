// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_ActiveElement/MTP_ActiveElement"

/**
 * @class MTP_TriPosVlv
 * @brief Represents the MTP_TriPosVlv class.
 */
class MTP_TriPosVlv : MTP_ActiveElement
{
  private int _safePosition; //!< Safe position selection: 1=Pos1, 2=Pos2, 3=Pos3.
  private bool _safePositionEnabled; //!< True if safe position is enabled.
  private bool _safePositionActive; //!< True if safe position is active.

  private int _pos1Configuration; //!< Configuration value for position 1.
  private int _pos2Configuration; //!< Configuration value for position 2.
  private int _pos3Configuration; //!< Configuration value for position 3.

  private bool _pos1Operator; //!< Operator request for position 1.
  private bool _pos2Operator; //!< Operator request for position 2.
  private bool _pos3Operator; //!< Operator request for position 3.

  private bool _pos1Automatic; //!< Automatic request for position 1.
  private bool _pos2Automatic; //!< Automatic request for position 2.
  private bool _pos3Automatic; //!< Automatic request for position 3.

  private bool _pos1Control; //!< Effective control state for position 1.
  private bool _pos2Control; //!< Effective control state for position 2.
  private bool _pos3Control; //!< Effective control state for position 3.

  private bool _pos1FeedbackSource; //!< Feedback source selector for position 1.
  private bool _pos2FeedbackSource; //!< Feedback source selector for position 2.
  private bool _pos3FeedbackSource; //!< Feedback source selector for position 3.

  private bool _pos1FeedbackSignal; //!< Feedback signal for position 1.
  private bool _pos2FeedbackSignal; //!< Feedback signal for position 2.
  private bool _pos3FeedbackSignal; //!< Feedback signal for position 3.

  private bool _resetOperator; //!< Operator reset request.
  private bool _resetAutomatic; //!< Automatic reset request.

  private shared_ptr<MTP_State> _state; //!< Operation mode/channel helper.
  private shared_ptr<MTP_Security> _security; //!< Permission/interlock/protection helper.

  /**
   * @brief Creates a TriPos valve model for the given datapoint.
   *
   * @param dp Base datapoint name of the TriPos valve.
   */
  public MTP_TriPosVlv(const string &dp) : MTP_ActiveElement(dp)
  {
    if (!dpExists(getDp() + ".SafePos"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePos"));
    }

    if (!dpExists(getDp() + ".SafePosEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePosEn"));
    }

    if (!dpExists(getDp() + ".SafePosAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePosAct"));
    }

    if (!dpExists(getDp() + ".Pos1Conf"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos1Conf"));
    }

    if (!dpExists(getDp() + ".Pos2Conf"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos2Conf"));
    }

    if (!dpExists(getDp() + ".Pos3Conf"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos3Conf"));
    }

    if (!dpExists(getDp() + ".Pos1Op"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos1Op"));
    }

    if (!dpExists(getDp() + ".Pos2Op"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos2Op"));
    }

    if (!dpExists(getDp() + ".Pos3Op"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos3Op"));
    }

    if (!dpExists(getDp() + ".Pos1Aut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos1Aut"));
    }

    if (!dpExists(getDp() + ".Pos2Aut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos2Aut"));
    }

    if (!dpExists(getDp() + ".Pos3Aut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos3Aut"));
    }

    if (!dpExists(getDp() + ".Pos1Ctrl"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos1Ctrl"));
    }

    if (!dpExists(getDp() + ".Pos2Ctrl"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos2Ctrl"));
    }

    if (!dpExists(getDp() + ".Pos3Ctrl"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos3Ctrl"));
    }

    if (!dpExists(getDp() + ".Pos1FbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos1FbkCalc"));
    }

    if (!dpExists(getDp() + ".Pos2FbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos2FbkCalc"));
    }

    if (!dpExists(getDp() + ".Pos3FbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos3FbkCalc"));
    }

    if (!dpExists(getDp() + ".Pos1Fbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos1Fbk"));
    }

    if (!dpExists(getDp() + ".Pos2Fbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos2Fbk"));
    }

    if (!dpExists(getDp() + ".Pos3Fbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos3Fbk"));
    }

    if (!dpExists(getDp() + ".ResetOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ResetOp"));
    }

    if (!dpExists(getDp() + ".ResetAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ResetAut"));
    }

    dpGet(getDp() + ".Pos1Op", _pos1Operator,
          getDp() + ".Pos2Op", _pos2Operator,
          getDp() + ".Pos3Op", _pos3Operator,
          getDp() + ".ResetOp", _resetOperator);

    dpConnect(this, setSafePositionCB, getDp() + ".SafePos");
    dpConnect(this, setSafePositionEnabledCB, getDp() + ".SafePosEn");
    dpConnect(this, setSafePositionActiveCB, getDp() + ".SafePosAct");

    dpConnect(this, setPos1ConfigurationCB, getDp() + ".Pos1Conf");
    dpConnect(this, setPos2ConfigurationCB, getDp() + ".Pos2Conf");
    dpConnect(this, setPos3ConfigurationCB, getDp() + ".Pos3Conf");

    dpConnect(this, setPos1AutomaticCB, getDp() + ".Pos1Aut");
    dpConnect(this, setPos2AutomaticCB, getDp() + ".Pos2Aut");
    dpConnect(this, setPos3AutomaticCB, getDp() + ".Pos3Aut");

    dpConnect(this, setPos1ControlCB, getDp() + ".Pos1Ctrl");
    dpConnect(this, setPos2ControlCB, getDp() + ".Pos2Ctrl");
    dpConnect(this, setPos3ControlCB, getDp() + ".Pos3Ctrl");

    dpConnect(this, setPos1FeedbackSourceCB, getDp() + ".Pos1FbkCalc");
    dpConnect(this, setPos2FeedbackSourceCB, getDp() + ".Pos2FbkCalc");
    dpConnect(this, setPos3FeedbackSourceCB, getDp() + ".Pos3FbkCalc");

    dpConnect(this, setPos1FeedbackSignalCB, getDp() + ".Pos1Fbk");
    dpConnect(this, setPos2FeedbackSignalCB, getDp() + ".Pos2Fbk");
    dpConnect(this, setPos3FeedbackSignalCB, getDp() + ".Pos3Fbk");

    dpConnect(this, setResetAutomaticCB, getDp() + ".ResetAut");

    _state = new MTP_State(getDp() + ".StateChannel", getDp() + ".StateOffAut", getDp() + ".StateOpAut", getDp() + ".StateAutAut", getDp() + ".StateOffOp", getDp() + ".StateOpOp", getDp() + ".StateAutOp", getDp() + ".StateOpAct", getDp() + ".StateAutAct", getDp() + ".StateOffAct");
    _security = new MTP_Security(getDp() + ".PermEn", getDp() + ".Permit", getDp() + ".IntlEn", getDp() + ".Interlock", getDp() + ".ProtEn", getDp() + ".Protect");
  }

  #event safePositionChanged(const int &safePosition) //!< Triggered when `SafePos` changes.
  #event safePositionEnabledChanged(const bool &safePositionEnabled) //!< Triggered when `SafePosEn` changes.
  #event safePositionActiveChanged(const bool &safePositionActive) //!< Triggered when `SafePosAct` changes.

  #event pos1ConfigurationChanged(const int &pos1Configuration) //!< Triggered when `Pos1Conf` changes.
  #event pos2ConfigurationChanged(const int &pos2Configuration) //!< Triggered when `Pos2Conf` changes.
  #event pos3ConfigurationChanged(const int &pos3Configuration) //!< Triggered when `Pos3Conf` changes.

  #event pos1AutomaticChanged(const bool &pos1Automatic) //!< Triggered when `Pos1Aut` changes.
  #event pos2AutomaticChanged(const bool &pos2Automatic) //!< Triggered when `Pos2Aut` changes.
  #event pos3AutomaticChanged(const bool &pos3Automatic) //!< Triggered when `Pos3Aut` changes.

  #event pos1ControlChanged(const bool &pos1Control) //!< Triggered when `Pos1Ctrl` changes.
  #event pos2ControlChanged(const bool &pos2Control) //!< Triggered when `Pos2Ctrl` changes.
  #event pos3ControlChanged(const bool &pos3Control) //!< Triggered when `Pos3Ctrl` changes.

  #event pos1FeedbackSourceChanged(const bool &pos1FeedbackSource) //!< Triggered when `Pos1FbkCalc` changes.
  #event pos2FeedbackSourceChanged(const bool &pos2FeedbackSource) //!< Triggered when `Pos2FbkCalc` changes.
  #event pos3FeedbackSourceChanged(const bool &pos3FeedbackSource) //!< Triggered when `Pos3FbkCalc` changes.

  #event pos1FeedbackSignalChanged(const bool &pos1FeedbackSignal) //!< Triggered when `Pos1Fbk` changes.
  #event pos2FeedbackSignalChanged(const bool &pos2FeedbackSignal) //!< Triggered when `Pos2Fbk` changes.
  #event pos3FeedbackSignalChanged(const bool &pos3FeedbackSignal) //!< Triggered when `Pos3Fbk` changes.

  #event resetAutomaticChanged(const bool &resetAutomatic) //!< Triggered when `ResetAut` changes.

  /** @brief Returns configured safe position (1..3). */
  /**
   * @brief Retrieves the safe position.
   *
   * @return The safe position.
   */
  public int getSafePosition()
  {
    return _safePosition;
  }

  /** @brief Returns whether safe position functionality is enabled. */
  /**
   * @brief Retrieves the safe position enabled.
   *
   * @return The safe position enabled.
   */
  public bool getSafePositionEnabled()
  {
    return _safePositionEnabled;
  }

  /** @brief Returns whether safe position mode is currently active. */
  /**
   * @brief Retrieves the safe position active.
   *
   * @return The safe position active.
   */
  public bool getSafePositionActive()
  {
    return _safePositionActive;
  }

  /** @brief Returns configured value for position 1. */
  /**
   * @brief Retrieves the pos1 configuration.
   *
   * @return The pos1 configuration.
   */
  public int getPos1Configuration()
  {
    return _pos1Configuration;
  }

  /** @brief Returns configured value for position 2. */
  /**
   * @brief Retrieves the pos2 configuration.
   *
   * @return The pos2 configuration.
   */
  public int getPos2Configuration()
  {
    return _pos2Configuration;
  }

  /** @brief Returns configured value for position 3. */
  /**
   * @brief Retrieves the pos3 configuration.
   *
   * @return The pos3 configuration.
   */
  public int getPos3Configuration()
  {
    return _pos3Configuration;
  }

  /** @brief Returns operator request state for position 1. */
  /**
   * @brief Retrieves the pos1 operator.
   *
   * @return The pos1 operator.
   */
  public bool getPos1Operator()
  {
    return _pos1Operator;
  }

  /** @brief Returns operator request state for position 2. */
  /**
   * @brief Retrieves the pos2 operator.
   *
   * @return The pos2 operator.
   */
  public bool getPos2Operator()
  {
    return _pos2Operator;
  }

  /** @brief Returns operator request state for position 3. */
  /**
   * @brief Retrieves the pos3 operator.
   *
   * @return The pos3 operator.
   */
  public bool getPos3Operator()
  {
    return _pos3Operator;
  }

  /** @brief Returns automatic request state for position 1. */
  /**
   * @brief Retrieves the pos1 automatic.
   *
   * @return The pos1 automatic.
   */
  public bool getPos1Automatic()
  {
    return _pos1Automatic;
  }

  /** @brief Returns automatic request state for position 2. */
  /**
   * @brief Retrieves the pos2 automatic.
   *
   * @return The pos2 automatic.
   */
  public bool getPos2Automatic()
  {
    return _pos2Automatic;
  }

  /** @brief Returns automatic request state for position 3. */
  /**
   * @brief Retrieves the pos3 automatic.
   *
   * @return The pos3 automatic.
   */
  public bool getPos3Automatic()
  {
    return _pos3Automatic;
  }

  /** @brief Returns control output state for position 1. */
  /**
   * @brief Retrieves the pos1 control.
   *
   * @return The pos1 control.
   */
  public bool getPos1Control()
  {
    return _pos1Control;
  }

  /** @brief Returns control output state for position 2. */
  /**
   * @brief Retrieves the pos2 control.
   *
   * @return The pos2 control.
   */
  public bool getPos2Control()
  {
    return _pos2Control;
  }

  /** @brief Returns control output state for position 3. */
  /**
   * @brief Retrieves the pos3 control.
   *
   * @return The pos3 control.
   */
  public bool getPos3Control()
  {
    return _pos3Control;
  }

  /** @brief Returns feedback source selector for position 1. */
  /**
   * @brief Retrieves the pos1 feedback source.
   *
   * @return The pos1 feedback source.
   */
  public bool getPos1FeedbackSource()
  {
    return _pos1FeedbackSource;
  }

  /** @brief Returns feedback source selector for position 2. */
  /**
   * @brief Retrieves the pos2 feedback source.
   *
   * @return The pos2 feedback source.
   */
  public bool getPos2FeedbackSource()
  {
    return _pos2FeedbackSource;
  }

  /** @brief Returns feedback source selector for position 3. */
  /**
   * @brief Retrieves the pos3 feedback source.
   *
   * @return The pos3 feedback source.
   */
  public bool getPos3FeedbackSource()
  {
    return _pos3FeedbackSource;
  }

  /** @brief Returns feedback signal state for position 1. */
  /**
   * @brief Retrieves the pos1 feedback signal.
   *
   * @return The pos1 feedback signal.
   */
  public bool getPos1FeedbackSignal()
  {
    return _pos1FeedbackSignal;
  }

  /** @brief Returns feedback signal state for position 2. */
  /**
   * @brief Retrieves the pos2 feedback signal.
   *
   * @return The pos2 feedback signal.
   */
  public bool getPos2FeedbackSignal()
  {
    return _pos2FeedbackSignal;
  }

  /** @brief Returns feedback signal state for position 3. */
  /**
   * @brief Retrieves the pos3 feedback signal.
   *
   * @return The pos3 feedback signal.
   */
  public bool getPos3FeedbackSignal()
  {
    return _pos3FeedbackSignal;
  }

  /** @brief Returns operator reset request state. */
  /**
   * @brief Retrieves the reset operator.
   *
   * @return The reset operator.
   */
  public bool getResetOperator()
  {
    return _resetOperator;
  }

  /** @brief Returns automatic reset request state. */
  /**
   * @brief Retrieves the reset automatic.
   *
   * @return The reset automatic.
   */
  public bool getResetAutomatic()
  {
    return _resetAutomatic;
  }

  /** @brief Returns state helper for mode/channel handling. */
  /**
   * @brief Retrieves the state.
   *
   * @return The state.
   */
  public shared_ptr<MTP_State> getState()
  {
    return _state;
  }

  /** @brief Returns security helper for permission/interlock/protect handling. */
  /**
   * @brief Retrieves the security.
   *
   * @return The security.
   */
  public shared_ptr<MTP_Security> getSecurity()
  {
    return _security;
  }

  /** @brief Sets operator request for position 1 and writes `Pos1Op`. */
  /**
   * @brief Sets the pos1 operator.
   *
   * @param pos1Operator The new pos1 operator value.
   */
  public void setPos1Operator(const bool &pos1Operator)
  {
    _pos1Operator = pos1Operator;
    dpSet(getDp() + ".Pos1Op", _pos1Operator);
  }

  /** @brief Sets operator request for position 2 and writes `Pos2Op`. */
  /**
   * @brief Sets the pos2 operator.
   *
   * @param pos2Operator The new pos2 operator value.
   */
  public void setPos2Operator(const bool &pos2Operator)
  {
    _pos2Operator = pos2Operator;
    dpSet(getDp() + ".Pos2Op", _pos2Operator);
  }

  /** @brief Sets operator request for position 3 and writes `Pos3Op`. */
  /**
   * @brief Sets the pos3 operator.
   *
   * @param pos3Operator The new pos3 operator value.
   */
  public void setPos3Operator(const bool &pos3Operator)
  {
    _pos3Operator = pos3Operator;
    dpSet(getDp() + ".Pos3Op", _pos3Operator);
  }

  /** @brief Sets operator reset request and writes `ResetOp`. */
  /**
   * @brief Sets the reset operator.
   *
   * @param resetOperator The new reset operator value.
   */
  public void setResetOperator(const bool &resetOperator)
  {
    _resetOperator = resetOperator;
    dpSet(getDp() + ".ResetOp", _resetOperator);
  }

  /** @brief Callback for `SafePos` updates. */
  /**
   * @brief Sets the safe position from the connected data point element.
   *
   * @param dpe The data point element.
   * @param safePosition The new safe position value.
   */
  private void setSafePositionCB(const string &dpe, const int &safePosition)
  {
    _safePosition = safePosition;
    safePositionChanged(_safePosition);
  }

  /** @brief Callback for `SafePosEn` updates. */
  /**
   * @brief Sets the safe position enabled from the connected data point element.
   *
   * @param dpe The data point element.
   * @param safePositionEnabled The new safe position enabled value.
   */
  private void setSafePositionEnabledCB(const string &dpe, const bool &safePositionEnabled)
  {
    _safePositionEnabled = safePositionEnabled;
    safePositionEnabledChanged(_safePositionEnabled);
  }

  /** @brief Callback for `SafePosAct` updates. */
  /**
   * @brief Sets the safe position active from the connected data point element.
   *
   * @param dpe The data point element.
   * @param safePositionActive The new safe position active value.
   */
  private void setSafePositionActiveCB(const string &dpe, const bool &safePositionActive)
  {
    _safePositionActive = safePositionActive;
    safePositionActiveChanged(_safePositionActive);
  }

  /** @brief Callback for `Pos1Conf` updates. */
  /**
   * @brief Sets the pos1 configuration from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos1Configuration The new pos1 configuration value.
   */
  private void setPos1ConfigurationCB(const string &dpe, const int &pos1Configuration)
  {
    _pos1Configuration = pos1Configuration;
    pos1ConfigurationChanged(_pos1Configuration);
  }

  /** @brief Callback for `Pos2Conf` updates. */
  /**
   * @brief Sets the pos2 configuration from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos2Configuration The new pos2 configuration value.
   */
  private void setPos2ConfigurationCB(const string &dpe, const int &pos2Configuration)
  {
    _pos2Configuration = pos2Configuration;
    pos2ConfigurationChanged(_pos2Configuration);
  }

  /** @brief Callback for `Pos3Conf` updates. */
  /**
   * @brief Sets the pos3 configuration from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos3Configuration The new pos3 configuration value.
   */
  private void setPos3ConfigurationCB(const string &dpe, const int &pos3Configuration)
  {
    _pos3Configuration = pos3Configuration;
    pos3ConfigurationChanged(_pos3Configuration);
  }

  /** @brief Callback for `Pos1Aut` updates. */
  /**
   * @brief Sets the pos1 automatic from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos1Automatic The new pos1 automatic value.
   */
  private void setPos1AutomaticCB(const string &dpe, const bool &pos1Automatic)
  {
    _pos1Automatic = pos1Automatic;
    pos1AutomaticChanged(_pos1Automatic);
  }

  /** @brief Callback for `Pos2Aut` updates. */
  /**
   * @brief Sets the pos2 automatic from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos2Automatic The new pos2 automatic value.
   */
  private void setPos2AutomaticCB(const string &dpe, const bool &pos2Automatic)
  {
    _pos2Automatic = pos2Automatic;
    pos2AutomaticChanged(_pos2Automatic);
  }

  /** @brief Callback for `Pos3Aut` updates. */
  /**
   * @brief Sets the pos3 automatic from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos3Automatic The new pos3 automatic value.
   */
  private void setPos3AutomaticCB(const string &dpe, const bool &pos3Automatic)
  {
    _pos3Automatic = pos3Automatic;
    pos3AutomaticChanged(_pos3Automatic);
  }

  /** @brief Callback for `Pos1Ctrl` updates. */
  /**
   * @brief Sets the pos1 control from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos1Control The new pos1 control value.
   */
  private void setPos1ControlCB(const string &dpe, const bool &pos1Control)
  {
    _pos1Control = pos1Control;
    pos1ControlChanged(_pos1Control);
  }

  /** @brief Callback for `Pos2Ctrl` updates. */
  /**
   * @brief Sets the pos2 control from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos2Control The new pos2 control value.
   */
  private void setPos2ControlCB(const string &dpe, const bool &pos2Control)
  {
    _pos2Control = pos2Control;
    pos2ControlChanged(_pos2Control);
  }

  /** @brief Callback for `Pos3Ctrl` updates. */
  /**
   * @brief Sets the pos3 control from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos3Control The new pos3 control value.
   */
  private void setPos3ControlCB(const string &dpe, const bool &pos3Control)
  {
    _pos3Control = pos3Control;
    pos3ControlChanged(_pos3Control);
  }

  /** @brief Callback for `Pos1FbkCalc` updates. */
  /**
   * @brief Sets the pos1 feedback source from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos1FeedbackSource The new pos1 feedback source value.
   */
  private void setPos1FeedbackSourceCB(const string &dpe, const bool &pos1FeedbackSource)
  {
    _pos1FeedbackSource = pos1FeedbackSource;
    pos1FeedbackSourceChanged(_pos1FeedbackSource);
  }

  /** @brief Callback for `Pos2FbkCalc` updates. */
  /**
   * @brief Sets the pos2 feedback source from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos2FeedbackSource The new pos2 feedback source value.
   */
  private void setPos2FeedbackSourceCB(const string &dpe, const bool &pos2FeedbackSource)
  {
    _pos2FeedbackSource = pos2FeedbackSource;
    pos2FeedbackSourceChanged(_pos2FeedbackSource);
  }

  /** @brief Callback for `Pos3FbkCalc` updates. */
  /**
   * @brief Sets the pos3 feedback source from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos3FeedbackSource The new pos3 feedback source value.
   */
  private void setPos3FeedbackSourceCB(const string &dpe, const bool &pos3FeedbackSource)
  {
    _pos3FeedbackSource = pos3FeedbackSource;
    pos3FeedbackSourceChanged(_pos3FeedbackSource);
  }

  /** @brief Callback for `Pos1Fbk` updates. */
  /**
   * @brief Sets the pos1 feedback signal from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos1FeedbackSignal The new pos1 feedback signal value.
   */
  private void setPos1FeedbackSignalCB(const string &dpe, const bool &pos1FeedbackSignal)
  {
    _pos1FeedbackSignal = pos1FeedbackSignal;
    pos1FeedbackSignalChanged(_pos1FeedbackSignal);
  }

  /** @brief Callback for `Pos2Fbk` updates. */
  /**
   * @brief Sets the pos2 feedback signal from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos2FeedbackSignal The new pos2 feedback signal value.
   */
  private void setPos2FeedbackSignalCB(const string &dpe, const bool &pos2FeedbackSignal)
  {
    _pos2FeedbackSignal = pos2FeedbackSignal;
    pos2FeedbackSignalChanged(_pos2FeedbackSignal);
  }

  /** @brief Callback for `Pos3Fbk` updates. */
  /**
   * @brief Sets the pos3 feedback signal from the connected data point element.
   *
   * @param dpe The data point element.
   * @param pos3FeedbackSignal The new pos3 feedback signal value.
   */
  private void setPos3FeedbackSignalCB(const string &dpe, const bool &pos3FeedbackSignal)
  {
    _pos3FeedbackSignal = pos3FeedbackSignal;
    pos3FeedbackSignalChanged(_pos3FeedbackSignal);
  }

  /** @brief Callback for `ResetAut` updates. */
  /**
   * @brief Sets the reset automatic from the connected data point element.
   *
   * @param dpe The data point element.
   * @param resetAutomatic The new reset automatic value.
   */
  private void setResetAutomaticCB(const string &dpe, const bool &resetAutomatic)
  {
    _resetAutomatic = resetAutomatic;
    resetAutomaticChanged(_resetAutomatic);
  }
};
