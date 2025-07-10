// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewBase"
#uses "classes/MtpBarIndicator/MtpBarIndicator"

class MonAnaDrvFaceplateHome3 : MtpViewBase
{
  private shape _rectAlarmHighActive;
  private shape _rectAlarmLowActive;
  private shape _txtAlarmHighActive;
  private shape _txtAlarmLowActive;

  private shared_ptr<MtpBarIndicator> _barIndicator;

  public MonAnaDrvFaceplateHome3(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MtpBarIndicator::setValueLimit, MtpViewBase::getViewModel(), MonAnaDrv::rpmErrorChanged);
    classConnect(this, setRpmAlarmHighActiveCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmAlarmHighActiveChanged);
    classConnect(this, setRpmAlarmLowActiveCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmAlarmLowActiveChanged);

    _barIndicator.showLimitIndicator();
    _barIndicator.setScale(MtpViewBase::getViewModel().getRpmScaleMin(), MtpViewBase::getViewModel().getRpmScaleMax());
    _barIndicator.setUnit(MtpViewBase::getViewModel().getRpmUnit());

    _barIndicator.setAlertHighShape(TRUE, MtpViewBase::getViewModel().getRpmAlarmHighLimit());
    _barIndicator.setAlertLowShape(TRUE, MtpViewBase::getViewModel().getRpmAlarmLowLimit());

    _barIndicator.setValueLimit(MtpViewBase::getViewModel().getRpmError());
    setRpmAlarmHighActiveCB(MtpViewBase::getViewModel().getRpmAlarmHighActive());
    setRpmAlarmLowActiveCB(MtpViewBase::getViewModel().getRpmAlarmLowActive());
  }

  protected void initializeShapes() override
  {
    _rectAlarmHighActive = MtpViewBase::extractShape("_rectAlarmHighActive");
    _rectAlarmLowActive = MtpViewBase::extractShape("_rectAlarmLowActive");
    _txtAlarmHighActive = MtpViewBase::extractShape("_txtAlarmHighActive");
    _txtAlarmLowActive = MtpViewBase::extractShape("_txtAlarmLowActive");

    _barIndicator = MtpViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
  }

  private void setRpmAlarmHighActiveCB(const bool &active)
  {
    if (active)
    {
      _rectAlarmHighActive.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectAlarmHighActive.sizeAsDyn = makeDynInt(30, 25);
    }
    else
    {
      _rectAlarmHighActive.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectAlarmHighActive.sizeAsDyn = makeDynInt(30, 25);
    }
  }

  private void setRpmAlarmLowActiveCB(const bool &active)
  {
    if (active)
    {
      _rectAlarmLowActive.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectAlarmLowActive.sizeAsDyn = makeDynInt(30, 25);
    }
    else
    {
      _rectAlarmLowActive.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectAlarmLowActive.sizeAsDyn = makeDynInt(30, 25);
    }
  }
};
