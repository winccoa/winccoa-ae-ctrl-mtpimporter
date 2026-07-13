// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_AnaDrv/MTP_AnaDrv"
#uses "classes/MTP_View/MTP_ViewBase"

/**
 * @class MTP_AnaDrvFaceplateHome3
 * @brief Represents the MTP_AnaDrvFaceplateHome3 class.
 */
class MTP_AnaDrvFaceplateHome3 : MTP_ViewBase
{
  private shared_ptr<MTP_BarIndicator> _barIndicator; //!< Reference to the bar indicator for displaying RPM values and limits.

  /**
   * @brief Constructor for MTP_AnaDrvFaceplateHome3.
   *
   * @param viewModel A shared pointer to the MTP_AnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_AnaDrvFaceplateHome3(shared_ptr<MTP_AnaDrv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MTP_BarIndicator::setValueLimit, MTP_ViewBase::getViewModel(), MTP_AnaDrv::rpmErrorChanged);

    _barIndicator.setScale(MTP_ViewBase::getViewModel().getRpmScaleMin(), MTP_ViewBase::getViewModel().getRpmScaleMax());
    _barIndicator.setUnit(MTP_ViewBase::getViewModel().getRpmUnit());
    _barIndicator.setAlertHighShape(FALSE, MTP_ViewBase::getViewModel().getRpmMax());
    _barIndicator.setAlertLowShape(FALSE, MTP_ViewBase::getViewModel().getRpmMin());

    _barIndicator.setValueLimit(MTP_ViewBase::getViewModel().getRpmError());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _barIndicator = MTP_ViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
  }
};
