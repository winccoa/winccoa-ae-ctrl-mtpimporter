// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/PIDCtrl/PIDCtrl"
#uses "classes/MtpView/MtpViewRef"

class PIDCtrlRef : MtpViewRef
{
  private shape _rectError;
  private shape _rectMode;
  private shape _rectSource;
  private shape _rectLimits;

  private shape _txtUnitPV;
  private shape _txtUnitSP;
  private shape _txtProcessValue;
  private shape _txtSetpoint;

  private bool _sourceManualActive;
  private bool _sourceInternalActive;

  private bool _stateOffActive;
  private bool _stateOperatorActive;

  public PIDCtrlRef(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setProcessValueCB, MtpViewRef::getViewModel(), PIDCtrl::processValueChanged);
    classConnect(this, setSetpointCB, MtpViewRef::getViewModel(), PIDCtrl::setpointChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MtpViewRef::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MtpViewRef::getViewModel().getState(), MtpState::operatorActiveChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MtpViewRef::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MtpViewRef::getViewModel().getSource(), MtpSource::internalActiveChanged);

    _stateOffActive =  MtpViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MtpViewRef::getViewModel().getState().getOperatorActive();
    _sourceManualActive = MtpViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MtpViewRef::getViewModel().getSource().getInternalActive();

    setProcessValueCB(MtpViewRef::getViewModel().getProcessValue());
    setSetpointCB(MtpViewRef::getViewModel().getSetpoint());

    setUnitPV(MtpViewRef::getViewModel().getProcessValueUnit());
    setUnitSP(MtpViewRef::getViewModel().getSetpointUnit());
    setModeCB("_stateOffActive", _stateOffActive);
    setSourceCB("_sourceManualActive", _sourceManualActive);
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  * @details This method overrides the base class method to extract the shapes.
  */
  protected void initializeShapes() override
  {
    _rectError = MtpViewRef::extractShape("_rectError");
    _rectLimits = MtpViewRef::extractShape("_rectLimits");
    _rectMode = MtpViewRef::extractShape("_rectMode");
    _rectSource = MtpViewRef::extractShape("_rectSource");
    _txtUnitPV = MtpViewRef::extractShape("_txtUnitPV");
    _txtUnitSP = MtpViewRef::extractShape("_txtUnitSP");
    _txtProcessValue = MtpViewRef::extractShape("_txtProcessValue");
    _txtSetpoint = MtpViewRef::extractShape("_txtSetpoint");
  }

  private void setUnitPV(shared_ptr<MtpUnit> unit)
  {
    _txtUnitPV.text = unit.toString();
  }

  private void setUnitSP(shared_ptr<MtpUnit> unit)
  {
    _txtUnitSP.text = unit.toString();
  }

  private void setProcessValueCB(const float &pv)
  {
    _txtProcessValue.text = pv;
  }

  private void setSetpointCB(const float &sp)
  {
    _txtSetpoint.text = sp;
  }

  private void setModeCB(const string &varName, const bool &mode)
  {
    switch (varName)
    {
      case "_stateOffActive":
        _stateOffActive = mode;
        break;

      case "_stateOperatorActive":
        _stateOperatorActive = mode;
        break;
    }

    if (_stateOffActive)
    {
      _rectMode.fill = "[pattern,[tile,any,MTP_Icones/Power.svg]]";
      _rectMode.visible = TRUE;
      return;
    }
    else if (_stateOperatorActive)
    {
      _rectMode.fill = "[pattern,[tile,any,MTP_Icones/Manual_1.svg]]";
      _rectMode.visible = TRUE;
    }
    else
    {
      _rectMode.visible = FALSE;
    }
  }

  private void setSourceCB(const string &varName, const bool &source)
  {
    switch (varName)
    {
      case "_sourceManualActive":
        _sourceManualActive = source;
        break;

      case "_sourceInternalActive":
        _sourceInternalActive = source;
        break;
    }

    if (_sourceManualActive)
    {
      _rectSource.fill = "[pattern,[tile,any,MTP_Icones/Manual__2.svg]]";
      _rectSource.visible = TRUE;
      return;
    }
    else if (_sourceInternalActive)
    {
      _rectSource.fill = "[pattern,[tile,any,MTP_Icones/internal.svg]]";
      _rectSource.visible = TRUE;
    }
    else
    {
      _rectSource.visible = FALSE;
    }
  }
};
