// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_BinMan/MTP_BinMan"

/**
 * @class MTP_BinManRef
 * @brief Represents the MTP_BinManRef class.
 */
class MTP_BinManRef : MTP_ViewRef
{
  protected shape _rectValue; //!< Reference to the value rectangle shape.

  /**
   * @brief Constructor for MTP_BinManRef.
   *
   * @param viewModel A shared pointer to the BinMan view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinManRef(shared_ptr<MTP_BinMan> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MTP_ViewRef::getViewModel(), MTP_BinMan::valueOutChanged);
    setValueCB(MTP_ViewRef::getViewModel().getValueOut());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _rectValue = MTP_ViewRef::extractShape("_rectValue");
  }

  /**
   * @brief Sets the output value for the reference.
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
