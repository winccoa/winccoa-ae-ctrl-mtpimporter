// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpViewModel/MtpViewModelBase"

class MonBinVlv : MtpViewModelBase
{
  private bool _safetyposition;
  private bool _safetypositionActive;
  private bool _safetypositionEnabled;
  private bool _openOperator;
  private bool _closeOperator;
  private bool _openAutomatic;
  private bool _closeAutomatic;
  private bool _valveControl;
  private bool _openFeedbackSource;
  private bool _closeFeedbackSource;
  private bool _openCheckbackSignal;
  private bool _closeCheckbackSignal;
  private bool _resetOperator;
  private bool _resetAutomatic;

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpState> _state; //!< The state associated with the monitored value.
  private shared_ptr<MtpSecurity> _security; //!< The security associated with the monitored value.
  private shared_ptr<MtpMonitor> _monitor; //!< The monitor associated with the monitored value.

  public MonBinVlv(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".SafePos"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePos"));
    }

    if (!dpExists(getDp() + ".SafePosEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePosEn"));
    }

    if (!dpExists(getDp() + ".SafePosAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePosAct"));
    }

    if (!dpExists(getDp() + ".OpenOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenOp"));
    }

    if (!dpExists(getDp() + ".CloseOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseOp"));
    }

    if (!dpExists(getDp() + ".OpenAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenAut"));
    }

    if (!dpExists(getDp() + ".CloseAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseAut"));
    }

    if (!dpExists(getDp() + ".Ctrl"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Ctrl"));
    }

    if (!dpExists(getDp() + ".OpenFbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenFbkCalc"));
    }

    if (!dpExists(getDp() + ".OpenFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenFbk"));
    }

    if (!dpExists(getDp() + ".CloseFbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseFbkCalc"));
    }

    if (!dpExists(getDp() + ".CloseFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseFbk"));
    }

    if (!dpExists(getDp() + ".ResetOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ResetOp"));
    }

    if (!dpExists(getDp() + ".ResetAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ResetAut"));
    }


    dpGet(getDp() + ".OpenOp", _openOperator,
          getDp() + ".CloseOp", _closeOperator,
          getDp() + ".OpenFbkCalc", _openFeedbackSource,
          getDp() + ".OpenFbkCalc", _closeFeedbackSource,
          getDp() + ".ResetOp", _resetOperator);

    dpConnect(this, setOpenCheckbackSignalCB, getDp() + ".OpenFbk");
    dpConnect(this, setCloseCheckbackSignalCB, getDp() + ".CloseFbk");
    dpConnect(this, setSafetyPositionCB, getDp() + ".SafePos");
    dpConnect(this, setSafetyPositionActiveCB, getDp() + ".SafePosAct");
    dpConnect(this, setSafetyPositionEnabledCB, getDp() + ".SafePosEn");
    dpConnect(this, setOpenAutomaticCB, getDp() + ".OpenAut");
    dpConnect(this, setCloseAutomaticCB, getDp() + ".CloseAut");
    dpConnect(this, setValveControlCB, getDp() + ".Ctrl");
    dpConnect(this, setResetAutomaticCB, getDp() + ".ResetAut");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _state = new MtpState(getDp() + ".StateChannel", getDp() + ".StateOffAut", getDp() + ".StateOpAut", getDp() + ".StateAutAut", getDp() + ".StateOffOp", getDp() + ".StateOpOp", getDp() + ".StateAutOp", getDp() + ".StateOpAct", getDp() + ".StateAutAct", getDp() + ".StateOffAct");
    _security = new MtpSecurity(getDp() + ".PermEn", getDp() + ".Permit", getDp() + ".IntEn", getDp() + ".Interlock", getDp() + ".ProtEn", getDp() + ".Protect");
    _monitor = new MtpMonitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".MonStatErr", getDp() + ".MonDynErr", getDp() + ".MonStatTi", getDp() + ".MonDynTi");
  }

#event openCheckbackSignalChanged(const bool &openCheckbackSignal)
#event valveControlChanged(const bool &valveControl)
#event closeCheckbackSignalChanged(const bool &closeCheckbackSignal)
#event safetyPositionActiveChanged(const bool &safetyPositionActive)
#event safetyPositionEnabledChanged(const bool &safetyPositionEnabled)
#event safetyPositionChanged(const bool &safetyPosition)
#event closeAutomaticChanged(const bool &closeAutomatic)
#event openAutomaticChanged(const bool &openAutomatic)
#event resetAutomaticChanged(const bool &resetAutomatic)

  public bool getSafetyPosition()
  {
    return _safetyposition;
  }

  public bool getSafetyPositionActive()
  {
    return _safetypositionActive;
  }

  public bool getSafetyPositionEnabled()
  {
    return _safetypositionEnabled;
  }

  public bool getOpenOperator()
  {
    return _openOperator;
  }

  public bool getCloseOperator()
  {
    return _closeOperator;
  }

  public bool getOpenAutomatic()
  {
    return _openAutomatic;
  }

  public bool getCloseAutomatic()
  {
    return _closeAutomatic;
  }

  public bool getValveControl()
  {
    return _valveControl;
  }

  public bool getOpenFeedbackSource()
  {
    return _openFeedbackSource;
  }

  public bool getOpenCheckbackSignal()
  {
    return _openCheckbackSignal;
  }

  public bool getCloseFeedbackSource()
  {
    return _closeFeedbackSource;
  }

  public bool getCloseCheckbackSignal()
  {
    return _closeCheckbackSignal;
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

  public void setOpenOperator(const bool &openOperator)
  {
    _openOperator = openOperator;
    dpSet(getDp() + ".OpenOp", _openOperator);
  }

  public void setCloseOperator(const bool &closeOperator)
  {
    _closeOperator = closeOperator;
    dpSet(getDp() + ".CloseOp", _closeOperator);
  }

  public void setResetOperator(const bool &resetOperator)
  {
    _resetOperator = resetOperator;
    dpSet(getDp() + ".ResetOp", _resetOperator);
  }

  private void setOpenCheckbackSignalCB(const string &dpe, const bool &openCheckbackSignal)
  {
    _openCheckbackSignal = openCheckbackSignal;
    openCheckbackSignalChanged(_openCheckbackSignal);
  }

  private void setCloseCheckbackSignalCB(const string &dpe, const bool &closeCheckbackSignal)
  {
    _closeCheckbackSignal = closeCheckbackSignal;
    closeCheckbackSignalChanged(_closeCheckbackSignal);
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

  private void setSafetyPositionEnabledCB(const string &dpe, const bool &safetyPositionEnabled)
  {
    _safetypositionEnabled = safetyPositionEnabled;
    safetyPositionEnabledChanged(_safetypositionEnabled);
  }

  private void setOpenAutomaticCB(const string &dpe, const bool &openAutomatic)
  {
    _openAutomatic = openAutomatic;
    openAutomaticChanged(_openAutomatic);
  }

  private void setCloseAutomaticCB(const string &dpe, const bool &closeAutomatic)
  {
    _closeAutomatic = closeAutomatic;
    closeAutomaticChanged(_closeAutomatic);
  }

  private void setValveControlCB(const string &dpe, const bool &valveControl)
  {
    _valveControl = valveControl;
    valveControlChanged(_valveControl);
  }

  private void setResetAutomaticCB(const string &dpe, const bool &resetAutomatic)
  {
    _resetAutomatic = resetAutomatic;
    resetAutomaticChanged(_resetAutomatic);
  }
};
