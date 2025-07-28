// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpState/MtpState"
#uses "classes/PIDCtrl/PIDCtrl"
#uses "classes/MtpView/MtpViewBase"

class PIDCtrlFaceplateHome : MtpViewBase
{
  private shape _refWqc;
  private shape _rectAutomatic;
  private shape _rectError;
  private shape _rectInternal;
  private shape _rectManual;
  private shape _rectOff;
  private shape _rectOperator;
  private shape _txtError;
  private shape _txtMV;
  private shape _txtPV;
  private shape _txtSP;
  private shape _txtUnitMV;
  private shape _txtUnitPV;
  private shape _txtUnitSP;
  private shape _txtSPInternal;
  private shape _txtSPManual;
  private shape _rectPvViolated;
  private shape _rectSpViolated;
  private shape _rectMvViolated;

  private bool _stateAutomaticActive;
  private bool _stateOperatorActive;

  private bool _manualActive;
  private bool _internalActive;
  private bool _channel;

  private bool _stateOffActive;
  private bool _stateChannel;
  private bool _osLevelStation;

  private float _pv;
  private bool _pvLimitViolated;
  private float _pvSclMin;
  private float _pvSclMax;

  private float _sp;
  private bool _spLimitViolated;
  private float _spSclMin;
  private float _spSclMax;

  private float _mv;
  private bool _mvLimitViolated;
  private float _mvSclMin;
  private float _mvSclMax;

  public PIDCtrlFaceplateHome(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setProcessValueCB, MtpViewBase::getViewModel(), PIDCtrl::processValueChanged);
    classConnect(this, setSetpointCB, MtpViewBase::getViewModel(), PIDCtrl::setpointChanged);
    classConnect(this, setManipulatedValueCB, MtpViewBase::getViewModel(), PIDCtrl::manipulatedValueChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setSetpointInternalCB, MtpViewBase::getViewModel(), PIDCtrl::setpointInternalChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    classConnect(this, setSetpointManualCB, MtpViewBase::getViewModel(), PIDCtrl::setpointManualChanged);

    classConnectUserData(this, setProcessValueScaleCB, "min", MtpViewBase::getViewModel(), PIDCtrl::processValueScaleMinChanged);
    classConnectUserData(this, setProcessValueScaleCB, "max", MtpViewBase::getViewModel(), PIDCtrl::processValueScaleMaxChanged);
    classConnectUserData(this, setSetpointValueScaleCB, "min", MtpViewBase::getViewModel(), PIDCtrl::setpointScaleMinChanged);
    classConnectUserData(this, setSetpointValueScaleCB, "max", MtpViewBase::getViewModel(), PIDCtrl::setpointScaleMaxChanged);
    classConnectUserData(this, setManipulatedValueScaleCB, "min", MtpViewBase::getViewModel(), PIDCtrl::manipulatedValueScaleMinChanged);
    classConnectUserData(this, setManipulatedValueScaleCB, "max", MtpViewBase::getViewModel(), PIDCtrl::manipulatedValueScaleMaxChanged);

    classConnectUserData(this, setStateCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setStateCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);

    //Buttons:
    classConnectUserData(this, setManualActiveCB, "_manualActive", MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);
    classConnectUserData(this, setInternalActiveCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MtpViewBase::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    _stateOffActive =  MtpViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MtpViewBase::getViewModel().getState().getChannel();
    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();
    _stateOperatorActive = MtpViewBase::getViewModel().getState().getOperatorActive();

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();

    _pvSclMin =  MtpViewBase::getViewModel().getProcessValueScaleMin();
    _pvSclMax =  MtpViewBase::getViewModel().getProcessValueScaleMax();
    _pv = MtpViewBase::getViewModel().getProcessValue();

    _spSclMin =  MtpViewBase::getViewModel().getSetpointScaleMin();
    _spSclMax =  MtpViewBase::getViewModel().getSetpointScaleMax();
    _sp = MtpViewBase::getViewModel().getSetpoint();

    _mvSclMin =  MtpViewBase::getViewModel().getManipulatedValueScaleMin();
    _mvSclMax =  MtpViewBase::getViewModel().getManipulatedValueScaleMax();
    _mv = MtpViewBase::getViewModel().getManipulatedValue();

    setUnit(MtpViewBase::getViewModel().getProcessValueUnit(), MtpViewBase::getViewModel().getSetpointUnit(), MtpViewBase::getViewModel().getManipulatedValueUnit());

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setProcessValueCB(MtpViewBase::getViewModel().getProcessValue());
    setSetpointCB(MtpViewBase::getViewModel().getSetpoint());
    setManipulatedValueCB(MtpViewBase::getViewModel().getManipulatedValue());
    setStateCB("_stateAutomaticActive", _stateAutomaticActive);
    setSetpointInternalCB(MtpViewBase::getViewModel().getSetpointInternal());
    setSetpointManualCB(MtpViewBase::getViewModel().getSetpointManual());
    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());

    setProcessValueScaleCB("min", _pvSclMin);
    setSetpointValueScaleCB("min", _spSclMin);
    setManipulatedValueScaleCB("min", _mvSclMin);
  }

