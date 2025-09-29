// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "std"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class AnaManInt
 * @brief Represents the AnaManInt class.
 */
class AnaManInt : MtpViewModelBase
{
  private float _valueOut; //!< The output value of the monitored analog drive.
  private float _valueScaleMin; //!< The minimum scale value for the monitored analog drive.
  private float _valueScaleMax; //!< The maximum scale value for the monitored analog drive.
  private float _valueManual; //!< The manually set value for the monitored analog drive.
  private float _valueInternal; //!< The internally set value for the monitored analog drive.
  private float _valueReadback; //!< The readback value from the monitored analog drive.
  private float _valueFeedback; //!< The feedback value from the monitored analog drive.
  private float _valueMin; //!< The minimum allowable value for the monitored analog drive.
  private float _valueMax; //!< The maximum allowable value for the monitored analog drive.
  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored analog drive.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored analog drive.
  private shared_ptr<MtpSource> _source; //!< The source of the monitored analog drive (e.g., manual or internal).
  private shared_ptr<MtpUnit> _valueUnit; //!< The unit of measurement for the monitored analog drive values.

  /**
   * @brief Constructor for the AnaManInt object.
   *
   * @param dp The data point of the AnaManInt.
   */
  public AnaManInt(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".VOut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VOut"));
    }

    if (!dpExists(getDp() + ".VSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMin"));
    }

    if (!dpExists(getDp() + ".VSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMax"));
    }

    if (!dpExists(getDp() + ".VMan"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VMan"));
    }

    if (!dpExists(getDp() + ".VInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VInt"));
    }

    if (!dpExists(getDp() + ".VRbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VRbk"));
    }

    if (!dpExists(getDp() + ".VFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFbk"));
    }

    if (!dpExists(getDp() + ".VMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VMin"));
    }

    if (!dpExists(getDp() + ".VMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VMax"));
    }

    dpGet(getDp() + ".VMan", _valueManual,
          getDp() + ".VRbk", _valueReadback);

    dpConnect(this, setValueOutCB, getDp() + ".VOut");
    dpConnect(this, setValueFeedbackCB, getDp() + ".VFbk");
    dpConnect(this, setValueMinCB, getDp() + ".VMin");
    dpConnect(this, setValueMaxCB, getDp() + ".VMax");
    dpConnect(this, setValueInternalCB, getDp() + ".VInt");
    dpConnect(this, setValueScaleMinCB, getDp() + ".VSclMin");
    dpConnect(this, setValueScaleMaxCB, getDp() + ".VSclMax");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _valueUnit = new MtpUnit(getDp() + ".VUnit");
    _source =  new MtpSource(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
  }

