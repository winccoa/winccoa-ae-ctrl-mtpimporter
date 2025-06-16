// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

class MtpSecurity
{
  private bool _permissionEnabled;
  private bool _permit;
  private bool _interlockEnabled;
  private bool _interlock;
  private bool _protectionEnabled;
  private bool _protection;

  public MtpSecurity(const string &dpePermissionEnabled, const string &dpePermit, const string &dpeInterlockEnabled, const string &dpeInterlock, const string &dpeProtectionEnabled, const string &dpeProtection)
  {
    if (!dpExists(dpePermissionEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpePermissionEnabled));
    }

    if (!dpExists(dpePermit))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpePermit));
    }

    if (!dpExists(dpeInterlockEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInterlockEnabled));
    }

    if (!dpExists(dpeInterlock))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeInterlock));
    }

    if (!dpExists(dpeProtectionEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeProtectionEnabled));
    }

    if (!dpExists(dpeProtection))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeProtection));
    }

    dpConnect(this, setPermissionEnabledCB, dpePermissionEnabled);
    dpConnect(this, setPermitCB, dpePermit);
    dpConnect(this, setInterlockEnabledCB, dpeInterlockEnabled);
    dpConnect(this, setInterlockCB, dpeInterlock);
    dpConnect(this, setProtectionEnabledCB, dpeProtectionEnabled);
    dpConnect(this, setProtectionCB, dpeProtection);
  }

  #event permissionEnabledChanged(const bool &value)
  #event permitChanged(const bool &value)
  #event interlockEnabledChanged(const bool &value)
  #event interlockChanged(const bool &value)
  #event protectionEnabledChanged(const bool &value)
  #event protectionChanged(const bool &value)

  public bool getPermissionEnabled()
  {
    return _permissionEnabled;
  }

  public bool getPermit()
  {
    return _permit;
  }

  public bool getInterlockEnabled()
  {
    return _interlockEnabled;
  }

  public bool getInterlock()
  {
    return _interlock;
  }

  public bool getProtectionEnabled()
  {
    return _protectionEnabled;
  }

  public bool getProtection()
  {
    return _protection;
  }

  private void setPermissionEnabledCB(const string &dpe, const bool &value)
  {
    _permissionEnabled = value;
    permissionEnabledChanged(getPermissionEnabled());
  }

  private void setPermitCB(const string &dpe, const bool &value)
  {
    _permit = value;
    permitChanged(getPermit());
  }

  private void setInterlockEnabledCB(const string &dpe, const bool &value)
  {
    _interlockEnabled = value;
    interlockEnabledChanged(getInterlockEnabled());
  }

  private void setInterlockCB(const string &dpe, const bool &value)
  {
    _interlock = value;
    interlockChanged(getInterlock());
  }

  private void setProtectionEnabledCB(const string &dpe, const bool &value)
  {
    _protectionEnabled = value;
    protectionEnabledChanged(getProtectionEnabled());
  }

  private void setProtectionCB(const string &dpe, const bool &value)
  {
    _protection = value;
    protectionChanged(getProtection());
  }
};
