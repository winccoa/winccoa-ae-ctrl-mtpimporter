#uses "std"

// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

/**
 * @class MtpMonitor
 * @brief Represents the monitiring state for the MTP library object.
 */
class MtpMonitor
{
  private bool _enabled; //!< Indicates if the monitoring is enabled.
  private bool _safePosition; //!< Indicates if the safe position is active.
  private bool _staticError; //!< Indicates if a static error is present.
  private bool _dynamicError; //!< Indicates if a dynamic error is present.
  private float _staticTime; //!< The monitoring time for uncontrolled changes.
  private float _dynamicTime; //!< The monitoring time for controlled changes.
  private string _dpeEnabled; //!< Data point element for the enabled state.

  /**
   * @brief Constructor for MtpMonitor.
   *
   * @param dpeEnabled The data point element for the enabled state.
   * @param dpeSafePosition The data point element for the safe position state.
   * @param dpeStaticError The data point element for the static error state.
   * @param dpeDynamicError The data point element for the dynamic error state.
   * @param dpeStaticTime The data point element for the static time value.
   * @param dpeDynamicTime The data point element for the dynamic time value.
   */
  public MtpMonitor(const string &dpeEnabled, const string &dpeSafePosition, const string &dpeStaticError, const string &dpeDynamicError, const string &dpeStaticTime, const string &dpeDynamicTime)
  {
    if(!dpExists(dpeEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeEnabled));
    }

    if(!dpExists(dpeSafePosition))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeSafePosition));
    }

    if(!dpExists(dpeStaticError))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeStaticError));
    }

    if(!dpExists(dpeDynamicError))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeDynamicError));
    }

    if(!dpExists(dpeStaticTime))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeStaticTime));
    }

    if(!dpExists(dpeDynamicTime))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeDynamicTime));
    }

    _dpeEnabled = dpeEnabled;

    dpGet(_dpeEnabled, _enabled);

    dpConnect(this, setStaticErrorCB, dpeStaticError);
    dpConnect(this, setDynamicErrorCB, dpeDynamicError);
    dpConnect(this, setSafePositionCB, dpeSafePosition);
    dpConnect(this, setStaticTimeCB, dpeStaticTime);
    dpConnect(this, setDynamicTimeCB, dpeDynamicTime);
  }

  #event staticErrorChanged(const bool &staticError) //!< Event triggered when static error state changes.
  #event dynamicErrorChanged(const bool &dynamicError) //!< Event triggered when dynamic error state changes.
  #event safePositionChanged(const bool &safePosition) //!< Event triggered when safe position state changes.
  #event staticTimeChanged(const float &staticTime) //!< Event triggered when static time value changes.
  #event dynamicTimeChanged(const float &dynamicTime) //!< Event triggered when dynamic time value changes.

  /**
   * @brief Retrieves the enabled state of the monitor.
   *
   * @return True if the monitor is enabled, false otherwise.
   */
  public bool getEnabled()
  {
    return _enabled;
  }

  /**
   * @brief Retrieves the safe position state of the monitor.
   *
   * @return True if the safe position is active, false otherwise.
   */
  public bool getSafePosition()
  {
    return _safePosition;
  }

  /**
   * @brief Retrieves the static error state of the monitor.
   *
   * @return True if a static error is present, false otherwise.
   */
  public bool getStaticError()
  {
    return _staticError;
  }

  /**
   * @brief Retrieves the dynamic error state of the monitor.
   *
   * @return True if a dynamic error is present, false otherwise.
   */
  public bool getDynamicError()
  {
    return _dynamicError;
  }

  /**
   * @brief Retrieves the static time value of the monitor.
   *
   * @return The static time value.
   */
  public float getStaticTime()
  {
    return _staticTime;
  }

  /**
   * @brief Retrieves the dynamic time value of the monitor.
   *
   * @return The dynamic time value.
   */
  public float getDynamicTime()
  {
    return _dynamicTime;
  }

  /**
   * @brief Sets the enabled state of the monitor.
   *
   * @param enabled True to enable the monitor, false to disable it.
   */
  public void setEnabled(const bool &enabled)
  {
    _enabled = enabled;
    dpSet(_dpeEnabled, getEnabled());
  }

  /**
   * @brief Sets the safe position state of the monitor.
   * @details Triggers the safePositionChanged event.
   *
   * @param dpe The data point element.
   * @param safePosition True to activate the safe position, false to deactivate it.
   */
  private void setStaticErrorCB(const string &dpe, const bool &staticError)
  {
    _staticError = staticError;
    staticErrorChanged(getStaticError());
  }

  /**
   * @brief Sets the dynamic error state of the monitor.
   * @details Triggers the dynamicErrorChanged event.
   *
   * @param dpe The data point element.
   * @param dynamicError True to activate the dynamic error, false to deactivate it.
   */
  private void setDynamicErrorCB(const string &dpe, const bool &dynamicError)
  {
    _dynamicError = dynamicError;
    dynamicErrorChanged(getDynamicError());
  }

  /**
   * @brief Sets the safe position state of the monitor.
   * @details Triggers the safePositionChanged event.
   *
   * @param dpe The data point element.
   * @param safePosition True to activate the safe position, false to deactivate it.
   */
  private void setSafePositionCB(const string &dpe, const bool &safePosition)
  {
    _safePosition = safePosition;
    safePositionChanged(getSafePosition());
  }

  /**
   * @brief Sets the static time value of the monitor.
   * @details Triggers the staticTimeChanged event.
   *
   * @param dpe The data point element.
   * @param staticTime The static time value.
   */
  private void setStaticTimeCB(const string &dpe, const float &staticTime)
  {
    _staticTime = staticTime;
    staticTimeChanged(getStaticTime());
  }

  /**
   * @brief Sets the dynamic time value of the monitor.
   * @details Triggers the dynamicTimeChanged event.
   *
   * @param dpe The data point element.
   * @param dynamicTime The dynamic time value.
   */
  private void setDynamicTimeCB(const string &dpe, const float &dynamicTime)
  {
    _dynamicTime = dynamicTime;
    dynamicTimeChanged(getDynamicTime());
  }
};
