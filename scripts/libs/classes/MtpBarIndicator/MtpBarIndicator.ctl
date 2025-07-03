// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpRef/MtpRefBase"

class MtpBarIndicator : MtpRefBase
{
  private shape _txtValue;
  private shape _txtUnit;

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

  private float _value;
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

  public MtpBarIndicator(const mapping &shapes) : MtpRefBase(shapes)
  {
  }

  public void setScale(const float &min, const float &max)
  {
    _minV = min;
    _maxV = max;

    _txtHalfMax.text = max / 2;
    _txtMax.text = max;
  }

  public void setAlertHighShape(const bool &ahEnabled, const float &ahLimit)
  {
    _ahEnabled = ahEnabled;
    _ahLimit = ahLimit;
    _circleAH1.angle2 = (ahEnabled) ? ((calculateCircleDeg(ahLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(ahLimit, _minV, _maxV)) : 0;
  }

  public void setWarningHighShape(const bool &whEnabled, const float &whLimit)
  {
    _whEnabled = whEnabled;
    _whLimit = whLimit;
    _circleWH1.angle2 = (whEnabled) ? ((calculateCircleDeg(whLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(whLimit, _minV, _maxV)) : 0;
  }

  public void setToleranceHighShape(const bool &thEnabled, const float &thLimit)
  {
    _thEnabled = thLimit;
    _thLimit = thLimit;
    _circleTH1.angle2 = (thEnabled) ? ((calculateCircleDeg(thLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(thLimit, _minV, _maxV)) : 0;
  }

  public void setAlertLowShape(const bool &alEnabled, const float &alLimit)
  {
    _alEnabled = alEnabled;
    _alLimit = alLimit;
    _circleAL1.angle2 = 180;
    _circleAL1.angle1 = (alEnabled) ? ((calculateCircleDeg(alLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(alLimit, _minV, _maxV)) : 180;
  }

  public void setWarningLowShape(const bool &wlEnabled, const float &wlLimit)
  {
    _wlEnabled = wlEnabled;
    _wlLimit = wlLimit;
    _circleWL1.angle2 = 180;
    _circleWL1.angle1 = (wlEnabled) ? ((calculateCircleDeg(wlLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(wlLimit, _minV, _maxV)) : 180;
  }

  public void setToleranceLowShape(const bool &tlEnabled, const float &tlLimit)
  {
    _tlEnabled = tlEnabled;
    _tlLimit = tlLimit;
    _circleTL1.angle2 = 180;
    _circleTL1.angle1 = (tlEnabled) ? ((calculateCircleDeg(tlLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(tlLimit, _minV, _maxV)) : 180;
  }

  public void setValue(const float &value)
  {
    _value = value;
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
      _circleValue.backCol = "mtpGrey";
    }
    else
    {
      _circleValue.backCol = "mtpGreen";
    }

    _pvPointer.rotation = (calculatePvDeg(value, _minV, _maxV) < 180) ? 180 : calculatePvDeg(value, _minV, _maxV);
  }

  public void setUnit(shared_ptr<MtpUnit> unit)
  {
    _unit = unit.toString;
    _txtUnit.text = unit.toString();
  }

  protected void initializeShapes()
  {
    _body1 = MtpRefBase::extractShape("_body1");
    _circleAH1 = MtpRefBase::extractShape("_circleAH1");
    _circleAL1 = MtpRefBase::extractShape("_circleAL1");
    _circlePV1 = MtpRefBase::extractShape("_circlePV1");
    _circleTH1 = MtpRefBase::extractShape("_circleTH1");
    _circleTL1 = MtpRefBase::extractShape("_circleTL1");
    _circleWH1 = MtpRefBase::extractShape("_circleWH1");
    _circleWL1 = MtpRefBase::extractShape("_circleWL1");

    _body = MtpRefBase::extractShape("_body");
    _circlePV = MtpRefBase::extractShape("_circlePV");
    _circleValue = MtpRefBase::extractShape("_circleValue");
    _pvPointer = MtpRefBase::extractShape("_pvPointer");

    _txtHalfMax = MtpRefBase::extractShape("_txtHalfMax");
    _txtMax = MtpRefBase::extractShape("_txtMax");

    _txtValue = MtpRefBase::extractShape("_txtValue");
    _txtUnit = MtpRefBase::extractShape("_txtUnit");
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
