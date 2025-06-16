// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

class MtpUnit
{
  private int _value;

  public MtpUnit(const string &dpeUnit)
  {
    if (!dpExists(dpeUnit))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeUnit));
    }

    dpGet(dpeUnit, _value);
  }

  public string toString()
  {
    return getCatStr("LCFL_Unit", _value);
  }
};
