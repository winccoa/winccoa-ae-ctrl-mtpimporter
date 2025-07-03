// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MtpState
 * @brief Represents the current operation state for the MTP library object.
 */
class MtpState
{
  private bool _channel; //!< The state channel of the MTP object.
  private bool _offAutomatic; //!< Indicates if the MTP object is in off automatic mode.
  private bool _operatorAutomatic; //!< Indicates if the MTP object is in operator automatic mode.
  private bool _automaticAutomatic; //!< Indicates if the MTP object is in automatic automatic mode.
  private bool _offOperator; //!< Indicates if the MTP object is in off operator mode.
  private bool _automaticOperator; //!< Indicates if the MTP object is in automatic operator mode.
  private bool _operatorOperator; //!< Indicates if the MTP object is in operator operator mode.
  private bool _operatorActive; //!< Indicates if the operator mode is active.
  private bool _automaticActive; //!< Indicates if the automatic mode is active.
  private bool _offActive; //!< Indicates if the off mode is active.
  private string _dpeOffOperator; //!< Data point element for off operator state.
  private string _dpeOperatorOperator; //!< Data point element for operator operator state.
  private string _dpeAutomaticOperator; //!< Data point element for automatic operator state.

  /**
   * @brief Constructor for MtpState.
   *
   * @param dpeChannel The data point element for the channel state.
   * @param dpeOffAutomatic The data point element for off automatic state.
   * @param dpeOperatorAutomatic The data point element for operator automatic state.
   * @param dpeAutomaticAutomatic The data point element for automatic automatic state.
   * @param dpeOffOperator The data point element for off operator state.
   * @param dpeOperatorOperator The data point element for operator operator state.
   * @param dpeAutomaticOperator The data point element for automatic operator state.
   * @param dpeOperatorActive The data point element for operator active state.
   * @param dpeAutomaticActive The data point element for automatic active state.
   * @param dpeOffActive The data point element for off active state.
   */
  public MtpState(const string &dpeChannel, const string &dpeOffAutomatic, const string &dpeOperatorAutomatic, const string &dpeAutomaticAutomatic, const string &dpeOffOperator, const string &dpeOperatorOperator, const string &dpeAutomaticOperator, const string &dpeOperatorActive, const string &dpeAutomaticActive, const string &dpeOffActive)
  {
    if (!dpExists(dpeChannel))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeChannel));
    }

    if (!dpExists(dpeOffAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOffAutomatic));
    }

    if (!dpExists(dpeOperatorAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOperatorAutomatic));
    }

    if (!dpExists(dpeAutomaticAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeAutomaticAutomatic));
    }

    if (!dpExists(dpeOffOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOffOperator));
    }

    if (!dpExists(dpeOperatorOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOperatorOperator));
    }

    if (!dpExists(dpeAutomaticOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeAutomaticOperator));
    }

    if (!dpExists(dpeOperatorActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOperatorActive));
    }

    if (!dpExists(dpeAutomaticActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeAutomaticActive));
    }

    if (!dpExists(dpeOffActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOffActive));
    }

    _dpeOffOperator = dpeOffOperator;
    _dpeOperatorOperator = dpeOperatorOperator;
    _dpeAutomaticOperator = dpeAutomaticOperator;

    dpGet(_dpeOffOperator, _offOperator,
          _dpeOperatorOperator, _operatorOperator,
          _dpeAutomaticOperator, _automaticOperator);

    dpConnect(this, setChannelCB, dpeChannel);
    dpConnect(this, setOffAutomaticCB, dpeOffAutomatic);
    dpConnect(this, setOperatorAutomaticCB, dpeOperatorAutomatic);
    dpConnect(this, setAutomaticAutomaticCB, dpeAutomaticAutomatic);
    dpConnect(this, setOperatorActiveCB, dpeOperatorActive);
    dpConnect(this, setAutomaticActiveCB, dpeAutomaticActive);
    dpConnect(this, setOffActiveCB, dpeOffActive);
  }

