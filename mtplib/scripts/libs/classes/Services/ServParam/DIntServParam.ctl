// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/Services/ServParam/ServParamBase"

/**
 * @class DIntServParam
 * @brief Represents the DIntServParam class for managing discrete integer service parameters.
 */
class DIntServParam : ServParamBase
{
  private int _valueScaleMin; //!< The minimum scale value for the discrete integer parameter.
  private int _valueScaleMax; //!< The maximum scale value for the discrete integer parameter.
  private int _valueMinimum; //!< The minimum allowed value for the discrete integer parameter.
  private int _valueMaximum; //!< The maximum allowed value for the discrete integer parameter.

  /**
    * @brief Constructor for the DIntServParam object.
    *
    * @param dp The data point of the DIntServParam.
    */
  public DIntServParam(const string &dp) : ServParamBase(dp)
  {
    if (!dpExists(getDp() + ".VSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMin"));
    }

    if (!dpExists(getDp() + ".VSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMax"));
    }

    if (!dpExists(getDp() + ".VMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VMin"));
    }

    if (!dpExists(getDp() + ".VMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VMax"));
    }

    dpConnect(this, setValueScaleMinCB, getDp() + ".VSclMin");
    dpConnect(this, setValueScaleMaxCB, getDp() + ".VSclMax");
    dpConnect(this, setValueMinimumCB, getDp() + ".VMin");
    dpConnect(this, setValueMaximumCB, getDp() + ".VMax");
  }

