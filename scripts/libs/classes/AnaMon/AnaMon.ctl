// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"
#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpViewModel/MtpViewModelBase"

class AnaMon : MtpViewModelBase
{
  private float _value;
  private float _valueScaleMin;
  private float _valueScaleMax;
  private shared_ptr<MtpQualityCode> _wqc;
  private shared_ptr<MtpOsLevel> _osLevel;
  private shared_ptr<MtpUnit> _unit;
  private shared_ptr<MtpValueLimitFloat> _alertHighLimit;
  private shared_ptr<MtpValueLimitFloat> _warningHighLimit;
  private shared_ptr<MtpValueLimitFloat> _toleranceHighLimit;
  private shared_ptr<MtpValueLimitFloat> _toleranceLowLimit;
  private shared_ptr<MtpValueLimitFloat> _warningLowLimit;
  private shared_ptr<MtpValueLimitFloat> _alertLowLimit;

  public AnaMon(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".V"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".V"));
    }

    if (!dpExists(getDp() + ".VSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMin"));
    }

    if (!dpExists(getDp() + ".VSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMax"));
    }

    dpGet(getDp() + ".VSclMin", _valueScaleMin,
          getDp() + ".VSclMax", _valueScaleMax);

    dpConnect(this, setValueCB, getDp() + ".V");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _unit = new MtpUnit(getDp() + ".VUnit");
    _alertHighLimit = new MtpValueLimitFloat(getDp() + ".VAHLim", getDp() + ".VAHEn", getDp() + ".VAHAct");
    _warningHighLimit = new MtpValueLimitFloat(getDp() + ".VWHLim", getDp() + ".VWHEn", getDp() + ".VWHAct");
    _toleranceHighLimit = new MtpValueLimitFloat(getDp() + ".VTHLim", getDp() + ".VTHEn", getDp() + ".VTHAct");
    _toleranceLowLimit = new MtpValueLimitFloat(getDp() + ".VTLLim", getDp() + ".VTLEn", getDp() + ".VTLAct");
    _warningLowLimit = new MtpValueLimitFloat(getDp() + ".VWLLim", getDp() + ".VWLEn", getDp() + ".VWLAct");
    _alertLowLimit = new MtpValueLimitFloat(getDp() + ".VALLim", getDp() + ".VALEn", getDp() + ".VALAct");
  }

#event valueChanged(const float &value)

  public float getValue()
  {
    return _value;
  }

  public float getValueScaleMin()
  {
    return _valueScaleMin;
  }

  public float getValueScaleMax()
  {
    return _valueScaleMax;
  }

  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  public shared_ptr<MtpUnit> getUnit()
  {
    return _unit;
  }

  public shared_ptr<MtpValueLimitFloat> getAlertHighLimit()
  {
    return _alertHighLimit;
  }

  public shared_ptr<MtpValueLimitFloat> getWarningHighLimit()
  {
    return _warningHighLimit;
  }

  public shared_ptr<MtpValueLimitFloat> getToleranceHighLimit()
  {
    return _toleranceHighLimit;
  }

  public shared_ptr<MtpValueLimitFloat> getToleranceLowLimit()
  {
    return _toleranceLowLimit;
  }

  public shared_ptr<MtpValueLimitFloat> getWarningLowLimit()
  {
    return _warningLowLimit;
  }

  public shared_ptr<MtpValueLimitFloat> getAlertLowLimit()
  {
    return _alertLowLimit;
  }

  private void setValueCB(const string &dpe, const float &value)
  {
    _value = value;
    valueChanged(_value);
  }
};
