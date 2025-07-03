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
    string dp = MtpViewBase::getViewModel().getDp();
    openChildPanel("object_parts/MtpFaceplate/Main.xml", dpGetDescription(dp));
    invokeMethod(getShape(myModuleName(), dpGetDescription(dp), ""), "initialize", MtpViewBase::getViewModel());
  }

  /**
   * @brief Opens a child panel.
   * 
   * @param fileName The file name of the child panel to be opened.
   * @param panelName The name of the panel to be displayed.
   */
  private void openChildPanel(const string &fileName, const string &panelName)
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
              dp + "ChildPanelOn.Parameter:_original.._value", makeDynString(),
              dp + "ChildPanelOn.Modal:_original.._value", 0);

  }
};
