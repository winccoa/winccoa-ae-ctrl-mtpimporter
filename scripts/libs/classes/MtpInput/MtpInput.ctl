// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"
#uses "classes/MtpQualityCode/MtpQualityCode"

class MtpInput
{
  private bool _enabled;
  private bool _value;
  private bool _inverted;
  private string _text;
  private shared_ptr<MtpQualityCode> _qualityCode;

  public MtpInput(const string &dpeEnabled, const string &dpeValue, const string &dpeInverted, const string &dpeText, const string &dpeQualityCode)
  {
    if (!dpExists(dpeEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeEnabled));
    }

    if (!dpExists(dpeValue))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeValue));
    }

    if (!dpExists(dpeInverted))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInverted));
    }

    if (!dpExists(dpeText))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeText));
    }

    _qualityCode = new MtpQualityCode(dpeQualityCode);

    dpGet(dpeInverted, _inverted,
          dpeText, _text);

    dpConnect(this, setEnabledCB, dpeEnabled);
    dpConnect(this, setValueCB, dpeValue);
  }

#event enabledChanged(const bool &enabled)
#event valueChanged(const bool &value)

  public bool getEnabled()
  {
    return _enabled;
  }

  public bool getValue()
  {
    return _value;
  }

  public bool getInverted()
  {
    return _inverted;
  }

  public string getText()
  {
    return _text;
  }

  public shared_ptr<MtpQualityCode> getQualityCode()
  {
    return _qualityCode;
  }

  private void setEnabledCB(const string &dpe, const bool &enabled)
  {
    _enabled = enabled;
    enabledChanged(getEnabled());
  }

  private void setValueCB(const string &dpe, const bool &value)
  {
    _value = value;
    valueChanged(getValue());
  }
};
