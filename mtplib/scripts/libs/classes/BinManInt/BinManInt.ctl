// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpViewModel/MtpViewModelBase"
#uses "classes/MtpQualityCode/MtpQualityCode"

/**
 * @class BinManInt
 * @brief Represents the BinManInt class for managing binary manual integer values.
 */
class BinManInt : MtpViewModelBase
{
  private bool _valueOut; //!< The output value of the monitored variable.
  private string _valueStateFalseText; //!< The text representation for the false state.
  private string _valueStateTrueText; //!< The text representation for the true state.
  private bool _valueManual; //!< The manually set value for the monitored variable.
  private bool _valueInternal; //!< The internal value for the monitored variable.
  private bool _valueReadback; //!< The readback value for the monitored variable.
  private bool _valueFeedback; //!< The feedback value for the monitored variable.
  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored variable.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored variable.
  private shared_ptr<MtpSource> _source; //!< The source information for the monitored variable.

  /**
   * @brief Constructor for the BinManInt object.
   *
   * @param dp The data point of the BinManInt.
   */
  public BinManInt(const string &dp) : MtpViewModelBase(dp)
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

    if (!dpExists(getDp() + ".VInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VInt"));
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
    dpConnect(this, setValueInternalCB, getDp() + ".VInt");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _source =  new MtpSource(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
  }

#event valueOutChanged(const bool &value) //!< Event triggered when the output value state changes (boolean).
#event valueManualChanged(const bool &value) //!< Event triggered when the manual value state changes.
#event valueInternalChanged(const bool &value) //!< Event triggered when the internal value state changes.
#event valueFeedbackChanged(const bool &value) //!< Event triggered when the feedback value state changes.

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
   * @brief Retrieves the internal value.
   *
   * @return The internal value as a boolean.
   */
  public bool getValueInternal()
  {
    return _valueInternal;
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
   * @details Updates the manual value and writes it to the data point.
   *
   * @param value The new manual value to set.
   */
  public void setValueManual(const bool &value)
  {
    _valueOut = value;
    dpSet(getDp() + ".VMan", value);
  }

  /**
   * @brief Retrieves the quality code (WQC) associated with this object.
   *
   * @return The shared pointer to the MtpQualityCode instance.
   */
  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the operating system level information.
   *
   * @return The shared pointer to the MtpOsLevel instance.
   */
  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Retrieves the source information for the monitored variable.
   *
   * @return The shared pointer to the MtpSource instance.
   */
  public shared_ptr<MtpSource> getSource()
  {
    return _source;
  }

  /**
   * @brief Sets the output value of the monitored variable.
   * @details Triggers the valueOutChanged event.
   *
   * @param dpe The data point element.
   * @param value The new output value to set.
   */
  private void setValueOutCB(const string &dpe, const float &value)
  {
    _valueOut = value;
    valueOutChanged(_valueOut);
  }

  /**
   * @brief Sets the feedback value of the monitored variable.
   * @details Triggers the valueFeedbackChanged event.
   *
   * @param dpe The data point element.
   * @param value The new feedback value to set.
   */
  private void setValueFeedbackCB(const string &dpe, const float &value)
  {
    _valueFeedback = value;
    valueFeedbackChanged(_valueFeedback);
  }

  /**
   * @brief Sets the internal value of the monitored variable.
   * @details Triggers the valueInternalChanged event.
   *
   * @param dpe The data point element.
   * @param value The new internal value to set.
   */
  private void setValueInternalCB(const string &dpe, const float &value)
  {
    _valueInternal = value;
    valueInternalChanged(_valueInternal);
  }

  /**
   * @brief Sets the manual value of the monitored variable.
   * @details Triggers the valueManualChanged event.
   *
   * @param dpe The data point element.
   * @param value The new manual value to set.
   */
  private void setValueManualCB(const string &dpe, const float &value)
  {
    _valueManual = value;
    valueManualChanged(_valueManual);
  }
};
