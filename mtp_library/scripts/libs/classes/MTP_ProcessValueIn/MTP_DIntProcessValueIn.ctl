// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Unit/MTP_Unit"
#uses "std"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_InputElement/MTP_InputElement"

/**
 * @class MTP_DIntProcessValueIn
 * @brief Represents the MTP_DIntProcessValueIn class.
 */
class MTP_DIntProcessValueIn : MTP_InputElement
{
  private shared_ptr<MTP_OsLevel> _osLevel; //!< The operational state level of the monitored value.
  private int _value; //!< Input of the current value.
  private int _scaleMinCur; //!< Current scale minimum information.
  private int _scaleMaxCur; //!< Current scale maximum information.
  private shared_ptr<MTP_Unit> _unitCur; //!< Current unit information.

  /**
   * @brief Constructor for the MTP_DIntProcessValueIn object.
   *
   * @param dp The data point of the DINT process value input.
   */
  public MTP_DIntProcessValueIn(const string &dp) : MTP_InputElement(dp)
  {
    if (!dpExists(getDp() + ".V"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".V"));
    }

    if (!dpExists(getDp() + ".SclMinCur"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SclMinCur"));
    }

    if (!dpExists(getDp() + ".SclMaxCur"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SclMaxCur"));
    }

    dpGet(getDp() + ".SclMinCur", _scaleMinCur,
          getDp() + ".SclMaxCur", _scaleMaxCur);

    dpConnect(this, setValueCB, getDp() + ".V");

    _osLevel = new MTP_OsLevel(getDp() + ".OSLevel");
    _unitCur = new MTP_Unit(getDp() + ".UnitCur");
  }

  #event valueChanged(const int &value) //!< Event triggered when the current value changes.

  /**
   * @brief Retrieves the operational state level of the monitored value.
   *
   * @return The operational state level as a shared pointer to MTP_OsLevel.
   */
  public shared_ptr<MTP_OsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Retrieves the current input value.
   *
   * @return The current DINT value.
   */
  public int getValue()
  {
    return _value;
  }

  /**
   * @brief Retrieves the current scale minimum.
   *
   * @return The current scale minimum.
   */
  public int getScaleMinCur()
  {
    return _scaleMinCur;
  }

  /**
   * @brief Retrieves the current scale maximum.
   *
   * @return The current scale maximum.
   */
  public int getScaleMaxCur()
  {
    return _scaleMaxCur;
  }

  /**
   * @brief Retrieves the current unit information.
   *
   * @return The current unit as a shared pointer to MTP_Unit.
   */
  public shared_ptr<MTP_Unit> getUnitCur()
  {
    return _unitCur;
  }

  /**
   * @brief Writes a new process value.
   *
   * @param value The value to write.
   */
  public void setValue(const int &value)
  {
    dpSet(getDp() + ".V", value);
  }

  /**
   * @brief Sets the current value from the connected data point element.
   *
   * @param dpe The data point element.
   * @param value The new current value.
   */
  private void setValueCB(const string &dpe, const int &value)
  {
    _value = value;
    valueChanged(_value);
  }
};
