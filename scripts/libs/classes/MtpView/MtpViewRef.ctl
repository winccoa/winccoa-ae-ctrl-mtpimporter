// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpViewModel/MtpViewModelBase"
#uses "classes/MtpView/MtpViewBase"

class MtpViewRef : MtpViewBase
{
  protected MtpViewRef(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes): MtpViewBase(viewModel, shapes)
  {

  }

  public void openFaceplate()
  {
    string dp = MtpViewBase::getViewModel().getDp();
    ChildPanelOnCentral("object_parts/MtpFaceplate/Main.xml", dpGetDescription(dp), makeDynString("$dp:" + dp));
  }
};
