// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

// Libraries used (#uses)
#uses "std"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class PIDCtrl
 * @brief Represents a PID controller with process, setpoint, and manipulated value management.
 */
class PIDCtrl : MtpViewModelBase
{
  private float _processValue; //!< The current process value.
  private float _processValueScaleMin; //!< The minimum scale for the process value.
  private float _processValueScaleMax; //!< The maximum scale for the process value.
  private float _setpointManual; //!< The manual setpoint value.
  private float _setpointInternal; //!< The internal setpoint value.
  private float _setpointScaleMin; //!< The minimum scale for the setpoint value.
  private float _setpointScaleMax; //!< The maximum scale for the setpoint value.
  private float _setpointInternalMin; //!< The minimum internal setpoint value.
  private float _setpointInternalMax; //!< The maximum internal setpoint value.
  private float _setpointManualMin; //!< The minimum manual setpoint value.
  private float _setpointManualMax; //!< The maximum manual setpoint value.
  private float _setpoint; //!< The current setpoint value.
  private float _manipulatedValueManual; //!< The manual manipulated value.
  private float _manipulatedValue; //!< The current manipulated value.
  private float _manipulatedValueMin; //!< The minimum manipulated value.
  private float _manipulatedValueMax; //!< The maximum manipulated value.
  private float _manipulatedValueScaleMin; //!< The minimum scale for the manipulated value.
  private float _manipulatedValueScaleMax; //!< The maximum scale for the manipulated value.
  private float _proportionalParameter; //!< The proportional parameter for the PID controller.
  private float _integrationParameter; //!< The integration parameter for the PID controller.
  private float _derivationParameter; //!< The derivation parameter for the PID controller.

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpState> _state; //!< The state associated with the monitored value.
  private shared_ptr<MtpSource> _source; //!< The source associated with the monitored value.
  private shared_ptr<MtpUnit> _pvUnit; //!< The unit associated with the PV value.
  private shared_ptr<MtpUnit> _spUnit; //!< The unit associated with the SP value.
  private shared_ptr<MtpUnit> _mvUnit; //!< The unit associated with the MV value.

  /**
   * @brief Constructor for the PIDCtrl object.
   *
   * @param dp The data point of the PID controller.
   */
  public PIDCtrl(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".PV"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PV"));
    }

