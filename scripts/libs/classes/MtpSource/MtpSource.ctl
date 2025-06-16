// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

class MtpSource
{
  private bool _channel;
  private bool _manualAutomatic;
  private bool _internalAutomatic;
  private bool _manualOperator;
  private bool _internalOperator;
  private bool _manualActive;
  private bool _internalActive;
  private string _dpeManualOperator;
  private string _dpeInternalOperator;

  public MtpSource(const string &dpeChannel, const string &dpeManualAutomatic, const string &dpeInternalAutomatic, const string &dpeManualOperator, const string &dpeInternalOperator, const string &dpeManualActive, const string &dpeInternalActive)
  {
    if (!dpExists(dpeChannel))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeChannel));
    }

    if (!dpExists(dpeManualAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeManualAutomatic));
    }

    if (!dpExists(dpeInternalAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInternalAutomatic));
    }

    if (!dpExists(dpeManualOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeManualOperator));
    }

    if (!dpExists(dpeInternalOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInternalOperator));
    }

    if (!dpExists(dpeManualActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeManualActive));
    }

    if (!dpExists(dpeInternalActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInternalActive));
    }

    _dpeManualOperator = dpeManualOperator;
    _dpeInternalOperator = dpeInternalOperator;

    dpGet(_dpeManualOperator, _manualOperator,
          _dpeInternalOperator, _internalOperator);

    dpConnect(this, setChannelCB, dpeChannel);
    dpConnect(this, setManualAutomaticCB, dpeManualAutomatic);
    dpConnect(this, setInternalAutomaticCB, dpeInternalAutomatic);
    dpConnect(this, setManualActiveCB, dpeManualActive);
    dpConnect(this, setInternalActiveCB, dpeInternalActive);
  }

#event channelChanged(const bool &channel)
#event manualAutomaticChanged(const bool &manualAutomatic)
#event internalAutomaticChanged(const bool &internalAutomatic)
#event manualActiveChanged(const bool &manualActive)
#event internalActiveChanged(const bool &internalActive)

  public bool getChannel()
  {
    return _channel;
  }

  public bool getManualAutomatic()
  {
    return _manualAutomatic;
  }

  public bool getInternalAutomatic()
  {
    return _internalAutomatic;
  }

  public bool getManualOperator()
  {
    return _manualOperator;
  }

  public bool getInternalOperator()
  {
    return _internalOperator;
  }

  public bool getManualActive()
  {
    return _manualActive;
  }

  public bool getInternalActive()
  {
    return _internalActive;
  }

  public void setManualOperator(const bool &manualOperator)
  {
    _manualOperator = manualOperator;
    dpSet(_dpeManualOperator, _manualOperator);
  }

  public void setInternalOperator(const bool &internalOperator)
  {
    _internalOperator = internalOperator;
    dpSet(_dpeInternalOperator, _internalOperator);
  }

  private void setChannelCB(const string &dpe, const bool &channel)
  {
    _channel = channel;
    channelChanged(getChannel());
  }

  private void setManualAutomaticCB(const string &dpe, const bool &manualAutomatic)
  {
    _manualAutomatic = manualAutomatic;
    manualAutomaticChanged(getManualAutomatic());
  }

  private void setInternalAutomaticCB(const string &dpe, const bool &internalAutomatic)
  {
    _internalAutomatic = internalAutomatic;
    internalAutomaticChanged(getInternalAutomatic());
  }

  private void setManualActiveCB(const string &dpe, const bool &manualActive)
  {
    _manualActive = manualActive;
    manualActiveChanged(getManualActive());
  }

  private void setInternalActiveCB(const string &dpe, const bool &internalActive)
  {
    _internalActive = internalActive;
    internalActiveChanged(getInternalActive());
  }
};
