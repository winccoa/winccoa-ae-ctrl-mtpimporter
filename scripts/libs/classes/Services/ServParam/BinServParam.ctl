// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/Services/ServParam/ServParamBase"

/**
 * @class BinServParam
 * @brief Represents the BinServParam class for managing binary service parameters.
 */
class BinServParam : ServParamBase
{
  private string _valueStateFalseText; //!< The text representation for the false state of the binary parameter.
  private string _valueStateTrueText; //!< The text representation for the true state of the binary parameter.

  /**
    * @brief Constructor for the BinServParam object.
    *
    * @param dp The data point of the BinServParam.
    */
  public BinServParam(const string &dp) : ServParamBase(dp)
  {
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
  }

  /**
   * @brief Retrieves the external value of the binary parameter.
   * @return The external value as a boolean.
   */
  public bool getValueExternal() override
  {
    return ServParamBase::getValueExternal();
  }

  /**
   * @brief Retrieves the internal value of the binary parameter.
   * @return The internal value as a boolean.
   */
  public bool getValueInternal() override
  {
    return ServParamBase::getValueInternal();
  }

  /**
   * @brief Retrieves the requested value of the binary parameter.
   * @return The requested value as a boolean.
   */
  public bool getValueRequested() override
  {
    return ServParamBase::getValueRequested();
  }

  /**
   * @brief Retrieves the feedback value of the binary parameter.
   * @return The feedback value as a boolean.
   */
  public bool getValueFeedback() override
  {
    return ServParamBase::getValueFeedback();
  }

  /**
   * @brief Retrieves the text representation for the false state of the binary parameter.
   * @return The false state text as a string.
   */
  public string getValueStateFalseText()
  {
    return _valueStateFalseText;
  }

  /**
   * @brief Retrieves the text representation for the true state of the binary parameter.
   * @return The true state text as a string.
   */
  public string getValueStateTrueText()
  {
    return _valueStateTrueText;
  }

  /**
   * @brief Sets the text representation for the false state of the binary parameter.
   * @details Updates the false state text and writes it to the data point.
   *
   * @param valueStateFalseText The new false state text.
   */
  public void setValueStateFalseText(const string &valueStateFalseText)
  {
    _valueStateFalseText = valueStateFalseText;
    dpSet(getDp() + ".VState0", _valueStateFalseText);
  }

  /**
   * @brief Sets the text representation for the true state of the binary parameter.
   * @details Updates the true state text and writes it to the data point.
   *
   * @param valueStateTrueText The new true state text.
   */
  public void setValueStateTrueText(const string &valueStateTrueText)
  {
    _valueStateTrueText = valueStateTrueText;
    dpSet(getDp() + ".VState1", _valueStateTrueText);
  }

  /**
   * @brief Sets the external value of the binary parameter.
   * @details Updates the external value by calling the base class method.
   *
   * @param valueExternal The new external value.
   */
  public void setValueExternal(const bool &valueExternal) override
  {
    ServParamBase::setValueExternal(valueExternal);
  }

  /**
   * @brief Sets the internal value of the binary parameter.
   * @details Updates the internal value by calling the base class method.
   *
   * @param valueInternal The new internal value.
   */
  public void setValueInternal(const bool &valueInternal) override
  {
    ServParamBase::setValueInternal(valueInternal);
  }

  /**
   * @brief Sets the requested value of the binary parameter.
   * @details Updates the requested value by calling the base class method.
   *
   * @param valueRequested The new requested value.
   */
  public void setValueRequested(const bool &valueRequested) override
  {
    ServParamBase::setValueRequested(valueRequested);
  }

  /**
   * @brief Sets the feedback value of the binary parameter.
   * @details Updates the feedback value by calling the base class method.
   *
   * @param valueFeedback The new feedback value.
   */
  public void setValueFeedback(const bool &valueFeedback) override
  {
    ServParamBase::setValueFeedback(valueFeedback);
  }
};
