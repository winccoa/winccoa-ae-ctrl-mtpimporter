// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewFaceplateSettings"

/**
 * @class MonBinDrvFaceplateSettings
 * @brief Represents the settings faceplate for the MonBinDrv objects.
 */
class MonBinDrvFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _btnMonitorDisabled; //!< Reference to the monitor disabled button shape.
  private shape _btnMonitorEnabled; //!< Reference to the monitor enabled button shape.
  private bool _osLevelStation; //!< Indicates if the OS station level is active.

  /**
   * @brief Constructor for MonBinDrvFaceplateSettings.
   *
   * @param viewModel A shared pointer to the MonBinDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonBinDrvFaceplateSettings(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
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
  * @brief Switches to the next settings faceplate (not implemented -> Maintenance).
  */
  public void switchPageForward()
  {
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
