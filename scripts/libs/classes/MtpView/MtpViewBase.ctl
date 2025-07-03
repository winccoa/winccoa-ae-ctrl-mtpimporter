// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpRef/MtpRefBase"
#uses "classes/MtpViewModel/MtpViewModelBase"

class MtpViewBase : MtpRefBase
{
  private shared_ptr<MtpViewModelBase> _viewModel;

  protected MtpViewBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpRefBase(shapes)
  {
    assignPtr(_viewModel, viewModel);
  }

  protected shared_ptr<MtpViewModelBase> getViewModel()
  {
    return _viewModel;
  }
};
