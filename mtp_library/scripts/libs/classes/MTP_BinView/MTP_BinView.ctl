// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_IndicatorElement/MTP_IndicatorElement"

/**
 * @class MTP_BinView
 * @brief Represents the MTP_BinView class.
 */
class MTP_BinView : MTP_IndicatorElement
{
  private bool _value; //!< The current binary value of the monitored value.
  private string _valueStateFalseText; //!< Text representation for the false state of the binary value.
  private string _valueStateTrueText; //!< Text representation for the true state of the binary value.

  /**
   * @brief Constructor for the MTP_BinView object.
   *
   * @param dp The data point of the MTP_BinView.
   */
  public MTP_BinView(const string &dp) : MTP_IndicatorElement(dp)
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

    dpGet(getDp() + ".VState0", _valueStateFalseText,
          getDp() + ".VState1", _valueStateTrueText);

    dpConnect(this, setValueCB, getDp() + ".V");
  }

  #event valueChanged(const bool &value) //!< Event triggered when the value changes.

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
};
