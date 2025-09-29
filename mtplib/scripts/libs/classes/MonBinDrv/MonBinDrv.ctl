// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MtpState/MtpState"
#uses "std"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class MonBinDrv
 * @brief Represents a view model for monitoring binary drive systems, managing motor control, feedback, safety, and state information.
 */
class MonBinDrv : MtpViewModelBase
{
  private bool _safetyposition; //!< Indicates if the safety position is enabled.
  private bool _safetypositionActive; //!< Indicates if the safety position is currently active.
  private bool _forwardEnabled; //!< Indicates if forward operation is enabled.
  private bool _reverseEnabled; //!< Indicates if reverse operation is enabled.
  private bool _stopOperator; //!< Indicates if the stop operator command is active.
  private bool _forwardOperator; //!< Indicates if the forward operator command is active.
  private bool _reverseOperator; //!< Indicates if the reverse operator command is active.
  private bool _stopAutomatic; //!< Indicates if the stop automatic command is active.
  private bool _forwardAutomatic; //!< Indicates if the forward automatic command is active.
  private bool _reverseAutomatic; //!< Indicates if the reverse automatic command is active.
  private bool _forwardControl; //!< Indicates the forward control state.
  private bool _reverseControl; //!< Indicates the reverse control state.
  private bool _reverseFeedbackSource; //!< Indicates the reverse feedback source calculation state.
  private bool _forwardFeedbackSource; //!< Indicates the forward feedback source calculation state.
  private bool _forwardFeedbackSignal; //!< Indicates the forward feedback signal state.
  private bool _reverseFeedbackSignal; //!< Indicates the reverse feedback signal state.
  private bool _driveSafetyIndicator; //!< Indicates the drive safety (trip) indicator state.
  private bool _resetOperator; //!< Indicates if the reset operator command is active.
  private bool _resetAutomatic; //!< Indicates if the reset automatic command is active.

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpState> _state; //!< The state associated with the monitored value.
  private shared_ptr<MtpSecurity> _security; //!< The security associated with the monitored value.
  private shared_ptr<MtpMonitor> _monitor; //!< The monitor associated with the monitored value.

  /**
     * @brief Constructor for MonBinDrv.
     *
     * @param dp The data point identifier for the binary drive.
     * @throws Exception if any required data points do not exist.
     */
  public MonBinDrv(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".SafePos"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePos"));
    }

    if (!dpExists(getDp() + ".SafePosAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePosAct"));
    }

    if (!dpExists(getDp() + ".FwdEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".FwdEn"));
    }

    if (!dpExists(getDp() + ".RevEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RevEn"));
    }

    if (!dpExists(getDp() + ".StopOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".StopOp"));
    }

    if (!dpExists(getDp() + ".FwdOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".FwdOp"));
    }

    if (!dpExists(getDp() + ".RevOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RevOp"));
    }

    if (!dpExists(getDp() + ".StopAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".StopAut"));
    }

    if (!dpExists(getDp() + ".FwdAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".FwdAut"));
    }

    if (!dpExists(getDp() + ".RevAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RevAut"));
    }

    if (!dpExists(getDp() + ".FwdCtrl"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".FwdCtrl"));
    }

    if (!dpExists(getDp() + ".RevCtrl"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RevCtrl"));
    }

    if (!dpExists(getDp() + ".RevFbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RevFbkCalc"));
    }

    if (!dpExists(getDp() + ".RevFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RevFbk"));
    }

    if (!dpExists(getDp() + ".FwdFbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".FwdFbkCalc"));
    }

    if (!dpExists(getDp() + ".FwdFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".FwdFbk"));
    }

    if (!dpExists(getDp() + ".Trip"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Trip"));
    }

    if (!dpExists(getDp() + ".ResetOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ResetOp"));
    }

    if (!dpExists(getDp() + ".ResetAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ResetAut"));
    }

    dpGet(getDp() + ".FwdEn", _forwardEnabled,
          getDp() + ".RevEn", _reverseEnabled,
          getDp() + ".StopOp", _stopOperator,
          getDp() + ".FwdOp", _forwardOperator,
          getDp() + ".RevOp", _reverseOperator,
          getDp() + ".RevFbkCalc", _reverseFeedbackSource,
          getDp() + ".FwdFbkCalc", _forwardFeedbackSource,
          getDp() + ".ResetOp", _resetOperator);

    dpConnect(this, setForwardControlCB, getDp() + ".FwdCtrl");
    dpConnect(this, setReverseControlCB, getDp() + ".RevCtrl");
    dpConnect(this, setForwardFeedbackSignalCB, getDp() + ".FwdFbk");
    dpConnect(this, setReverseFeedbackSignalCB, getDp() + ".RevFbk");
    dpConnect(this, setDriveSafetyIndicatorCB, getDp() + ".Trip");
    dpConnect(this, setSafetyPositionActiveCB, getDp() + ".SafePosAct");
    dpConnect(this, setSafetyPositionCB, getDp() + ".SafePos");
    dpConnect(this, setForwardAutomaticCB, getDp() + ".FwdAut");
    dpConnect(this, setReverseAutomaticCB, getDp() + ".RevAut");
    dpConnect(this, setStopAutomaticCB, getDp() + ".StopAut");
    dpConnect(this, setResetAutomaticCB, getDp() + ".ResetAut");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _state = new MtpState(getDp() + ".StateChannel", getDp() + ".StateOffAut", getDp() + ".StateOpAut", getDp() + ".StateAutAut", getDp() + ".StateOffOp", getDp() + ".StateOpOp", getDp() + ".StateAutOp", getDp() + ".StateOpAct", getDp() + ".StateAutAct", getDp() + ".StateOffAct");
    _security = new MtpSecurity(getDp() + ".PermEn", getDp() + ".Permit", getDp() + ".IntEn", getDp() + ".Interlock", getDp() + ".ProtEn", getDp() + ".Protect");
    _monitor = new MtpMonitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".MonStatErr", getDp() + ".MonDynErr", getDp() + ".MonStatTi", getDp() + ".MonDynTi");
  }

