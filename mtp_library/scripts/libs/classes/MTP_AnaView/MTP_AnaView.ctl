// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"
#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_IndicatorElement/MTP_IndicatorElement"

/**
 * @class MTP_AnaView
 * @brief Represents the MTP_AnaView class.
 */
class MTP_AnaView : MTP_IndicatorElement
{
  private float _value; //!< The value.
  private float _valueScaleMin; //!< The minimum scale value.
  private float _valueScaleMax; //!< The maximum scale value.
  private shared_ptr<MTP_Unit> _unit; //!< The unit instance.

  /**
   * @brief Constructor for the MTP_AnaView object.
   *
   * @param dp The data point of the MTP_AnaView.
   */
  public MTP_AnaView(const string &dp) : MTP_IndicatorElement(dp)
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

    _unit = new MTP_Unit(getDp() + ".VUnit");;
  }

  #event valueChanged(const float &value) //!< Event triggered when the value changes.

  /**
   * @brief Retrieves the value.
   *
   * @return The value.
   */
  public float getValue()
  {
    return _value;
  }

  /**
   * @brief Retrieves the value scale min.
   *
   * @return The minimum scale value.
   */
  public float getValueScaleMin()
  {
    return _valueScaleMin;
  }

  /**
   * @brief Retrieves the value scale max.
   *
   * @return The maximum scale value.
   */
  public float getValueScaleMax()
  {
    return _valueScaleMax;
  }

  /**
   * @brief Retrieves the unit.
   *
   * @return The unit.
   */
  public shared_ptr<MTP_Unit> getUnit()
  {
    return _unit;
  }

  /**
   * @brief Sets the value from the connected data point element.
   *
   * @param dpe The data point element.
   * @param value The new value.
   */
  private void setValueCB(const string &dpe, const float &value)
  {
    _value = value;
    valueChanged(_value);
  }
};
