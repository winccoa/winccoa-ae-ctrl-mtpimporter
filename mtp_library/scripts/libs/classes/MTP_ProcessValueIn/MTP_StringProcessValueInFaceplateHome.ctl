// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_ProcessValueIn/MTP_StringProcessValueIn"

/**
 * @class MTP_StringProcessValueInFaceplateHome
 * @brief Faceplate controller for string process value inputs.
 */
class MTP_StringProcessValueInFaceplateHome : MTP_ViewBase
{
  private shape _txtCurrent; //!< Current value input field.

  /**
   * @brief Constructor.
   *
   * @param viewModel String process value input model.
   * @param shapes Shape mapping.
   */
  public MTP_StringProcessValueInFaceplateHome(shared_ptr<MTP_StringProcessValueIn> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setCurrentValueCB, MTP_ViewBase::getViewModel(), MTP_StringProcessValueIn::valueChanged);
    setCurrentValueCB(MTP_ViewBase::getViewModel().getValue());
  }

  /**
   * @brief Writes user-entered current value.
   *
   * @param valueText Entered text.
   */
  public void setCurrentValue(const string &valueText)
  {
    MTP_ViewBase::getViewModel().setValue(valueText);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _txtCurrent = MTP_ViewBase::extractShape("_txtCurrent");
  }

  /**
   * @brief Updates displayed current value.
   *
   * @param value Current string value.
   */
  private void setCurrentValueCB(const string &value)
  {
    _txtCurrent.text = value;
  }
};
