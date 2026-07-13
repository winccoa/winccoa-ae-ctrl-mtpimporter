// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_Ref/MTP_RefBase"
#uses "classes/MTP_DataAssembly/MTP_DataAssembly"

/**
 * @class MTP_ViewBase
 * @brief Represents the MTP_ViewBase class.
 */
class MTP_ViewBase : MTP_RefBase
{
  private shared_ptr<MTP_DataAssembly> _viewModel; //!< The view model associated with this view.

  /**
   * @brief Constructor for MTP_ViewBase.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the view.
   */
  protected MTP_ViewBase(shared_ptr<MTP_DataAssembly> viewModel, const mapping &shapes) : MTP_RefBase(shapes)
  {
    assignPtr(_viewModel, viewModel);
  }

  /**
   * @brief Retrieves the view model associated with this view.
   *
   * @return The shared pointer to the MTP_DataAssembly instance.
   */
  protected shared_ptr<MTP_DataAssembly> getViewModel()
  {
    return _viewModel;
  }

  /**
   * @brief Opens a child panel.
   *
   * @param fileName The file name of the child panel to be opened.
   * @param panelName The name of the panel to be displayed.
   */
  protected void openChildPanel(const string &fileName, const string &panelName)
  {
    int panelWidth, panelHeight, x, y;
    float factor, initFactor;
    dyn_int panelSizeAsDyn;

    panelSizeAsDyn = getPanelSize(fileName, true);

    if (dynlen(panelSizeAsDyn) < 2)
    {
      return;
    }

    getZoomFactor(factor, myModuleName());
    panelSize(myPanelName(), panelWidth, panelHeight, (factor == 1));
    getInitialZoomFactor(initFactor);

    x = ((panelWidth) - (panelSizeAsDyn.at(0) * initFactor / factor)) / 2;
    y = ((panelHeight) - (panelSizeAsDyn.at(1) * initFactor / factor) - 20) / 2;

    if (x < 0)
    {
      x = 0;
    }

    if (y < 0)
    {
      y = 0;
    }

    if (isPanelOpen(panelName))
    {
      restorePanel(panelName);
      return;
    }

    string dp = myUiDpName() + ".";
    dpSetWait(dp + "ChildPanelOn.ModuleName:_original.._value", myModuleName(),
              dp + "ChildPanelOn.ParentName:_original.._value", myPanelName(),
              dp + "ChildPanelOn.FileName:_original.._value", fileName,
              dp + "ChildPanelOn.X:_original.._value", x,
              dp + "ChildPanelOn.Y:_original.._value", y,
              dp + "ChildPanelOn.Scale:_original.._value", 1.0,
              dp + "ChildPanelOn.ParentScale:_original.._value", 0,
              dp + "ChildPanelOn.PanelName:_original.._value", panelName,
              dp + "ChildPanelOn.Parameter:_original.._value", makeDynString("$DP:" + _viewModel.getDp()),
              dp + "ChildPanelOn.Modal:_original.._value", 0);
  }
};
