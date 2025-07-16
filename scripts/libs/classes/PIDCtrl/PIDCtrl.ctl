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

class PIDCtrl : MtpViewModelBase
{
  private float _processValue;
  private float _processValueScaleMin;
  private float _processValueScaleMax;
  private float _setpointManual;
  private float _setpointInternal;
  private float _setpointScaleMin;
  private float _setpointScaleMax;
  private float _setpointInternalMin;
  private float _setpointInternalMax;
  private float _setpointManualMin;
  private float _setpointManualMax;
  private float _setpoint;
  private float _manipulatedValueManual;
  private float _manipulatedValue;
  private float _manipulatedValueMin;
  private float _manipulatedValueMax;
  private float _manipulatedValueScaleMin;
  private float _manipulatedValueScaleMax;
  private float _proportionalParameter;
  private float _integrationParameter;
  private float _derivationParameter;

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpState> _state; //!< The state associated with the monitored value.
  private shared_ptr<MtpSource> _source; //!< The source associated with the monitored value.
  private shared_ptr<MtpUnit> _pvUnit; //!< The unit associated with the PV value.
  private shared_ptr<MtpUnit> _spUnit; //!< The unit associated with the SP value.
  private shared_ptr<MtpUnit> _mvUnit; //!< The unit associated with the MV value.

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

#event  processValueChanged(const float &processValue)
#event  setpointChanged(const float &setpoint)
#event  manipulatedValueChanged(const float &manipulatedValue)
#event  manipulatedValueMinChanged(const float &manipulatedValueMin)
#event  manipulatedValueMaxChanged(const float &manipulatedValueMax)
#event  setpointInternalChanged(const float &setpointInternal)
#event  setpointManualChanged(const float &setpointManual)
#event  setpointInternalMinChanged(const float &setpointInternalMin)
#event  setpointInternalMaxChanged(const float &setpointInternalMax)
#event  processValueScaleMinChanged(const float &processValueScaleMin)
#event  processValueScaleMaxChanged(const float &processValueScaleMax)
#event  setpointScaleMinChanged(const float &setpointScaleMin)
#event  setpointScaleMaxChanged(const float &setpointScaleMax)
#event  manipulatedValueScaleMinChanged(const float &manipulatedValueScaleMin)
#event  manipulatedValueScaleMaxChanged(const float &manipulatedValueScaleMax)

  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  public shared_ptr<MtpState> getState()
  {
    return _state;
  }

  public shared_ptr<MtpSource> getSource()
  {
    return _source;
  }

  public shared_ptr<MtpUnit> getProcessValueUnit()
  {
    return _pvUnit;
  }

  public shared_ptr<MtpUnit> getSetpointUnit()
  {
    return _spUnit;
  }

  public shared_ptr<MtpUnit> getManipulatedValueUnit()
  {
    return _mvUnit;
  }

  public float getProcessValue()
  {
    return _processValue;
  }

  public float getProcessValueScaleMin()
  {
    return _processValueScaleMin;
  }

  public float getProcessValueScaleMax()
  {
    return _processValueScaleMax;
  }

  public float getSetpointManual()
  {
    return _setpointManual;
  }

  public float getSetpointInternal()
  {
    return _setpointInternal;
  }

  public float getSetpointScaleMin()
  {
    return _setpointScaleMin;
  }

  public float getSetpointScaleMax()
  {
    return _setpointScaleMax;
  }

  public float getSetpointInternalMin()
  {
    return _setpointInternalMin;
  }

  public float getSetpointInternalMax()
  {
    return _setpointInternalMax;
  }

  public float getSetpointManualMin()
  {
    return _setpointManualMin;
  }

  public float getSetpointManualMax()
  {
    return _setpointManualMax;
  }

  public float getSetpoint()
  {
    return _setpoint;
  }

  public float getManipulatedValueManual()
  {
    return _manipulatedValueManual;
  }

  public float getManipulatedValue()
  {
    return _manipulatedValue;
  }

  public float getManipulatedValueMin()
  {
    return _manipulatedValueMin;
  }

  public float getManipulatedValueMax()
  {
    return _manipulatedValueMax;
  }

  public float getManipulatedValueScaleMin()
  {
    return _manipulatedValueScaleMin;
  }

  public float getManipulatedValueScaleMax()
  {
    return _manipulatedValueScaleMax;
  }

  public float getProportionalParameter()
  {
    return _proportionalParameter;
  }

  public float getIntegrationParameter()
  {
    return _integrationParameter;
  }

  public float getDerivationParameter()
  {
    return _derivationParameter;
  }

  public void setSetpointManual(const float &setpointManual)
  {
    _setpointManual = setpointManual;
    dpSet(getDp() + ".SPMan", _setpointManual);
  }

