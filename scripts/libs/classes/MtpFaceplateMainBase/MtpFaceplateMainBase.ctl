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

/**
 * @class MtpFaceplateMainBase
 * @brief A base class for faceplate main components in the MTP library.
 */
class MtpFaceplateMainBase : MtpViewBase
{
  private shape _txtTitle; //!< The title text shape used in the faceplate.
  private shape _panel; //!< The panel shape used in the faceplate.
  private shape _module; //!< The module shape used in the faceplate.
  private string _layoutNavigation; //!< The layout for navigation buttons.
  private vector<shared_ptr<MtpNavigationButton> > _navigationButtons; //!< A vector of navigation buttons used in the faceplate.

  /**
   * @brief Constructor for the MtpFaceplateMainBase class.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the faceplate.
   * @param layoutNavigation The layout for navigation buttons.
   */
  protected MtpFaceplateMainBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpViewBase(viewModel, shapes)
  {
    _layoutNavigation = layoutNavigation;
    setNavigation();
    setTitle();
  }


  /**
   * @brief Closes the current faceplate.
   */
  public void close()
  {
    panelOff();
  }

  /**
   * @brief Handles the click event for a navigation button.
   *
   * @param name The name of the navigation button that was clicked.
   */
  public void clickNavigation(const string &name)
  {
    shared_ptr<MtpNavigationButton> button = _navigationButtons.at(_navigationButtons.indexListOf("_name", name).at(0));
    loadPanel(button);
    invokeMethod(getShape(_module.ModuleName(), button.getName(), ""), "initialize", MtpViewBase::getViewModel());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method.
   */
  protected initializeShapes() override
  {
    _txtTitle = MtpViewBase::extractShape("_txtTitle");
    _panel = MtpViewBase::extractShape("_panel");
    _module = MtpViewBase::extractShape("_module");
  }

  /**
   * @brief Retrieves the navigation buttons used in the faceplate.
   *
   * @return A vector of shared pointers to the navigation buttons.
   */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons()
  {
    return _navigationButtons;
  }

  /**
   * @brief Sets the title text for the faceplate.
   */
  private void setTitle()
  {
    _txtTitle.text = dpGetDescription(MtpViewBase::getViewModel().getDp());
  }

  /**
   * @brief Sets up the navigation buttons for the faceplate.
   */
  private void setNavigation()
  {
    _navigationButtons = getNavigationButtons();

    int size = _navigationButtons.count();

    for (int i = 0; i < size; i++)
    {
      shared_ptr<MtpNavigationButton> button = _navigationButtons.at(i);
      addSymbol(_panel, "/objects/MtpFaceplate/NaviButton.xml", button.getName(), i, _layoutNavigation, makeDynString());
      button.setButton(getShape(_panel, button.getName()));
      button.setPicture();
      uiConnect(this, clickNavigation, getShape(_panel, button.getName()), "clickNavigationEvent");

      if (i == 0)
      {
        clickNavigation(button.getName());
      }
    }
  }

  /**
   * @brief Loads a panel in a given module.
   *
   * @param fileName The file name of the panel to be loaded.
   * @param panelName The name of the panel to be loaded.
   * @param moduleName The name of the module in which the panel should be loaded.
   */
  private void loadPanel(shared_ptr<MtpNavigationButton> button)
  {
    string moduleName = _module.ModuleName();
    string panelName = button.getName();

    if (isPanelOpen(panelName, moduleName))
    {
      button.nextIndex();
    }
    else
    {
      button.resetIndex();
    }

    button.setPicture();

    string fileName = button.getFileName();

    if (isModuleOpen(moduleName))
    {
      dyn_int orgSize = getPanelSize("object_parts/MtpFaceplate/Main.xml");
      dyn_int size = getPanelSize(fileName);
      setPanelSize(myModuleName(), myPanelName(), FALSE, size.at(0) + 2, orgSize.at(1));
      string uiDp = myUiDpName() + ".";

      dpSetWait(uiDp + "RootPanelOrigOn.ModuleName:_original.._value", moduleName,
                uiDp + "RootPanelOrigOn.FileName:_original.._value", fileName,
                uiDp + "RootPanelOrigOn.PanelName:_original.._value", panelName,
                uiDp + "RootPanelOrigOn.Parameter:_original.._value", makeDynString());
    }
  }
};
