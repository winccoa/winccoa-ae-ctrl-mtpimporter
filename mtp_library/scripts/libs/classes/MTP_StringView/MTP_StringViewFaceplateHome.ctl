// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_StringView/MTP_StringView"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Wqc/MTP_Wqc"


/**
 * @class MTP_StringViewFaceplateHome
 * @brief Represents the MTP_StringViewFaceplateHome class.
 */
class MTP_StringViewFaceplateHome : MTP_ViewBase
{
  private shape _txtText; //!< Reference to the text value.

  /**
   * @brief Constructor for MTP_StringViewFaceplateHome.
   *
   * @param viewModel A shared pointer to the StringView view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_StringViewFaceplateHome(shared_ptr<MTP_StringView> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setTextCB, MTP_ViewBase::getViewModel(), MTP_StringView::textChanged);

    setTextCB(MTP_ViewBase::getViewModel().getText());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtText = MTP_ViewBase::extractShape("_txtText");
  }

  /**
   * @brief Callback function to update the Text value and its display.
   *
   * @param text The new Text value.
   */
  private void setTextCB(const string &text)
  {
      _txtText.text = text;
  }
};