  public void setProcessValue(const float &value)
  {
    MtpViewBase::getViewModel().setProcessValue(value);
  }

  public void setSetpoint(const float &value)
  {
    MtpViewBase::getViewModel().setSetpoint(value);
  }

  public void setManipulatedValue(const float &value)
  {
    MtpViewBase::getViewModel().setManipulatedValueManual(value);
  }

  public void setSetpointManual(const float &setpointManual)
  {
    MtpViewBase::getViewModel().setSetpointManual(setpointManual);
  }

  public void activateManual()
  {
    MtpViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  public void activateInternal()
  {
    MtpViewBase::getViewModel().getSource().setInternalOperator(TRUE);
  }

  public void activateStateOff()
  {
    MtpViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  public void activateStateOperator()
  {
    MtpViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  public void activateStateAutomatic()
  {
    MtpViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtMV = MtpViewBase::extractShape("_txtMV");
    _txtPV = MtpViewBase::extractShape("_txtPV");
    _txtSP = MtpViewBase::extractShape("_txtSP");
    _txtUnitMV = MtpViewBase::extractShape("_txtUnitMV");
    _txtUnitPV = MtpViewBase::extractShape("_txtUnitPV");
    _txtUnitSP = MtpViewBase::extractShape("_txtUnitSP");
    _txtSPInternal = MtpViewBase::extractShape("_txtSPInternal");
    _txtSPManual = MtpViewBase::extractShape("_txtSPManual");
    _rectPvViolated = MtpViewBase::extractShape("_rectPvViolated");
    _rectSpViolated = MtpViewBase::extractShape("_rectSpViolated");
    _rectMvViolated = MtpViewBase::extractShape("_rectMvViolated");
  }

  private void setUnit(MtpUnit pvUnit, MtpUnit spUnit, MtpUnit mvUnit)
  {
    _txtUnitMV.text = getCatStr("PIDCtrl", "MV") + " [" + mvUnit.toString() + "]";
    _txtUnitPV.text = getCatStr("PIDCtrl", "PV") + " [" + pvUnit.toString() + "]";
    _txtUnitSP.text = getCatStr("PIDCtrl", "SP") + " [" + spUnit.toString() + "]";
  }

  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setStateOffActiveCB("", FALSE);
    setOperatorActiveCB("", FALSE);
    setAutomaticActiveCB("", FALSE);
    setInternalActiveCB("", FALSE);
    setManualActiveCB("", FALSE);
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  private void setProcessValueCB(const float &value)
  {
    _pv = value;
    _txtPV.text = value;
    setProcessValueScaleCB("min", _pvSclMin);
  }

  private void setProcessValueScaleCB(const string &varName, const float &value)
  {
    switch (varName)
    {
      case "min":
        _pvSclMin = value;
        break;

      case "max":
        _pvSclMax = value;
        break;
    }

    if (_pv < _pvSclMin || _pv > _pvSclMax)
    {
      _pvLimitViolated = TRUE;
      _rectPvViolated.visible = TRUE;
      errorShow();
    }
    else
    {
      _pvLimitViolated = FALSE;
      _rectPvViolated.visible = FALSE;
      errorShow();
    }
  }

  private void errorShow()
  {
    if (_pvLimitViolated)
    {
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
    }
    else
    {
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
    }
  }

  private void setSetpointCB(const float &value)
  {
    _txtSP.text = value;
    _sp = value;
    setSetpointValueScaleCB("min", _spSclMin);
  }

  private void setSetpointValueScaleCB(const string &varName, const float &value)
  {
    switch (varName)
    {
      case "min":
        _spSclMin = value;
        break;

      case "max":
        _spSclMax = value;
        break;
    }

    if (_sp < _spSclMin || _sp > _spSclMax)
    {
      _spLimitViolated = TRUE;
      _rectSpViolated.visible = TRUE;
      errorShow();
    }
    else
    {
      _spLimitViolated = FALSE;
      _rectSpViolated.visible = FALSE;
      errorShow();
    }
  }

  private void setManipulatedValueCB(const float &value)
  {
    if (_stateAutomaticActive)
    {
      _txtMV.text = value;
    }

    _mv = value;
    setManipulatedValueScaleCB("min", _mvSclMin);
  }

  private void setManipulatedValueScaleCB(const string &varName, const float &value)
  {
    switch (varName)
    {
      case "min":
        _mvSclMin = value;
        break;

      case "max":
        _mvSclMax = value;
        break;
    }

    if (_mv < _mvSclMin || _mv > _mvSclMax)
    {
      _mvLimitViolated = TRUE;
      _rectMvViolated.visible = TRUE;
      errorShow();
    }
    else
    {
      _mvLimitViolated = FALSE;
      _rectMvViolated.visible = FALSE;
      errorShow();
    }
  }

  private void setSetpointInternalCB(const float &value)
  {
    _txtSPInternal.text = value;
  }

  private void setSetpointManualCB(const float &value)
  {
    _txtSPManual.text = value;
  }

  private void setAutomaticActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if ((_stateAutomaticActive && _stateChannel) || (!_stateChannel && _stateAutomaticActive && !_osLevelStation))
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]";
    }
    else if (_stateAutomaticActive && !_stateChannel && _osLevelStation)
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_2_rounded.svg]]";
    }
    else
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_3_rounded.svg]]";
    }

    _rectAutomatic.transparentForMouse = (_rectAutomatic.fill == "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]");
  }


  private void setOperatorActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if ((_stateOperatorActive && _stateChannel) || (!_stateChannel && _stateOperatorActive && !_osLevelStation))
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_1_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_stateChannel && _osLevelStation)
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_2_rounded.svg]]";
    }
    else
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_3_rounded.svg]]";
    }

    _rectOperator.transparentForMouse = (_rectOperator.fill == "[pattern,[fit,any,MTP_Icones/Operator_1_rounded.svg]]");
  }

  private void setStateOffActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOffActive":
        _stateOffActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if ((_stateOffActive && _stateChannel) || (!_stateChannel && _stateOffActive && !_osLevelStation))
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]";
    }
    else if (_stateOffActive && !_stateChannel && _osLevelStation)
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_3_rounded.svg]]";
    }
    else
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_1_rounded.svg]]";
    }

    _rectOff.transparentForMouse = (_rectOff.fill == "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]");
  }


  private void setInternalActiveCB(const string &varName, const bool &internalActive)
  {
    switch (varName)
    {
      case "_internalActive":
        _internalActive = internalActive;
        break;

      case "_channel":
        _channel = internalActive;
        break;
    }

    if ((_internalActive && _channel) || (!_osLevelStation && !_channel && _internalActive))
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]";
    }
    else if (_internalActive && !_channel && _osLevelStation)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_2_rounded.svg]]";
    }
    else
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_3_rounded.svg]]";
    }

    _rectInternal.transparentForMouse = (_rectInternal.fill == "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]");
  }

  private void setManualActiveCB(const string &varName, const bool &manualActive)
  {
    switch (varName)
    {
      case "_manualActive":
        _manualActive = manualActive;
        break;

      case "_channel":
        _channel = manualActive;
        break;
    }

    if ((_manualActive && _channel) || (!_osLevelStation && !_channel && _manualActive))
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
    }
    else if (_manualActive && !_channel && _osLevelStation)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]");
  }

  private void setStateCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;
    }

    if (_stateOperatorActive)
    {
      _txtMV.editable = TRUE;
      _txtMV.text = MtpViewBase::getViewModel().getManipulatedValueManual();
    }
    else
    {
      _txtMV.editable = FALSE;
      _txtMV.text = MtpViewBase::getViewModel().getManipulatedValue();
    }
  }
};
