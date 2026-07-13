// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_OperationElement/MTP_OperationElement"

/**
 * @class MTP_BinMan
 * @brief Represents the MTP_BinMan class.
 */
class MTP_BinMan : MTP_OperationElement
{
  private bool _valueOut; //!< The output value of the monitored variable.
  private string _valueStateFalseText; //!< The text representation for the false state.
  private string _valueStateTrueText; //!< The text representation for the true state.
  private bool _valueManual; //!< The manually set value for the monitored variable.
  private bool _valueReadback; //!< The readback value for the monitored variable.
  private bool _valueFeedback; //!< The feedback value for the monitored variable.

  /**
   * @brief Constructor for the MTP_BinMan object.
   *
   * @param dp The data point of the MTP_BinMan.
   */
  public MTP_BinMan(const string &dp) : MTP_OperationElement(dp)
  {

    if (!dpExists(getDp() + ".VOut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VOut"));
    }

    if (!dpExists(getDp() + ".VState0"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VState0"));
    }

    if (!dpExists(getDp() + ".VState1"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VState1"));
    }

    if (!dpExists(getDp() + ".VMan"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VMan"));
    }

    if (!dpExists(getDp() + ".VRbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VRbk"));
    }

    if (!dpExists(getDp() + ".VFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFbk"));
    }

    dpGet(getDp() + ".VState0", _valueStateFalseText,
          getDp() + ".VState1", _valueStateTrueText);

    dpConnect(this, setValueOutCB, getDp() + ".VOut");
    dpConnect(this, setValueManualCB, getDp() + ".VMan");
    dpConnect(this, setValueFeedbackCB, getDp() + ".VFbk");
  }

  #event valueFeedbackChanged(const bool &value) //!< Event triggered when the feedback value state changes.
  #event valueOutChanged(const bool &value) //!< Event triggered when the output value state changes (boolean).
  #event valueManualChanged(const bool &value) //!< Event triggered when the manual value state changes.

/**
   * @brief Retrieves the output value.
   *
   * @return The output value as a boolean.
   */
  public bool getValueOut()
  {
    return _valueOut;
  }

  /**
   * @brief Retrieves the text representation for the true state.
   *
   * @return The true state text as a string.
   */
  public string getValueStateTrueText()
  {
    return _valueStateTrueText;
  }

  /**
   * @brief Retrieves the text representation for the false state.
   *
   * @return The false state text as a string.
   */
  public string getValueStateFalseText()
  {
    return _valueStateFalseText;
  }

  /**
   * @brief Retrieves the manually set value.
   *
   * @return The manual value as a boolean.
   */
  public bool getValueManual()
  {
    return _valueManual;
  }

   /**
   * @brief Retrieves the readback value.
   *
   * @return The readback value as a boolean.
   */
  public bool getValueReadback()
  {
    return _valueReadback;
  }

  /**
   * @brief Retrieves the feedback value.
   *
   * @return The feedback value as a boolean.
   */
  public bool getValueFeedback()
  {
    return _valueFeedback;
  }

  /**
   * @brief Sets the manual value of the monitored variable.
   *
   * @param value The new manual value to set.
   */
  public void setValueManual(const bool &value)
  {
    _valueOut = value;
    dpSet(getDp() + ".VMan", value);
  }

    /**
   * @brief Sets the output value of the monitored variable.
   *
   * @param dpe The data point element.
   * @param value The new output value to set.
   */
  private void setValueOutCB(const string &dpe, const bool &value)
  {
    _valueOut = value;
    valueOutChanged(_valueOut);
  }

  /**
   * @brief Sets the feedback value of the monitored variable.
   *
   * @param dpe The data point element.
   * @param value The new feedback value to set.
   */
  private void setValueFeedbackCB(const string &dpe, const bool &value)
  {
    _valueFeedback = value;
    valueFeedbackChanged(_valueFeedback);
  }

    /**
   * @brief Sets the manual value of the monitored variable.
   *
   * @param dpe The data point element.
   * @param value The new manual value to set.
   */
  private void setValueManualCB(const string &dpe, const bool &value)
  {
    _valueManual = value;
    valueManualChanged(_valueManual);
  }
};
