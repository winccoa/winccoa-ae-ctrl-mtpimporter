// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/AnaMon/AnaMon"
#uses "classes/MtpView/MtpViewBase"

class AnaMonFaceplateHome : MtpViewBase
{
  private shape _txtValue;
  private shape _txtUnit;
  private shape _refWqc;
  private shape _rectLimitHigh;
  private shape _rectLimitLow;
  private shape _txtLimitHigh;
  private shape _txtLimitLow;

  private shape _body1;
  private shape _circleAH1;
  private shape _circleAL1;
  private shape _circlePV1;
  private shape _circleTH1;
  private shape _circleTL1;
  private shape _circleWH1;
  private shape _circleWL1;

  private shape _body;
  private shape _circlePV;
  private shape _circleValue;
  private shape _pvPointer;

  private shape _txtHalfMax;
  private shape _txtMax;

  private bool _alertHighActive;
  private bool _warningHighActive;
  private bool _toleranceHighActive;
  private bool _toleranceLowActive;
  private bool _warningLowActive;
  private bool _alertLowActive;

  private float _ahLimit;
  private float _alLimit;
  private float _whLimit;
  private float _wlLimit;
  private float _thLimit;
  private float _tlLimit;
  private bool _ahEnabled;
  private bool _alEnabled;
  private bool _whEnabled;
  private bool _wlEnabled;
  private bool _thEnabled;
  private bool _tlEnabled;
  private float _minV;
  private float _maxV;
  private string _unit;

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

    _ahLimit = MtpViewBase::getViewModel().getAlertHighLimit().getLimit();
    _alLimit = MtpViewBase::getViewModel().getAlertLowLimit().getLimit();
    _whLimit = MtpViewBase::getViewModel().getWarningHighLimit().getLimit();
    _wlLimit = MtpViewBase::getViewModel().getWarningLowLimit().getLimit();
    _thLimit = MtpViewBase::getViewModel().getToleranceHighLimit().getLimit();
    _tlLimit = MtpViewBase::getViewModel().getToleranceLowLimit().getLimit();

    _ahEnabled = MtpViewBase::getViewModel().getAlertHighLimit().getEnabled();
    _alEnabled = MtpViewBase::getViewModel().getAlertLowLimit().getEnabled();
    _whEnabled = MtpViewBase::getViewModel().getWarningHighLimit().getEnabled();
    _wlEnabled = MtpViewBase::getViewModel().getWarningLowLimit().getEnabled();
    _thEnabled = MtpViewBase::getViewModel().getToleranceHighLimit().getEnabled();
    _tlEnabled = MtpViewBase::getViewModel().getToleranceLowLimit().getEnabled();

    _minV = MtpViewBase::getViewModel().getValueScaleMin();
    _maxV = MtpViewBase::getViewModel().getValueScaleMax();
    _unit = MtpViewBase::getViewModel().getUnit().toString();

    setUnit(MtpViewBase::getViewModel().getUnit());
    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setValueCB(MtpViewBase::getViewModel().getValue());
    setStatusHighCB("_alertHighActive", MtpViewBase::getViewModel().getAlertHighLimit().getActive());
    setStatusLowCB("_alertLowActive", MtpViewBase::getViewModel().getAlertLowLimit().getActive());

    setScaleTexts(MtpViewBase::getViewModel().getValueScaleMax());

