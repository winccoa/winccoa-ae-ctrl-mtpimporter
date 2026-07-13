// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

/**
 * @class MTP_Procedure
 * @brief Represents the MTP_Procedure class.
 */
class MTP_Procedure
{
  private uint _operator; //!< The operator state of the MTP procedure.
  private uint _internal; //!< The internal state of the MTP procedure.
  private uint _external; //!< The external state of the MTP procedure.
  private uint _current; //!< The current state of the MTP procedure.
  private uint _requested; //!< The requested value of the MTP procedure.

  private string _dpeOperator; //!< Data point element for operator state.
  private string _dpeRequested; //!< Data point element for requested variable.
  private string _dpeCurrent; //!< Data point element for current variable.

  /**
   * @brief Constructor for MTP_Procedure.
   *
   * @param dpeOperator The data point element for the operator state.
   * @param dpeInternal The data point element for the internal state.
   * @param dpeExternal The data point element for the external state.
   * @param dpeCurrent The data point element for the current state.
   * @param dpeRequested The data point element for the requested value.
   */
  public MTP_Procedure(const string &dpeOperator, const string &dpeInternal, const string &dpeExternal, const string &dpeCurrent, const string &dpeRequested)
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
    _dpeRequested = dpeRequested;
    _dpeCurrent = dpeCurrent;

    dpGet(_dpeOperator, _operator);

    dpConnect(this, setExternalCB, dpeExternal);
    dpConnect(this, setCurrentCB, dpeCurrent);
    dpConnect(this, setInternalCB, dpeInternal);
    dpConnect(this, setRequestedCB, dpeRequested);
  }

#event externalChanged(const uint &external) //!< Event triggered when external state changes.
#event currentChanged(const uint &current) //!< Event triggered whencurrent state changes.
#event internalChanged(const uint &internal) //!< Event triggered when internal state changes.
#event requestedChanged(const uint &requested) //!< Event triggered when requested value changes.

  /**
  * @brief Sets the operator mode.
  *
  * @param operatorProcedure Sets Procedure using value of operator.
  */
  public void setOperator(const uint &operatorProcedure)
  {
    _operator = operatorProcedure;
    dpSet(_dpeOperator, _operator);
  }

  /**
  * @brief Sets the requested procedure.
  *
  * @param requestedProcedure Sets Procedure using value of requested.
  */
  public void setRequested(const uint &requestedProcedure)
  {
    _requested = requestedProcedure;
    dpSet(_dpeRequested, _requested);
  }

  /**
  * @brief Sets the current procedure.
  *
  * @param currentProcedure Sets Procedure using value of current.
  */
  public void setCurrent(const uint &currentProcedure)
  {
    _current = currentProcedure;
    dpSet(_dpeCurrent, _current);
  }

  /**
   * @brief Retrieves the external state.
   *
   * @return The current external state.
   */
  public uint getExternal()
  {
    return _external;
  }

  /**
   * @brief Retrieves the current state.
   *
   * @return The current state.
   */
  public uint getCurrent()
  {
    return _current;
  }

  /**
   * @brief Retrieves the internal state.
   *
   * @return The current internal state.
   */
  public uint getInternal()
  {
    return _internal;
  }

  /**
   * @brief Retrieves the requested value.
   *
   * @return The current requested value.
   */
  public uint getRequested()
  {
    return _requested;
  }

  /**
  * @brief Retrieves the operator value.
  *
  * @return The current operator value.
  */
  public uint getOperator()
  {
    return _operator;
  }

  /**
   * @brief Sets the external state.
   *
   * @param dpe The data point element.
   * @param external The new external state to set.
   */
  private void setExternalCB(const string &dpe, const uint &external)
  {
    _external = external;
    externalChanged(getExternal());
  }

  /**
   * @brief Sets the current state.
   *
   * @param dpe The data point element.
   * @param current The new current state to set.
   */
  private void setCurrentCB(const string &dpe, const uint &current)
  {
    _current = current;
    currentChanged(getCurrent());
  }

  /**
   * @brief Sets the internal state.
   *
   * @param dpe The data point element.
   * @param internal The new internal state to set.
   */
  private void setInternalCB(const string &dpe, const uint &internal)
  {
    _internal = internal;
    internalChanged(getInternal());
  }

  /**
   * @brief Sets the requested value.
   *
   * @param dpe The data point element.
   * @param requested The new requested value to set.
   */
  private void setRequestedCB(const string &dpe, const uint &requested)
  {
    _requested = requested;
    requestedChanged(getRequested());
  }
};
