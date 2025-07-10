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

  private shared_ptr<MtpBarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  public MonAnaDrvFaceplateHome2(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MtpBarIndicator::setValueCustomLimit, MtpViewBase::getViewModel(), MonAnaDrv::rpmChanged);
    classConnect(this, setRpmFeedbackValueCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmFeedbackSignalChanged);
    classConnect(this, setRpmValueInternalCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmInternalChanged);

    classConnect(this, setManualActiveCB, MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnect(this, setInternalActiveCB, MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();

    _refBarIndicator.setAlertHighShape(FALSE, MtpViewBase::getViewModel().getRpmMax());
    _refBarIndicator.setAlertLowShape(FALSE, MtpViewBase::getViewModel().getRpmMin());
    _refBarIndicator.setScale(MtpViewBase::getViewModel().getRpmScaleMin(), MtpViewBase::getViewModel().getRpmScaleMax());
    _refBarIndicator.setUnit(MtpViewBase::getViewModel().getRpmUnit());

    setValueManualText(MtpViewBase::getViewModel().getRpmManual());
    _refBarIndicator.setValueCustomLimit(MtpViewBase::getViewModel().getRpm());
    setUnit(MtpViewBase::getViewModel().getRpmUnit());
    setRpmFeedbackValueCB(MtpViewBase::getViewModel().getRpmFeedbackSignal());
    setRpmValueInternalCB(MtpViewBase::getViewModel().getRpmInternal());

    setManualActiveCB(_manualActive);
    setInternalActiveCB(_internalActive);
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

  private void setManualActiveCB(const bool &manualActive)
  {
    _manualActive = manualActive;

    if (manualActive && !_channel)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else if (_manualActive && _channel)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
    }
    else
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }
  }

  private void setInternalActiveCB(const bool &internalActive)
  {
    _internalActive = internalActive;

    if (internalActive && !_channel)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_2_rounded.svg]]";
    }
    else if (internalActive && _channel)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]";
    }
    else
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_3_rounded.svg]]";
    }
  }
};
