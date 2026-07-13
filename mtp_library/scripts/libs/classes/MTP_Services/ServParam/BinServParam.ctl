// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Services/ServParam/ServParamBase"

/**
 * @class BinServParam
 * @brief Represents the BinServParam class.
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
  * @brief Retrieves the operator value of the bool parameter.
  * @return The operator value as a bool.
  */
  public bool getValueOperator() override
  {
    return ServParamBase::getValueOperator();
  }

  /**
  * @brief Retrieves the output value of the bool parameter.
  * @return The output value as a bool.
  */
  public bool getValueOutput() override
  {
    return ServParamBase::getValueOutput();
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
   * @brief Sets the external value of the binary parameter.
   *
   * @param valueExternal The new external value.
   */
  public void setValueExternal(const bool &valueExternal) override
  {
    ServParamBase::setValueExternal(valueExternal);
  }

  /**
   * @brief Sets the internal value of the binary parameter.
   *
   * @param valueInternal The new internal value.
   */
  public void setValueInternal(const bool &valueInternal) override
  {
    ServParamBase::setValueInternal(valueInternal);
  }

  /**
   * @brief Sets the requested value of the binary parameter.
   *
   * @param valueRequested The new requested value.
   */
  public void setValueRequested(const bool &valueRequested) override
  {
    ServParamBase::setValueRequested(valueRequested);
  }

  /**
   * @brief Sets the feedback value of the binary parameter.
   *
   * @param valueFeedback The new feedback value.
   */
  public void setValueFeedback(const bool &valueFeedback) override
  {
    ServParamBase::setValueFeedback(valueFeedback);
  }

    /**
  * @brief Sets the operator value of the bool parameter.
  *
  * @param valueOperator The new feedback value.
  */
  public void setValueOperator(const bool &valueOperator) override
  {
    ServParamBase::setValueOperator(valueOperator);
  }
};
