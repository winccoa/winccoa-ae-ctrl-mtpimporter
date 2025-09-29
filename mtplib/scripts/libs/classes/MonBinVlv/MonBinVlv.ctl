// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "std"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class MonBinVlv
 * @brief A view model class for managing binary valve operations, including open/close control, feedback signals, and safety position monitoring.
 */
class MonBinVlv : MtpViewModelBase
{
  private bool _safetyposition; //!< Indicates the safety position state of the valve.
  private bool _safetypositionActive; //!< Indicates if the safety position is active.
  private bool _safetypositionEnabled; //!< Indicates if the safety position is enabled.
  private bool _openOperator; //!< Indicates the operator-initiated open command.
  private bool _closeOperator; //!< Indicates the operator-initiated close command.
  private bool _openAutomatic; //!< Indicates the automatic open command.
  private bool _closeAutomatic; //!< Indicates the automatic close command.
  private bool _valveControl; //!< Indicates the valve control state.
  private bool _openFeedbackSource; //!< Indicates the source open feedback signal.
  private bool _closeFeedbackSource; //!< Indicates the source close feedback signal.
  private bool _openCheckbackSignal; //!< Indicates the open checkback signal.
  private bool _closeCheckbackSignal; //!< Indicates the close checkback signal.
  private bool _resetOperator; //!< Indicates the operator-initiated reset command.
  private bool _resetAutomatic; //!< Indicates the automatic reset command.

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpState> _state; //!< The state associated with the monitored value.
  private shared_ptr<MtpSecurity> _security; //!< The security associated with the monitored value.
  private shared_ptr<MtpMonitor> _monitor; //!< The monitor associated with the monitored value.

  /**
   * @brief Constructor for MonBinVlv.
   * @details Initializes the view model by checking the existence of required data points and setting up data point connections for valve states and feedback signals.
   *
   * @param dp The data point path for the valve.
   * @throws An error if any required data point does not exist.
   */
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

#event openCheckbackSignalChanged(const bool &openCheckbackSignal) //!< Event triggered when the open checkback signal changes.
#event valveControlChanged(const bool &valveControl) //!< Event triggered when the valve control state changes.
#event closeCheckbackSignalChanged(const bool &closeCheckbackSignal) //!< Event triggered when the close checkback signal changes.
#event safetyPositionActiveChanged(const bool &safetyPositionActive) //!< Event triggered when the safety position activation state changes.
#event safetyPositionEnabledChanged(const bool &safetyPositionEnabled) //!< Event triggered when the safety position enabled state changes.
#event safetyPositionChanged(const bool &safetyPosition) //!< Event triggered when the safety position state changes.
#event closeAutomaticChanged(const bool &closeAutomatic) //!< Event triggered when the automatic close state changes.
#event openAutomaticChanged(const bool &openAutomatic) //!< Event triggered when the automatic open state changes.
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
   * @brief Retrieves the safety position active state.
   * @return The current safety position active state.
   */
  public bool getSafetyPositionActive()
  {
    return _safetypositionActive;
  }

  /**
   * @brief Retrieves the safety position enabled state.
   * @return The current safety position enabled state.
   */
  public bool getSafetyPositionEnabled()
  {
    return _safetypositionEnabled;
  }

  /**
   * @brief Retrieves the operator-initiated open command state.
   * @return The current open operator command state.
   */
  public bool getOpenOperator()
  {
    return _openOperator;
  }

  /**
   * @brief Retrieves the operator-initiated close command state.
   * @return The current close operator command state.
   */
  public bool getCloseOperator()
  {
    return _closeOperator;
  }

  /**
   * @brief Retrieves the automatic open command state.
   * @return The current open automatic command state.
   */
  public bool getOpenAutomatic()
  {
    return _openAutomatic;
  }

  /**
   * @brief Retrieves the automatic close command state.
   * @return The current close automatic command state.
   */
  public bool getCloseAutomatic()
  {
    return _closeAutomatic;
  }

  /**
   * @brief Retrieves the valve control state.
   * @return The current valve control state.
   */
  public bool getValveControl()
  {
    return _valveControl;
  }

  /**
   * @brief Retrieves the source open feedback signal state.
   * @return The current open feedback source state.
   */
  public bool getOpenFeedbackSource()
  {
    return _openFeedbackSource;
  }

  /**
   * @brief Retrieves the open checkback signal state.
   * @return The current open checkback signal state.
   */
  public bool getOpenCheckbackSignal()
  {
    return _openCheckbackSignal;
  }

  /**
   * @brief Retrieves the source close feedback signal state.
   * @return The current close feedback source state.
   */
  public bool getCloseFeedbackSource()
  {
    return _closeFeedbackSource;
  }

  /**
   * @brief Retrieves the close checkback signal state.
   * @return The current close checkback signal state.
   */
  public bool getCloseCheckbackSignal()
  {
    return _closeCheckbackSignal;
  }