    updateBars();
  }

  protected void initializeShapes()
  {
    _txtValue = MtpViewBase::extractShape("_txtValue");
    _txtUnit = MtpViewBase::extractShape("_txtUnit");
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectLimitHigh = MtpViewBase::extractShape("_rectLimitHigh");
    _rectLimitLow = MtpViewBase::extractShape("_rectLimitLow");
    _txtLimitHigh = MtpViewBase::extractShape("_txtLimitHigh");
    _txtLimitLow = MtpViewBase::extractShape("_txtLimitLow");

    _body1 = MtpViewBase::extractShape("_body1");
    _circleAH1 = MtpViewBase::extractShape("_circleAH1");
    _circleAL1 = MtpViewBase::extractShape("_circleAL1");
    _circlePV1 = MtpViewBase::extractShape("_circlePV1");
    _circleTH1 = MtpViewBase::extractShape("_circleTH1");
    _circleTL1 = MtpViewBase::extractShape("_circleTL1");
    _circleWH1 = MtpViewBase::extractShape("_circleWH1");
    _circleWL1 = MtpViewBase::extractShape("_circleWL1");

    _body = MtpViewBase::extractShape("_body");
    _circlePV = MtpViewBase::extractShape("_circlePV");
    _circleValue = MtpViewBase::extractShape("_circleValue");
    _pvPointer = MtpViewBase::extractShape("_pvPointer");

    _txtHalfMax = MtpViewBase::extractShape("_txtHalfMax");
    _txtMax = MtpViewBase::extractShape("_txtMax");
  }

  private void setValueCB(const float &value)
  {
    _txtValue.text = value;

    float clampedValue = value;

    if (clampedValue < _minV)
      clampedValue = _minV;

    if (clampedValue > _maxV)
      clampedValue = _maxV;

    _circlePV.angle2 = 180;
    _circleValue.angle2 = 180;
    _circleValue.angle1 = (_maxV != _minV) ? ((calculateCircleDeg(clampedValue, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(clampedValue, _minV, _maxV)) : 180;

    if ((_ahEnabled && value >= _ahLimit) || (_alEnabled && value <= _alLimit))
    {
      _circleValue.backCol = "mtpRed";
    }
    else if ((_whEnabled && value >= _whLimit) || (_wlEnabled && value <= _wlLimit))
    {
      _circleValue.backCol = "mtpYellow";
    }
    else if ((_thEnabled && value >= _thLimit) || (_tlEnabled && value <= _tlLimit))
    {
      _circleValue.backCol = "mtpSidebar";
    }
    else
    {
      _circleValue.backCol = "mtpGreen";
    }

    _pvPointer.rotation = (calculatePvDeg(value, _minV, _maxV) < 180) ? 180 : calculatePvDeg(value, _minV, _maxV);
  }


  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtUnit.text = unit.toString();
  }

  private void setScaleTexts(const float &scaleMax)
  {
    _txtHalfMax.text = scaleMax / 2;
    _txtMax.text = scaleMax;
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
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Error.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text = "Alarm hoch";
      return;
    }

    if (_warningHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Mainenance.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text = "Warnung hoch";
      return;
    }

    if (_toleranceHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Tolerance.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text = "Toleranz hoch";
      return;
    }

    _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Ok.svg]]";
    _rectLimitHigh.sizeAsDyn = makeDynInt(30, 25);
    _txtLimitHigh.text = "Grenze hoch";

    updateBars();
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
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Error.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = "Alarm niedrig";
      return;
    }

    if (_warningLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Mainenance.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = "Warnung niedrig";
      return;
    }

    if (_toleranceLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Tolerance.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = "Toleranz niedrig";
      return;
    }

    _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Ok.svg]]";
    _rectLimitLow.sizeAsDyn = makeDynInt(30, 25);
    _txtLimitLow.text = "Grenze niedrig";

    updateBars();
  }

  private void updateBars()
  {
    _circleAH1.angle2 = (_ahEnabled) ? ((calculateCircleDeg(_ahLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(_ahLimit, _minV, _maxV)) : 0;
    _circleWH1.angle2 = (_whEnabled) ? ((calculateCircleDeg(_whLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(_whLimit, _minV, _maxV)) : 0;
    _circleTH1.angle2 = (_thEnabled) ? ((calculateCircleDeg(_thLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(_thLimit, _minV, _maxV)) : 0;

    _circleAL1.angle2 = 180;
    _circleWL1.angle2 = 180;
    _circleTL1.angle2 = 180;
    _circleAL1.angle1 = (_alEnabled) ? ((calculateCircleDeg(_alLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(_alLimit, _minV, _maxV)) : 180;
    _circleWL1.angle1 = (_wlEnabled) ? ((calculateCircleDeg(_wlLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(_wlLimit, _minV, _maxV)) : 180;
    _circleTL1.angle1 = (_tlEnabled) ? ((calculateCircleDeg(_tlLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(_tlLimit, _minV, _maxV)) : 180;
  }

  private float calculatePvDeg(float value, float minV, float maxV)
  {
    float pvk = (180.0 / (minV - maxV));
    float pvd = (360.0 - minV * pvk);
    return value * pvk + pvd;
  }

  private float calculateCircleDeg(float value, float minV, float maxV)
  {
    float ck = (180.0 / (minV - maxV));
    float cd = (180.0 - minV * ck);
    return value * ck + cd;
  }
};
