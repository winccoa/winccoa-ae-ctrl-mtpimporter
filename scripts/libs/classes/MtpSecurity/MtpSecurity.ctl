// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MtpSecurity
 * @brief This class provides security functionalities for the MTP library project.
 */
class MtpSecurity
{
  private bool _permissionEnabled; //!< Indicates if permission lock is enabled.
  private bool _permit; //!< Indicates if the permit is granted.
  private bool _interlockEnabled; //!< Indicates if interlock is enabled.
  private bool _interlock; //!< Indicates if interlock is active.
  private bool _protectionEnabled; //!< Indicates if protection is enabled.
  private bool _protection; //!< Indicates if protection is active.

  /**
   * @brief Constructor for MtpSecurity.
   *
   * @param dpePermissionEnabled The data point element for permission enabled state.
   * @param dpePermit The data point element for permit state.
   * @param dpeInterlockEnabled The data point element for interlock enabled state.
   * @param dpeInterlock The data point element for interlock state.
   * @param dpeProtectionEnabled The data point element for protection enabled state.
   * @param dpeProtection The data point element for protection state.
   */
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

  #event permissionEnabledChanged(const bool &value) //!< Event triggered when permission enabled state changes.
  #event permitChanged(const bool &value) //!< Event triggered when permit state changes.
  #event interlockEnabledChanged(const bool &value) //!< Event triggered when interlock enabled state changes.
  #event interlockChanged(const bool &value) //!< Event triggered when interlock state changes.
  #event protectionEnabledChanged(const bool &value) //!< Event triggered when protection enabled state changes.
  #event protectionChanged(const bool &value) //!< Event triggered when protection state changes.

  /**
   * @brief Retrieves the current permission lock enabled state.
   *
   * @return True if permission lock is enabled, false otherwise.
   */
  public bool getPermissionEnabled()
  {
    return _permissionEnabled;
  }

  /**
   * @brief Retrieves the current permit state.
   *
   * @return True if permit is granted, false otherwise.
   */
  public bool getPermit()
  {
    return _permit;
  }

  /**
   * @brief Retrieves the current interlock enabled state.
   *
   * @return True if interlock is enabled, false otherwise.
   */
  public bool getInterlockEnabled()
  {
    return _interlockEnabled;
  }

  /**
   * @brief Retrieves the current interlock state.
   *
   * @return True if interlock is inactive, false otherwise.
   */
  public bool getInterlock()
  {
    return _interlock;
  }

  /**
   * @brief Retrieves the current protection enabled state.
   *
   * @return True if protection is enabled, false otherwise.
   */
  public bool getProtectionEnabled()
  {
    return _protectionEnabled;
  }

  /**
   * @brief Retrieves the current protection state.
   *
   * @return True if protection is inactive, false otherwise.
   */
  public bool getProtection()
  {
    return _protection;
  }

  /**
   * @brief Sets the permission enabled state.
   * @details Triggers the permissionEnabledChanged event.
   *
   * @param dpe The data point element.
   * @param value The new state for permission enabled.
   */
  private void setPermissionEnabledCB(const string &dpe, const bool &value)
  {
    _permissionEnabled = value;
    permissionEnabledChanged(getPermissionEnabled());
  }

  /**
   * @brief Sets the permit state.
   * @details Triggers the permitChanged event.
   *
   * @param dpe The data point element.
   * @param value The new state for permit.
   */
  private void setPermitCB(const string &dpe, const bool &value)
  {
    _permit = value;
    permitChanged(getPermit());
  }

  /**
   * @brief Sets the interlock enabled state.
   * @details Triggers the interlockEnabledChanged event.
   *
   * @param dpe The data point element.
   * @param value The new state for interlock enabled.
   */
  private void setInterlockEnabledCB(const string &dpe, const bool &value)
  {
    _interlockEnabled = value;
    interlockEnabledChanged(getInterlockEnabled());
  }

  /**
   * @brief Sets the interlock state.
   * @details Triggers the interlockChanged event.
   *
   * @param dpe The data point element.
   * @param value The new state for interlock.
   */
  private void setInterlockCB(const string &dpe, const bool &value)
  {
    _interlock = value;
    interlockChanged(getInterlock());
  }

  /**
   * @brief Sets the protection enabled state.
   * @details Triggers the protectionEnabledChanged event.
   *
   * @param dpe The data point element.
   * @param value The new state for protection enabled.
   */
  private void setProtectionEnabledCB(const string &dpe, const bool &value)
  {
    _protectionEnabled = value;
    protectionEnabledChanged(getProtectionEnabled());
  }

  /**
   * @brief Sets the protection state.
   * @details Triggers the protectionChanged event.
   *
   * @param dpe The data point element.
   * @param value The new state for protection.
   */
  private void setProtectionCB(const string &dpe, const bool &value)
  {
    _protection = value;
    protectionChanged(getProtection());
  }
};
