// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpView/MtpViewBase"

/**
 * @class MtpViewFaceplateSettings
 * @brief A class that represents the faceplate settings view.
 */
class MtpViewFaceplateSettings  : MtpViewBase
{
  /**
   * @brief Constructor for MtpViewFaceplateSettings.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the view.
   */
  public MtpViewFaceplateSettings(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {

  }

  /**
   * @brief Loads a panel in it's own module.
   * 
   * @param fileName The file name of the panel to be loaded.
   * @param panelName The name of the panel to be loaded.
   */
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
