// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimitFloat"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_AnaView/MTP_AnaView"

/**
 * @class MTP_AnaViewFaceplateHome
 * @brief Represents the MTP_AnaViewFaceplateHome class.
 */
class MTP_AnaViewFaceplateHome : MTP_ViewBase
{
  private shared_ptr<MTP_BarIndicator> _barIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MTP_AnaViewFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_AnaView view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_AnaViewFaceplateHome(shared_ptr<MTP_AnaView> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MTP_BarIndicator::setValueLimit, MTP_ViewBase::getViewModel(), MTP_AnaView::valueChanged);

    _barIndicator.setScale(MTP_ViewBase::getViewModel().getValueScaleMin(), MTP_ViewBase::getViewModel().getValueScaleMax());
    _barIndicator.setUnit(MTP_ViewBase::getViewModel().getUnit());
    _barIndicator.setValueLimit(MTP_ViewBase::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _barIndicator = MTP_ViewBase::extractShape("_barIndicator").getMtpBarIndicator();
  }
};
