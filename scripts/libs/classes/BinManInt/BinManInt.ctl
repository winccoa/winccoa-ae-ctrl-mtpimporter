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

class BinManInt : MtpViewModelBase
{
  private bool _valueOut;
  private string _valueStateFalseText;
  private string _valueStateTrueText;
  private bool _valueManual;
  private bool _valueInternal;
  private bool _valueReadback;
  private bool _valueFeedback;
  private shared_ptr<MtpQualityCode> _wqc;
  private shared_ptr<MtpOsLevel> _osLevel;
  private shared_ptr<MtpSource> _source;

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

#event valueOutChanged(const bool &value)
#event valueManualChanged(const bool &value)
#event valueInternalChanged(const bool &value)
#event valueFeedbackChanged(const bool &value)

  public bool getValueOut()
  {
    return _valueOut;
  }

  public string getValueStateTrueText()
  {
    return _valueStateTrueText;
  }

  public string getValueStateFalseText()
  {
    return _valueStateFalseText;
  }

  public bool getValueManual()
  {
    return _valueManual;
  }

  public bool getValueInternal()
  {
    return _valueInternal;
  }

  public bool getValueReadback()
  {
    return _valueReadback;
  }

  public bool getValueFeedback()
  {
    return _valueFeedback;
  }

  public void setValueMan(const bool &value)
  {
    _valueOut = value;
    dpSet(getDp() + ".VMan", value);
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

  private void setValueOutCB(const string &dpe, const float &value)
  {
    _valueOut = value;
    valueOutChanged(_valueOut);
  }

  private void setValueFeedbackCB(const string &dpe, const float &value)
  {
    _valueFeedback = value;
    valueFeedbackChanged(_valueFeedback);
  }

  private void setValueInternalCB(const string &dpe, const float &value)
  {
    _valueInternal = value;
    valueInternalChanged(_valueInternal);
  }

  private void setValueManualCB(const string &dpe, const float &value)
  {
    _valueManual = value;
    valueManualChanged(_valueManual);
  }
};