#event offActiveChanged(const bool &active) //!< Event triggered when the off active state changes.
#event operatorActiveChanged(const bool &active) //!< Event triggered when the operator active state changes.
#event automaticActiveChanged(const bool &active) //!< Event triggered when the automatic active state changes.
#event channelChanged(const bool &channel) //!< Event triggered when the channel state changes.
#event offAutomaticChanged(const bool &automatic) //!< Event triggered when the off automatic state changes.
#event operatorAutomaticChanged(const bool &automatic) //!< Event triggered when the operator automatic state changes.
#event automaticAutomaticChanged(const bool &automatic) //!< Event triggered when the automatic automatic state changes.

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
   * @brief Retrieves the operating mode off automatic.
   * 
   * @return True if off automatic, false otherwise.
   */
  public bool getOffAutomatic()
  {
    return _offAutomatic;
  }

  /**
   * @brief Retrieves the operating mode operator automatic.
   * 
   * @return True if operator automatic, false otherwise.
   */
  public bool getOperatorAutomatic()
  {
    return _operatorAutomatic;
  }

  /**
   * @brief Retrieves the operating mode automatic automatic.
   * 
   * @return True if automatic automatic, false otherwise.
   */
  public bool getAutomaticAutomatic()
  {
    return _automaticAutomatic;
  }

  /**
   * @brief Retrieves the operating mode off operator.
   * 
   * @return True if off operator, false otherwise.
   */
  public bool getOffOperator()
  {
    return _offOperator;
  }

  /**
   * @brief Retrieves the operating mode operator operator.
   * 
   * @return True if operator operator, false otherwise.
   */
  public bool getOperatorOperator()
  {
    return _operatorOperator;
  }

  /**
   * @brief Retrieves the operating mode automatic operator.
   * 
   * @return True if automatic operator, false otherwise.
   */
  public bool getAutomaticOperator()
  {
    return _automaticOperator;
  }

  /**
   * @brief Retrieves the active state of the operator mode.
   * 
   * @return True if operator mode is active, false otherwise.
   */
  public bool getOperatorActive()
  {
    return _operatorActive;
  }

  /**
   * @brief Retrieves the active state of the automatic mode.
   * 
   * @return True if automatic mode is active, false otherwise.
   */
  public bool getAutomaticActive()
  {
    return _automaticActive;
  }

  /**
   * @brief Retrieves the active state of the off mode.
   * 
   * @return True if off mode is active, false otherwise.
   */
  public bool getOffActive()
  {
    return _offActive;
  }

  /**
   * @brief Sets the off operator mode.
   * 
   * @param offOperator True to set off operator mode, false otherwise.
   */
  public void setOffOperator(const bool &offOperator)
  {
    _offOperator = offOperator;
    dpSet(_dpeOffOperator, _offOperator);
  }

  /**
   * @brief Sets the operator operator mode.
   * 
   * @param operatorOperator True to set operator operator mode, false otherwise.
   */
  public void setOperatorOperator(const bool &operatorOperator)
  {
    _operatorOperator = operatorOperator;
    dpSet(_dpeOperatorOperator, _operatorOperator);
  }

  /**
   * @brief Sets the automatic operator mode.
   * 
   * @param automaticOperator True to set automatic operator mode, false otherwise.
   */
  public void setAutomaticOperator(const bool &automaticOperator)
  {
    _automaticOperator = automaticOperator;
    dpSet(_dpeAutomaticOperator, _automaticOperator);
  }

  /**
   * @brief Sets the state of the channel.
   * @details Triggers the channelChanged event.
   *
   * @param dpe The data point element.
   * @param channel The new channel state to set.
   */
  private void setChannelCB(const string &dpe, const bool &channel)
  {
    _channel = channel;
    channelChanged(getChannel());
  }

  /**
   * @brief Sets the state of the off automatic mode.
   * @details Triggers the offAutomaticChanged event.
   * 
   * @param dpe The data point element.
   * @param offAutomatic The new off automatic state to set.
   */
  private void setOffAutomaticCB(const string &dpe, const bool &offAutomatic)
  {
    _offAutomatic = offAutomatic;
    offAutomaticChanged(getOffAutomatic());
  }

  /**
   * @brief Sets the state of the operator automatic mode.
   * @details Triggers the operatorAutomaticChanged event.
   * 
   * @param dpe The data point element.
   * @param operatorAutomatic The new operator automatic state to set.
   */
  private void setOperatorAutomaticCB(const string &dpe, const bool &operatorAutomatic)
  {
    _operatorAutomatic = operatorAutomatic;
    operatorAutomaticChanged(getOperatorAutomatic());
  }

  /**
   * @brief Sets the state of the automatic automatic mode.
   * @details Triggers the automaticAutomaticChanged event.
   * 
   * @param dpe The data point element.
   * @param automaticAutomatic The new automatic automatic state to set.
   */
  private void setAutomaticAutomaticCB(const string &dpe, const bool &automaticAutomatic)
  {
    _automaticAutomatic = automaticAutomatic;
    automaticAutomaticChanged(getAutomaticAutomatic());
  }

  /**
   * @brief Sets the active state of the operator mode.
   * @details Triggers the operatorActiveChanged event.
   * 
   * @param dpe The data point element.
   * @param operatorActive The new operator active state to set.
   */
  private void setOperatorActiveCB(const string &dpe, const bool &operatorActive)
  {
    _operatorActive = operatorActive;
    operatorActiveChanged(getOperatorActive());
  }

  /**
   * @brief Sets the active state of the automatic mode.
   * @details Triggers the automaticActiveChanged event.
   * 
   * @param dpe The data point element.
   * @param automaticActive The new automatic active state to set.
   */
  private void setAutomaticActiveCB(const string &dpe, const bool &automaticActive)
  {
    _automaticActive = automaticActive;
    automaticActiveChanged(getAutomaticActive());
  }

  /**
   * @brief Sets the active state of the off mode.
   * @details Triggers the offActiveChanged event.
   * 
   * @param dpe The data point element.
   * @param offActive The new off active state to set.
   */
  private void setOffActiveCB(const string &dpe, const bool &offActive)
  {
    _offActive = offActive;
    offActiveChanged(getOffActive());
  }
};
