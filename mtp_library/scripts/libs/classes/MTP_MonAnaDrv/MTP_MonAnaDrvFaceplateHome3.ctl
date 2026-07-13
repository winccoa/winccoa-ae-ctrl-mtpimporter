// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_MonAnaDrv/MTP_MonAnaDrv"
#uses "classes/MTP_View/MTP_ViewBase"

/**
 * @class MTP_MonAnaDrvFaceplateHome3
 * @brief Represents the MTP_MonAnaDrvFaceplateHome3 class.
 */
class MTP_MonAnaDrvFaceplateHome3 : MTP_ViewBase
{
  private shape _rectAlarmHighActive; //!< Reference to the high RPM alarm rectangle shape.
  private shape _rectAlarmLowActive; //!< Reference to the low RPM alarm rectangle shape.
  private shape _txtAlarmHighActive; //!< Reference to the high RPM alarm text shape.
  private shape _txtAlarmLowActive; //!< Reference to the low RPM alarm text shape.

  private shared_ptr<MTP_BarIndicator> _barIndicator; //!< Reference to the bar indicator for displaying RPM values and limits.

  /**
   * @brief Constructor for MTP_MonAnaDrvFaceplateHome3.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonAnaDrvFaceplateHome3(shared_ptr<MTP_MonAnaDrv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MTP_BarIndicator::setValueLimit, MTP_ViewBase::getViewModel(), MTP_MonAnaDrv::rpmErrorChanged);
    classConnect(this, setRpmAlarmHighActiveCB, MTP_ViewBase::getViewModel(), MTP_MonAnaDrv::rpmAlarmHighActiveChanged);
    classConnect(this, setRpmAlarmLowActiveCB, MTP_ViewBase::getViewModel(), MTP_MonAnaDrv::rpmAlarmLowActiveChanged);

    _barIndicator.showAlarmLimitIndicator();
    _barIndicator.setScale(MTP_ViewBase::getViewModel().getRpmScaleMin(), MTP_ViewBase::getViewModel().getRpmScaleMax());
    _barIndicator.setUnit(MTP_ViewBase::getViewModel().getRpmUnit());

    _barIndicator.setAlertHighShape(TRUE, MTP_ViewBase::getViewModel().getRpmAlarmHighLimit());
    _barIndicator.setAlertLowShape(TRUE, MTP_ViewBase::getViewModel().getRpmAlarmLowLimit());

    _barIndicator.setValueLimit(MTP_ViewBase::getViewModel().getRpmError());
    setRpmAlarmHighActiveCB(MTP_ViewBase::getViewModel().getRpmAlarmHighActive());
    setRpmAlarmLowActiveCB(MTP_ViewBase::getViewModel().getRpmAlarmLowActive());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _rectAlarmHighActive = MTP_ViewBase::extractShape("_rectAlarmHighActive");
    _rectAlarmLowActive = MTP_ViewBase::extractShape("_rectAlarmLowActive");
    _txtAlarmHighActive = MTP_ViewBase::extractShape("_txtAlarmHighActive");
    _txtAlarmLowActive = MTP_ViewBase::extractShape("_txtAlarmLowActive");

    _barIndicator = MTP_ViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
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