    if (!dpExists(getDp() + ".PVSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PVSclMin"));
    }

    if (!dpExists(getDp() + ".PVSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PVSclMax"));
    }

    if (!dpExists(getDp() + ".SPMan"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SPMan"));
    }

    if (!dpExists(getDp() + ".SPInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SPInt"));
    }

    if (!dpExists(getDp() + ".SPSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SPSclMin"));
    }

    if (!dpExists(getDp() + ".SPSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SPSclMax"));
    }

    if (!dpExists(getDp() + ".SPIntMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SPIntMin"));
    }

    if (!dpExists(getDp() + ".SPIntMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SPIntMax"));
    }

    if (!dpExists(getDp() + ".SPManMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SPManMin"));
    }

    if (!dpExists(getDp() + ".SPManMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SPManMax"));
    }

    if (!dpExists(getDp() + ".SP"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SP"));
    }

    if (!dpExists(getDp() + ".MVMan"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".MVMan"));
    }

    if (!dpExists(getDp() + ".MV"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".MV"));
    }

    if (!dpExists(getDp() + ".MVMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".MVMin"));
    }

    if (!dpExists(getDp() + ".MVMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".MVMax"));
    }

    if (!dpExists(getDp() + ".MVSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".MVSclMin"));
    }

    if (!dpExists(getDp() + ".MVSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".MVSclMax"));
    }

    if (!dpExists(getDp() + ".P"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".P"));
    }

    if (!dpExists(getDp() + ".Ti"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Ti"));
    }

    if (!dpExists(getDp() + ".Td"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Td"));
    }

    dpGet(getDp() + ".SPMan", _setpointManual,
          getDp() + ".SPManMin", _setpointManualMin,
          getDp() + ".SPManMax", _setpointManualMax,
          getDp() + ".MVMan", _manipulatedValueManual,
          getDp() + ".P", _proportionalParameter,
          getDp() + ".Ti", _integrationParameter,
          getDp() + ".Td", _derivationParameter);

    dpConnect(this, setProcessValueCB, getDp() + ".PV");
    dpConnect(this, setSetpointInternalCB, getDp() + ".SPInt");
    dpConnect(this, setSetpointManualCB, getDp() + ".SPMan");
    dpConnect(this, setManipulatedValueCB, getDp() + ".MV");
    dpConnect(this, setManipulatedValueMinCB, getDp() + ".MVMin");
    dpConnect(this, setManipulatedValueMaxCB, getDp() + ".MVMax");
    dpConnect(this, setSetpointInternalMinCB, getDp() + ".SPIntMin");
    dpConnect(this, setSetpointInternalMaxCB, getDp() + ".SPIntMax");
    dpConnect(this, setSetpointCB, getDp() + ".SP");
    dpConnect(this, setProcessValueScaleMinCB, getDp() + ".PVSclMin");
    dpConnect(this, setProcessValueScaleMaxCB, getDp() + ".PVSclMax");
    dpConnect(this, setSetpointScaleMinCB, getDp() + ".SPSclMin");
    dpConnect(this, setSetpointScaleMaxCB, getDp() + ".SPSclMax");
    dpConnect(this, setManipulatedValueScaleMinCB, getDp() + ".MVSclMin");
    dpConnect(this, setManipulatedValueScaleMaxCB, getDp() + ".MVSclMax");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _source =  new MtpSource(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
    _state = new MtpState(getDp() + ".StateChannel", getDp() + ".StateOffAut", getDp() + ".StateOpAut", getDp() + ".StateAutAut", getDp() + ".StateOffOp", getDp() + ".StateOpOp", getDp() + ".StateAutOp", getDp() + ".StateOpAct", getDp() + ".StateAutAct", getDp() + ".StateOffAct");
    _pvUnit = new MtpUnit(getDp() + ".PVUnit");
    _spUnit = new MtpUnit(getDp() + ".SPUnit");
    _mvUnit = new MtpUnit(getDp() + ".MVUnit");
  }

#event  processValueChanged(const float &processValue) //!< Event triggered when the process value changes.
#event  setpointInternalChanged(const float &setpointInternal) //!< Event triggered when the internal setpoint changes.
#event  setpointChanged(const float &setpoint) //!< Event triggered when the setpoint changes.
#event  manipulatedValueChanged(const float &manipulatedValue) //!< Event triggered when the manipulated value changes.
#event  manipulatedValueMinChanged(const float &manipulatedValueMin) //!< Event triggered when the manipulated value minimum changes.
#event  manipulatedValueMaxChanged(const float &manipulatedValueMax) //!< Event triggered when the manipulated value maximum changes.
#event  setpointManualChanged(const float &setpointManual) //!< Event triggered when the manual setpoint changes.
#event  setpointInternalMinChanged(const float &setpointInternalMin) //!< Event triggered when the internal setpoint minimum changes.
#event  setpointInternalMaxChanged(const float &setpointInternalMax) //!< Event triggered when the internal setpoint maximum changes.
#event  processValueScaleMinChanged(const float &processValueScaleMin) //!< Event triggered when the process value scale minimum changes.
#event  processValueScaleMaxChanged(const float &processValueScaleMax) //!< Event triggered when the process value scale maximum changes.
#event  setpointScaleMinChanged(const float &setpointScaleMin) //!< Event triggered when the setpoint scale minimum changes.
#event  setpointScaleMaxChanged(const float &setpointScaleMax) //!< Event triggered when the setpoint scale maximum changes.
#event  manipulatedValueScaleMinChanged(const float &manipulatedValueScaleMin) //!< Event triggered when the manipulated value scale minimum changes.
#event  manipulatedValueScaleMaxChanged(const float &manipulatedValueScaleMax) //!< Event triggered when the manipulated value scale maximum changes.

  /**
   * @brief Retrieves the quality code associated with the monitored value.
   *
   * @return The quality code as a shared pointer to MtpQualityCode.
   */
  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the operational state level of the monitored value.
   *
   * @return The operational state level as a shared pointer to MtpOsLevel.
   */
  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Retrieves the state associated with the monitored value.
   *
   * @return The state as a shared pointer to MtpState.
   */
  public shared_ptr<MtpState> getState()
  {
    return _state;
  }

  /**
   * @brief Retrieves the source associated with the monitored value.
   *
   * @return The source as a shared pointer to MtpSource.
   */
  public shared_ptr<MtpSource> getSource()
  {
    return _source;
  }

  /**
   * @brief Retrieves a shared pointer to the associated MtpUnit for the process value.
   *
   * @return The shared pointer to the MtpUnit instance.
   */
  public shared_ptr<MtpUnit> getProcessValueUnit()
  {
    return _pvUnit;
  }

  /**
   * @brief Retrieves a shared pointer to the associated MtpUnit for the setpoint.
   *
   * @return The shared pointer to the MtpUnit instance.
   */
  public shared_ptr<MtpUnit> getSetpointUnit()
  {
    return _spUnit;
  }

  /**
   * @brief Retrieves a shared pointer to the associated MtpUnit for the manipulated value.
   *
   * @return The shared pointer to the MtpUnit instance.
   */
  public shared_ptr<MtpUnit> getManipulatedValueUnit()
  {
    return _mvUnit;
  }

  /**
   * @brief Retrieves the current process value.
   *
   * @return The current process value as a float.
   */
  public float getProcessValue()
  {
    return _processValue;
  }

  /**
   * @brief Retrieves the current process value scale minimum.
   *
   * @return The current process value scale minimum as a float.
   */
  public float getProcessValueScaleMin()
  {
    return _processValueScaleMin;
  }

  /**
   * @brief Retrieves the current process value scale maximum.
   *
   * @return The current process value scale maximum as a float.
   */
  public float getProcessValueScaleMax()
  {
    return _processValueScaleMax;
  }

  /**
   * @brief Retrieves the current setpoint manual value.
   *
   * @return The current setpoint manual value as a float.
   */
  public float getSetpointManual()
  {
    return _setpointManual;
  }

  /**
   * @brief Retrieves the current internal setpoint value.
   *
   * @return The current internal setpoint value as a float.
   */
  public float getSetpointInternal()
  {
    return _setpointInternal;
  }

  /**
   * @brief Retrieves the current setpoint scale minimum.
   *
   * @return The current setpoint scale minimum as a float.
   */
  public float getSetpointScaleMin()
  {
    return _setpointScaleMin;
  }

  /**
   * @brief Retrieves the current setpoint scale maximum.
   *
   * @return The current setpoint scale maximum as a float.
   */
  public float getSetpointScaleMax()
  {
    return _setpointScaleMax;
  }

  /**
   * @brief Retrieves the current internal setpoint minimum.
   *
   * @return The current internal setpoint minimum as a float.
   */
  public float getSetpointInternalMin()
  {
    return _setpointInternalMin;
  }

  /**
   * @brief Retrieves the current internal setpoint maximum.
   *
   * @return The current internal setpoint maximum as a float.
   */
  public float getSetpointInternalMax()
  {
    return _setpointInternalMax;
  }

  /**
   * @brief Retrieves the current setpoint manual minimum.
   *
   * @return The current setpoint manual minimum as a float.
   */
  public float getSetpointManualMin()
  {
    return _setpointManualMin;
  }

  /**
   * @brief Retrieves the current setpoint manual maximum.
   *
   * @return The current setpoint manual maximum as a float.
   */
  public float getSetpointManualMax()
  {
    return _setpointManualMax;
  }

  /**
   * @brief Retrieves the current setpoint value.
   *
   * @return The current setpoint value as a float.
   */
  public float getSetpoint()
  {
    return _setpoint;
  }

  /**
   * @brief Retrieves the current manipulated value manual.
   *
   * @return The current manipulated value manual as a float.
   */
  public float getManipulatedValueManual()
  {
    return _manipulatedValueManual;
  }

  /**
   * @brief Retrieves the current manipulated value.
   *
   * @return The current manipulated value as a float.
   */
  public float getManipulatedValue()
  {
    return _manipulatedValue;
  }

  /**
   * @brief Retrieves the current manipulated value minimum.
   *
   * @return The current manipulated value minimum as a float.
   */
  public float getManipulatedValueMin()
  {
    return _manipulatedValueMin;
  }

  /**
   * @brief Retrieves the current manipulated value maximum.
   *
   * @return The current manipulated value maximum as a float.
   */
  public float getManipulatedValueMax()
  {
    return _manipulatedValueMax;
  }

  /**
   * @brief Retrieves the current manipulated value scale minimum.
   *
   * @return The current manipulated value scale minimum as a float.
   */
  public float getManipulatedValueScaleMin()
  {
    return _manipulatedValueScaleMin;
  }

  /**
   * @brief Retrieves the current manipulated value scale maximum.
   *
   * @return The current manipulated value scale maximum as a float.
   */
  public float getManipulatedValueScaleMax()
  {
    return _manipulatedValueScaleMax;
  }

  /**
   * @brief Retrieves the current proportional parameter.
   *
   * @return The current proportional parameter as a float.
   */
  public float getProportionalParameter()
  {
    return _proportionalParameter;
  }

  /**
   * @brief Retrieves the current integration parameter.
   *
   * @return The current integration parameter as a float.
   */
  public float getIntegrationParameter()
  {
    return _integrationParameter;
  }

  /**
   * @brief Retrieves the current derivation parameter.
   *
   * @return The current derivation parameter as a float.
   */
  public float getDerivationParameter()
  {
    return _derivationParameter;
  }

  /**
   * @brief Sets the manual setpoint value.
   *
   * @param setpointManual The manual setpoint value to set.
   */
  public void setSetpointManual(const float &setpointManual)
  {
    _setpointManual = setpointManual;
    dpSet(getDp() + ".SPMan", _setpointManual);
  }

  /**
   * @brief Sets the manipulated value manual.
   *
   * @param manipulatedValueManual The manipulated value manual to set.
   */
  public void setManipulatedValueManual(const float &manipulatedValueManual)
  {
    _manipulatedValueManual = manipulatedValueManual;
    dpSet(getDp() + ".MVMan", _manipulatedValueManual);
  }

    /**
   * @brief Sets the manual setpoint minimum.
   *
   * @param setpointManualMin The manual setpoint minimum to set.
   */
  public void setSetpointManualMin(const float &setpointManualMin)
  {
    _setpointManualMin = setpointManualMin;
    dpSet(getDp() + ".SPManMin", _setpointManualMin);
  }

  /**
   * @brief Sets the manual setpoint maximum.
   *
   * @param setpointManualMax The manual setpoint maximum to set.
   */
  public void setSetpointManualMax(const float &setpointManualMax)
  {
    _setpointManualMax = setpointManualMax;
    dpSet(getDp() + ".SPManMax", _setpointManualMax);
  }

/**
* @brief Sets the proportional parameter.
*
* @param proportionalParameter The proportional parameter to set.
*/
  public void setProportionalParameter(const float &proportionalParameter)
  {
    _proportionalParameter = proportionalParameter;
    dpSet(getDp() + ".P", _proportionalParameter);
  }

/**
   * @brief Sets the process value.
   *
   * @param processValue The process value to set.
   */
  public void setProcessValue(const float &processValue)
  {
    _processValue = processValue;
    dpSet(getDp() + ".PV", _processValue);
  }

  /**
  * @brief sets the setpoint
  *
  * @param setpoint The setpoint to set.
  */
  public void setSetpoint(const float &setpoint)
  {
    _setpoint = setpoint;
    dpSet(getDp() + ".SP", _setpoint);
  }

  /**
   * @brief Sets the manipulated value.
   *
   * @param manipulatedValue The manipulated value to set.
   */
  public void setManipulatedValue(const float &manipulatedValue)
  {
    _manipulatedValue = manipulatedValue;
    dpSet(getDp() + ".MV", _manipulatedValue);
  }

  /**
  * @brief Sets the integration parameter.
   *
   * @param integrationParameter The integration parameter to set.
   */
  public void setIntegrationParameter(const float &integrationParameter)
  {
    _integrationParameter = integrationParameter;
    dpSet(getDp() + ".Ti", _integrationParameter);
  }

  /**
   * @brief Sets the derivation parameter.
   *
   * @param derivationParameter The derivation parameter to set.
   */
  public void setDerivationParameter(const float &derivationParameter)
  {
    _derivationParameter = derivationParameter;
    dpSet(getDp() + ".Td", _derivationParameter);
  }

  /**
   * @brief Sets the process value.
   *
   * @param processValue The process value to set.
   */
  private void setProcessValueCB(const string &dpe, const float &processValue)
  {
    _processValue = processValue;
    processValueChanged(_processValue);
  }

  /**
   * @brief Sets the internal setpoint value.
   *
   * @param setpointInternal The internal setpoint value to set.
   */
  private void setSetpointInternalCB(const string &dpe, const float &setpointInternal)
  {
    _setpointInternal = setpointInternal;
    setpointInternalChanged(_setpointInternal);
  }

  /**
   * @brief Sets the manual setpoint value.
   *
   * @param setpointManual The manual setpoint value to set.
   */
  private void setSetpointManualCB(const string &dpe, const float &setpointManual)
  {
    _setpointManual = setpointManual;
    setpointManualChanged(_setpointManual);
  }

  /**
   * @brief Sets the manipulated value.
   *
   * @param manipulatedValue The manipulated value to set.
   */
  private void setManipulatedValueCB(const string &dpe, const float &manipulatedValue)
  {
    _manipulatedValue = manipulatedValue;
    manipulatedValueChanged(_manipulatedValue);
  }

  /**
   * @brief Sets the manipulated value minimum.
   *
   * @param manipulatedValueMin The manipulated value minimum to set.
   */
  private void setManipulatedValueMinCB(const string &dpe, const float &manipulatedValueMin)
  {
    _manipulatedValueMin = manipulatedValueMin;
    manipulatedValueMinChanged(_manipulatedValueMin);
  }

  /**
   * @brief Sets the manipulated value maximum.
   *
   * @param manipulatedValueMax The manipulated value maximum to set.
   */
  private void setManipulatedValueMaxCB(const string &dpe, const float &manipulatedValueMax)
  {
    _manipulatedValueMax = manipulatedValueMax;
    manipulatedValueMaxChanged(_manipulatedValueMax);
  }

  /**
   * @brief Sets the internal setpoint minimum.
   *
   * @param setpointInternalMin The internal setpoint minimum to set.
   */
  private void setSetpointInternalMinCB(const string &dpe, const float &setpointInternalMin)
  {
    _setpointInternalMin = setpointInternalMin;
    setpointInternalMinChanged(_setpointInternalMin);
  }

  /**
   * @brief Sets the internal setpoint maximum.
   *
   * @param setpointInternalMax The internal setpoint maximum to set.
   */
  private void setSetpointInternalMaxCB(const string &dpe, const float &setpointInternalMax)
  {

    _setpointInternalMax = setpointInternalMax;
    setpointInternalMaxChanged(_setpointInternalMax);
  }

  /**
   * @brief Sets the setpoint value.
   *
   * @param setpoint The setpoint value to set.
   */
  private void setSetpointCB(const string &dpe, const float &setpoint)
  {
    _setpoint = setpoint;
    setpointChanged(_setpoint);
  }

  /**
   * @brief Sets the process value scale minimum.
   *
   * @param processValueScaleMin The process value scale minimum to set.
   */
  private void setProcessValueScaleMinCB(const string &dpe, const float &processValueScaleMin)
  {
    _processValueScaleMin = processValueScaleMin;
    processValueScaleMinChanged(_processValueScaleMin);
  }

  /**
   * @brief Sets the process value scale maximum.
   *
   * @param processValueScaleMax The process value scale maximum to set.
   */
  private void setProcessValueScaleMaxCB(const string &dpe, const float &processValueScaleMax)
  {
    _processValueScaleMax = processValueScaleMax;
    processValueScaleMaxChanged(_processValueScaleMax);
  }

  /**
   * @brief Sets the setpoint scale minimum.
   *
   * @param setpointScaleMin The setpoint scale minimum to set.
   */
  private void setSetpointScaleMinCB(const string &dpe, const float &setpointScaleMin)
  {
    _setpointScaleMin = setpointScaleMin;
    setpointScaleMinChanged(_setpointScaleMin);
  }

  /**
   * @brief Sets the setpoint scale maximum.
   *
   * @param setpointScaleMax The setpoint scale maximum to set.
   */
  private void setSetpointScaleMaxCB(const string &dpe, const float &setpointScaleMax)
  {
    _setpointScaleMax = setpointScaleMax;
    setpointScaleMaxChanged(_setpointScaleMax);
  }

  /**
   * @brief Sets the manipulated value scale minimum.
   *
   * @param manipulatedValueScaleMin The manipulated value scale minimum to set.
   */
  private void setManipulatedValueScaleMinCB(const string &dpe, const float &manipulatedValueScaleMin)
  {
    _manipulatedValueScaleMin = manipulatedValueScaleMin;
    manipulatedValueScaleMinChanged(_manipulatedValueScaleMin);
  }

  /**
   * @brief Sets the manipulated value scale maximum.
   *
   * @param manipulatedValueScaleMax The manipulated value scale maximum to set.
   */
  private void setManipulatedValueScaleMaxCB(const string &dpe, const float &manipulatedValueScaleMax)
  {
    _manipulatedValueScaleMax = manipulatedValueScaleMax;
    manipulatedValueScaleMaxChanged(_manipulatedValueScaleMax);
  }
};
