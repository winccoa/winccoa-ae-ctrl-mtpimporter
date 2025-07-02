// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpViewModel/MtpViewModelBase"
#uses "classes/MtpView/MtpViewBase"
#uses "classes/MtpNavigationButton/MtpNavigationButton"

class MtpFaceplateMainBase : MtpViewBase
{
  private shape _txtTitle;
  private shape _panel;
  private shape _module;
  private string _layoutNavigation;
  private vector<shared_ptr<MtpNavigationButton> > _navigationButtons;

  protected MtpFaceplateMainBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpViewBase(viewModel, shapes)
  {
    _layoutNavigation = layoutNavigation;
    setNavigation();
    setTitle();;
  }

  public void close()
  {
    panelOff();
  }

  public void clickNavigation(const string &name)
  {
    shared_ptr<MtpNavigationButton> button = _navigationButtons.at(_navigationButtons.indexListOf("_name", name).at(0));
    loadPanel(button.getFileName(), button.getName(), _module.ModuleName());
    invokeMethod(getShape(_module.ModuleName(), button.getName(), ""), "initialize", MtpViewBase::getViewModel());
  }

  protected initializeShapes() override
  {
    _txtTitle = MtpViewBase::extractShape("_txtTitle");
    _panel = MtpViewBase::extractShape("_panel");
    _module = MtpViewBase::extractShape("_module");
  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons()
  {
    return _navigationButtons;
  }

  private void setTitle()
  {
    _txtTitle.text = dpGetDescription(MtpViewBase::getViewModel().getDp());
  }

  private void setNavigation()
  {
    _navigationButtons = getNavigationButtons();

    int size = _navigationButtons.count();

    for (int i = 0; i < size; i++)
    {
      shared_ptr<MtpNavigationButton> button = _navigationButtons.at(i);
      addSymbol(_panel, "/objects/MtpFaceplate/NaviButton.xml", button.getName(), i, _layoutNavigation, makeDynString("$picture:" + button.getPicture()));
      uiConnect(this, clickNavigation, getShape(_panel, button.getName()), "clickNavigationEvent");

      if (i == 0)
      {
        clickNavigation(button.getName());
      }
    }
  }

  private void loadPanel(const string &fileName, const string &panelName, const string &moduleName)
  {
    if (isModuleOpen(moduleName) && !isPanelOpen(panelName, moduleName))
    {
      dyn_int orgSize = getPanelSize("object_parts/MtpFaceplate/Main.xml");
      dyn_int size = getPanelSize(fileName);
      setPanelSize(myModuleName(), myPanelName(), FALSE, size.at(0)+2, orgSize.at(1));
      string uiDp = myUiDpName() + ".";

      dpSetWait(uiDp + "RootPanelOrigOn.ModuleName:_original.._value", moduleName,
                uiDp + "RootPanelOrigOn.FileName:_original.._value", fileName,
                uiDp + "RootPanelOrigOn.PanelName:_original.._value", panelName,
                uiDp + "RootPanelOrigOn.Parameter:_original.._value", makeDynString());
    }
  }
};