#event valueOutChanged(const float &value) //!< Event triggered when the output value changes.
#event valueFeedbackChanged(const float &valueFeedback) //!< Event triggered when the feedback value changes.
#event valueMinChanged(const float &min) //!< Event triggered when the minimum allowable value changes.
#event valueMaxChanged(const float &max) //!< Event triggered when the maximum allowable value changes.
#event valueInternalChanged(const float &valueInternal) //!< Event triggered when the internally set value changes.
#event valueScaleMinChanged(const float &valueScaleMin) //!< Event triggered when the minimum scale value changes.
#event valueScaleMaxChanged(const float &valueScaleMax) //!< Event triggered when the maximum scale value changes.

  /**
   * @brief Retrieves the output value.
   *
   * @return The output value as a float.
   */
  public float getValueOut()
  {
    return _valueOut;
  }

  /**
     * @brief Retrieves the minimum scale value.
     *
     * @return The minimum scale value as a float.
     */
  public float getValueScaleMin()
  {
    return _valueScaleMin;
  }

  /**
   * @brief Retrieves the maximum scale value.
   *
   * @return The maximum scale value as a float.
   */
  public float getValueScaleMax()
  {
    return _valueScaleMax;
  }

  /**
   * @brief Retrieves the manually set value.
   *
   * @return The manually set value as a float.
   */
  public float getValueManual()
  {
    return _valueManual;
  }

  /**
   * @brief Retrieves the internal value.
   *
   * @return The internal value as a float.
   */
  public float getValueInternal()
  {
    return _valueInternal;
  }

  /**
   * @brief Retrieves the readback value.
   *
   * @return The readback value as a float.
   */
  public float getValueReadback()
  {
    return _valueReadback;
  }

  /**
   * @brief Retrieves the feedback value.
   *
   * @return The feedback value as a float.
   */
  public float getValueFeedback()
  {
    return _valueFeedback;
  }

  /**
   * @brief Retrieves the minimum allowable value.
   *
   * @return The minimum allowable value as a float.
   */
  public float getValueMin()
  {
    return _valueMin;
  }

  /**
   * @brief Retrieves the maximum allowable value.
   *
   * @return The maximum allowable value as a float.
   */
  public float getValueMax()
  {
    return _valueMax;
  }

  /**
   * @brief Sets the manually set value.
   * @details Updates the manual value and writes it to the data point.
   *
   * @param valueManual The new manual value to set.
   */
  public void setValueManual(const float &valueManual)
  {
    _valueManual = valueManual;
    dpSet(getDp() + ".VMan", _valueManual);
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
   * @brief Retrieves the source information for the monitored variable.
   *
   * @return The shared pointer to the MtpSource instance.
   */
  public shared_ptr<MtpSource> getSource()
  {
    return _source;
  }

  /**
   * @brief Retrieves the unit of measurement for the monitored variable.
   *
   * @return The shared pointer to the MtpUnit instance.
   */
  public shared_ptr<MtpUnit> getValueUnit()
  {
    return _valueUnit;
  }

  /**
   * @brief Sets the output value of the monitored variable.
   * @details Triggers the valueOutChanged event.
   *
   * @param dpe The data point element.
   * @param value The new output value to set.
   */
  private void setValueOutCB(const string &dpe, const float &value)
  {
    _valueOut = value;
    valueOutChanged(_valueOut);
  }

  /**
   * @brief Sets the feedback value of the monitored variable.
   * @details Triggers the valueFeedbackChanged event.
   *
   * @param dpe The data point element.
   * @param valueFeedback The new feedback value to set.
   */
  private void setValueFeedbackCB(const string &dpe, const float &valueFeedback)
  {
    _valueFeedback = valueFeedback;
    valueFeedbackChanged(_valueFeedback);
  }

  /**
   * @brief Sets the minimum allowable value.
   * @details Triggers the valueMinChanged event.
   *
   * @param dpe The data point element.
   * @param min The new minimum value to set.
   */
  private void setValueMinCB(const string &dpe, const float &min)
  {
    _valueMin = min;
    valueMinChanged(_valueMin);
  }

  /**
   * @brief Sets the maximum allowable value.
   * @details Triggers the valueMaxChanged event.
   *
   * @param dpe The data point element.
   * @param max The new maximum value to set.
   */
  private void setValueMaxCB(const string &dpe, const float &max)
  {
    _valueMax = max;
    valueMaxChanged(_valueMax);
  }

  /**
   * @brief Sets the internal value of the monitored variable.
   * @details Triggers the valueInternalChanged event.
   *
   * @param dpe The data point element.
   * @param valueInternal The new internal value to set.
   */
  private void setValueInternalCB(const string &dpe, const float &valueInternal)
  {
    _valueInternal = valueInternal;
    valueInternalChanged(_valueInternal);
  }

  /**
   * @brief Sets the minimum scale value.
   * @details Triggers the valueScaleMinChanged event.
   *
   * @param dpe The data point element.
   * @param valueScaleMin The new minimum scale value to set.
   */
  private void setValueScaleMinCB(const string &dpe, const float &valueScaleMin)
  {
    _valueScaleMin = valueScaleMin;
    valueScaleMinChanged(_valueScaleMin);
  }

  /**
   * @brief Sets the maximum scale value.
   * @details Triggers the valueScaleMaxChanged event.
   *
   * @param dpe The data point element.
   * @param valueScaleMax The new maximum scale value to set.
   */
  private void setValueScaleMaxCB(const string &dpe, const float &valueScaleMax)
  {
    _valueScaleMax = valueScaleMax;
    valueScaleMaxChanged(_valueScaleMax);
  }
};
