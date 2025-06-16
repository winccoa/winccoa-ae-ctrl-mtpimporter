// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpValueLimit/MtpValueLimit"

class MtpValueLimitFloat : MtpValueLimit
{
  public MtpValueLimitFloat(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive) : MtpValueLimit(dpeLimit, dpeEnabled, dpeActive)
  {

  }

  public float getLimit() override
  {
    return MtpValueLimit::getLimit();
  }

  public void setLimit(const float &value) override
  {
    MtpValueLimit::setLimit(value);
  }
};