  /**
   * @brief Retrieves the operator-initiated reset command state.
   * @return The current reset operator command state.
   */
  public bool getResetOperator()
  {
    return _resetOperator;
  }

  /**
   * @brief Retrieves the automatic reset command state.
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
   * @brief Retrieves the security settings.
   * @return The shared pointer to the MtpSecurity instance.
   */
  public shared_ptr<MtpSecurity> getSecurity()
  {
    return _security;
  }

  /**
   * @brief Sets the operator-initiated open command state.
   * @details Updates the open operator state and writes it to the corresponding data point.
   *
   * @param openOperator The new open operator command state.
   */
  public void setOpenOperator(const bool &openOperator)
  {
    _openOperator = openOperator;
    dpSet(getDp() + ".OpenOp", _openOperator);
  }

  /**
   * @brief Sets the operator-initiated close command state.
   * @details Updates the close operator state and writes it to the corresponding data point.
   *
   * @param closeOperator The new close operator command state.
   */
  public void setCloseOperator(const bool &closeOperator)
  {
    _closeOperator = closeOperator;
    dpSet(getDp() + ".CloseOp", _closeOperator);
  }

  /**
   * @brief Sets the operator-initiated reset command state.
   * @details Updates the reset operator state and writes it to the corresponding data point.
   *
   * @param resetOperator The new reset operator command state.
   */
  public void setResetOperator(const bool &resetOperator)
  {
    _resetOperator = resetOperator;
    dpSet(getDp() + ".ResetOp", _resetOperator);
  }

  /**
   * @brief Callback function to update the open checkback signal state.
   * @details Updates the open checkback signal and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param openCheckbackSignal The new open checkback signal state.
   */
  private void setOpenCheckbackSignalCB(const string &dpe, const bool &openCheckbackSignal)
  {
    _openCheckbackSignal = openCheckbackSignal;
    openCheckbackSignalChanged(_openCheckbackSignal);
  }

  /**
   * @brief Callback function to update the close checkback signal state.
   * @details Updates the close checkback signal and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param closeCheckbackSignal The new close checkback signal state.
   */
  private void setCloseCheckbackSignalCB(const string &dpe, const bool &closeCheckbackSignal)
  {
    _closeCheckbackSignal = closeCheckbackSignal;
    closeCheckbackSignalChanged(_closeCheckbackSignal);
  }

  /**
   * @brief Callback function to update the safety position state.
   * @details Updates the safety position state and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param safetyPosition The new safety position state.
   */
  private void setSafetyPositionCB(const string &dpe, const bool &safetyPosition)
  {
    _safetyposition = safetyPosition;
    safetyPositionChanged(_safetyposition);
  }

  /**
   * @brief Callback function to update the safety position active state.
   * @details Updates the safety position active state and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param safetyPositionActive The new safety position active state.
   */
  private void setSafetyPositionActiveCB(const string &dpe, const bool &safetyPositionActive)
  {
    _safetypositionActive = safetyPositionActive;
    safetyPositionActiveChanged(_safetypositionActive);
  }

  /**
   * @brief Callback function to update the safety position enabled state.
   * @details Updates the safety position enabled state and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param safetyPositionEnabled The new safety position enabled state.
   */
  private void setSafetyPositionEnabledCB(const string &dpe, const bool &safetyPositionEnabled)
  {
    _safetypositionEnabled = safetyPositionEnabled;
    safetyPositionEnabledChanged(_safetypositionEnabled);
  }

  /**
   * @brief Callback function to update the automatic open command state.
   * @details Updates the open automatic state and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param openAutomatic The new open automatic command state.
   */
  private void setOpenAutomaticCB(const string &dpe, const bool &openAutomatic)
  {
    _openAutomatic = openAutomatic;
    openAutomaticChanged(_openAutomatic);
  }

  /**
   * @brief Callback function to update the automatic close command state.
   * @details Updates the close automatic state and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param closeAutomatic The new close automatic command state.
   */
  private void setCloseAutomaticCB(const string &dpe, const bool &closeAutomatic)
  {
    _closeAutomatic = closeAutomatic;
    closeAutomaticChanged(_closeAutomatic);
  }

  /**
   * @brief Callback function to update the valve control state.
   * @details Updates the valve control state and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param valveControl The new valve control state.
   */
  private void setValveControlCB(const string &dpe, const bool &valveControl)
  {
    _valveControl = valveControl;
    valveControlChanged(_valveControl);
  }

  /**
   * @brief Callback function to update the automatic reset command state.
   * @details Updates the reset automatic state and triggers the corresponding event.
   *
   * @param dpe The data point element.
   * @param resetAutomatic The new reset automatic command state.
   */
  private void setResetAutomaticCB(const string &dpe, const bool &resetAutomatic)
  {
    _resetAutomatic = resetAutomatic;
    resetAutomaticChanged(_resetAutomatic);
  }
};
