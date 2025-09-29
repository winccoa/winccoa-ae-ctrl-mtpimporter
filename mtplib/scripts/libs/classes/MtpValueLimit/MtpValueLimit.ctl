// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MtpValueLimit
 * @brief Represents a class for handling value limits in the MTP library.
 */
class MtpValueLimit
{
  private string _dpeLimit; //!< The data point element for the limit value.
  private anytype _value; //!< The current value of the limit.
  private bool _enabled; //!< Indicates if the limit is enabled.
  private bool _active; //!< Indicates if the limit is currently active.

  /**
   * @brief Constructor for MtpValueLimit.
   *
   * @param dpeLimit The data point element for the limit value.
   * @param dpeEnabled The data point element indicating if the limit is enabled.
   * @param dpeActive The data point element indicating if the limit is active.
   */
  protected MtpValueLimit(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive)
  {
    _dpeLimit = dpeLimit;

    if (!dpExists(_dpeLimit))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dpeLimit));
    }

    if (!dpExists(dpeEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeEnabled));
    }

    if (!dpExists(dpeActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeActive));
    }

    dpGet(dpeEnabled, _enabled);

    dpConnect(this, setActiveCB, dpeActive);
    dpConnect(this, setLimitCB, _dpeLimit);
  }

#event activeChanged(const bool &active) //!< Event triggered when the active state changes.

  /**
   * @brief Retrieves the active state of the limit.
   * 
   * @return True if the limit is active, false otherwise.
   */
  public bool getActive()
  {
    return _active;
  }

  /**
   * @brief Retrieves the enabled state of the limit.
   *
   * @return True if the limit is enabled, false otherwise.
   */
  public bool getEnabled()
  {
    return _enabled;
  }

  /**
   * @brief Sets the limit.
   *
   * @param value The value to set as the limit.
   */
  protected void setLimit(const anytype &value)
  {
    dpSet(_dpeLimit, value);
  }

  /**
   * @brief Retrieves the limit value.
   * 
   * @return anytype The limit value.
   */
  protected anytype getLimit()
  {
    return _value;
  }

  /**
   * @brief Sets the active state of the limit.
   * 
   * @param dpe The data point element.
   * @param active A boolean value indicating the active state.
   */
  private void setActiveCB(const string &dpe, const bool &active)
  {
    _active = active;
    activeChanged(getActive());
  }

  /**
   * @brief Sets the limit value.
   * 
   * @param dpe The data point element.
   * @param value The new value to set for the limit.
   */
  private void setLimitCB(const string &dpe, const anytype &value)
  {
    _value = value;
  }
};
