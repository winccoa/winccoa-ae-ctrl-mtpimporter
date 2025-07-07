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

class MonBinDrv : MtpViewModelBase
{
  private bool _safetyposition;
  private bool _safetypositionActive;
  private bool _forwardEnabled;
  private bool _reverseEnabled;
  private bool _stopOperator;
  private bool _forwardOperator;
  private bool _reverseOperator;
  private bool _stopAutomatic;
  private bool _forwardAutomatic;
  private bool _reverseAutomatic;
  private bool _forwardControl;
  private bool _reverseControl;
  private bool _reverseFeedbackSource;
  private bool _forwardFeedbackSource;
  private bool _forwardFeedbackSignal;
  private bool _reverseFeedbackSignal;
  private bool _driveSafetyIndicator;
  private bool _resetOperator;
  private bool _resetAutomatic;

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpState> _state; //!< The state associated with the monitored value.
  private shared_ptr<MtpSecurity> _security; //!< The security associated with the monitored value.
  private shared_ptr<MtpMonitor> _monitor; //!< The monitor associated with the monitored value.

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

#event forwardControlChanged(const bool &forwardControl)
#event reverseControlChanged(const bool &reverseControl)
#event forwardFeedbackSignalChanged(const bool &forwardFeedbackSignal)
#event reverseFeedbackSignalChanged(const bool &reverseFeedbackSignal)
#event driveSafetyIndicatorChanged(const bool &driveSafetyIndicator)
#event safetyPositionActiveChanged(const bool &safetyPositionActive)
#event safetyPositionChanged(const bool &safetyPosition)
#event forwardAutomaticChanged(const bool &forwardAutomatic)
#event reverseAutomaticChanged(const bool &reverseAutomatic)
#event stopAutomaticChanged(const bool &stopAutomatic)
#event resetAutomaticChanged(const bool &resetAutomatic)

  public bool getSafetyPosition()
  {
    return _safetyposition;
  }

  public bool getSafetyPositionActive()
  {
    return _safetypositionActive;
  }

  public bool getForwardEnabled()
  {
    return _forwardEnabled;
  }

  public bool getReverseEnabled()
  {
    return _reverseEnabled;
  }

  public bool getStopOperator()
  {
    return _stopOperator;
  }

  public bool getForwardOperator()
  {
    return _forwardOperator;
  }

  public bool getReverseOperator()
  {
    return _reverseOperator;
  }

  public bool getStopAutomatic()
  {
    return _stopAutomatic;
  }

  public bool getForwardAutomatic()
  {
    return _forwardAutomatic;
  }

  public bool getReverseAutomatic()
  {
    return _reverseAutomatic;
  }

  public bool getForwardControl()
  {
    return _forwardControl;
  }

  public bool getReverseControl()
  {
    return _reverseControl;
  }

  public bool getReverseFeedbackSource()
  {
    return _reverseFeedbackSource;
  }

  public bool getForwardFeedbackSource()
  {
    return _forwardFeedbackSource;
  }

  public bool getForwardFeedbackSignal()
  {
    return _forwardFeedbackSignal;
  }

  public bool getReverseFeedbackSignal()
  {
    return _reverseFeedbackSignal;
  }

  public bool getDriveSafetyIndicator()
  {
    return _driveSafetyIndicator;
  }

  public bool getResetOperator()
  {
    return _resetOperator;
  }

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

  public shared_ptr<MtpState> getState()
  {
    return _state;
  }

  public shared_ptr<MtpMonitor> getMonitor()
  {
    return _monitor;
  }

  public shared_ptr<MtpSecurity> getSecurity()
  {
    return _security;
  }

  public void setResetOperator(const bool &resetOperator)
  {
    _resetOperator = resetOperator;
    dpSet(getDp() + ".ResetOp", _resetOperator);
  }

  public void setReverseOperator(const bool &reverseOperator)
  {
    _reverseOperator = reverseOperator;
    dpSet(getDp() + ".RevOp", _reverseOperator);
  }

  public void setForwardOperator(const bool &forwardOperator)
  {
    _forwardOperator = forwardOperator;
    dpSet(getDp() + ".FwdOp", _forwardOperator);
  }

  public void setStopOperator(const bool &stopOperator)
  {
    _stopOperator = stopOperator;
    dpSet(getDp() + ".StopOp", _stopOperator);
  }

  private void setForwardControlCB(const string &dpe, const bool &forwardControl)
  {
    _forwardControl = forwardControl;
    forwardControlChanged(_forwardControl);
  }

  private void setReverseControlCB(const string &dpe, const bool &reverseControl)
  {
    _reverseControl = reverseControl;
    reverseControlChanged(_reverseControl);
  }

  private void setSafetyPositionCB(const string &dpe, const bool &safetyPosition)
  {
    _safetyposition = safetyPosition;
    safetyPositionChanged(_safetyposition);
  }

  private void setSafetyPositionActiveCB(const string &dpe, const bool &safetyPositionActive)
  {
    _safetypositionActive = safetyPositionActive;
    safetyPositionActiveChanged(_safetypositionActive);
  }

  private void setForwardFeedbackSignalCB(const string &dpe, const bool &forwardFeedbackSignal)
  {
    _forwardFeedbackSignal = forwardFeedbackSignal;
    forwardFeedbackSignalChanged(_forwardFeedbackSignal);
  }

  private void setReverseFeedbackSignalCB(const string &dpe, const bool &reverseFeedbackSignal)
  {
    _reverseFeedbackSignal = reverseFeedbackSignal;
    reverseFeedbackSignalChanged(_reverseFeedbackSignal);
  }

  private void setDriveSafetyIndicatorCB(const string &dpe, const bool &driveSafetyIndicator)
  {
    _driveSafetyIndicator = driveSafetyIndicator;
    driveSafetyIndicatorChanged(_driveSafetyIndicator);
  }

  private void setForwardAutomaticCB(const string &dpe, const bool &forwardAutomatic)
  {
    _forwardAutomatic = forwardAutomatic;
    forwardAutomaticChanged(_forwardAutomatic);
  }

  private void setReverseAutomaticCB(const string &dpe, const bool &reverseAutomatic)
  {
    _reverseAutomatic = reverseAutomatic;
    reverseAutomaticChanged(_reverseAutomatic);
  }

  private void setStopAutomaticCB(const string &dpe, const bool &stopAutomatic)
  {
    _stopAutomatic = stopAutomatic;
    stopAutomaticChanged(_stopAutomatic);
  }

  private void setResetAutomaticCB(const string &dpe, const bool &resetAutomatic)
  {
    _resetAutomatic = resetAutomatic;
    resetAutomaticChanged(_resetAutomatic);
  }
};
