// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"
#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class AnaMon
 * @brief Represents the AnaMon class.
 */
class AnaMon : MtpViewModelBase
{
  private float _value; //!< The current value of the monitored value.
  private float _valueScaleMin; //!< The minimum value for the monitored value.
  private float _valueScaleMax; //!< The maximum value for the monitored value.
  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpUnit> _unit; //!< The unit of measurement for the monitored value.
  private shared_ptr<MtpValueLimitFloat> _alertHighLimit; //!< The alert high limit for the monitored value.
  private shared_ptr<MtpValueLimitFloat> _warningHighLimit; //!< The warning high limit for the monitored value.
  private shared_ptr<MtpValueLimitFloat> _toleranceHighLimit; //!< The tolerance high limit for the monitored value.
  private shared_ptr<MtpValueLimitFloat> _toleranceLowLimit; //!< The tolerance low limit for the monitored value.
  private shared_ptr<MtpValueLimitFloat> _warningLowLimit; //!< The warning low limit for the monitored value.
  private shared_ptr<MtpValueLimitFloat> _alertLowLimit; //!< The alert low limit for the monitored value.

  /**
   * @brief Constructor for the AnaMon object.
   *
   * @param dp The data point of the AnaMon.
   */
  public AnaMon(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".V"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".V"));
    }

    if (!dpExists(getDp() + ".VSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMin"));
    }

    if (!dpExists(getDp() + ".VSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMax"));
    }

    dpGet(getDp() + ".VSclMin", _valueScaleMin,
          getDp() + ".VSclMax", _valueScaleMax);

    dpConnect(this, setValueCB, getDp() + ".V");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _unit = new MtpUnit(getDp() + ".VUnit");
    _alertHighLimit = new MtpValueLimitFloat(getDp() + ".VAHLim", getDp() + ".VAHEn", getDp() + ".VAHAct");
    _warningHighLimit = new MtpValueLimitFloat(getDp() + ".VWHLim", getDp() + ".VWHEn", getDp() + ".VWHAct");
    _toleranceHighLimit = new MtpValueLimitFloat(getDp() + ".VTHLim", getDp() + ".VTHEn", getDp() + ".VTHAct");
    _toleranceLowLimit = new MtpValueLimitFloat(getDp() + ".VTLLim", getDp() + ".VTLEn", getDp() + ".VTLAct");
    _warningLowLimit = new MtpValueLimitFloat(getDp() + ".VWLLim", getDp() + ".VWLEn", getDp() + ".VWLAct");
    _alertLowLimit = new MtpValueLimitFloat(getDp() + ".VALLim", getDp() + ".VALEn", getDp() + ".VALAct");
  }

#event valueChanged(const float &value) //!< Event triggered when the value changes.

  /**
   * @brief Retrieves the current value.
   * 
   * @return The current value as a float.
   */
  public float getValue()
  {
    return _value;
  }

  /**
   * @brief Retrieves the minimum value.
   *
   * @return The minimum value as a float.
   */
  public float getValueScaleMin()
  {
    return _valueScaleMin;
  }

  /**
   * @brief Returns the maximum value.
   *
   * @return The maximum value as a float.
   */
  public float getValueScaleMax()
  {
    return _valueScaleMax;
  }

  /**
   * @brief Retrieves the quality code (WQC) associated with this object.
   * 
   * @return The shared pointer to the MtpQualityCode instance.
   */
  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the operating system level information.
   * 
   * @return The shared pointer to the MtpOsLevel instance.
   */
  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Retrieves a shared pointer to the associated MtpUnit.
   * 
   * @return The shared pointer to the MtpUnit instance.
   */
  public shared_ptr<MtpUnit> getUnit()
  {
    return _unit;
  }

  /**
   * @brief Retrieves the high alert limit value as a shared pointer.
   * 
   * @return The shared pointer to the high alert limit instance.
   */
  public shared_ptr<MtpValueLimitFloat> getAlertHighLimit()
  {
    return _alertHighLimit;
  }

  /**
   * @brief Retrieves the high warning limit for the monitored value.
   * 
   * @return The shared pointer to the high warning limit instance.
   */
  public shared_ptr<MtpValueLimitFloat> getWarningHighLimit()
  {
    return _warningHighLimit;
  }

  /**
   * @brief Retrieves the high tolerance limit for the monitored value.
   * 
   * @return The shared pointer to the high tolerance limit instance.
   */
  public shared_ptr<MtpValueLimitFloat> getToleranceHighLimit()
  {
    return _toleranceHighLimit;
  }

  /**
   * @brief Retrieves the low tolerance limit for the monitored value.
   * 
   * @return The shared pointer to the low tolerance limit instance.
   */
  public shared_ptr<MtpValueLimitFloat> getToleranceLowLimit()
  {
    return _toleranceLowLimit;
  }

  /**
   * @brief Retrieves the warning low limit for the monitored value.
   * 
   * @return The shared pointer to the warning low limit instance.
   */
  public shared_ptr<MtpValueLimitFloat> getWarningLowLimit()
  {
    return _warningLowLimit;
  }

  /**
   * @brief Retrieves the alert low limit for the monitored value.
   * 
   * @return The shared pointer to the alert low limit instance.
   */
  public shared_ptr<MtpValueLimitFloat> getAlertLowLimit()
  {
    return _alertLowLimit;
  }

  /**
   * @brief Sets the value of the monitored value.
   * @details Triggers the valueChanged event.
   * 
   * @param dpe The data point element.
   * @param value The new value to set.
   */
  private void setValueCB(const string &dpe, const float &value)
  {
    _value = value;
    valueChanged(_value);
  }
};
