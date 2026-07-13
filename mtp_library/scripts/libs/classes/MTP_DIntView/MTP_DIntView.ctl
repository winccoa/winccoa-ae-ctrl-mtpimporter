// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_IndicatorElement/MTP_IndicatorElement"

/**
 * @class MTP_DIntView
 * @brief Represents the MTP_DIntView class.
 */
class MTP_DIntView : MTP_IndicatorElement
{
  private int _value; //!< The value.
  private int _valueScaleMin; //!< The minimum scale value.
  private int _valueScaleMax; //!< The maximum scale value.
  private shared_ptr<MTP_Unit> _unit; //!< The unit instance.

 /**
  * @brief Constructor for the MTP_DIntView object.
  *
  * @param dp The data point of the MTP_DIntView.
  */
 public MTP_DIntView(const string &dp) : MTP_IndicatorElement(dp)
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

  #event valueChanged(const int &value) //!< Event triggered when the value changes.

  /**
   * @brief Retrieves the value.
   *
   * @return The value.
   */
  public int getValue()
  {
    return _value;
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
  private void setValueCB(const string &dpe, const int &value)
  {
    _value = value;
    valueChanged(_value);
  }
};
