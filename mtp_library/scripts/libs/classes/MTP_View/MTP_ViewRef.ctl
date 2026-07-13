// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_DataAssembly/MTP_DataAssembly"
#uses "stdlib_hook_project"

/**
 * @class MTP_ViewRef
 * @brief Represents the MTP_ViewRef class.
 */
class MTP_ViewRef : MTP_ViewBase
{
  /**
   * @brief Constructor for the MTP_ViewRef class.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the view.
   */
  protected MTP_ViewRef(shared_ptr<MTP_DataAssembly> viewModel, const mapping &shapes): MTP_ViewBase(viewModel, shapes)
  {

  }

  /**
   * @brief Opens the main MTP faceplate.
   */
  public void openFaceplate()
  {
    hook_openFaceplate(getViewModel().getDp());
  }
};
