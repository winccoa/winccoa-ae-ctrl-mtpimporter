// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"
#uses "classes/MtpQualityCode/MtpQualityCode"

/**
 * @class MtpInput
 * @brief Represents the input for the MTP library interlock object
 */
class MtpInput
{
  private bool _enabled; //!< Indicates if the input is enabled.
  private bool _value; //!< Indicates the value of the input.
  private bool _inverted; //!< Indicates if the input is inverted.
  private string _text; //!< The text associated with the input.
  private shared_ptr<MtpQualityCode> _qualityCode; //!< The quality code associated with the input.

  /**
   * @brief Constructor for MtpInput.
   *
   * @param dpeEnabled The data point element for the enabled state.
   * @param dpeValue The data point element for the value state.
   * @param dpeInverted The data point element for the inverted state.
   * @param dpeText The data point element for the text.
   * @param dpeQualityCode The data point element for the quality code.
   */
  public MtpInput(const string &dpeEnabled, const string &dpeValue, const string &dpeInverted, const string &dpeText, const string &dpeQualityCode)
  {
    if (!dpExists(dpeEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeEnabled));
    }

    if (!dpExists(dpeValue))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeValue));
    }

    if (!dpExists(dpeInverted))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInverted));
    }

    if (!dpExists(dpeText))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeText));
    }

    _qualityCode = new MtpQualityCode(dpeQualityCode);

    dpGet(dpeText, _text);

    dpConnect(this, setEnabledCB, dpeEnabled);
    dpConnect(this, setValueCB, dpeValue);
    dpConnect(this, setInvertedCB, dpeInverted);
  }

#event enabledChanged(const bool &enabled) //!< Event triggered when the enabled state changes.
#event valueChanged(const bool &value) //!< Event triggered when the value changes.
#event invertedChanged(const bool &inverted) //!< Event triggered when the inverted state changes.

  /**
   * @brief Retrieves the enabled state of the input.
   *
   * @return True if the input is enabled, false otherwise.
   */
  public bool getEnabled()
  {
    return _enabled;
  }

  /**
   * @brief Retrieves the value of the input.
   *
   * @return The value of the input.
   */
  public bool getValue()
  {
    return _value;
  }

  /**
   * @brief Retrieves if the input is inverted.
   *
   * @return True if the input is inverted, false otherwise.
   */
  public bool getInverted()
  {
    return _inverted;
  }

  /**
   * @brief Retrieves the text associated with the input.
   *
   * @return The text of the input.
   */
  public string getText()
  {
    return _text;
  }

  /**
   * @brief Retrieves the quality code associated with the input.
   *
   * @return The quality code of the input.
   */
  public shared_ptr<MtpQualityCode> getQualityCode()
  {
    return _qualityCode;
  }

  /**
   * @brief Sets the enabled state of the input.
   * @details Triggers the enabledChanged event.
   *
   * @param dpe The data point element.
   * @param enabled True if enabled, false otherwise.
   */
  private void setEnabledCB(const string &dpe, const bool &enabled)
  {
    _enabled = enabled;
    enabledChanged(getEnabled());
  }

  /**
   * @brief Sets the value of the input.
   * @details Triggers the valueChanged event.
   *
   * @param dpe The data point element.
   * @param value The new value for the input.
   */
  private void setValueCB(const string &dpe, const bool &value)
  {
    _value = value;
    valueChanged(getValue());
  }

  /**
   * @brief Sets the inverted state of the input.
   * @details Triggers the invertedChanged event.
   *
   * @param dpe The data point element.
   * @param inverted True if inverted, false otherwise.
   */
  private void setInvertedCB(const string &dpe, const bool &inverted)
  {
    _inverted = inverted;
    invertedChanged(getInverted());
  }
};
