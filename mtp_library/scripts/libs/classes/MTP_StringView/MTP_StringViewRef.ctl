// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_StringView/MTP_StringView"

/**
 * @class MTP_StringViewRef
 * @brief Represents the MTP_StringViewRef class.
 */
class MTP_StringViewRef : MTP_ViewRef
{
  protected shape _txtText; //!< Reference to the value rectangle shape.

  /**
   * @brief Constructor for MTP_StringViewRef.
   *
   * @param viewModel A shared pointer to the MTP_StringView view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_StringViewRef(shared_ptr<MTP_StringView> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setTextCB, MTP_ViewRef::getViewModel(), MTP_StringView::textChanged);
    setTextCB(MTP_ViewRef::getViewModel().getText());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _txtText = MTP_ViewRef::extractShape("_txtText");
  }

  /**
   * @brief Sets the text for the MTP_StringView object.
   *
   * @param text The string value to be set.
   */
  private void setTextCB(const string &text)
  {
    _txtText.text = text;
  }
};
