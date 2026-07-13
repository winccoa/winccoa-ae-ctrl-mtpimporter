// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_ActiveElement/MTP_ActiveElement"

/**
 * @class MTP_AnaDrv
 * @brief Represents the MTP_AnaDrv class.
 */
class MTP_AnaDrv : MTP_ActiveElement
{
  private bool _safetyposition; //!< Indicates if the safety position is active.
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
  private float _rpmScaleMin; //!< The minimum scale value for RPM.
  private float _rpmScaleMax; //!< The maximum scale value for RPM.
  private float _rpmMin; //!< The minimum RPM value.
  private float _rpmMax; //!< The maximum RPM value.
  private float _rpmManual; //!< The manually set RPM value.
  private float _rpmInternal; //!< The internally set RPM value.
  private float _rpmReadback; //!< The readback RPM value.
  private float _rpm; //!< The current RPM value.
  private bool _reverseFeedbackSource; //!< Indicates the reverse feedback source state.
  private bool _forwardFeedbackSource; //!< Indicates the forward feedback source state.
  private bool _forwardFeedbackSignal; //!< Indicates the forward feedback signal state.
  private bool _reverseFeedbackSignal; //!< Indicates the reverse feedback signal state.
  private bool _rpmFeedbackSource; //!< Indicates the RPM feedback source state.
  private float _rpmFeedbackSignal; //!< The RPM feedback signal value.
  private bool _driveSafetyIndicator; //!< Indicates the drive safety indicator state.
  private bool _resetOperator; //!< Indicates if the reset operator command is active.
  private bool _resetAutomatic; //!< Indicates if the reset automatic command is active.
  private float _rpmError; //!< The RPM error value.

  private shared_ptr<MTP_State> _state; //!< The state associated with the monitored value.
  private shared_ptr<MTP_Security> _security; //!< The security associated with the monitored value.
  private shared_ptr<MTP_Source> _source; //!< The source associated with the monitored value.
  private shared_ptr<MTP_Unit> _rpmUnit; //!< The unit associated with the monitored value.

  /**
   * @brief Constructor for the MTP_AnaDrv object.
   *
   * @param dp The data point of the MTP_AnaDrv.
   */
  public MTP_AnaDrv(const string &dp) : MTP_ActiveElement(dp)
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

