// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "std"
#uses "classes/Services/ServParam/ServParamBase"

/**
 * @class AnaServParam
 * @brief Represents the AnaServParam class for managing analog service parameters.
 */
class AnaServParam : ServParamBase
{
  private float _valueScaleMin; //!< The minimum scale value for the analog parameter.
  private float _valueScaleMax; //!< The maximum scale value for the analog parameter.
  private float _valueMinimum; //!< The minimum allowed value for the analog parameter.
  private float _valueMaximum; //!< The maximum allowed value for the analog parameter.

  /**
    * @brief Constructor for the AnaServParam object.
    *
    * @param dp The data point of the AnaServParam.
    */
  public AnaServParam(const string &dp) : ServParamBase(dp)
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

#event valueScaleMinChanged(const float &valueScaleMin) //!< Event triggered when the valueScaleMin state changes.
#event valueScaleMaxChanged(const float &valueScaleMax) //!< Event triggered when the valueScaleMax state changes.
#event valueMinimumChanged(const float &valueMinimum) //!< Event triggered when the valueMinimum state changes.
#event valueMaximumChanged(const float &valueMaximum) //!< Event triggered when the valueMaximum state changes.

  /**
   * @brief Retrieves the external value of the analog parameter.
   * @return The external value as a float.
   */
  public float getValueExternal() override
  {
    return ServParamBase::getValueExternal();
  }

  /**
   * @brief Retrieves the internal value of the analog parameter.
   * @return The internal value as a float.
   */
  public float getValueInternal() override
  {
    return ServParamBase::getValueInternal();
  }

  /**
   * @brief Retrieves the requested value of the analog parameter.
   * @return The requested value as a float.
   */
  public float getValueRequested() override
  {
    return ServParamBase::getValueRequested();
  }

  /**
   * @brief Retrieves the feedback value of the analog parameter.
   * @return The feedback value as a float.
   */
  public float getValueFeedback() override
  {
    return ServParamBase::getValueFeedback();
  }

  /**
  * @brief Retrieves the operator value of the float parameter.
  * @return The operator value as a float.
  */
  public float getValueOperator() override
  {
    return ServParamBase::getValueOperator();
  }

  /**
  * @brief Retrieves the output value of the float parameter.
  * @return The output value as a float.
  */
  public float getValueOutput() override
  {
    return ServParamBase::getValueOutput();
  }

  /**
   * @brief Retrieves the minimum scale value of the analog parameter.
   * @return The minimum scale value as a float.
   */
  public float getValueScaleMin()
  {
    return _valueScaleMin;
  }

  /**
   * @brief Retrieves the maximum scale value of the analog parameter.
   * @return The maximum scale value as a float.
   */
  public float getValueScaleMax()
  {
    return _valueScaleMax;
  }

  /**
   * @brief Retrieves the minimum allowed value of the analog parameter.
   * @return The minimum allowed value as a float.
   */
  public float getValueMinimum()
  {
    return _valueMinimum;
  }

  /**
   * @brief Retrieves the maximum allowed value of the analog parameter.
   * @return The maximum allowed value as a float.
   */
  public float getValueMaximum()
  {
    return _valueMaximum;
  }

  /**
   * @brief Sets the external value of the analog parameter.
   * @details Updates the external value by calling the base class method.
   *
   * @param valueExternal The new external value.
   */
  public void setValueExternal(const float &valueExternal) override
  {
    ServParamBase::setValueExternal(valueExternal);
  }

  /**
   * @brief Sets the internal value of the analog parameter.
   * @details Updates the internal value by calling the base class method.
   *
   * @param valueInternal The new internal value.
   */
  public void setValueInternal(const float &valueInternal) override
  {
    ServParamBase::setValueInternal(valueInternal);
  }

  /**
   * @brief Sets the requested value of the analog parameter.
   * @details Updates the requested value by calling the base class method.
   *
   * @param valueRequested The new requested value.
   */
  public void setValueRequested(const float &valueRequested) override
  {
    ServParamBase::setValueRequested(valueRequested);
  }

  /**
   * @brief Sets the feedback value of the analog parameter.
   * @details Updates the feedback value by calling the base class method.
   *
   * @param valueFeedback The new feedback value.
   */
  public void setValueFeedback(const float &valueFeedback) override
  {
    ServParamBase::setValueFeedback(valueFeedback);
  }

  /**
  * @brief Sets the operator value of the float parameter.
  * @details Updates the operator value by calling the base class method.
  *
  * @param valueOperator The new feedback value.
  */
  public void setValueOperator(const float &valueOperator) override
  {
    ServParamBase::setValueOperator(valueOperator);
  }

  /**
   * @brief Sets the minimum scale value of the analog parameter.
   * @details Updates the minimum scale value and writes it to the data point.
   *
   * @param valueScaleMin The new minimum scale value.
   */
  public void setValueScaleMin(const float &valueScaleMin)
  {
    _valueScaleMin = valueScaleMin;
    dpSet(getDp() + ".VSclMin", _valueScaleMin);
  }

  /**
   * @brief Sets the maximum scale value of the analog parameter.
   * @details Updates the maximum scale value and writes it to the data point.
   *
   * @param valueScaleMax The new maximum scale value.
   */
  public void setValueScaleMax(const float &valueScaleMax)
  {
    _valueScaleMax = valueScaleMax;
    dpSet(getDp() + ".VSclMax", _valueScaleMax);
  }

  /**
   * @brief Sets the minimum allowed value of the analog parameter.
   * @details Updates the minimum allowed value and writes it to the data point.
   *
   * @param valueMinimum The new minimum allowed value.
   */
  public void setValueMinimum(const float &valueMinimum)
  {
    _valueMinimum = valueMinimum;
    dpSet(getDp() + ".VMin", _valueMinimum);
  }

  /**
   * @brief Sets the maximum allowed value of the analog parameter.
   * @details Updates the maximum allowed value and writes it to the data point.
   *
   * @param valueMaximum The new maximum allowed value.
   */
  public void setValueMaximum(const float &valueMaximum)
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
  private void setValueScaleMinCB(const string &dpe, const float &valueScaleMin)
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
  private void setValueScaleMaxCB(const string &dpe, const float &valueScaleMax)
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
  private void setValueMinimumCB(const string &dpe, const float &valueMinimum)
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
  private void setValueMaximumCB(const string &dpe, const float &valueMaximum)
  {
    _valueMaximum = valueMaximum;
    valueMaximumChanged(_valueMaximum);
  }
};
