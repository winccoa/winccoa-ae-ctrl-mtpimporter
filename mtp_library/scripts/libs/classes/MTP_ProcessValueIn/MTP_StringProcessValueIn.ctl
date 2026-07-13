// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_InputElement/MTP_InputElement"

/**
 * @class MTP_StringProcessValueIn
 * @brief Represents the MTP_StringProcessValueIn class.
 */
class MTP_StringProcessValueIn : MTP_InputElement
{
  private string _value; //!< Input of the current value.

  /**
   * @brief Constructor for the MTP_StringProcessValueIn object.
   *
   * @param dp The data point of the string process value input.
   */
  public MTP_StringProcessValueIn(const string &dp) : MTP_InputElement(dp)
  {
    if (!dpExists(getDp() + ".V"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".V"));
    }

    dpConnect(this, setValueCB, getDp() + ".V");
  }

  #event valueChanged(const string &value) //!< Event triggered when the current value changes.

  /**
   * @brief Retrieves the current input value.
   *
   * @return The current string value.
   */
  public string getValue()
  {
    return _value;
  }

  /**
   * @brief Writes a new process value.
   *
   * @param value The value to write.
   */
  public void setValue(const string &value)
  {
    dpSet(getDp() + ".V", value);
  }

  /**
   * @brief Sets the current value from the connected data point element.
   *
   * @param dpe The data point element.
   * @param value The new current value.
   */
  private void setValueCB(const string &dpe, const string &value)
  {
    _value = value;
    valueChanged(_value);
  }
};
