// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_DataAssembly/MTP_DataAssembly"

/**
 * @class MTP_ViewFaceplateSettings
 * @brief Represents the MTP_ViewFaceplateSettings class.
 */
class MTP_ViewFaceplateSettings  : MTP_ViewBase
{
  /**
   * @brief Constructor for MTP_ViewFaceplateSettings.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the view.
   */
  public MTP_ViewFaceplateSettings(shared_ptr<MTP_DataAssembly> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
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
                uiDp + "RootPanelOrigOn.Parameter:_original.._value", makeDynString("$DP:" + MTP_ViewBase::getViewModel().getDp()));
    }
  }
};
