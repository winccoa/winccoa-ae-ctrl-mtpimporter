// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinView/MTP_BinView"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_BinViewRef
 * @brief Represents the MTP_BinViewRef class.
 */
class MTP_BinViewRef : MTP_ViewRef
{
  protected shape _rectValue; //!< Reference to the value rectangle shape.

  /**
   * @brief Constructor for MTP_BinViewRef.
   *
   * @param viewModel A shared pointer to the MTP_BinView view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinViewRef(shared_ptr<MTP_BinView> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MTP_ViewRef::getViewModel(), MTP_BinView::valueChanged);
    setValueCB(MTP_ViewRef::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _rectValue = MTP_ViewRef::extractShape("_rectValue");
  }

  /**
   * @brief Sets the value for the MTP_BinMon object.
   *
   * @param value The boolean value to be set.
   */
  protected void setValueCB(const bool &value)
  {
    if (value && _rectValue.enabled())
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
    }
  }
};
