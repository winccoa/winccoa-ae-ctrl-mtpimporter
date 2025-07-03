// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpBarIndicator/MtpBarIndicator"
#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/AnaMon/AnaMon"
#uses "classes/MtpView/MtpViewBase"

class AnaMonFaceplateHome : MtpViewBase
{
  private shape _refWqc;
  private shape _rectLimitHigh;
  private shape _rectLimitLow;
  private shape _txtLimitHigh;
  private shape _txtLimitLow;

  private bool _alertHighActive;
  private bool _warningHighActive;
  private bool _toleranceHighActive;
  private bool _toleranceLowActive;
  private bool _warningLowActive;
  private bool _alertLowActive;

  private shared_ptr<MtpBarIndicator> _barIndicator;

  public AnaMonFaceplateHome(shared_ptr<AnaMon> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setValueCB, MtpViewBase::getViewModel(), AnaMon::valueChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnectUserData(this, setStatusHighCB, "_alertHighActive", MtpViewBase::getViewModel().getAlertHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusHighCB, "_warningHighActive", MtpViewBase::getViewModel().getWarningHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusHighCB, "_toleranceHighActive", MtpViewBase::getViewModel().getToleranceHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_toleranceLowActive", MtpViewBase::getViewModel().getToleranceLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_warningLowActive", MtpViewBase::getViewModel().getWarningLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_alertLowActive", MtpViewBase::getViewModel().getAlertLowLimit(), MtpValueLimitFloat::activeChanged);

    _alertHighActive = MtpViewBase::getViewModel().getAlertHighLimit().getActive();
    _warningHighActive = MtpViewBase::getViewModel().getWarningHighLimit().getActive();
    _toleranceHighActive = MtpViewBase::getViewModel().getToleranceHighLimit().getActive();
    _toleranceLowActive = MtpViewBase::getViewModel().getToleranceLowLimit().getActive();
    _warningLowActive = MtpViewBase::getViewModel().getWarningLowLimit().getActive();
    _alertLowActive = MtpViewBase::getViewModel().getAlertLowLimit().getActive();

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setStatusHighCB("_alertHighActive", MtpViewBase::getViewModel().getAlertHighLimit().getActive());
    setStatusLowCB("_alertLowActive", MtpViewBase::getViewModel().getAlertLowLimit().getActive());

    _barIndicator.setScale(MtpViewBase::getViewModel().getValueScaleMin(), MtpViewBase::getViewModel().getValueScaleMax());
    _barIndicator.setUnit(MtpViewBase::getViewModel().getUnit());

    _barIndicator.setAlertHighShape(MtpViewBase::getViewModel().getAlertHighLimit().getEnabled(), MtpViewBase::getViewModel().getAlertHighLimit().getLimit());
    _barIndicator.setWarningHighShape(MtpViewBase::getViewModel().getWarningHighLimit().getEnabled(), MtpViewBase::getViewModel().getWarningHighLimit().getLimit());
    _barIndicator.setToleranceHighShape(MtpViewBase::getViewModel().getToleranceHighLimit().getEnabled(), MtpViewBase::getViewModel().getToleranceHighLimit().getLimit());

    _barIndicator.setAlertLowShape(MtpViewBase::getViewModel().getAlertLowLimit().getEnabled(), MtpViewBase::getViewModel().getAlertLowLimit().getLimit());
    _barIndicator.setWarningLowShape(MtpViewBase::getViewModel().getWarningLowLimit().getEnabled(), MtpViewBase::getViewModel().getWarningLowLimit().getLimit());
    _barIndicator.setToleranceLowShape(MtpViewBase::getViewModel().getToleranceLowLimit().getEnabled(), MtpViewBase::getViewModel().getToleranceLowLimit().getLimit());

    setValueCB(MtpViewBase::getViewModel().getValue());
  }

  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectLimitHigh = MtpViewBase::extractShape("_rectLimitHigh");
    _rectLimitLow = MtpViewBase::extractShape("_rectLimitLow");
    _txtLimitHigh = MtpViewBase::extractShape("_txtLimitHigh");
    _txtLimitLow = MtpViewBase::extractShape("_txtLimitLow");

    _barIndicator = MtpViewBase::extractShape("_barIndicator").getMtpBarIndicator();
  }

  private void setValueCB(const float &value)
  {
    _barIndicator.setValue(value);
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  private void setStatusHighCB(const string &varName, const bool &active)
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
    }

    if (_alertHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(30, 25);
      _txtLimitHigh.text = "Alarm hoch";
      return;
    }

    if (_warningHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Mainenance_2.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text = "Warnung hoch";
      return;
    }

    if (_toleranceHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Tolerance_2.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text = "Toleranz hoch";
      return;
    }

    _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
    _rectLimitHigh.sizeAsDyn = makeDynInt(30, 25);
    _txtLimitHigh.text = "Grenze hoch";

  }

  private void setStatusLowCB(const string &varName, const bool &active)
  {
    switch (varName)
    {
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

    if (_alertLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(30, 25);
      _txtLimitLow.text = "Alarm niedrig";
      return;
    }

    if (_warningLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Mainenance_2.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = "Warnung niedrig";
      return;
    }

    if (_toleranceLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Tolerance_2.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = "Toleranz niedrig";
      return;
    }

    _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
    _rectLimitLow.sizeAsDyn = makeDynInt(30, 25);
    _txtLimitLow.text = "Grenze niedrig";
  }
};
