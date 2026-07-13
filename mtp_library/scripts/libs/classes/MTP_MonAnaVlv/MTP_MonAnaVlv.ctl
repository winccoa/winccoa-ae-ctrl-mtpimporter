// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaVlv/MTP_AnaVlv"
#uses "std"
#uses "classes/MTP_Monitor/MTP_Monitor"

/**
 * @class MTP_MonAnaVlv
 * @brief Represents the MTP_MonAnaVlv class.
 */
class MTP_MonAnaVlv : MTP_AnaVlv
{
  private bool _positionReachedFeedback; //!< Indicates if the position reached feedback is active.
  private bool _monitorPositionError; //!< Indicates if the monitor position error is active.
  private float _positionTolerance; //!< The position tolerance.
  private float _monitorPositionTime; //!< The monitor position time.

  private shared_ptr<MTP_Monitor> _monitor; //!< The monitor instance.

  /**
   * @brief Constructor for the MTP_MonAnaVlv object.
   *
   * @param dp The data point of the MTP_MonAnaVlv.
   */
  public MTP_MonAnaVlv(const string &dp) : MTP_AnaVlv(dp)
  {
    if (!dpExists(getDp() + ".PosReachedFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosReachedFbk"));
    }

    if (!dpExists(getDp() + ".PosTolerance"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosTolerance"));
    }

    if (!dpExists(getDp() + ".MonPosTi"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".MonPosTi"));
    }

    if (!dpExists(getDp() + ".MonPosErr"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".MonPosErr"));
    }

    dpConnect(this, setPositionReachedFeedbackCB, getDp() + ".PosReachedFbk");
    dpConnect(this, setPositionToleranceCB, getDp() + ".PosTolerance");
    dpConnect(this, setMonitorPositionTimeCB, getDp() + ".MonPosTi");
    dpConnect(this, setMonitorPositionErrorCB, getDp() + ".MonPosErr");

    _monitor = new MTP_Monitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".MonStatErr", getDp() + ".MonDynErr", getDp() + ".MonStatTi", getDp() + ".MonDynTi");
  }

  #event positionReachedFeedbackChanged(const bool &positionReachedFeedback) //!< Event triggered when the position reached feedback changes.
  #event positionToleranceChanged(const float &positionTolerance) //!< Event triggered when the position tolerance changes.
  #event monitorPositionTimeChanged(const float &monitorPositionTime) //!< Event triggered when the monitor position time changes.
  #event monitorPositionErrorChanged(const bool &monitorPositionError) //!< Event triggered when the monitor position error changes.

  /**
   * @brief Retrieves the position reached feedback.
   *
   * @return The position reached feedback.
   */
  public bool getPositionReachedFeedback()
  {
    return _positionReachedFeedback;
  }

  /**
   * @brief Retrieves the position tolerance.
   *
   * @return The position tolerance.
   */
  public float getPositionTolerance()
  {
    return _positionTolerance;
  }

  /**
   * @brief Retrieves the monitor position time.
   *
   * @return The monitor position time.
   */
  public float getMonitorPositionTime()
  {
    return _monitorPositionTime;
  }

  /**
   * @brief Retrieves the monitor position error.
   *
   * @return The monitor position error.
   */
  public bool getMonitorPositionError()
  {
    return _monitorPositionError;
  }

  /**
   * @brief Retrieves the monitor.
   *
   * @return The monitor.
   */
  public shared_ptr<MTP_Monitor> getMonitor()
  {
    return _monitor;
  }

  /**
   * @brief Sets the position reached feedback from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionReachedFeedback The new position reached feedback value.
   */
  private void setPositionReachedFeedbackCB(const string &dpe, const bool &positionReachedFeedback)
  {
    _positionReachedFeedback = positionReachedFeedback;
    positionReachedFeedbackChanged(_positionReachedFeedback);
  }

  /**
   * @brief Sets the position tolerance from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionTolerance The new position tolerance value.
   */
  private void setPositionToleranceCB(const string &dpe, const float &positionTolerance)
  {
    _positionTolerance = positionTolerance;
    positionToleranceChanged(_positionTolerance);
  }

  /**
   * @brief Sets the monitor position time from the connected data point element.
   *
   * @param dpe The data point element.
   * @param monitorPositionTime The new monitor position time value.
   */
  private void setMonitorPositionTimeCB(const string &dpe, const float &monitorPositionTime)
  {
    _monitorPositionTime = monitorPositionTime;
    monitorPositionTimeChanged(_monitorPositionTime);
  }

  /**
   * @brief Sets the monitor position error from the connected data point element.
   *
   * @param dpe The data point element.
   * @param monitorPositionError The new monitor position error value.
   */
  private void setMonitorPositionErrorCB(const string &dpe, const bool &monitorPositionError)
  {
    _monitorPositionError = monitorPositionError;
    monitorPositionErrorChanged(_monitorPositionError);
  }
};
