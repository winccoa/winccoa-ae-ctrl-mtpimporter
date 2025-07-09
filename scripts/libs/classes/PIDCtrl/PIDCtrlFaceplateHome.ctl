// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

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

  private bool _stateAutomaticActive;
  private bool _stateOperatorActive;

  public PIDCtrlFaceplateHome(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setProcessValueCB, MtpViewBase::getViewModel(), PIDCtrl::processValueChanged);
    classConnect(this, setSetpointCB, MtpViewBase::getViewModel(), PIDCtrl::setpointChanged);
    classConnect(this, setManipulatedValueCB, MtpViewBase::getViewModel(), PIDCtrl::manipulatedValueChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setSetpointInternalCB, MtpViewBase::getViewModel(), PIDCtrl::setpointInternalChanged);

    classConnectUserData(this, setStateCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setStateCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);

    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();
    _stateOperatorActive = MtpViewBase::getViewModel().getState().getOperatorActive();

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setProcessValueCB(MtpViewBase::getViewModel().getProcessValue());
    setSetpointCB(MtpViewBase::getViewModel().getSetpoint());
    setManipulatedValueCB(MtpViewBase::getViewModel().getManipulatedValue());
    setStateCB("_stateAutomaticActive", _stateAutomaticActive);
    setSetpointInternalCB(MtpViewBase::getViewModel().getSetpointInternal());
    setSetpointManualText(MtpViewBase::getViewModel().getSetpointManual());
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
    MtpViewBase::getViewModel().setManipulatedValue(value);
  }

  public void setSetpointManual(const float &setpointManual)
  {
    MtpViewBase::getViewModel().setSetpointManual(setpointManual);
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
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  private void setProcessValueCB(const float &value)
  {
    _txtPV.text = value;
  }

  private void setSetpointCB(const float &value)
  {
    _txtSP.text = value;
  }

  private void setManipulatedValueCB(const float &value)
  {
    _txtMV.text = value;
  }

  private void setSetpointInternalCB(const float &value)
  {
    _txtSPInternal.text = value;
  }

  private void setSetpointManualText(const float &value)
  {
    _txtSPManual.text = value;
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

    if (_stateAutomaticActive)
    {
      _txtMV.editable = FALSE;
      return;
    }
    else if (_stateOperatorActive)
    {
      _txtMV.editable = TRUE;
      return;
    }
  }
};
