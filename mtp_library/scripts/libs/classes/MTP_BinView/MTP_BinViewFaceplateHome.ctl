// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_BinView/MTP_BinView"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_BinViewFaceplateHome
 * @brief Represents the MTP_BinViewFaceplateHome class.
 */
class MTP_BinViewFaceplateHome : MTP_ViewBase
{
  private shape _txtValue; //!< Reference to the value text shape.
  private shape _rectValue; //!< Reference to the value rectangle shape.

  /**
   * @brief Constructor for MTP_BinViewFaceplateHome.
   *
   * @param viewModel A shared pointer to the BinMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_BinViewFaceplateHome(shared_ptr<MTP_BinView> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setValueCB, MTP_ViewBase::getViewModel(), MTP_BinView::valueChanged);
    setValueCB(MTP_ViewBase::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtValue = MTP_ViewBase::extractShape("_txtValue");
    _rectValue = MTP_ViewBase::extractShape("_rectValue");
  }

  /**
   * @brief Sets the value for the faceplate.
   *
   * @param value The boolean value to be set.
   */
  private void setValueCB(const bool &value)
  {
    if (value)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
      _txtValue.text = MTP_ViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _txtValue.text = MTP_ViewBase::getViewModel().getValueStateFalseText();
    }
  }
};
