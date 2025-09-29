// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class BinMon
 * @brief Represents a BinMon class.
 */
class BinMon : MtpViewModelBase
{
  private bool _value; //!< The current binary value of the monitored value.
  private string _valueStateFalseText; //!< Text representation for the false state of the binary value.
  private string _valueStateTrueText; //!< Text representation for the true state of the binary value.
  private bool _flutterEnabled; //!< Indicates if fluttering is enabled for the monitored value.
  private float _flutterTime; //!< The time duration for fluttering in seconds.
  private int _flutterCount; //!< The count of flutter events that have occurred.
  private bool _flutterActive; //!< Indicates if fluttering is currently active.
  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored binary value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored binary value.

  /**
   * @brief Constructor for the BinMon object.
   * 
   * @param dp The data point of the BinMon.
   */
  public BinMon(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".V"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".V"));
    }

    if (!dpExists(getDp() + ".VState0"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VState0"));
    }

    if (!dpExists(getDp() + ".VState1"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VState1"));
    }

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
          getDp() + ".VState0", _valueStateFalseText,
          getDp() + ".VState1", _valueStateTrueText,
          getDp() + ".VFlutEn", _flutterEnabled);

    dpConnect(this, setValueCB, getDp() + ".V");
    dpConnect(this, setFlutterActiveCB, getDp() + ".VFlutAct");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
  }

#event valueChanged(const bool &value) //!< Event triggered when the value changes.
#event flutterActiveChanged(const bool &flutterActive) //!< Event triggered when the flutter active state changes.

  /**
   * @brief Retrieves the current value.
   * 
   * @return The current value as a boolean.
   */
  public bool getValue()
  {
    return _value;
  }

  /**
   * @brief Retrieves the text representation for the "true" state of a value.
   * 
   * @return A string containing the text associated with the "true" state.
   */
  public string getValueStateTrueText()
  {
    return _valueStateTrueText;
  }

  /**
   * @brief Retrieves the text representation for the "false" state of a value.
   * 
   * @return A string containing the text associated with the "false" state.
   */
  public string getValueStateFalseText()
  {
    return _valueStateFalseText;
  }

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
   * @brief Retrieves the quality code (WQC).
   * 
   * @return The shared pointer to the MtpQualityCode instance.
   */
  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the operating system level.
   * 
   * @return The shared pointer to the MtpOsLevel instance.
   */
  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Sets the flutter count for the BinMon instance.
   * 
   * @param flutterCount The new flutter count value to be set. This is a constant
   *                     integer passed by reference.
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
   * @brief Sets the value of the monitored value.
   * 
   * @param dpe The data point element.
   * @param value The new value to set.
   */
  private void setValueCB(const string &dpe, const bool &value)
  {
    _value = value;
    valueChanged(_value);
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
