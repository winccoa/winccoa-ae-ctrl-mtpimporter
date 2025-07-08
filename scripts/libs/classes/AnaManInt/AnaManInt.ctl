// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "std"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpViewModel/MtpViewModelBase"

class AnaManInt : MtpViewModelBase
{
  private float _valueOut;
  private float _valueScaleMin;
  private float _valueScaleMax;
  private float _valueManual;
  private float _valueInternal;
  private float _valueReadback;
  private float _valueFeedback;
  private float _valueMin;
  private float _valueMax;
  private shared_ptr<MtpQualityCode> _wqc;
  private shared_ptr<MtpOsLevel> _osLevel;
  private shared_ptr<MtpSource> _source;
  private shared_ptr<MtpUnit> _valueUnit;

  public AnaManInt(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".VOut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VOut"));
    }

    if (!dpExists(getDp() + ".VSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMin"));
    }

    if (!dpExists(getDp() + ".VSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VSclMax"));
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

    if (!dpExists(getDp() + ".VMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VMin"));
    }

    if (!dpExists(getDp() + ".VMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VMax"));
    }

    dpGet(getDp() + ".VMan", _valueManual,
          getDp() + ".VRbk", _valueReadback);

    dpConnect(this, setValueOutCB, getDp() + ".VOut");
    dpConnect(this, setValueFeedbackCB, getDp() + ".VFbk");
    dpConnect(this, setValueMinCB, getDp() + ".VMin");
    dpConnect(this, setValueMaxCB, getDp() + ".VMax");
    dpConnect(this, setValueInternalCB, getDp() + ".VInt");
    dpConnect(this, setValueScaleMinCB, getDp() + ".VSclMin");
    dpConnect(this, setValueScaleMaxCB, getDp() + ".VSclMax");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _valueUnit = new MtpUnit(getDp() + ".VUnit");
    _source =  new MtpSource(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
  }

#event valueOutChanged(const float &value)
#event valueFeedbackChanged(const float &valueFeedback)
#event valueMinChanged(const float &min)
#event valueMaxChanged(const float &max)
#event valueInternalChanged(const float &valueInternal)
#event valueScaleMinChanged(const float &valueScaleMin)
#event valueScaleMaxChanged(const float &valueScaleMax)

  public float getValueOut()
  {
    return _valueOut;
  }

  public float getValueScaleMin()
  {
    return _valueScaleMin;
  }

  public float getValueScaleMax()
  {
    return _valueScaleMax;
  }

  public float getValueManual()
  {
    return _valueManual;
  }

  public float getValueInternal()
  {
    return _valueInternal;
  }

  public float getValueReadback()
  {
    return _valueReadback;
  }

  public float getValueFeedback()
  {
    return _valueFeedback;
  }

  public float getValueMin()
  {
    return _valueMin;
  }

  public float getValueMax()
  {
    return _valueMax;
  }

  public void setValueManual(const float &valueManual)
  {
    _valueManual = valueManual;
    dpSet(getDp() + ".VMan", _valueManual);
  }

  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  public shared_ptr<MtpSource> getSource()
  {
    return _source;
  }

  public shared_ptr<MtpUnit> getValueUnit()
  {
    return _valueUnit;
  }

  private void setValueOutCB(const string &dpe, const float &value)
  {
    _valueOut = value;
    valueOutChanged(_valueOut);
  }

  private void setValueFeedbackCB(const string &dpe, const float &valueFeedback)
  {
    _valueFeedback = valueFeedback;
    valueFeedbackChanged(_valueFeedback);
  }

  private void setValueMinCB(const string &dpe, const float &min)
  {
    _valueMin = min;
    valueMinChanged(_valueMin);
  }

  private void setValueMaxCB(const string &dpe, const float &max)
  {
    _valueMax = max;
    valueMaxChanged(_valueMax);
  }

  private void setValueInternalCB(const string &dpe, const float &valueInternal)
  {
    _valueInternal = valueInternal;
    valueInternalChanged(_valueInternal);
  }

  private void setValueScaleMinCB(const string &dpe, const float &valueScaleMin)
  {
    _valueScaleMin = valueScaleMin;
    valueScaleMinChanged(_valueScaleMin);
  }

  private void setValueScaleMaxCB(const string &dpe, const float &valueScaleMax)
  {
    _valueScaleMax = valueScaleMax;
    valueScaleMaxChanged(_valueScaleMax);
  }
};
