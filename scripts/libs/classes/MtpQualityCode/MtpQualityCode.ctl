// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

class MtpQualityCode
{
  private bit32 _value;

  public MtpQualityCode(const string &dpeQc)
  {
    if (!dpExists(dpeQc))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeQc));
    }

    dpConnect(this, setQcCB, dpeQc);
  }

  #event qualityGoodChanged(const bool &qualityGood)

  public bool getQualityGood()
  {
    return (_value == 0x80 || _value == 0xFF);
  }

  private void setQcCB(const string &dpe, const bit32 value)
  {
    _value = value;

    qualityGoodChanged(getQualityGood());
  }
};
