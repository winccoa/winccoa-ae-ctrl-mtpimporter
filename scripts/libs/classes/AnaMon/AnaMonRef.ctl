// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpView/MtpViewBase"

class AnaMonRef : MtpViewBase
{
  private shape _txtValue;
  private shape _txtUnit;
  private shape _rectStatus;
  private bool _alertHighActive;
  private bool _warningHighActive;
  private bool _toleranceHighActive;
  private bool _toleranceLowActive;
  private bool _warningLowActive;
  private bool _alertLowActive;

  public AnaMonRef(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setStatusCB, "_alertHighActive", MtpViewBase::getViewModel().getAlertHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_warningHighActive", MtpViewBase::getViewModel().getWarningHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_toleranceHighActive", MtpViewBase::getViewModel().getToleranceHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_toleranceLowActive", MtpViewBase::getViewModel().getToleranceLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_warningLowActive", MtpViewBase::getViewModel().getWarningLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_alertLowActive", MtpViewBase::getViewModel().getAlertLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnect(this, setValueCB, MtpViewBase::getViewModel().getValue(), AnaMon::valueChanged);

    _alertHighActive = MtpViewBase::getViewModel().getAlertHighLimit().getActive();
    _warningHighActive = MtpViewBase::getViewModel().getWarningHighLimit().getActive();
    _toleranceHighActive = MtpViewBase::getViewModel().getToleranceHighLimit().getActive();
    _toleranceLowActive = MtpViewBase::getViewModel().getToleranceLowLimit().getActive();
    _warningLowActive = MtpViewBase::getViewModel().getWarningLowLimit().getActive();

    setStatusCB("_alertLowActive", MtpViewBase::getViewModel().getAlertLowLimit().getActive());
    setUnit(MtpViewBase::getViewModel().getUnit());
    setValueCB(MtpViewBase::getViewModel().getValue());
  }

  public void openFaceplate()
  {
    // TODO.
  }

  protected void initializeShapes()
  {
    _txtValue = MtpViewBase::extractShape("_txtValue");
    _txtUnit = MtpViewBase::extractShape("_txtUnit");
    _rectStatus = MtpViewBase::extractShape("_rectStatus");
  }

  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtUnit.text = unit.toString();
  }

  private void setValueCB(const float &value)
  {
    _txtValue.text = value;
  }

  private void setStatusCB(const string &varName, const bool &active)
  {
    switch (varName)
    {
      case "_alertHighActive":
        _alertHighActive = active;
        break;

      case "_warningHighActive":
        _warningHighActive = active;
        break;

      case "_toleranceHighActive":
        _toleranceHighActive = active;
        break;

      case "_toleranceLowActive":
        _toleranceLowActive = active;
        break;

      case "_warningLowActive":
        _warningLowActive = active;
        break;

      case "_alertLowActive":
        _alertLowActive = active;
        break;
    }

    if (_alertHighActive || _alertLowActive)
    {
      // TODO.
      return;
    }

    if (_warningHighActive || _warningLowActive)
    {
      // TODO.
      return;
    }

    if (_toleranceHighActive || _toleranceLowActive)
    {
      // TODO.
      return;
    }

    // TODO.
  }
};