  public void setManipulatedValueManual(const float &manipulatedValueManual)
  {
    _manipulatedValueManual = manipulatedValueManual;
    dpSet(getDp() + ".MVMan", _manipulatedValueManual);
  }

  public void setSetpointManualMin(const float &setpointManualMin)
  {
    _setpointManualMin = setpointManualMin;
    dpSet(getDp() + ".SPManMin", _setpointManualMin);
  }

  public void setSetpointManualMax(const float &setpointManualMax)
  {
    _setpointManualMax = setpointManualMax;
    dpSet(getDp() + ".SPManMax", _setpointManualMax);
  }

  public void setProportionalParameter(const float &proportionalParameter)
  {
    _proportionalParameter = proportionalParameter;
    dpSet(getDp() + ".P", _proportionalParameter);
  }

  public void setProcessValue(const float &processValue)
  {
    _processValue = processValue;
    dpSet(getDp() + ".PV", _processValue);
  }

  public void setSetpoint(const float &setpoint)
  {
    _setpoint = setpoint;
    dpSet(getDp() + ".SP", _setpoint);
  }

  public void setManipulatedValue(const float &manipulatedValue)
  {
    _manipulatedValue = manipulatedValue;
    dpSet(getDp() + ".MV", _manipulatedValue);
  }

  public void setIntegrationParameter(const float &integrationParameter)
  {
    _integrationParameter = integrationParameter;
    dpSet(getDp() + ".Ti", _integrationParameter);
  }

  public void setDerivationParameter(const float &derivationParameter)
  {
    _derivationParameter = derivationParameter;
    dpSet(getDp() + ".Td", _derivationParameter);
  }

  private void setProcessValueCB(const string &dpe, const float &processValue)
  {
    _processValue = processValue;
    processValueChanged(_processValue);
  }

  private void setSetpointInternalCB(const string &dpe, const float &setpointInternal)
  {
    _setpointInternal = setpointInternal;
    setpointInternalChanged(_setpointInternal);
  }

  private void setSetpointManualCB(const string &dpe, const float &setpointManual)
  {
    _setpointManual = setpointManual;
    setpointManualChanged(_setpointManual);
  }

  private void setManipulatedValueCB(const string &dpe, const float &manipulatedValue)
  {
    _manipulatedValue = manipulatedValue;
    manipulatedValueChanged(_manipulatedValue);
  }

  private void setManipulatedValueMinCB(const string &dpe, const float &manipulatedValueMin)
  {
    _manipulatedValueMin = manipulatedValueMin;
    manipulatedValueMinChanged(_manipulatedValueMin);
  }

  private void setManipulatedValueMaxCB(const string &dpe, const float &manipulatedValueMax)
  {
    _manipulatedValueMax = manipulatedValueMax;
    manipulatedValueMaxChanged(_manipulatedValueMax);
  }

  private void setSetpointInternalMinCB(const string &dpe, const float &setpointInternalMin)
  {
    _setpointInternalMin = setpointInternalMin;
    setpointInternalMinChanged(_setpointInternalMin);
  }

  private void setSetpointInternalMaxCB(const string &dpe, const float &setpointInternalMax)
  {

    _setpointInternalMax = setpointInternalMax;
    setpointInternalMaxChanged(_setpointInternalMax);
  }

  private void setSetpointCB(const string &dpe, const float &setpoint)
  {
    _setpoint = setpoint;
    setpointChanged(_setpoint);
  }

  private void setProcessValueScaleMinCB(const string &dpe, const float &processValueScaleMin)
  {
    _processValueScaleMin = processValueScaleMin;
    processValueScaleMinChanged(_processValueScaleMin);
  }

  private void setProcessValueScaleMaxCB(const string &dpe, const float &processValueScaleMax)
  {
    _processValueScaleMax = processValueScaleMax;
    processValueScaleMaxChanged(_processValueScaleMax);
  }

  private void setSetpointScaleMinCB(const string &dpe, const float &setpointScaleMin)
  {
    _setpointScaleMin = setpointScaleMin;
    setpointScaleMinChanged(_setpointScaleMin);
  }

  private void setSetpointScaleMaxCB(const string &dpe, const float &setpointScaleMax)
  {
    _setpointScaleMax = setpointScaleMax;
    setpointScaleMaxChanged(_setpointScaleMax);
  }

  private void setManipulatedValueScaleMinCB(const string &dpe, const float &manipulatedValueScaleMin)
  {
    _manipulatedValueScaleMin = manipulatedValueScaleMin;
    manipulatedValueScaleMinChanged(_manipulatedValueScaleMin);
  }

  private void setManipulatedValueScaleMaxCB(const string &dpe, const float &manipulatedValueScaleMax)
  {
    _manipulatedValueScaleMax = manipulatedValueScaleMax;
    manipulatedValueScaleMaxChanged(_manipulatedValueScaleMax);
  }
};
