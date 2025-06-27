// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpView/MtpViewBase"

class MtpViewFaceplateSettings  : MtpViewBase
{
  public MtpViewFaceplateSettings(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {

  }

  protected void loadPanel(const string &fileName, const string &panelName)
  {
    string moduleName = myModuleName();

    if (isModuleOpen(moduleName) && !isPanelOpen(panelName, moduleName))
    {
      string uiDp = myUiDpName() + ".";

      dpSetWait(uiDp + "RootPanelOrigOn.ModuleName:_original.._value", moduleName,
                uiDp + "RootPanelOrigOn.FileName:_original.._value", fileName,
                uiDp + "RootPanelOrigOn.PanelName:_original.._value", panelName,
                uiDp + "RootPanelOrigOn.Parameter:_original.._value", makeDynString("$dp:" + MtpViewBase::getViewModel().getDp()));
    }
  }
};
