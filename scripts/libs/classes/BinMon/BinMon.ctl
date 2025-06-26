// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpViewModel/MtpViewModelBase"

class BinMon : MtpViewModelBase
{
  private bool _value;
  private string _valueStateFalseText;
  private string _valueStateTrueText;
  private bool _flutterEnabled;
  private float _flutterTime;
  private int _flutterCount;
  private bool _flutterActive;
  private shared_ptr<MtpQualityCode> _wqc;
  private shared_ptr<MtpOsLevel> _osLevel;

  public BinMon(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".V"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".V"));
    }

    if (!dpExists(getDp() + ".VState0"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VState0"));
    }

    if (!dpExists(getDp() + ".VState1"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VState1"));
    }

    if (!dpExists(getDp() + ".VFlutEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFlutEn"));
    }

    if (!dpExists(getDp() + ".VFlutTi"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFlutTi"));
    }

    if (!dpExists(getDp() + ".VFlutCnt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFlutCnt"));
    }

    if (!dpExists(getDp() + ".VFlutAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VFlutAct"));
    }

    dpGet(getDp() + ".VFlutCnt", _flutterCount,
          getDp() + ".VFlutTi", _flutterTime,
          getDp() + ".VState0", _valueStateFalseText,
          getDp() + ".VState1", _valueStateTrueText,
          getDp() + ".VFlutEn", _flutterEnabled);

    dpConnect(this, setValueCB, getDp() + ".V");
    dpConnect(this, setFlutterActiveCB, getDp() + ".VFlutAct");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
  }

#event valueChanged(const bool &value)
#event flutterActiveChanged(const bool &flutterActive)

  public bool getValue()
  {
    return _value;
  }

  public string getValueStateTrueText()
  {
    return _valueStateTrueText;
  }

  public string getValueStateFalseText()
  {
    return _valueStateFalseText;
  }

  public bool getFlutterEnabled()
  {
    return _flutterEnabled;
  }

  public float getFlutterTime()
  {
    return _flutterTime;
  }

  public int getFlutterCount()
  {
    return _flutterCount;
  }

  public bool getFlutterActive()
  {
    return _flutterActive;
  }

  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  public void setFlutterCount(const int &flutterCount)
  {
    _flutterCount = flutterCount;
    dpSet(getDp() + ".VFlutCnt", _flutterCount);
  }

  public void setFlutterTime(const float &flutterTime)
  {
    _flutterTime = flutterTime;
    dpSet(getDp() + ".VFlutTi", _flutterTime);
  }

  private void setValueCB(const string &dpe, const bool &value)
  {
    _value = value;
    valueChanged(_value);
  }

  private void setFlutterActiveCB(const string &dpe, const bool &flutterActive)
  {
    _flutterActive = flutterActive;
    flutterActiveChanged(_flutterActive);
  }
};
