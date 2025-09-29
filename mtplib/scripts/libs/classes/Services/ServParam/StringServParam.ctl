// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/Services/ServParam/ServParamBase"

/**
 * @class StringServParam
 * @brief Represents the StringServParam class for managing string service parameters.
 */
class StringServParam : ServParamBase
{

  /**
    * @brief Constructor for the StringServParam object.
    *
    * @param dp The data point of the StringServParam.
    */
  public StringServParam(const string &dp) : ServParamBase(dp)
  {
  }

  /**
   * @brief Retrieves the external value of the string parameter.
   * @return The external value as a string.
   */
  public string getValueExternal() override
  {
    return ServParamBase::getValueExternal();
  }

  /**
   * @brief Retrieves the internal value of the string parameter.
   * @return The internal value as a string.
   */
  public string getValueInternal() override
  {
    return ServParamBase::getValueInternal();
  }

  /**
   * @brief Retrieves the requested value of the string parameter.
   * @return The requested value as a string.
   */
  public string getValueRequested() override
  {
    return ServParamBase::getValueRequested();
  }

  /**
   * @brief Retrieves the operator value of the string parameter.
   * @return The operator value as a string.
   */
  public string getValueOperator() override
  {
    return ServParamBase::getValueOperator();
  }

  /**
  * @brief Retrieves the output value of the string parameter.
  * @return The output value as a string.
  */
  public string getValueOutput() override
  {
    return ServParamBase::getValueOutput();
  }

  /**
  * @brief Retrieves the feedback value of the string parameter.
  * @return The feedback value as a string.
  */
  public string getValueFeedback() override
  {
    return ServParamBase::getValueFeedback();
  }

  /**
   * @brief Sets the external value of the string parameter.
   * @details Updates the external value by calling the base class method.
   *
   * @param valueExternal The new external value.
   */
  public void setValueExternal(const string &valueExternal) override
  {
    ServParamBase::setValueExternal(valueExternal);
  }

  /**
   * @brief Sets the internal value of the string parameter.
   * @details Updates the internal value by calling the base class method.
   *
   * @param valueInternal The new internal value.
   */
  public void setValueInternal(const string &valueInternal) override
  {
    ServParamBase::setValueInternal(valueInternal);
  }

  /**
   * @brief Sets the requested value of the string parameter.
   * @details Updates the requested value by calling the base class method.
   *
   * @param valueRequested The new requested value.
   */
  public void setValueRequested(const string &valueRequested) override
  {
    ServParamBase::setValueRequested(valueRequested);
  }

  /**
   * @brief Sets the feedback value of the string parameter.
   * @details Updates the feedback value by calling the base class method.
   *
   * @param valueFeedback The new feedback value.
   */
  public void setValueFeedback(const string &valueFeedback) override
  {
    ServParamBase::setValueFeedback(valueFeedback);
  }

  /**
  * @brief Sets the operator value of the string parameter.
  * @details Updates the operator value by calling the base class method.
  *
  * @param valueOperator The new feedback value.
  */
  public void setValueOperator(const string &valueOperator) override
  {
    ServParamBase::setValueOperator(valueOperator);
  }
};
