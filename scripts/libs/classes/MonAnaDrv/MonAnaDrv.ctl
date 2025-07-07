// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "std"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpViewModel/MtpViewModelBase"

class MonAnaDrv : MtpViewModelBase
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
  private float _rpmScaleMin;
  private float _rpmScaleMax;
  private float _rpmMin;
  private float _rpmMax;
  private float _rpmManual;
  private float _rpmInternal;
  private float _rpmReadback;
  private float _rpm;
  private bool _reverseFeedbackSource;
  private bool _forwardFeedbackSource;
  private bool _forwardFeedbackSignal;
  private bool _reverseFeedbackSignal;
  private bool _rpmFeedbackSource;
  private float _rpmFeedbackSignal;
  private bool _driveSafetyIndicator;
  private bool _resetOperator;
  private bool _resetAutomatic;
  private float _rpmError;
  private bool _rpmAlarmHighEnabled;
  private bool _rpmAlarmLowEnabled;
  private bool _rpmAlarmHighActive;
  private bool _rpmAlarmLowActive;
  private float _rpmAlarmHighLimit;
  private float _rpmAlarmLowLimit;

  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MtpOsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MtpState> _state; //!< The state associated with the monitored value.
  private shared_ptr<MtpSecurity> _security; //!< The security associated with the monitored value.
  private shared_ptr<MtpSource> _source; //!< The source associated with the monitored value.
  private shared_ptr<MtpMonitor> _monitor; //!< The monitor associated with the monitored value.
  private shared_ptr<MtpUnit> _rpmUnit; //!< The unit associated with the monitored value.

  public MonAnaDrv(const string &dp) : MtpViewModelBase(dp)
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

    if (!dpExists(getDp() + ".RpmAHAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmAHAct"));
    }

    if (!dpExists(getDp() + ".RpmALAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmALAct"));
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

    if (!dpExists(getDp() + ".RpmAHEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmAHEn"));
    }

    if (!dpExists(getDp() + ".RpmALEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmALEn"));
    }

    if (!dpExists(getDp() + ".RpmAHLim"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmAHLim"));
    }

    if (!dpExists(getDp() + ".RpmALLim"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RpmALLim"));
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
          getDp() + ".RpmMan", _rpmManual,
          getDp() + ".RpmFbkCalc", _rpmFeedbackSource,
          getDp() + ".RpmAHEn", _rpmAlarmHighEnabled,
          getDp() + ".RpmALEn", _rpmAlarmLowEnabled,
          getDp() + ".RpmAHLim", _rpmAlarmHighLimit,
          getDp() + ".RpmALLim", _rpmAlarmLowLimit,
          getDp() + ".RpmRbk", _rpmReadback);

    dpConnect(this, setForwardControlCB, getDp() + ".FwdCtrl");
    dpConnect(this, setReverseControlCB, getDp() + ".RevCtrl");
    dpConnect(this, setForwardFeedbackSignalCB, getDp() + ".FwdFbk");
    dpConnect(this, setReverseFeedbackSignalCB, getDp() + ".RevFbk");
    dpConnect(this, setRpmFeedbackSignalCB, getDp() + ".RpmFbk");
    dpConnect(this, setRpmCB, getDp() + ".Rpm");
    dpConnect(this, setDriveSafetyIndicatorCB, getDp() + ".Trip");
    dpConnect(this, setRpmAlarmHighActiveCB, getDp() + ".RpmAHAct");
    dpConnect(this, setRpmAlarmLowActiveCB, getDp() + ".RpmALAct");
    dpConnect(this, setSafetyPositionActiveCB, getDp() + ".SafePosAct");
    dpConnect(this, setRpmErrorCB, getDp() + ".RpmErr");
    dpConnect(this, setStopAutomaticCB, getDp() + ".StopAut");
    dpConnect(this, setForwardAutomaticCB, getDp() + ".FwdAut");
    dpConnect(this, setReverseAutomaticCB, getDp() + ".RevAut");
    dpConnect(this, setSafetyPositionCB, getDp() + ".SafePos");
    dpConnect(this, setResetAutomaticCB, getDp() + ".ResetAut");
    dpConnect(this, setRpmInternalCB, getDp() + ".RpmInt");

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _osLevel = new MtpOsLevel(getDp() + ".OSLevel");
    _state = new MtpState(getDp() + ".StateChannel", getDp() + ".StateOffAut", getDp() + ".StateOpAut", getDp() + ".StateAutAut", getDp() + ".StateOffOp", getDp() + ".StateOpOp", getDp() + ".StateAutOp", getDp() + ".StateOpAct", getDp() + ".StateAutAct", getDp() + ".StateOffAct");
    _security = new MtpSecurity(getDp() + ".PermEn", getDp() + ".Permit", getDp() + ".IntEn", getDp() + ".Interlock", getDp() + ".ProtEn", getDp() + ".Protect");
    _source = new MtpSource(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
    _monitor = new MtpMonitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".MonStatErr", getDp() + ".MonDynErr", getDp() + ".MonStatTi", getDp() + ".MonDynTi");
    _rpmUnit = new MtpUnit(getDp() + ".RpmUnit");
  }

#event forwardControlChanged(const bool &forwardControl)
#event reverseControlChanged(const bool &reverseControl)
#event forwardFeedbackSignalChanged(const bool &forwardFeedbackSignal)
#event reverseFeedbackSignalChanged(const bool &reverseFeedbackSignal)
#event rpmFeedbackSignalChanged(const float &rpmFeedbackSignal)
#event rpmChanged(const float &rpm)
#event rpmInternalChanged(const float &rpmInternal)
#event driveSafetyIndicatorChanged(const bool &driveSafetyIndicator)
#event rpmAlarmHighActiveChanged(const bool &enabled)
#event rpmAlarmLowActiveChanged(const bool &enabled)
#event safetyPositionActiveChanged(const bool &active)
#event safetyPositionChanged(const bool &safetyPosition)
#event rpmErrorChanged(const float &error)
#event stopAutomaticChanged(const bool &stopAutomatic)
#event forwardAutomaticChanged(const bool &forwardAutomatic)
#event reverseAutomaticChanged(const bool &reverseAutomatic)
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

  public float getRpmScaleMin()
  {
    return _rpmScaleMin;
  }

  public float getRpmScaleMax()
  {
    return _rpmScaleMax;
  }

  public float getRpmMin()
  {
    return _rpmMin;
  }

  public float getRpmMax()
  {
    return _rpmMax;
  }

  public float getRpmManual()
  {
    return _rpmManual;
  }

  public float getRpmInternal()
  {
    return _rpmInternal;
  }

  public float getRpmReadback()
  {
    return _rpmReadback;
  }

  public float getRpm()
  {
    return _rpm;
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

  public bool getRpmFeedbackSource()
  {
    return _rpmFeedbackSource;
  }

  public float getRpmFeedbackSignal()
  {
    return _rpmFeedbackSignal;
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

  public float getRpmError()
  {
    return _rpmError;
  }

  public bool getRpmAlarmHighEnabled()
  {
    return _rpmAlarmHighEnabled;
  }

  public bool getRpmAlarmLowEnabled()
  {
    return _rpmAlarmLowEnabled;
  }

  public bool getRpmAlarmHighActive()
  {
    return _rpmAlarmHighActive;
  }

  public bool getRpmAlarmLowActive()
  {
    return _rpmAlarmLowActive;
  }

  public float getRpmAlarmHighLimit()
  {
    return _rpmAlarmHighLimit;
  }

  public float getRpmAlarmLowLimit()
  {
    return _rpmAlarmLowLimit;
  }

  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

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

  public shared_ptr<MtpSource> getSource()
  {
    return _source;
  }

  public shared_ptr<MtpUnit> getRpmUnit()
  {
    return _rpmUnit;
  }

  public void setRpmAlarmHighLimit(const float &rpmAlarmHighLimit)
  {
    _rpmAlarmHighLimit = rpmAlarmHighLimit;
    dpSet(getDp() + ".RpmAHLim", _rpmAlarmHighLimit);
  }

  public void setRpmAlarmLowLimit(const float &rpmAlarmLowLimit)
  {
    _rpmAlarmLowLimit = rpmAlarmLowLimit;
    dpSet(getDp() + ".RpmALLim", _rpmAlarmLowLimit);
  }

  public void setRpmManual(const float &rpmManual)
  {
    _rpmManual = rpmManual;
    dpSet(getDp() + ".RpmMan", _rpmManual);
  }

  public void setStopOperator(const bool &stopOperator)
  {
    _stopOperator = stopOperator;
    dpSet(getDp() + ".StopOp", _stopOperator);
  }

  public void setForwardOperator(const bool &forwardOperator)
  {
    _forwardOperator = forwardOperator;
    dpSet(getDp() + ".FwdOp", _forwardOperator);
  }

  public void setReverseOperator(const bool &reverseOperator)
  {
    _reverseOperator = reverseOperator;
    dpSet(getDp() + ".RevOp", _reverseOperator);
  }

  public void setResetOperator(const bool &resetOperator)
  {
    _resetOperator = resetOperator;
    dpSet(getDp() + ".ResetOp", _resetOperator);
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

  private void setRpmFeedbackSignalCB(const string &dpe, const float &rpmFeedbackSignal)
  {
    _rpmFeedbackSignal = rpmFeedbackSignal;
    rpmFeedbackSignalChanged(_rpmFeedbackSignal);
  }

  private void setRpmCB(const string &dpe, const float &rpm)
  {
    _rpm = rpm;
    rpmChanged(_rpm);
  }

  private void setDriveSafetyIndicatorCB(const string &dpe, const bool &driveSafetyIndicator)
  {
    _driveSafetyIndicator = driveSafetyIndicator;
    driveSafetyIndicatorChanged(_driveSafetyIndicator);
  }

  private void setRpmAlarmHighActiveCB(const string &dpe, const bool &enabled)
  {
    _rpmAlarmHighActive = enabled;
    rpmAlarmHighActiveChanged(_rpmAlarmHighActive);
  }

  private void setRpmAlarmLowActiveCB(const string &dpe, const bool &enabled)
  {
    _rpmAlarmLowActive = enabled;
    rpmAlarmLowActiveChanged(_rpmAlarmLowActive);
  }

  private void setSafetyPositionActiveCB(const string &dpe, const bool &active)
  {
    _safetypositionActive = active;
    safetyPositionActiveChanged(_safetypositionActive);
  }

  private void setRpmErrorCB(const string &dpe, const float &error)
  {
    _rpmError = error;
    rpmErrorChanged(_rpmError);
  }

  private void setStopAutomaticCB(const string &dpe, const bool &stopAutomatic)
  {
    _stopAutomatic = stopAutomatic;
    stopAutomaticChanged(_stopAutomatic);
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

  private void setSafetyPositionCB(const string &dpe, const bool &safetyPosition)
  {
    _safetyposition = safetyPosition;
    safetyPositionChanged(_safetyposition);
  }

  private void setResetAutomaticCB(const string &dpe, const bool &resetAutomatic)
  {
    _resetAutomatic = resetAutomatic;
    resetAutomaticChanged(_resetAutomatic);
  }

  private void setRpmInternalCB(const string &dpe, const float &rpmInternal)
  {
    _rpmInternal = rpmInternal;
    rpmInternalChanged(_rpmInternal);
  }
};
