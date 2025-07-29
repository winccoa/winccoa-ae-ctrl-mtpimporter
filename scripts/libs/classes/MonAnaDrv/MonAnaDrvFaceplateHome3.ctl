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

/**
 * @class MonAnaDrvFaceplateHome3
 * @brief Represents the third faceplate for MonAnaDrv objects, handling RPM alarm indicators and display.
 */
class MonAnaDrvFaceplateHome3 : MtpViewBase
{
  private shape _rectAlarmHighActive; //!< Reference to the high RPM alarm rectangle shape.
  private shape _rectAlarmLowActive; //!< Reference to the low RPM alarm rectangle shape.
  private shape _txtAlarmHighActive; //!< Reference to the high RPM alarm text shape.
  private shape _txtAlarmLowActive; //!< Reference to the low RPM alarm text shape.

  private shared_ptr<MtpBarIndicator> _barIndicator; //!< Reference to the bar indicator for displaying RPM values and limits.

  /**
   * @brief Constructor for MonAnaDrvFaceplateHome3.
   *
   * @param viewModel A shared pointer to the MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
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

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the required shapes.
   */
  protected void initializeShapes() override
  {
    _rectAlarmHighActive = MtpViewBase::extractShape("_rectAlarmHighActive");
    _rectAlarmLowActive = MtpViewBase::extractShape("_rectAlarmLowActive");
    _txtAlarmHighActive = MtpViewBase::extractShape("_txtAlarmHighActive");
    _txtAlarmLowActive = MtpViewBase::extractShape("_txtAlarmLowActive");

    _barIndicator = MtpViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
  }

  /**
   * @brief Callback function to update the high RPM alarm shape.
   *
   * @param active The new state of the high RPM alarm.
   */
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

  /**
   * @brief Callback function to update the low RPM alarm shape.
   *
   * @param active The new state of the low RPM alarm.
   */
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
