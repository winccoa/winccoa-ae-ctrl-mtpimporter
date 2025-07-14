// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpViewModel/MtpViewModelBase"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MtpViewRef
 * @brief A class that extends the functionality of MtpViewBase.
 */
class MtpViewRef : MtpViewBase
{
  /**
   * @brief Constructor for the MtpViewRef class.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the view.
   */
  protected MtpViewRef(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes): MtpViewBase(viewModel, shapes)
  {

  }

  /**
   * @brief Opens the main MTP faceplate.
   */
  public void openFaceplate()
  {
    MtpViewBase::openChildPanel("object_parts/MtpFaceplate/Main.xml", dpGetDescription(MtpViewBase::getViewModel().getDp()));
  }
};