    if (!dpExists(getDp() + ".RpmFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmFbk"));
    }

    if (!dpExists(getDp() + ".Rpm"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Rpm"));
    }

    if (!dpExists(getDp() + ".RpmErr"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmErr"));
    }

    if (!dpExists(getDp() + ".RpmInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmInt"));
    }

    if (!dpExists(getDp() + ".RpmSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmSclMin"));
    }

    if (!dpExists(getDp() + ".RpmSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmSclMax"));
    }

    if (!dpExists(getDp() + ".RpmRbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmRbk"));
    }

    if (!dpExists(getDp() + ".RpmMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmMin"));
    }

    if (!dpExists(getDp() + ".RpmMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmMax"));
    }

    if (!dpExists(getDp() + ".RpmMan"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmMan"));
    }

    if (!dpExists(getDp() + ".RpmFbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmFbkCalc"));
    }

    dpGet(getDp() + ".FwdEn", _forwardEnabled,
          getDp() + ".RevEn", _reverseEnabled,
          getDp() + ".StopOp", _stopOperator,
          getDp() + ".FwdOp", _forwardOperator,
          getDp() + ".RevOp", _reverseOperator,
          getDp() + ".RevFbkCalc", _reverseFeedbackSource,
          getDp() + ".FwdFbkCalc", _forwardFeedbackSource,
          getDp() + ".ResetOp", _resetOperator,
          getDp() + ".RpmSclMin", _rpmScaleMin,
          getDp() + ".RpmSclMax", _rpmScaleMax,
          getDp() + ".RpmMin", _rpmMin,
          getDp() + ".RpmMax", _rpmMax,
          getDp() + ".RpmFbkCalc", _rpmFeedbackSource,
          getDp() + ".RpmRbk", _rpmReadback);

    dpConnect(this, setForwardControlCB, getDp() + ".FwdCtrl");
    dpConnect(this, setReverseControlCB, getDp() + ".RevCtrl");
    dpConnect(this, setForwardFeedbackSignalCB, getDp() + ".FwdFbk");
    dpConnect(this, setReverseFeedbackSignalCB, getDp() + ".RevFbk");
    dpConnect(this, setRpmFeedbackSignalCB, getDp() + ".RpmFbk");
    dpConnect(this, setRpmCB, getDp() + ".Rpm");
    dpConnect(this, setDriveSafetyIndicatorCB, getDp() + ".Trip");
    dpConnect(this, setSafetyPositionActiveCB, getDp() + ".SafePosAct");
    dpConnect(this, setRpmErrorCB, getDp() + ".RpmErr");
    dpConnect(this, setStopAutomaticCB, getDp() + ".StopAut");
    dpConnect(this, setForwardAutomaticCB, getDp() + ".FwdAut");
    dpConnect(this, setReverseAutomaticCB, getDp() + ".RevAut");
    dpConnect(this, setSafetyPositionCB, getDp() + ".SafePos");
    dpConnect(this, setResetAutomaticCB, getDp() + ".ResetAut");
    dpConnect(this, setRpmInternalCB, getDp() + ".RpmInt");
    dpConnect(this, setRpmManualCB, getDp() + ".RpmMan");

    _state = new MTP_State(getDp() + ".StateChannel", getDp() + ".StateOffAut", getDp() + ".StateOpAut", getDp() + ".StateAutAut", getDp() + ".StateOffOp", getDp() + ".StateOpOp", getDp() + ".StateAutOp", getDp() + ".StateOpAct", getDp() + ".StateAutAct", getDp() + ".StateOffAct");
    _security = new MTP_Security(getDp() + ".PermEn", getDp() + ".Permit", getDp() + ".IntlEn", getDp() + ".Interlock", getDp() + ".ProtEn", getDp() + ".Protect");
    _source = new MTP_Source(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
    _rpmUnit = new MTP_Unit(getDp() + ".RpmUnit");
  }

  #event forwardControlChanged(const bool &forwardControl) //!< Event triggered when the forward control state changes.
  #event reverseControlChanged(const bool &reverseControl) //!< Event triggered when the reverse control state changes.
  #event forwardFeedbackSignalChanged(const bool &forwardFeedbackSignal) //!< Event triggered when the forward feedback signal changes.
  #event reverseFeedbackSignalChanged(const bool &reverseFeedbackSignal) //!< Event triggered when the reverse feedback signal changes.
  #event rpmFeedbackSignalChanged(const float &rpmFeedbackSignal) //!< Event triggered when the RPM feedback signal changes.
  #event rpmChanged(const float &rpm) //!< Event triggered when the RPM value changes.
  #event rpmInternalChanged(const float &rpmInternal) //!< Event triggered when the internally set RPM value changes.
  #event rpmManualChanged(const float &rpmManual) //!< Event triggered when the manually set RPM value changes.
  #event driveSafetyIndicatorChanged(const bool &driveSafetyIndicator) //!< Event triggered when the drive safety indicator state changes.
  #event safetyPositionActiveChanged(const bool &active) //!< Event triggered when the safety position activation state changes.
  #event safetyPositionChanged(const bool &safetyPosition) //!< Event triggered when the safety position state changes.
  #event rpmErrorChanged(const float &error) //!< Event triggered when the RPM error value changes.
  #event stopAutomaticChanged(const bool &stopAutomatic) //!< Event triggered when the automatic stop state changes.
  #event forwardAutomaticChanged(const bool &forwardAutomatic) //!< Event triggered when the automatic forward state changes.
  #event reverseAutomaticChanged(const bool &reverseAutomatic) //!< Event triggered when the automatic reverse state changes.
  #event resetAutomaticChanged(const bool &resetAutomatic) //!< Event triggered when the automatic reset state changes.

  /**
   * @brief Retrieves the safety position state.
   *
   * @return The safety position state as a boolean.
   */
  public bool getSafetyPosition()
  {
    return _safetyposition;
  }

  /**
   * @brief Retrieves the safety position active state.
   *
   * @return The safety position active state as a boolean.
   */
  public bool getSafetyPositionActive()
  {
    return _safetypositionActive;
  }

  /**
   * @brief Retrieves the forward enabled state.
   *
   * @return The forward enabled state as a boolean.
   */
  public bool getForwardEnabled()
  {
    return _forwardEnabled;
  }

  /**
   * @brief Retrieves the reverse enabled state.
   *
   * @return The reverse enabled state as a boolean.
   */
  public bool getReverseEnabled()
  {
    return _reverseEnabled;
  }

  /**
   * @brief Retrieves the stop operator state.
   *
   * @return The stop operator state as a boolean.
   */
  public bool getStopOperator()
  {
    return _stopOperator;
  }

  /**
   * @brief Retrieves the forward operator state.
   *
   * @return The forward operator state as a boolean.
   */
  public bool getForwardOperator()
  {
    return _forwardOperator;
  }

  /**
   * @brief Retrieves the reverse operator state.
   *
   * @return The reverse operator state as a boolean.
   */
  public bool getReverseOperator()
  {
    return _reverseOperator;
  }

  /**
   * @brief Retrieves the stop automatic state.
   *
   * @return The stop automatic state as a boolean.
   */
  public bool getStopAutomatic()
  {
    return _stopAutomatic;
  }

  /**
   * @brief Retrieves the forward automatic state.
   *
   * @return The forward automatic state as a boolean.
   */
  public bool getForwardAutomatic()
  {
    return _forwardAutomatic;
  }

  /**
   * @brief Retrieves the reverse automatic state.
   *
   * @return The reverse automatic state as a boolean.
   */
  public bool getReverseAutomatic()
  {
    return _reverseAutomatic;
  }

  /**
   * @brief Retrieves the forward control state.
   *
   * @return The forward control state as a boolean.
   */
  public bool getForwardControl()
  {
    return _forwardControl;
  }

  /**
   * @brief Retrieves the reverse control state.
   *
   * @return The reverse control state as a boolean.
   */
  public bool getReverseControl()
  {
    return _reverseControl;
  }

  /**
   * @brief Retrieves the minimum RPM scale value.
   *
   * @return The minimum RPM scale value as a float.
   */
  public float getRpmScaleMin()
  {
    return _rpmScaleMin;
  }

  /**
   * @brief Retrieves the maximum RPM scale value.
   *
   * @return The maximum RPM scale value as a float.
   */
  public float getRpmScaleMax()
  {
    return _rpmScaleMax;
  }

  /**
   * @brief Retrieves the minimum RPM value.
   *
   * @return The minimum RPM value as a float.
   */
  public float getRpmMin()
  {
    return _rpmMin;
  }

  /**
   * @brief Retrieves the maximum RPM value.
   *
   * @return The maximum RPM value as a float.
   */
  public float getRpmMax()
  {
    return _rpmMax;
  }

  /**
   * @brief Retrieves the manual RPM value.
   *
   * @return The manual RPM value as a float.
   */
  public float getRpmManual()
  {
    return _rpmManual;
  }

  /**
   * @brief Retrieves the internal RPM value.
   *
   * @return The internal RPM value as a float.
   */
  public float getRpmInternal()
  {
    return _rpmInternal;
  }

  /**
     * @brief Retrieves the RPM readback value.
     *
     * @return The RPM readback value as a float.
     */
  public float getRpmReadback()
  {
    return _rpmReadback;
  }

  /**
   * @brief Retrieves the current RPM value.
   *
   * @return The current RPM value as a float.
   */
  public float getRpm()
  {
    return _rpm;
  }

  /**
   * @brief Retrieves the reverse feedback source state.
   *
   * @return The reverse feedback source state as a boolean.
   */
  public bool getReverseFeedbackSource()
  {
    return _reverseFeedbackSource;
  }

  /**
   * @brief Retrieves the forward feedback source state.
   *
   * @return The forward feedback source state as a boolean.
   */
  public bool getForwardFeedbackSource()
  {
    return _forwardFeedbackSource;
  }

  /**
   * @brief Retrieves the forward feedback signal state.
   *
   * @return The forward feedback signal state as a boolean.
   */
  public bool getForwardFeedbackSignal()
  {
    return _forwardFeedbackSignal;
  }

  /**
   * @brief Retrieves the reverse feedback signal state.
   *
   * @return The reverse feedback signal state as a boolean.
   */
  public bool getReverseFeedbackSignal()
  {
    return _reverseFeedbackSignal;
  }

  /**
   * @brief Retrieves the RPM feedback source state.
   *
   * @return The RPM feedback source state as a boolean.
   */
  public bool getRpmFeedbackSource()
  {
    return _rpmFeedbackSource;
  }

  /**
   * @brief Retrieves the RPM feedback signal value.
   *
   * @return The RPM feedback signal value as a float.
   */
  public float getRpmFeedbackSignal()
  {
    return _rpmFeedbackSignal;
  }

  /**
   * @brief Retrieves the drive safety indicator state.
   *
   * @return The drive safety indicator state as a boolean.
   */
  public bool getDriveSafetyIndicator()
  {
    return _driveSafetyIndicator;
  }

  /**
   * @brief Retrieves the reset operator state.
   *
   * @return The reset operator state as a boolean.
   */
  public bool getResetOperator()
  {
    return _resetOperator;
  }

  /**
   * @brief Retrieves the reset automatic state.
   *
   * @return The reset automatic state as a boolean.
   */
  public bool getResetAutomatic()
  {
    return _resetAutomatic;
  }

  /**
   * @brief Retrieves the RPM error value.
   *
   * @return The RPM error value as a float.
   */
  public float getRpmError()
  {
    return _rpmError;
  }

  /**
  * @brief Retrieves the state information for the monitored value.
  *
  * @return The shared pointer to the MTP_State instance.
  */
  public shared_ptr<MTP_State> getState()
  {
    return _state;
  }

  /**
  * @brief Retrieves the source information for the monitored value.
  *
  * @return The shared pointer to the MTP_Source instance.
  */
  public shared_ptr<MTP_Source> getSource()
  {
    return _source;
  }

  /**
   * @brief Retrieves the security information for the monitored value.
   *
   * @return The shared pointer to the MTP_Security instance.
   */
  public shared_ptr<MTP_Security> getSecurity()
  {
    return _security;
  }

  /**
   * @brief Retrieves the RPM unit information.
   *
   * @return The shared pointer to the MTP_Unit instance.
   */
  public shared_ptr<MTP_Unit> getRpmUnit()
  {
    return _rpmUnit;
  }

  /**
  * @brief Sets the manual RPM value.
  *
  * @param rpmManual The new manual RPM value.
  */
  public void setRpmManual(const float &rpmManual)
  {
    _rpmManual = rpmManual;
    dpSet(getDp() + ".RpmMan", _rpmManual);
  }

  /**
   * @brief Sets the stop operator state.
   *
   * @param stopOperator The new stop operator state.
   */
  public void setStopOperator(const bool &stopOperator)
  {
    _stopOperator = stopOperator;
    dpSet(getDp() + ".StopOp", _stopOperator);
  }

  /**
   * @brief Sets the forward operator state.
   *
   * @param forwardOperator The new forward operator state.
   */
  public void setForwardOperator(const bool &forwardOperator)
  {
    _forwardOperator = forwardOperator;
    dpSet(getDp() + ".FwdOp", _forwardOperator);
  }

  /**
   * @brief Sets the reverse operator state.
   *
   * @param reverseOperator The new reverse operator state.
   */
  public void setReverseOperator(const bool &reverseOperator)
  {
    _reverseOperator = reverseOperator;
    dpSet(getDp() + ".RevOp", _reverseOperator);
  }

  /**
   * @brief Sets the reset operator state.
   *
   * @param resetOperator The new reset operator state.
   */
  public void setResetOperator(const bool &resetOperator)
  {
    _resetOperator = resetOperator;
    dpSet(getDp() + ".ResetOp", _resetOperator);
  }

  /**
   * @brief Callback function to set the forward control state.
   *
   * @param dpe The data point element.
   * @param forwardControl The new forward control state.
   */
  private void setForwardControlCB(const string &dpe, const bool &forwardControl)
  {
    _forwardControl = forwardControl;
    forwardControlChanged(_forwardControl);
  }

  /**
   * @brief Callback function to set the reverse control state.
   *
   * @param dpe The data point element.
   * @param reverseControl The new reverse control state.
   */
  private void setReverseControlCB(const string &dpe, const bool &reverseControl)
  {
    _reverseControl = reverseControl;
    reverseControlChanged(_reverseControl);
  }

  /**
   * @brief Callback function to set the forward feedback signal state.
   *
   * @param dpe The data point element.
   * @param forwardFeedbackSignal The new forward feedback signal state.
   */
  private void setForwardFeedbackSignalCB(const string &dpe, const bool &forwardFeedbackSignal)
  {
    _forwardFeedbackSignal = forwardFeedbackSignal;
    forwardFeedbackSignalChanged(_forwardFeedbackSignal);
  }

  /**
   * @brief Callback function to set the reverse feedback signal state.
   *
   * @param dpe The data point element.
   * @param reverseFeedbackSignal The new reverse feedback signal state.
   */
  private void setReverseFeedbackSignalCB(const string &dpe, const bool &reverseFeedbackSignal)
  {
    _reverseFeedbackSignal = reverseFeedbackSignal;
    reverseFeedbackSignalChanged(_reverseFeedbackSignal);
  }

  /**
   * @brief Callback function to set the RPM feedback signal value.
   *
   * @param dpe The data point element.
   * @param rpmFeedbackSignal The new RPM feedback signal value.
   */
  private void setRpmFeedbackSignalCB(const string &dpe, const float &rpmFeedbackSignal)
  {
    _rpmFeedbackSignal = rpmFeedbackSignal;
    rpmFeedbackSignalChanged(_rpmFeedbackSignal);
  }

  /**
   * @brief Callback function to set the RPM value.
   *
   * @param dpe The data point element.
   * @param rpm The new RPM value.
   */
  private void setRpmCB(const string &dpe, const float &rpm)
  {
    _rpm = rpm;
    rpmChanged(_rpm);
  }

  /**
   * @brief Callback function to set the drive safety indicator state.
   *
   * @param dpe The data point element.
   * @param driveSafetyIndicator The new drive safety indicator state.
   */
  private void setDriveSafetyIndicatorCB(const string &dpe, const bool &driveSafetyIndicator)
  {
    _driveSafetyIndicator = driveSafetyIndicator;
    driveSafetyIndicatorChanged(_driveSafetyIndicator);
  }

  /**
  * @brief Callback function to set the safety position active state.
  *
  * @param dpe The data point element.
  * @param active The new safety position active state.
  */
  private void setSafetyPositionActiveCB(const string &dpe, const bool &active)
  {
    _safetypositionActive = active;
    safetyPositionActiveChanged(_safetypositionActive);
  }

  /**
   * @brief Callback function to set the RPM error value.
   *
   * @param dpe The data point element.
   * @param error The new RPM error value.
   */
  private void setRpmErrorCB(const string &dpe, const float &error)
  {
    _rpmError = error;
    rpmErrorChanged(_rpmError);
  }

  /**
   * @brief Callback function to set the stop automatic state.
   *
   * @param dpe The data point element.
   * @param stopAutomatic The new stop automatic state.
   */
  private void setStopAutomaticCB(const string &dpe, const bool &stopAutomatic)
  {
    _stopAutomatic = stopAutomatic;
    stopAutomaticChanged(_stopAutomatic);
  }

  /**
   * @brief Callback function to set the forward automatic state.
   *
   * @param dpe The data point element.
   * @param forwardAutomatic The new forward automatic state.
   */
  private void setForwardAutomaticCB(const string &dpe, const bool &forwardAutomatic)
  {
    _forwardAutomatic = forwardAutomatic;
    forwardAutomaticChanged(_forwardAutomatic);
  }

  /**
   * @brief Callback function to set the reverse automatic state.
   *
   * @param dpe The data point element.
   * @param reverseAutomatic The new reverse automatic state.
   */
  private void setReverseAutomaticCB(const string &dpe, const bool &reverseAutomatic)
  {
    _reverseAutomatic = reverseAutomatic;
    reverseAutomaticChanged(_reverseAutomatic);
  }

  /**
   * @brief Callback function to set the safety position state.
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
   * @brief Callback function to set the reset automatic state.
   *
   * @param dpe The data point element.
   * @param resetAutomatic The new reset automatic state.
   */
  private void setResetAutomaticCB(const string &dpe, const bool &resetAutomatic)
  {
    _resetAutomatic = resetAutomatic;
    resetAutomaticChanged(_resetAutomatic);
  }

  /**
   * @brief Callback function to set the internal RPM value.
   *
   * @param dpe The data point element.
   * @param rpmInternal The new internal RPM value.
   */
  private void setRpmInternalCB(const string &dpe, const float &rpmInternal)
  {
    _rpmInternal = rpmInternal;
    rpmInternalChanged(_rpmInternal);
  }

  /**
   * @brief Callback function to set the manual RPM value.
   *
   * @param dpe The data point element.
   * @param rpmManual The new manual RPM value.
   */
  private void setRpmManualCB(const string &dpe, const float &rpmManual)
  {
    _rpmManual = rpmManual;
    rpmManualChanged(_rpmManual);
  }
};
