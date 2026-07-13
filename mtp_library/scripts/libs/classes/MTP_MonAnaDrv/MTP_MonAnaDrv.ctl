// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaDrv/MTP_AnaDrv"
#uses "std"
#uses "classes/MTP_Monitor/MTP_Monitor"

/**
 * @class MTP_MonAnaDrv
 * @brief Represents the MTP_MonAnaDrv class.
 */
class MTP_MonAnaDrv : MTP_AnaDrv
{
  private bool _rpmAlarmHighEnabled; //!< Indicates if the high RPM alarm is enabled.
  private bool _rpmAlarmLowEnabled; //!< Indicates if the low RPM alarm is enabled.
  private bool _rpmAlarmHighActive; //!< Indicates if the high RPM alarm is active.
  private bool _rpmAlarmLowActive; //!< Indicates if the low RPM alarm is active.
  private float _rpmAlarmHighLimit; //!< The high RPM alarm limit value.
  private float _rpmAlarmLowLimit; //!< The low RPM alarm limit value.

  private shared_ptr<MTP_Monitor> _monitor; //!< The monitor associated with the monitored value.

  /**
   * @brief Constructor for the MTP_MonAnaDrv object.
   *
   * @param dp The data point of the MTP_MonAnaDrv.
   */
  public MTP_MonAnaDrv(const string &dp) : MTP_AnaDrv(dp)
  {
    if (!dpExists(getDp() + ".RpmAHAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmAHAct"));
    }

    if (!dpExists(getDp() + ".RpmALAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmALAct"));
    }

    if (!dpExists(getDp() + ".RpmAHEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmAHEn"));
    }

    if (!dpExists(getDp() + ".RpmALEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmALEn"));
    }

    if (!dpExists(getDp() + ".RpmAHLim"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmAHLim"));
    }

    if (!dpExists(getDp() + ".RpmALLim"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmALLim"));
    }

    dpGet(getDp() + ".RpmAHEn", _rpmAlarmHighEnabled,
          getDp() + ".RpmALEn", _rpmAlarmLowEnabled,
          getDp() + ".RpmAHLim", _rpmAlarmHighLimit,
          getDp() + ".RpmALLim", _rpmAlarmLowLimit);

    dpConnect(this, setRpmAlarmHighActiveCB, getDp() + ".RpmAHAct");
    dpConnect(this, setRpmAlarmLowActiveCB, getDp() + ".RpmALAct");

    _monitor = new MTP_Monitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".MonStatErr", getDp() + ".MonDynErr", getDp() + ".MonStatTi", getDp() + ".MonDynTi");
  }

  #event rpmAlarmHighActiveChanged(const bool &enabled) //!< Event triggered when the RPM high alarm activation state changes.
  #event rpmAlarmLowActiveChanged(const bool &enabled) //!< Event triggered when the RPM low alarm activation state changes.

  /**
   * @brief Retrieves the high RPM alarm enabled state.
   *
   * @return The high RPM alarm enabled state as a boolean.
   */
  public bool getRpmAlarmHighEnabled()
  {
    return _rpmAlarmHighEnabled;
  }

  /**
   * @brief Retrieves the low RPM alarm enabled state.
   *
   * @return The low RPM alarm enabled state as a boolean.
   */
  public bool getRpmAlarmLowEnabled()
  {
    return _rpmAlarmLowEnabled;
  }

  /**
   * @brief Retrieves the high RPM alarm active state.
   *
   * @return The high RPM alarm active state as a boolean.
   */
  public bool getRpmAlarmHighActive()
  {
    return _rpmAlarmHighActive;
  }

  /**
   * @brief Retrieves the low RPM alarm active state.
   *
   * @return The low RPM alarm active state as a boolean.
   */
  public bool getRpmAlarmLowActive()
  {
    return _rpmAlarmLowActive;
  }

  /**
   * @brief Retrieves the high RPM alarm limit value.
   *
   * @return The high RPM alarm limit value as a float.
   */
  public float getRpmAlarmHighLimit()
  {
    return _rpmAlarmHighLimit;
  }

  /**
   * @brief Retrieves the low RPM alarm limit value.
   *
   * @return The low RPM alarm limit value as a float.
   */
  public float getRpmAlarmLowLimit()
  {
    return _rpmAlarmLowLimit;
  }

  /**
   * @brief Retrieves the monitor information for the monitored value.
   *
   * @return The shared pointer to the MTP_Monitor instance.
   */
  public shared_ptr<MTP_Monitor> getMonitor()
  {
    return _monitor;
  }

  /**
   * @brief Sets the high RPM alarm limit.
   *
   * @param rpmAlarmHighLimit The new high RPM alarm limit value.
   */
  public void setRpmAlarmHighLimit(const float &rpmAlarmHighLimit)
  {
    _rpmAlarmHighLimit = rpmAlarmHighLimit;
    dpSet(getDp() + ".RpmAHLim", _rpmAlarmHighLimit);
  }

  /**
   * @brief Sets the low RPM alarm limit.
   *
   * @param rpmAlarmLowLimit The new low RPM alarm limit value.
   */
  public void setRpmAlarmLowLimit(const float &rpmAlarmLowLimit)
  {
    _rpmAlarmLowLimit = rpmAlarmLowLimit;
    dpSet(getDp() + ".RpmALLim", _rpmAlarmLowLimit);
  }

  /**
   * @brief Callback function to set the high RPM alarm active state.
   *
   * @param dpe The data point element.
   * @param enabled The new high RPM alarm active state.
   */
  private void setRpmAlarmHighActiveCB(const string &dpe, const bool &enabled)
  {
    _rpmAlarmHighActive = enabled;
    rpmAlarmHighActiveChanged(_rpmAlarmHighActive);
  }

  /**
   * @brief Callback function to set the low RPM alarm active state.
   *
   * @param dpe The data point element.
   * @param enabled The new low RPM alarm active state.
   */
  private void setRpmAlarmLowActiveCB(const string &dpe, const bool &enabled)
  {
    _rpmAlarmLowActive = enabled;
    rpmAlarmLowActiveChanged(_rpmAlarmLowActive);
  }
};
