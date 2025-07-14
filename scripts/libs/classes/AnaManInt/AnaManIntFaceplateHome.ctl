// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpBarIndicator/MtpBarIndicator"
#uses "classes/AnaManInt/AnaManInt"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpView/MtpViewBase"

class AnaManIntFaceplateHome : MtpViewBase
{
  private shape _refWqc;
  private shape _txtValueManual;
  private shape _txtValueInternal;
  private shape _txtFeedbackValue;
  private shape _rectManual;
  private shape _rectInternal;

  private bool _manualActive;
  private bool _internalActive;
  private bool _channel;
  private bool _osLevelStation;

  private shared_ptr<MtpBarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  public AnaManIntFaceplateHome(shared_ptr<AnaManInt> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MtpBarIndicator::setValueCustomLimit, MtpViewBase::getViewModel(), AnaManInt::valueOutChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setValueFeedbackCB, MtpViewBase::getViewModel(), AnaManInt::valueFeedbackChanged);
    classConnect(this, setValueInternalCB, MtpViewBase::getViewModel(), AnaManInt::valueInternalChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);
    classConnectUserData(this, setManualActiveCB, "_osLevelStation", MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osLevelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);
    classConnectUserData(this, setInternalActiveCB, "_osLevelStation", MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osLevelChanged);

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();
    _osLevelStation = MtpViewBase::getViewModel().getOsLevel().getStationLevel();

    _refBarIndicator.setAlertHighShape(FALSE, MtpViewBase::getViewModel().getValueMax());
    _refBarIndicator.setAlertLowShape(FALSE, MtpViewBase::getViewModel().getValueMin());
    _refBarIndicator.setScale(MtpViewBase::getViewModel().getValueScaleMin(), MtpViewBase::getViewModel().getValueScaleMax());
    _refBarIndicator.setUnit(MtpViewBase::getViewModel().getValueUnit());

    setValueManualText(MtpViewBase::getViewModel().getValueManual());
    _refBarIndicator.setValueCustomLimit(MtpViewBase::getViewModel().getValueOut());
    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setUnit(MtpViewBase::getViewModel().getValueUnit());
    setValueFeedbackCB(MtpViewBase::getViewModel().getValueFeedback());
    setValueInternalCB(MtpViewBase::getViewModel().getValueInternal());

    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
  }

  public void activateManual()
  {
    MtpViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  public void activateInternal()
  {
    MtpViewBase::getViewModel().getSource().setInternalOperator(TRUE);
  }

  public void setValueManual(const float &valueManual)
  {
    MtpViewBase::getViewModel().setValueManual(valueManual);
  }

  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _txtValueManual = MtpViewBase::extractShape("_txtValueManual");
    _txtValueInternal = MtpViewBase::extractShape("_txtValueInternal");
    _txtFeedbackValue = MtpViewBase::extractShape("_txtFeedbackValue");

    _refBarIndicator = MtpViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
  }

  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _refBarIndicator.setUnit(unit);
  }

  private void setValueManualText(const float &valueManual)
  {
    _txtValueManual.text = valueManual;
  }

  private void setValueFeedbackCB(const float &value)
  {
    _txtFeedbackValue.text = value;
  }

  private void setValueInternalCB(const float &valueInternal)
  {
    _txtValueInternal.text = valueInternal;
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
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

      case "_osLevelStation":
        _osLevelStation = internalActive;
        break;
    }

    if ((!_osLevelStation && internalActive && !_channel) || (internalActive && _channel))
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]";
    }
    else if (_osLevelStation && internalActive && !_channel)
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

      case "_osLevelStation":
        _osLevelStation = manualActive;
        break;
    }

    DebugTN(_osLevelStation);
    if ((!_osLevelStation && !_channel && manualActive) || (manualActive && _channel))
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
    }
    else if (_osLevelStation && _manualActive && !_channel)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]");
  }
};
