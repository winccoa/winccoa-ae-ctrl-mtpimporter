// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinView/MTP_BinView"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_BinMon
 * @brief Represents the MTP_BinMon class.
 */
class MTP_BinMon : MTP_BinView
{
  private bool _flutterEnabled; //!< Indicates if fluttering is enabled for the monitored value.
  private float _flutterTime; //!< The time duration for fluttering in seconds.
  private int _flutterCount; //!< The count of flutter events that have occurred.
  private bool _flutterActive; //!< Indicates if fluttering is currently active.
  private shared_ptr<MTP_OsLevel> _osLevel; //!< The operational state level of the monitored binary value.

  /**
   * @brief Constructor for the MTP_BinMon object.
   *
   * @param dp The data point of the MTP_BinMon.
   */
  public MTP_BinMon(const string &dp) : MTP_BinView(dp)
  {
    if (!dpExists(getDp() + ".VFlutEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFlutEn"));
    }

    if (!dpExists(getDp() + ".VFlutTi"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFlutTi"));
    }

    if (!dpExists(getDp() + ".VFlutCnt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFlutCnt"));
    }

    if (!dpExists(getDp() + ".VFlutAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFlutAct"));
    }

    dpGet(getDp() + ".VFlutCnt", _flutterCount,
          getDp() + ".VFlutTi", _flutterTime,
          getDp() + ".VFlutEn", _flutterEnabled);

    dpConnect(this, setFlutterActiveCB, getDp() + ".VFlutAct");

    _osLevel = new MTP_OsLevel(getDp() + ".OSLevel");
  }

#event flutterActiveChanged(const bool &flutterActive) //!< Event triggered when the flutter active state changes.

  /**
   * @brief Retrieves the status of the Flutter feature.
   *
   * @return True if the Flutter feature is enabled, false otherwise.
   */
  public bool getFlutterEnabled()
  {
    return _flutterEnabled;
  }

  /**
   * @brief Retrieves the flutter time.
   *
   * @return The flutter time.
   */
  public float getFlutterTime()
  {
    return _flutterTime;
  }

  /**
   * @brief Retrieves the flutter count.
   *
   * @return The current flutter count.
   */
  public int getFlutterCount()
  {
    return _flutterCount;
  }

  /**
   * @brief Retrieves the status of the Flutter Active flag.
   *
   * @return True if Flutter is active, false otherwise.
   */
  public bool getFlutterActive()
  {
    return _flutterActive;
  }

  /**
   * @brief Retrieves the operating system level.
   *
   * @return The shared pointer to the MTP_OsLevel instance.
   */
  public shared_ptr<MTP_OsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Sets the flutter count for the BinMon instance.
   *
   * @param flutterCount The new flutter count value to be set.
   */
  public void setFlutterCount(const int &flutterCount)
  {
    _flutterCount = flutterCount;
    dpSet(getDp() + ".VFlutCnt", _flutterCount);
  }

  /**
   * @brief Sets the flutter time for the BinMon class.
   *
   * @param flutterTime A constant reference to a float representing the flutter time to be set.
   */
  public void setFlutterTime(const float &flutterTime)
  {
    _flutterTime = flutterTime;
    dpSet(getDp() + ".VFlutTi", _flutterTime);
  }

  /**
   * @brief Sets the flutter active state of the monitored value.
   *
   * @param dpe The data point element.
   * @param flutterActive A boolean indicating whether flutter is active (true) or inactive (false).
   */
  private void setFlutterActiveCB(const string &dpe, const bool &flutterActive)
  {
    _flutterActive = flutterActive;
    flutterActiveChanged(_flutterActive);
  }
};
