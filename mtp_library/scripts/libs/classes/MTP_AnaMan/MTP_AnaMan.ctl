// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_OperationElement/MTP_OperationElement"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_AnaMan
 * @brief Represents the MTP_AnaMan class.
 */
class MTP_AnaMan : MTP_OperationElement
{
  private float _valueOut; //!< The value out.
  private float _valueScaleMin; //!< The minimum scale value.
  private float _valueScaleMax; //!< The maximum scale value.
  private float _valueManual; //!< The value manual.
  private float _valueReadback; //!< The value readback.
  private float _valueFeedback; //!< The value feedback.
  private float _valueMin; //!< The value min.
  private float _valueMax; //!< The value max.
  private shared_ptr<MTP_Unit> _valueUnit; //!< The value unit instance.

 /**
   * @brief Constructor for the MTP_AnaMan object.
   *
   * @param dp The data point of the MTP_AnaMan.
   */
  public MTP_AnaMan(const string &dp) : MTP_OperationElement(dp)
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

    if (!dpExists(getDp() + ".VUnit"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VUnit"));
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
    dpConnect(this, setValueScaleMinCB, getDp() + ".VSclMin");
    dpConnect(this, setValueScaleMaxCB, getDp() + ".VSclMax");

    _valueUnit = new MTP_Unit(getDp() + ".VUnit");
  }

#event valueOutChanged(const float &value) //!< Event triggered when the output value changes.
#event valueFeedbackChanged(const float &valueFeedback) //!< Event triggered when the feedback value changes.
#event valueMinChanged(const float &min) //!< Event triggered when the minimum allowable value changes.
#event valueMaxChanged(const float &max) //!< Event triggered when the maximum allowable value changes.
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
   *
   * @param valueManual The new manual value to set.
   */
  public void setValueManual(const float &valueManual)
  {
    _valueManual = valueManual;
    dpSet(getDp() + ".VMan", _valueManual);
  }

  /**
   * @brief Retrieves the unit of measurement for the monitored variable.
   *
   * @return The shared pointer to the MTP_Unit instance.
   */
  public shared_ptr<MTP_Unit> getValueUnit()
  {
    return _valueUnit;
  }

  /**
   * @brief Sets the output value of the monitored variable.
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
   * @brief Sets the minimum scale value.
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
