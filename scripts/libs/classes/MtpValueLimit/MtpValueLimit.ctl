// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

class MtpValueLimit
{
  private string _dpeLimit;
  private anytype _value;
  private bool _enabled;
  private bool _active;

  protected MtpValueLimit(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive)
  {
    _dpeLimit = dpeLimit;

    if (!dpExists(_dpeLimit))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dpeLimit));
    }

    if (!dpExists(dpeEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeEnabled));
    }

    if (!dpExists(dpeActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeActive));
    }

    dpGet(dpeEnabled, _enabled);

    dpConnect(this, setActiveCB, dpeActive);
    dpConnect(this, setLimitCB, _dpeLimit);
  }

#event activeChanged(const bool &active)

  public bool getActive()
  {
    return _active;
  }

  public bool getEnabled()
  {
    return _enabled;
  }

  protected void setLimit(const anytype &value)
  {
    dpSet(_dpeLimit, value);
  }

  protected anytype getLimit()
  {
    return _value;
  }

  private void setActiveCB(const string &dpe, const bool &active)
  {
    _active = active;
    activeChanged(getActive());
  }

  private void setLimitCB(const string &dpe, const anytype &value)
  {
    _value = value;
  }
};
