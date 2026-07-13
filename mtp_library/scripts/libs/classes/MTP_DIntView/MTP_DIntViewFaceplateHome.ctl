// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_DIntView/MTP_DIntView"
#uses "classes/MTP_ValueLimit/MTP_ValueLimitFloat"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_DIntViewFaceplateHome
 * @brief Represents the MTP_DIntViewFaceplateHome class.
 */
class MTP_DIntViewFaceplateHome : MTP_ViewBase
{
  private shared_ptr<MTP_BarIndicator> _barIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MTP_DIntViewFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_AnaView view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_DIntViewFaceplateHome(shared_ptr<MTP_DIntView> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MTP_BarIndicator::setValueLimit, MTP_ViewBase::getViewModel(), MTP_DIntView::valueChanged);

    _barIndicator.makeIntegerBarIndicator();
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
