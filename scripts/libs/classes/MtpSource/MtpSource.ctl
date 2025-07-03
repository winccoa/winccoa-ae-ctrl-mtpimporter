// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MtpSource
 * @brief Represents the current source state of the MTP library object.
 */
class MtpSource
{
  private bool _channel; //!< The source channel of the MTP object.
  private bool _manualAutomatic; //!< Indicates if the MTP object is in manual automatic mode.
  private bool _internalAutomatic; //!< Indicates if the MTP object is in internal automatic mode.
  private bool _manualOperator; //!< Indicates if the MTP object is in manual operator mode.
  private bool _internalOperator; //!< Indicates if the MTP object is in internal operator mode.
  private bool _manualActive; //!< Indicates if the MTP object is in manual active mode.
  private bool _internalActive; //!< Indicates if the MTP object is in internal active mode.
  private string _dpeManualOperator; //!< Data point element for manual operator state.
  private string _dpeInternalOperator; //!< Data point element for internal operator state.

  /**
   * @brief Constructor for MtpSource.
   *
   * @param dpeChannel The data point element for the channel state.
   * @param dpeManualAutomatic The data point element for manual automatic state.
   * @param dpeInternalAutomatic The data point element for internal automatic state.
   * @param dpeManualOperator The data point element for manual operator state.
   * @param dpeInternalOperator The data point element for internal operator state.
   * @param dpeManualActive The data point element for manual active state.
   * @param dpeInternalActive The data point element for internal active state.
   */
  public MtpSource(const string &dpeChannel, const string &dpeManualAutomatic, const string &dpeInternalAutomatic, const string &dpeManualOperator, const string &dpeInternalOperator, const string &dpeManualActive, const string &dpeInternalActive)
  {
    if (!dpExists(dpeChannel))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeChannel));
    }

    if (!dpExists(dpeManualAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeManualAutomatic));
    }

    if (!dpExists(dpeInternalAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInternalAutomatic));
    }

    if (!dpExists(dpeManualOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeManualOperator));
    }

    if (!dpExists(dpeInternalOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInternalOperator));
    }

    if (!dpExists(dpeManualActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeManualActive));
    }

    if (!dpExists(dpeInternalActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInternalActive));
    }

    _dpeManualOperator = dpeManualOperator;
    _dpeInternalOperator = dpeInternalOperator;

    dpGet(_dpeManualOperator, _manualOperator,
          _dpeInternalOperator, _internalOperator);

    dpConnect(this, setChannelCB, dpeChannel);
    dpConnect(this, setManualAutomaticCB, dpeManualAutomatic);
    dpConnect(this, setInternalAutomaticCB, dpeInternalAutomatic);
    dpConnect(this, setManualActiveCB, dpeManualActive);
    dpConnect(this, setInternalActiveCB, dpeInternalActive);
  }

#event channelChanged(const bool &channel) //!< Event triggered when the channel state changes.
#event manualAutomaticChanged(const bool &manualAutomatic) //!< Event triggered when the manual automatic state changes.
#event internalAutomaticChanged(const bool &internalAutomatic) //!< Event triggered when the internal automatic state changes.
#event manualActiveChanged(const bool &manualActive) //!< Event triggered when the manual active state changes.
#event internalActiveChanged(const bool &internalActive) //!< Event triggered when the internal active state changes.

  /**
   * @brief Retrieves the current channel state.
   * 
   * @return True if the channel is automatic, false if the channel is operator.
   */
  public bool getChannel()
  {
    return _channel;
  }

  /**
   * @brief Retrieves the current manual automatic state.
   * 
   * @return True if manual automatic, false otherwise.
   */
  public bool getManualAutomatic()
  {
    return _manualAutomatic;
  }

  /**
   * @brief Retrieves the current internal automatic state.
   * 
   * @return True if internal automatic, false otherwise.
   */
  public bool getInternalAutomatic()
  {
    return _internalAutomatic;
  }

  /**
   * @brief Retrieves the current manual operator state.
   * 
   * @return True if manual operator, false otherwise.
   */
  public bool getManualOperator()
  {
    return _manualOperator;
  }

  /**
   * @brief Retrieves the current internal operator state.
   * 
   * @return True if internal operator, false otherwise.
   */
  public bool getInternalOperator()
  {
    return _internalOperator;
  }

  /**
   * @brief Retrieves the current manual active state.
   * 
   * @return True if manual active, false otherwise.
   */
  public bool getManualActive()
  {
    return _manualActive;
  }

  /**
   * @brief Retrieves the current internal active state.
   * 
   * @return True if internal active, false otherwise.
   */
  public bool getInternalActive()
  {
    return _internalActive;
  }

  /**
   * @brief Sets the manual operator mode.
   *
   * @param manualOperator True to set manual operator mode, false otherwise.
   */
  public void setManualOperator(const bool &manualOperator)
  {
    _manualOperator = manualOperator;
    dpSet(_dpeManualOperator, _manualOperator);
  }

  /**
   * @brief Sets the internal operator mode.
   *
   * @param internalOperator True to set internal operator mode, false otherwise.
   */
  public void setInternalOperator(const bool &internalOperator)
  {
    _internalOperator = internalOperator;
    dpSet(_dpeInternalOperator, _internalOperator);
  }

  /**
   * @brief Sets the state of the channel.
   * @details Triggers the channelChanged event.
   *
   * @param dpe The data point element.
   * @param channel The new state for the channel.
   */
  private void setChannelCB(const string &dpe, const bool &channel)
  {
    _channel = channel;
    channelChanged(getChannel());
  }

  /**
   * @brief Sets the state of the manual automatic mode.
   * @details Triggers the manualAutomaticChanged event.
   * 
   * @param dpe The data point element.
   * @param manualAutomatic The new manual automatic state to set.
   */
  private void setManualAutomaticCB(const string &dpe, const bool &manualAutomatic)
  {
    _manualAutomatic = manualAutomatic;
    manualAutomaticChanged(getManualAutomatic());
  }

  /**
   * @brief Sets the state of the internal automatic mode.
   * @details Triggers the internalAutomaticChanged event.
   * 
   * @param dpe The data point element.
   * @param internalAutomatic The new internal automatic state to set.
   */
  private void setInternalAutomaticCB(const string &dpe, const bool &internalAutomatic)
  {
    _internalAutomatic = internalAutomatic;
    internalAutomaticChanged(getInternalAutomatic());
  }

  /**
   * @brief Sets the state of the manual active mode.
   * @details Triggers the manualActiveChanged event.
   *
   * @param dpe The data point element.
   * @param manualActive The new manual active state to set.
   */
  private void setManualActiveCB(const string &dpe, const bool &manualActive)
  {
    _manualActive = manualActive;
    manualActiveChanged(getManualActive());
  }

  /**
   * @brief Sets the state of the internal active mode.
   * @details Triggers the internalActiveChanged event.
   *
   * @param dpe The data point element.
   * @param internalActive The new internal active state to set.
   */
  private void setInternalActiveCB(const string &dpe, const bool &internalActive)
  {
    _internalActive = internalActive;
    internalActiveChanged(getInternalActive());
  }
};