#event valueScaleMinChanged(const int &valueScaleMin) //!< Event triggered when the valueScaleMin state changes.
#event valueScaleMaxChanged(const int &valueScaleMax) //!< Event triggered when the valueScaleMax state changes.
#event valueMinimumChanged(const int &valueMinimum) //!< Event triggered when the valueMinimum state changes.
#event valueMaximumChanged(const int &valueMaximum) //!< Event triggered when the valueMaximum state changes.

  /**
   * @brief Retrieves the external value of the discrete integer parameter.
   * @return The external value as an integer.
   */
  public int getValueExternal() override
  {
    return ServParamBase::getValueExternal();
  }

  /**
   * @brief Retrieves the internal value of the discrete integer parameter.
   * @return The internal value as an integer.
   */
  public int getValueInternal() override
  {
    return ServParamBase::getValueInternal();
  }

  /**
   * @brief Retrieves the requested value of the discrete integer parameter.
   * @return The requested value as an integer.
   */
  public int getValueRequested() override
  {
    return ServParamBase::getValueRequested();
  }

  /**
   * @brief Retrieves the feedback value of the discrete integer parameter.
   * @return The feedback value as an integer.
   */
  public int getValueFeedback() override
  {
    return ServParamBase::getValueFeedback();
  }

  /**
  * @brief Retrieves the operator value of the float parameter.
  * @return The operator value as a float.
  */
  public int getValueOperator() override
  {
    return ServParamBase::getValueOperator();
  }

  /**
  * @brief Retrieves the output value of the int parameter.
  * @return The output value as a int.
  */
  public int getValueOutput() override
  {
    return ServParamBase::getValueOutput();
  }

  /**
   * @brief Retrieves the minimum scale value of the discrete integer parameter.
   * @return The minimum scale value as an integer.
   */
  public int getValueScaleMin()
  {
    return _valueScaleMin;
  }

  /**
   * @brief Retrieves the maximum scale value of the discrete integer parameter.
   * @return The maximum scale value as an integer.
   */
  public int getValueScaleMax()
  {
    return _valueScaleMax;
  }

  /**
   * @brief Retrieves the minimum allowed value of the discrete integer parameter.
   * @return The minimum allowed value as an integer.
   */
  public int getValueMinimum()
  {
    return _valueMinimum;
  }

  /**
   * @brief Retrieves the maximum allowed value of the discrete integer parameter.
   * @return The maximum allowed value as an integer.
   */
  public int getValueMaximum()
  {
    return _valueMaximum;
  }

  /**
   * @brief Sets the external value of the discrete integer parameter.
   * @details Updates the external value by calling the base class method.
   *
   * @param valueExternal The new external value.
   */
  public void setValueExternal(const int &valueExternal) override
  {
    ServParamBase::setValueExternal(valueExternal);
  }

  /**
   * @brief Sets the internal value of the discrete integer parameter.
   * @details Updates the internal value by calling the base class method.
   *
   * @param valueInternal The new internal value.
   */
  public void setValueInternal(const int &valueInternal) override
  {
    ServParamBase::setValueInternal(valueInternal);
  }

  /**
   * @brief Sets the requested value of the discrete integer parameter.
   * @details Updates the requested value by calling the base class method.
   *
   * @param valueRequested The new requested value.
   */
  public void setValueRequested(const int &valueRequested) override
  {
    ServParamBase::setValueRequested(valueRequested);
  }

  /**
   * @brief Sets the feedback value of the discrete integer parameter.
   * @details Updates the feedback value by calling the base class method.
   *
   * @param valueFeedback The new feedback value.
   */
  public void setValueFeedback(const int &valueFeedback) override
  {
    ServParamBase::setValueFeedback(valueFeedback);
  }

  /**
  * @brief Sets the operator value of the int parameter.
  * @details Updates the operator value by calling the base class method.
  *
  * @param valueOperator The new feedback value.
  */
  public void setValueOperator(const int &valueOperator) override
  {
    ServParamBase::setValueOperator(valueOperator);
  }

  /**
   * @brief Sets the minimum scale value of the discrete integer parameter.
   * @details Updates the minimum scale value and writes it to the data point.
   *
   * @param valueScaleMin The new minimum scale value.
   */
  public void setValueScaleMin(const int &valueScaleMin)
  {
    _valueScaleMin = valueScaleMin;
    dpSet(getDp() + ".VSclMin", _valueScaleMin);
  }

  /**
   * @brief Sets the maximum scale value of the discrete integer parameter.
   * @details Updates the maximum scale value and writes it to the data point.
   *
   * @param valueScaleMax The new maximum scale value.
   */
  public void setValueScaleMax(const int &valueScaleMax)
  {
    _valueScaleMax = valueScaleMax;
    dpSet(getDp() + ".VSclMax", _valueScaleMax);
  }

  /**
   * @brief Sets the minimum allowed value of the discrete integer parameter.
   * @details Updates the minimum allowed value and writes it to the data point.
   *
   * @param valueMinimum The new minimum allowed value.
   */
  public void setValueMinimum(const int &valueMinimum)
  {
    _valueMinimum = valueMinimum;
    dpSet(getDp() + ".VMin", _valueMinimum);
  }

  /**
   * @brief Sets the maximum allowed value of the discrete integer parameter.
   * @details Updates the maximum allowed value and writes it to the data point.
   *
   * @param valueMaximum The new maximum allowed value.
   */
  public void setValueMaximum(const int &valueMaximum)
  {
    _valueMaximum = valueMaximum;
    dpSet(getDp() + ".VMax", _valueMaximum);
  }

  /**
   * @brief Callback function to set the minimum scale value.
   * @details Updates the minimum scale value and triggers the valueScaleMinChanged event.
   *
   * @param dpe The data point element.
   * @param valueScaleMin The new minimum scale value.
   */
  private void setValueScaleMinCB(const string &dpe, const int &valueScaleMin)
  {
    _valueScaleMin = valueScaleMin;
    valueScaleMinChanged(_valueScaleMin);
  }

  /**
   * @brief Callback function to set the maximum scale value.
   * @details Updates the maximum scale value and triggers the valueScaleMaxChanged event.
   *
   * @param dpe The data point element.
   * @param valueScaleMax The new maximum scale value.
   */
  private void setValueScaleMaxCB(const string &dpe, const int &valueScaleMax)
  {
    _valueScaleMax = valueScaleMax;
    valueScaleMaxChanged(_valueScaleMax);
  }

  /**
   * @brief Callback function to set the minimum allowed value.
   * @details Updates the minimum allowed value and triggers the valueMinimumChanged event.
   *
   * @param dpe The data point element.
   * @param valueMinimum The new minimum allowed value.
   */
  private void setValueMinimumCB(const string &dpe, const int &valueMinimum)
  {
    _valueMinimum = valueMinimum;
    valueMinimumChanged(_valueMinimum);
  }

  /**
   * @brief Callback function to set the maximum allowed value.
   * @details Updates the maximum allowed value and triggers the valueMaximumChanged event.
   *
   * @param dpe The data point element.
   * @param valueMaximum The new maximum allowed value.
   */
  private void setValueMaximumCB(const string &dpe, const int &valueMaximum)
  {
    _valueMaximum = valueMaximum;
    valueMaximumChanged(_valueMaximum);
  }
};
