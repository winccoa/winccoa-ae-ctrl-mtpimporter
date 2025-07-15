// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpBarIndicator/MtpBarIndicator"
#uses "classes/MtpView/MtpViewBase"

class MonAnaDrvFaceplateHome2 : MtpViewBase
{
  private shape _rectInternal;
  private shape _rectManual;
  private shape _txtRpmValueManual;
  private shape _txtRpmValueInternal;
  private shape _txtRpmFeedbackValue;

  private bool _manualActive;
  private bool _internalActive;
  private bool _channel;
  private bool _osLevelStation;

  private shared_ptr<MtpBarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  public MonAnaDrvFaceplateHome2(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MtpBarIndicator::setValueCustomLimit, MtpViewBase::getViewModel(), MonAnaDrv::rpmChanged);
    classConnect(this, setRpmFeedbackValueCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmFeedbackSignalChanged);
    classConnect(this, setRpmValueInternalCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmInternalChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();
    _osLevelStation = MtpViewBase::getViewModel().getOsLevel().getStationLevel();

    _refBarIndicator.setAlertHighShape(FALSE, MtpViewBase::getViewModel().getRpmMax());
    _refBarIndicator.setAlertLowShape(FALSE, MtpViewBase::getViewModel().getRpmMin());
    _refBarIndicator.setScale(MtpViewBase::getViewModel().getRpmScaleMin(), MtpViewBase::getViewModel().getRpmScaleMax());
    _refBarIndicator.setUnit(MtpViewBase::getViewModel().getRpmUnit());

    setValueManualText(MtpViewBase::getViewModel().getRpmManual());
    _refBarIndicator.setValueCustomLimit(MtpViewBase::getViewModel().getRpm());
    setUnit(MtpViewBase::getViewModel().getRpmUnit());
    setRpmFeedbackValueCB(MtpViewBase::getViewModel().getRpmFeedbackSignal());
    setRpmValueInternalCB(MtpViewBase::getViewModel().getRpmInternal());

    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  public void changeManual()
  {
    MtpViewBase::getViewModel().getSource().setManualOperator(true);
  }

  public void changeInternal()
  {
    MtpViewBase::getViewModel().getSource().setInternalOperator(true);
  }

  public void setRpmValueManual(const float &valueManual)
  {
    MtpViewBase::getViewModel().setRpmManual(valueManual);
  }

  protected void initializeShapes()
  {
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _txtRpmFeedbackValue = MtpViewBase::extractShape("_txtRpmFeedbackValue");
    _txtRpmValueInternal = MtpViewBase::extractShape("_txtRpmValueInternal");
    _txtRpmValueManual = MtpViewBase::extractShape("_txtRpmValueManual");

    _refBarIndicator = MtpViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
  }

  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setInternalActiveCB("", FALSE);
    setManualActiveCB("", FALSE);
  }

  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _refBarIndicator.setUnit(unit);
  }

  private void setValueManualText(const float &valueManual)
  {
    _txtRpmValueManual.text = valueManual;
  }

  private void setRpmFeedbackValueCB(const float &value)
  {
    _txtRpmFeedbackValue.text = value;
  }

  private void setRpmValueInternalCB(const float &valueInternal)
  {
    _txtRpmValueInternal.text = valueInternal;
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

    if ((!_osLevelStation && _internalActive && !_channel) || (_internalActive && _channel))
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]";
    }
    else if (_osLevelStation && _internalActive && !_channel)
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

    if ((!_osLevelStation && !_channel && _manualActive) || (_manualActive && _channel))
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
