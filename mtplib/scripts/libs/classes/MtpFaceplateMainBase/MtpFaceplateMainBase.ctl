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
  private shape _layoutNavigation; //!< The layout for navigation buttons.
  private vector<shared_ptr<MtpNavigationButton> > _navigationButtons; //!< A vector of navigation buttons used in the faceplate.
  private dyn_shape _info;

  /**
   * @brief Constructor for the MtpFaceplateMainBase class.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  protected MtpFaceplateMainBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    setNavigation();
    setTitle();

    classConnect(this, setEnabledCB, MtpViewBase::getViewModel(), MtpViewModelBase::enabledChanged);
    setEnabledCB(MtpViewBase::getViewModel().getEnabled());
  }


  /**
     * @brief Closes the current faceplate.
     * @details Calls the panelOff function to close the faceplate panel.
     */
  public void close()
  {
    panelOff();
  }

  /**
     * @brief Handles the click event for a navigation button.
     * @details Loads the panel associated with the clicked navigation button and initializes it with the view model.
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
    _layoutNavigation = MtpViewBase::extractShape("_layoutNavigation");

    _info.append(MtpViewBase::extractShape("_infoTop"));
    _info.append(MtpViewBase::extractShape("_infoTopBackground"));
    _info.append(MtpViewBase::extractShape("_infoTopText"));
    _info.append(MtpViewBase::extractShape("_infoBottom"));
    _info.append(MtpViewBase::extractShape("_infoBottomBackground"));
    _info.append(MtpViewBase::extractShape("_infoBottomText"));
  }

  /**
     * @brief Retrieves the navigation buttons used in the faceplate.
     * @details Returns the vector of navigation buttons configured for the faceplate.
     *
     * @return A vector of shared pointers to the navigation buttons.
     */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons()
  {
    return _navigationButtons;
  }

  /**
     * @brief Sets the title text for the faceplate.
     * @details Updates the title text shape with the description from the view model's data point.
     */
  private void setTitle()
  {
    _txtTitle.text = dpGetDescription(MtpViewBase::getViewModel().getDp());
  }

  /**
     * @brief Sets up the navigation buttons for the faceplate.
     * @details Initializes navigation buttons by adding them to the panel, setting their appearance, and connecting click events.
     */
  private void setNavigation()
  {
    _navigationButtons = getNavigationButtons();

    int size = _navigationButtons.count();

    for (int i = 0; i < size; i++)
    {
      shared_ptr<MtpNavigationButton> button = _navigationButtons.at(i);
      addSymbol(_panel, "/objects/MtpFaceplate/NaviButton.xml", button.getName(), i, _layoutNavigation.name(), makeDynString());
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
     * @details Loads the specified panel into the module, adjusting the panel size and updating data points as needed.
     *
     * @param button A shared pointer to the navigation button associated with the panel.
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

  /**
   * @brief Updates the visibility of faceplate elements based on enabled state.
   * @details Sets the visibility of the module and navigation layout, and toggles the visibility of info shapes based on the enabled state.
   *
   * @param enabled The enabled state of the faceplate.
   */
  private void setEnabledCB(const bool &enabled)
  {
    _module.visible = enabled;
    _layoutNavigation.visible = enabled;

    int size = _info.count();

    for (int i = 0; i < size; i++)
    {
      _info.at(i).visible = !enabled;
    }
  }
};
