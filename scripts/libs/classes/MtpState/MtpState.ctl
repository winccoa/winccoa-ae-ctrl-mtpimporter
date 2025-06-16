// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

class MtpState
{
  private bool _channel;
  private bool _offAutomatic;
  private bool _operatorAutomatic;
  private bool _automaticAutomatic;
  private bool _offOperator;
  private bool _automaticOperator;
  private bool _operatorOperator;
  private bool _operatorActive;
  private bool _automaticActive;
  private bool _offActive;
  private string _dpeOffOperator;
  private string _dpeOperatorOperator;
  private string _dpeAutomaticOperator;

  public MtpState(const string &dpeChannel, const string &dpeOffAutomatic, const string &dpeOperatorAutomatic, const string &dpeAutomaticAutomatic, const string &dpeOffOperator, const string &dpeOperatorOperator, const string &dpeAutomaticOperator, const string &dpeOperatorActive, const string &dpeAutomaticActive, const string &dpeOffActive)
  {
    if (!dpExists(dpeChannel))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeChannel));
    }

    if (!dpExists(dpeOffAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOffAutomatic));
    }

    if (!dpExists(dpeOperatorAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOperatorAutomatic));
    }

    if (!dpExists(dpeAutomaticAutomatic))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeAutomaticAutomatic));
    }

    if (!dpExists(dpeOffOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOffOperator));
    }

    if (!dpExists(dpeOperatorOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOperatorOperator));
    }

    if (!dpExists(dpeAutomaticOperator))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeAutomaticOperator));
    }

    if (!dpExists(dpeOperatorActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOperatorActive));
    }

    if (!dpExists(dpeAutomaticActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeAutomaticActive));
    }

    if (!dpExists(dpeOffActive))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOffActive));
    }

    _dpeOffOperator = dpeOffOperator;
    _dpeOperatorOperator = dpeOperatorOperator;
    _dpeAutomaticOperator = dpeAutomaticOperator;

    dpGet(_dpeOffOperator, _offOperator,
          _dpeOperatorOperator, _operatorOperator,
          _dpeAutomaticOperator, _automaticOperator);

    dpConnect(this, setChannelCB, dpeChannel);
    dpConnect(this, setOffAutomaticCB, dpeOffAutomatic);
    dpConnect(this, setOperatorAutomaticCB, dpeOperatorAutomatic);
    dpConnect(this, setAutomaticAutomaticCB, dpeAutomaticAutomatic);
    dpConnect(this, setOperatorActiveCB, dpeOperatorActive);
    dpConnect(this, setAutomaticActiveCB, dpeAutomaticActive);
    dpConnect(this, setOffActiveCB, dpeOffActive);
  }

#event offActiveChanged(const bool &active)
#event operatorActiveChanged(const bool &active)
#event automaticActiveChanged(const bool &active)
#event channelChanged(const bool &channel)
#event offAutomaticChanged(const bool &automatic)
#event operatorAutomaticChanged(const bool &automatic)
#event automaticAutomaticChanged(const bool &automatic)

  public bool getChannel()
  {
    return _channel;
  }

  public bool getOffAutomatic()
  {
    return _offAutomatic;
  }

  public bool getOperatorAutomatic()
  {
    return _operatorAutomatic;
  }

  public bool getAutomaticAutomatic()
  {
    return _automaticAutomatic;
  }

  public bool getOffOperator()
  {
    return _offOperator;
  }

  public bool getOperatorOperator()
  {
    return _operatorOperator;
  }

  public bool getAutomaticOperator()
  {
    return _automaticOperator;
  }

  public bool getOperatorActive()
  {
    return _operatorActive;
  }

  public bool getAutomaticActive()
  {
    return _automaticActive;
  }

  public bool getOffActive()
  {
    return _offActive;
  }

  public void setOffOperator(const bool &offOperator)
  {
    _offOperator = offOperator;
    dpSet(_dpeOffOperator, _offOperator);
  }

  public void setOperatorOperator(const bool &operatorOperator)
  {
    _operatorOperator = operatorOperator;
    dpSet(_dpeOperatorOperator, _operatorOperator);
  }

  public void setAutomaticOperator(const bool &automaticOperator)
  {
    _automaticOperator = automaticOperator;
    dpSet(_dpeAutomaticOperator, _automaticOperator);
  }

  private void setChannelCB(const string &dpe, const bool &channel)
  {
    _channel = channel;
    channelChanged(getChannel());
  }

  private void setOffAutomaticCB(const string &dpe, const bool &offAutomatic)
  {
    _offAutomatic = offAutomatic;
    offAutomaticChanged(getOffAutomatic());
  }

  private void setOperatorAutomaticCB(const string &dpe, const bool &operatorAutomatic)
  {
    _operatorAutomatic = operatorAutomatic;
    operatorAutomaticChanged(getOperatorAutomatic());
  }

  private void setAutomaticAutomaticCB(const string &dpe, const bool &automaticAutomatic)
  {
    _automaticAutomatic = automaticAutomatic;
    automaticAutomaticChanged(getAutomaticAutomatic());
  }

  private void setOperatorActiveCB(const string &dpe, const bool &operatorActive)
  {
    _operatorActive = operatorActive;
    operatorActiveChanged(getOperatorActive());
  }

  private void setAutomaticActiveCB(const string &dpe, const bool &automaticActive)
  {
    _automaticActive = automaticActive;
    automaticActiveChanged(getAutomaticActive());
  }

  private void setOffActiveCB(const string &dpe, const bool &offActive)
  {
    _offActive = offActive;
    offActiveChanged(getOffActive());
  }
};