#event forwardControlChanged(const bool &forwardControl) //!< Event triggered when the forward control state changes.
#event reverseControlChanged(const bool &reverseControl) //!< Event triggered when the reverse control state changes.
#event forwardFeedbackSignalChanged(const bool &forwardFeedbackSignal) //!< Event triggered when the forward feedback signal changes.
#event reverseFeedbackSignalChanged(const bool &reverseFeedbackSignal) //!< Event triggered when the reverse feedback signal changes.
#event driveSafetyIndicatorChanged(const bool &driveSafetyIndicator) //!< Event triggered when the drive safety indicator state changes.
#event safetyPositionActiveChanged(const bool &safetyPositionActive) //!< Event triggered when the safety position activation state changes.
#event safetyPositionChanged(const bool &safetyPosition) //!< Event triggered when the safety position state changes.
#event forwardAutomaticChanged(const bool &forwardAutomatic) //!< Event triggered when the automatic forward state changes.
#event reverseAutomaticChanged(const bool &reverseAutomatic) //!< Event triggered when the automatic reverse state changes.
#event stopAutomaticChanged(const bool &stopAutomatic) //!< Event triggered when the automatic stop state changes.
#event resetAutomaticChanged(const bool &resetAutomatic) //!< Event triggered when the automatic reset state changes.

  /**
   * @brief Retrieves the safety position state.
   * @return The current safety position state.
   */
  public bool getSafetyPosition()
  {
    return _safetyposition;
  }

  /**
   * @brief Retrieves the active safety position state.
   * @return The current active safety position state.
   */
  public bool getSafetyPositionActive()
  {
    return _safetypositionActive;
  }

  /**
   * @brief Retrieves the forward enabled state.
   * @return The current forward enabled state.
   */
  public bool getForwardEnabled()
  {
    return _forwardEnabled;
  }

  /**
   * @brief Retrieves the reverse enabled state.
   * @return The current reverse enabled state.
   */
  public bool getReverseEnabled()
  {
    return _reverseEnabled;
  }

  /**
   * @brief Retrieves the stop operator command state.
   * @return The current stop operator command state.
   */
  public bool getStopOperator()
  {
    return _stopOperator;
  }

  /**
   * @brief Retrieves the forward operator command state.
   * @return The current forward operator command state.
   */
  public bool getForwardOperator()
  {
    return _forwardOperator;
  }

  /**
   * @brief Retrieves the reverse operator command state.
   * @return The current reverse operator command state.
   */
  public bool getReverseOperator()
  {
    return _reverseOperator;
  }

  /**
   * @brief Retrieves the stop automatic command state.
   * @return The current stop automatic command state.
   */
  public bool getStopAutomatic()
  {
    return _stopAutomatic;
  }

  /**
   * @brief Retrieves the forward automatic command state.
   * @return The current forward automatic command state.
   */
  public bool getForwardAutomatic()
  {
    return _forwardAutomatic;
  }

  /**
   * @brief Retrieves the reverse automatic command state.
   * @return The current reverse automatic command state.
   */
  public bool getReverseAutomatic()
  {
    return _reverseAutomatic;
  }

  /**
   * @brief Retrieves the forward control state.
   * @return The current forward control state.
   */
  public bool getForwardControl()
  {
    return _forwardControl;
  }

  /**
   * @brief Retrieves the reverse control state.
   * @return The current reverse control state.
   */
  public bool getReverseControl()
  {
    return _reverseControl;
  }

  /**
   * @brief Retrieves the reverse feedback source state.
   * @return The current reverse feedback source state.
   */
  public bool getReverseFeedbackSource()
  {
    return _reverseFeedbackSource;
  }

  /**
   * @brief Retrieves the forward feedback source state.
   * @return The current forward feedback source state.
   */
  public bool getForwardFeedbackSource()
  {
    return _forwardFeedbackSource;
  }

  /**
   * @brief Retrieves the forward feedback signal state.
   * @return The current forward feedback signal state.
   */
  public bool getForwardFeedbackSignal()
  {
    return _forwardFeedbackSignal;
  }

  /**
   * @brief Retrieves the reverse feedback signal state.
   * @return The current reverse feedback signal state.
   */
  public bool getReverseFeedbackSignal()
  {
    return _reverseFeedbackSignal;
  }

  /**
   * @brief Retrieves the drive safety indicator state.
   * @return The current drive safety indicator state.
   */
  public bool getDriveSafetyIndicator()
  {
    return _driveSafetyIndicator;
  }

  /**
   * @brief Retrieves the reset operator command state.
   * @return The current reset operator command state.
   */
  public bool getResetOperator()
  {
    return _resetOperator;
  }

  /**
   * @brief Retrieves the reset automatic command state.
   * @return The current reset automatic command state.
   */
  public bool getResetAutomatic()
  {
    return _resetAutomatic;
  }

  /**
  * @brief Retrieves the quality code (WQC) associated with this object.
  *
  * @return The shared pointer to the MtpQualityCode instance.
  */
  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the operating system level information.
   *
   * @return The shared pointer to the MtpOsLevel instance.
   */
  public shared_ptr<MtpOsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Retrieves the state information.
   * @return The shared pointer to the MtpState instance.
   */
  public shared_ptr<MtpState> getState()
  {
    return _state;
  }

  /**
   * @brief Retrieves the monitor information.
   * @return The shared pointer to the MtpMonitor instance.
   */
  public shared_ptr<MtpMonitor> getMonitor()
  {
    return _monitor;
  }

  /**
   * @brief Retrieves the security information.
   * @return The shared pointer to the MtpSecurity instance.
   */
  public shared_ptr<MtpSecurity> getSecurity()
  {
    return _security;
  }

  /**
   * @brief Sets the reset operator command state.
   * @param resetOperator The new reset operator command state.
   */
  public void setResetOperator(const bool &resetOperator)
  {
    _resetOperator = resetOperator;
    dpSet(getDp() + ".ResetOp", _resetOperator);
  }

  /**
   * @brief Sets the reverse operator command state.
   * @param reverseOperator The new reverse operator command state.
   */
  public void setReverseOperator(const bool &reverseOperator)
  {
    _reverseOperator = reverseOperator;
    dpSet(getDp() + ".RevOp", _reverseOperator);
  }

  /**
   * @brief Sets the forward operator command state.
   * @param forwardOperator The new forward operator command state.
   */
  public void setForwardOperator(const bool &forwardOperator)
  {
    _forwardOperator = forwardOperator;
    dpSet(getDp() + ".FwdOp", _forwardOperator);
  }

  /**
   * @brief Sets the stop operator command state.
   * @param stopOperator The new stop operator command state.
   */
  public void setStopOperator(const bool &stopOperator)
  {
    _stopOperator = stopOperator;
    dpSet(getDp() + ".StopOp", _stopOperator);
  }

  /**
   * @brief Callback function to update the forward control state.
   * @param dpe The data point element identifier.
   * @param forwardControl The new forward control state.
   */
  private void setForwardControlCB(const string &dpe, const bool &forwardControl)
  {
    _forwardControl = forwardControl;
    forwardControlChanged(_forwardControl);
  }

  /**
   * @brief Callback function to update the reverse control state.
   * @param dpe The data point element identifier.
   * @param reverseControl The new reverse control state.
   */
  private void setReverseControlCB(const string &dpe, const bool &reverseControl)
  {
    _reverseControl = reverseControl;
    reverseControlChanged(_reverseControl);
  }

  /**
   * @brief Callback function to update the safety position state.
   * @param dpe The data point element identifier.
   * @param safetyPosition The new safety position state.
   */
  private void setSafetyPositionCB(const string &dpe, const bool &safetyPosition)
  {
    _safetyposition = safetyPosition;
    safetyPositionChanged(_safetyposition);
  }

  /**
   * @brief Callback function to update the active safety position state.
   * @param dpe The data point element identifier.
   * @param safetyPositionActive The new active safety position state.
   */
  private void setSafetyPositionActiveCB(const string &dpe, const bool &safetyPositionActive)
  {
    _safetypositionActive = safetyPositionActive;
    safetyPositionActiveChanged(_safetypositionActive);
  }

  /**
   * @brief Callback function to update the forward feedback signal state.
   * @param dpe The data point element identifier.
   * @param forwardFeedbackSignal The new forward feedback signal state.
   */
  private void setForwardFeedbackSignalCB(const string &dpe, const bool &forwardFeedbackSignal)
  {
    _forwardFeedbackSignal = forwardFeedbackSignal;
    forwardFeedbackSignalChanged(_forwardFeedbackSignal);
  }

  /**
   * @brief Callback function to update the reverse feedback signal state.
   * @param dpe The data point element identifier.
   * @param reverseFeedbackSignal The new reverse feedback signal state.
   */
  private void setReverseFeedbackSignalCB(const string &dpe, const bool &reverseFeedbackSignal)
  {
    _reverseFeedbackSignal = reverseFeedbackSignal;
    reverseFeedbackSignalChanged(_reverseFeedbackSignal);
  }

  /**
   * @brief Callback function to update the drive safety indicator state.
   * @param dpe The data point element identifier.
   * @param driveSafetyIndicator The new drive safety indicator state.
   */
  private void setDriveSafetyIndicatorCB(const string &dpe, const bool &driveSafetyIndicator)
  {
    _driveSafetyIndicator = driveSafetyIndicator;
    driveSafetyIndicatorChanged(_driveSafetyIndicator);
  }

  /**
   * @brief Callback function to update the forward automatic command state.
   * @param dpe The data point element identifier.
   * @param forwardAutomatic The new forward automatic command state.
   */
  private void setForwardAutomaticCB(const string &dpe, const bool &forwardAutomatic)
  {
    _forwardAutomatic = forwardAutomatic;
    forwardAutomaticChanged(_forwardAutomatic);
  }

  /**
   * @brief Callback function to update the reverse automatic command state.
   * @param dpe The data point element identifier.
   * @param reverseAutomatic The new reverse automatic command state.
   */
  private void setReverseAutomaticCB(const string &dpe, const bool &reverseAutomatic)
  {
    _reverseAutomatic = reverseAutomatic;
    reverseAutomaticChanged(_reverseAutomatic);
  }

  /**
   * @brief Callback function to update the stop automatic command state.
   * @param dpe The data point element identifier.
   * @param stopAutomatic The new stop automatic command state.
   */
  private void setStopAutomaticCB(const string &dpe, const bool &stopAutomatic)
  {
    _stopAutomatic = stopAutomatic;
    stopAutomaticChanged(_stopAutomatic);
  }

  /**
   * @brief Callback function to update the reset automatic command state.
   * @param dpe The data point element identifier.
   * @param resetAutomatic The new reset automatic command state.
   */
  private void setResetAutomaticCB(const string &dpe, const bool &resetAutomatic)
  {
    _resetAutomatic = resetAutomatic;
    resetAutomaticChanged(_resetAutomatic);
  }
};
