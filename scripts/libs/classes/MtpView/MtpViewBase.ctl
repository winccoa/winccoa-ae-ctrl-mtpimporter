// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpRef/MtpRefBase"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class MtpViewBase
 * @brief Base class for MTP view components.
 */
class MtpViewBase : MtpRefBase
{
  private shared_ptr<MtpViewModelBase> _viewModel; //!< The view model associated with this view.

  /**
   * @brief Constructor for MtpViewBase.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the view.
   */
  protected MtpViewBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpRefBase(shapes)
  {
    assignPtr(_viewModel, viewModel);
  }

  /**
   * @brief Retrieves the view model associated with this view.
   *
   * @return The shared pointer to the MtpViewModelBase instance.
   */
  protected shared_ptr<MtpViewModelBase> getViewModel()
  {
    return _viewModel;
  }
};
