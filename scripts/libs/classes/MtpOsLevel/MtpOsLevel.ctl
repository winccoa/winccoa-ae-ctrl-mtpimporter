// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

class MtpOsLevel
{
  private int _level;

  public MtpOsLevel(const string &dpeOsLevel)
  {
    if (!dpExists(dpeOsLevel))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOsLevel));
    }

    dpConnect(this, setLevelCB, dpeOsLevel);
  }

#event osLevelChanged(const int &level)

  public int getLevel()
  {
    return _level;
  }

  private void setLevelCB(const string &dpe, const int &level)
  {
    _level = level;
    osLevelChanged(getLevel());
  }
};
