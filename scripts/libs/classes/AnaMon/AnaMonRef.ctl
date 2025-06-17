// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpView/MtpViewRef"
#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpUnit/MtpUnit"

class AnaMonRef : MtpViewRef
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

  public AnaMonRef(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnectUserData(this, setStatusCB, "_alertHighActive", MtpViewRef::getViewModel().getAlertHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_warningHighActive", MtpViewRef::getViewModel().getWarningHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_toleranceHighActive", MtpViewRef::getViewModel().getToleranceHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_toleranceLowActive", MtpViewRef::getViewModel().getToleranceLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_warningLowActive", MtpViewRef::getViewModel().getWarningLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_alertLowActive", MtpViewRef::getViewModel().getAlertLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnect(this, setValueCB, MtpViewRef::getViewModel().getValue(), AnaMon::valueChanged);

    _alertHighActive = MtpViewRef::getViewModel().getAlertHighLimit().getActive();
    _warningHighActive = MtpViewRef::getViewModel().getWarningHighLimit().getActive();
    _toleranceHighActive = MtpViewRef::getViewModel().getToleranceHighLimit().getActive();
    _toleranceLowActive = MtpViewRef::getViewModel().getToleranceLowLimit().getActive();
    _warningLowActive = MtpViewRef::getViewModel().getWarningLowLimit().getActive();

    setStatusCB("_alertLowActive", MtpViewRef::getViewModel().getAlertLowLimit().getActive());
    setUnit(MtpViewRef::getViewModel().getUnit());
    setValueCB(MtpViewRef::getViewModel().getValue());
  }

  protected void initializeShapes() override
  {
    _txtValue = MtpViewRef::extractShape("_txtValue");
    _txtUnit = MtpViewRef::extractShape("_txtUnit");
    _rectStatus = MtpViewRef::extractShape("_rectStatus");
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
