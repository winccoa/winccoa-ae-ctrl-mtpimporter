// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpValueLimit/MtpValueLimit"

class MtpValueLimitInt : MtpValueLimit
{
  public MtpValueLimitInt(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive) : MtpValueLimit(dpeLimit, dpeEnabled, dpeActive)
  {

  }

  public int getLimit() override
  {
    return MtpValueLimit::getLimit();
  }

  public void setLimit(const int &limit) override
  {
    MtpValueLimit::setLimit(limit);
  }
};
