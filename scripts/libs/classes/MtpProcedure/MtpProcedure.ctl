// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

/**
 * @class MtpProcedure
 * @brief Manages the procedure states for the MTP library object.
 */
class MtpProcedure
{
  private long _operator; //!< The operator state of the MTP procedure.
  private long _internal; //!< The internal state of the MTP procedure.
  private long _external; //!< The external state of the MTP procedure.
  private long _current; //!< The current state of the MTP procedure.
  private long _requested; //!< The requested value of the MTP procedure.

  private string _dpeOperator; //!< Data point element for operator state.

  /**
   * @brief Constructor for MtpProcedure.
   *
   * @param dpeOperator The data point element for the operator state.
   * @param dpeInternal The data point element for the internal state.
   * @param dpeExternal The data point element for the external state.
   * @param dpeCurrent The data point element for the current state.
   * @param dpeRequested The data point element for the requested value.
   */
  public MtpProcedure(const string &dpeOperator, const string &dpeInternal, const string &dpeExternal, const string &dpeCurrent, const string &dpeRequested)
  {
    if (!dpExists(dpeOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOperator));
    }

    if (!dpExists(dpeInternal))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInternal));
    }

    if (!dpExists(dpeExternal))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeExternal));
    }

    if (!dpExists(dpeCurrent))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeCurrent));
    }

    if (!dpExists(dpeRequested))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeRequested));
    }

    _dpeOperator = dpeOperator;

    dpGet(_dpeOperator, _operator);

    dpConnect(this, setExternalCB, dpeExternal);
    dpConnect(this, setCurrentCB, dpeCurrent);
    dpConnect(this, setInternalCB, dpeInternal);
    dpConnect(this, setRequestedCB, dpeRequested);
  }

#event externalChanged(const long &external) //!< Event triggered when external state changes.
#event currentChanged(const long &current) //!< Event triggered whencurrent state changes.
#event internalChanged(const long &internal) //!< Event triggered when internal state changes.
#event requestedChanged(const long &requested) //!< Event triggered when requested value changes.

  /**
  * @brief Sets the operator mode.
  *
  * @param operatorMode Sets Procedure using value of operator.
  */
  public void setOperator(const long &operatorProcedure)
  {
    _operator = operatorProcedure;
    dpSet(_dpeOperator, _operator);
  }

  /**
   * @brief Retrieves the external state.
   *
   * @return The current external state.
   */
  public long getExternal()
  {
    return _external;
  }

  /**
   * @brief Retrieves the current state.
   *
   * @return The current state.
   */
  public long getCurrent()
  {
    return _current;
  }

  /**
   * @brief Retrieves the internal state.
   *
   * @return The current internal state.
   */
  public long getInternal()
  {
    return _internal;
  }

  /**
   * @brief Retrieves the requested value.
   *
   * @return The current requested value.
   */
  public long getRequested()
  {
    return _requested;
  }

  /**
  * @brief Retrieves the operator value.
  *
  * @return The current operator value.
  */
  public long getOperator()
  {
    return _operator;
  }

  /**
   * @brief Sets the external state.
   * @details Triggers the externalChanged event.
   *
   * @param dpe The data point element.
   * @param external The new external state to set.
   */
  private void setExternalCB(const string &dpe, const long &external)
  {
    _external = external;
    externalChanged(getExternal());
  }

  /**
   * @brief Sets the current state.
   * @details Triggers the currentChanged event.
   *
   * @param dpe The data point element.
   * @param current The new current state to set.
   */
  private void setCurrentCB(const string &dpe, const long &current)
  {
    _current = current;
    currentChanged(getCurrent());
  }

  /**
   * @brief Sets the internal state.
   * @details Triggers the internalChanged event.
   *
   * @param dpe The data point element.
   * @param internal The new internal state to set.
   */
  private void setInternalCB(const string &dpe, const long &internal)
  {
    _internal = internal;
    internalChanged(getInternal());
  }

  /**
   * @brief Sets the requested value.
   * @details Triggers the requestedChanged event.
   *
   * @param dpe The data point element.
   * @param requested The new requested value to set.
   */
  private void setRequestedCB(const string &dpe, const long &requested)
  {
    _requested = requested;
    requestedChanged(getRequested());
  }
};
