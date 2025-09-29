// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewFaceplateSettings"

/**
 * @class MonAnaDrvFaceplateSettings1
 * @brief Represents the first settings faceplate for the MonAnaDrv objects.
 */
class MonAnaDrvFaceplateSettings1 : MtpViewFaceplateSettings
{
  private shape _btnMonitorDisabled; //!< Reference to the monitor disabled button shape.
  private shape _btnMonitorEnabled; //!< Reference to the monitor enabled button shape.
  private bool _osLevelStation; //!< Indicates if the OS station level is active.

  /**
   * @brief Constructor for MonAnaDrvFaceplateSettings1.
   *
   * @param viewModel A shared pointer to the MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonAnaDrvFaceplateSettings1(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    if (MtpViewFaceplateSettings::getViewModel().getMonitor().getEnabled())
    {
      _btnMonitorEnabled.backCol = "mtpTitlebar";
      _btnMonitorDisabled.backCol = "mtpBorder";
    }
    else
    {
      _btnMonitorEnabled.backCol = "mtpBorder";
      _btnMonitorDisabled.backCol = "mtpTitlebar";
    }

    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Enables the monitor if the OS station level is active.
   */
  public void changeMonitorEnabled()
  {
    if (_osLevelStation)
    {
      MtpViewFaceplateSettings::getViewModel().getMonitor().setEnabled(TRUE);

      _btnMonitorEnabled.backCol = "mtpTitlebar";
      _btnMonitorDisabled.backCol = "mtpBorder";
    }
  }

  /**
   * @brief Disables the monitor if the OS station level is active.
   */
  public void changeMonitorDisabled()
  {
    if (_osLevelStation)
    {
      MtpViewFaceplateSettings::getViewModel().getMonitor().setEnabled(FALSE);

      _btnMonitorEnabled.backCol = "mtpBorder";
      _btnMonitorDisabled.backCol = "mtpTitlebar";
    }
  }

  /**
   * @brief Switches to the second settings faceplate.
   */
  public void switchPage()
  {
    loadPanel("object_parts/MonAnaDrv/MonAnaDrvFaceplateSettings2.xml", "2");
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the shapes.
   */
  protected void initializeShapes() override
  {
    _btnMonitorDisabled = MtpViewFaceplateSettings::extractShape("_btnMonitorDisabled");
    _btnMonitorEnabled = MtpViewFaceplateSettings::extractShape("_btnMonitorEnabled");
  }

  /**
   * @brief Sets the OS station level state.
   *
   * @param oslevel The boolean OS station level state to be set.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;
  }
};
