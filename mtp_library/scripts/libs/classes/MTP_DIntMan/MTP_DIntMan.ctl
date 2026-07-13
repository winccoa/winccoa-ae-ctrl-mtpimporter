// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_OperationElement/MTP_OperationElement"

/**
 * @class MTP_DIntMan
 * @brief Represents the MTP_DIntMan class.
 */
class MTP_DIntMan : MTP_OperationElement
{
  private int _valueOut; //!< The value out.
  private int _valueScaleMin; //!< The minimum scale value.
  private int _valueScaleMax; //!< The maximum scale value.
  private int _valueManual; //!< The value manual.
  private int _valueReadback; //!< The value readback.
  private int _valueFeedback; //!< The value feedback.
  private int _valueMin; //!< The value min.
  private int _valueMax; //!< The value max.
  private shared_ptr<MTP_Unit> _valueUnit; //!< The value unit instance.

  /**
   * @brief Constructor for the MTP_DIntMan object.
   *
   * @param dp The data point of the MTP_DIntMan.
   */
  public MTP_DIntMan(const string &dp) : MTP_OperationElement(dp)
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

  #event valueOutChanged(const int &value) //!< Event triggered when the value out changes.
  #event valueFeedbackChanged(const int &valueFeedback) //!< Event triggered when the value feedback changes.
  #event valueMinChanged(const int &min) //!< Event triggered when the value min changes.
  #event valueMaxChanged(const int &max) //!< Event triggered when the value max changes.
  #event valueScaleMinChanged(const int &valueScaleMin) //!< Event triggered when the value scale min changes.
  #event valueScaleMaxChanged(const int &valueScaleMax) //!< Event triggered when the value scale max changes.

  /**
   * @brief Retrieves the value out.
   *
   * @return The value out.
   */
  public int getValueOut()
  {
    return _valueOut;
  }

  /**
   * @brief Retrieves the value scale min.
   *
   * @return The minimum scale value.
   */
  public int getValueScaleMin()
  {
    return _valueScaleMin;
  }

  /**
   * @brief Retrieves the value scale max.
   *
   * @return The maximum scale value.
   */
  public int getValueScaleMax()
  {
    return _valueScaleMax;
  }

  /**
   * @brief Retrieves the value manual.
   *
   * @return The value manual.
   */
  public int getValueManual()
  {
    return _valueManual;
  }

  /**
   * @brief Retrieves the value readback.
   *
   * @return The value readback.
   */
  public int getValueReadback()
  {
    return _valueReadback;
  }

  /**
   * @brief Retrieves the value feedback.
   *
   * @return The value feedback.
   */
  public int getValueFeedback()
  {
    return _valueFeedback;
  }

  /**
   * @brief Retrieves the value min.
   *
   * @return The value min.
   */
  public int getValueMin()
  {
    return _valueMin;
  }

  /**
   * @brief Retrieves the value max.
   *
   * @return The value max.
   */
  public int getValueMax()
  {
    return _valueMax;
  }

  /**
   * @brief Sets the value manual.
   *
   * @param valueManual The new value manual value.
   */
  public void setValueManual(const int &valueManual)
  {
    _valueManual = valueManual;
    dpSet(getDp() + ".VMan", _valueManual);
  }

  /**
   * @brief Retrieves the value unit.
   *
   * @return The value unit.
   */
  public shared_ptr<MTP_Unit> getValueUnit()
  {
    return _valueUnit;
  }

  /**
   * @brief Sets the value out from the connected data point element.
   *
   * @param dpe The data point element.
   * @param value The new value.
   */
  private void setValueOutCB(const string &dpe, const int &value)
  {
    _valueOut = value;
    valueOutChanged(_valueOut);
  }

  /**
   * @brief Sets the value feedback from the connected data point element.
   *
   * @param dpe The data point element.
   * @param valueFeedback The new value feedback value.
   */
  private void setValueFeedbackCB(const string &dpe, const int &valueFeedback)
  {
    _valueFeedback = valueFeedback;
    valueFeedbackChanged(_valueFeedback);
  }

  /**
   * @brief Sets the value min from the connected data point element.
   *
   * @param dpe The data point element.
   * @param min The new minimum value.
   */
  private void setValueMinCB(const string &dpe, const int &min)
  {
    _valueMin = min;
    valueMinChanged(_valueMin);
  }

  /**
   * @brief Sets the value max from the connected data point element.
   *
   * @param dpe The data point element.
   * @param max The new maximum value.
   */
  private void setValueMaxCB(const string &dpe, const int &max)
  {
    _valueMax = max;
    valueMaxChanged(_valueMax);
  }

  /**
   * @brief Sets the value scale min from the connected data point element.
   *
   * @param dpe The data point element.
   * @param valueScaleMin The new minimum scale value.
   */
  private void setValueScaleMinCB(const string &dpe, const int &valueScaleMin)
  {
    _valueScaleMin = valueScaleMin;
    valueScaleMinChanged(_valueScaleMin);
  }

  /**
   * @brief Sets the value scale max from the connected data point element.
   *
   * @param dpe The data point element.
   * @param valueScaleMax The new maximum scale value.
   */
  private void setValueScaleMaxCB(const string &dpe, const int &valueScaleMax)
  {
    _valueScaleMax = valueScaleMax;
    valueScaleMaxChanged(_valueScaleMax);
  }
};
