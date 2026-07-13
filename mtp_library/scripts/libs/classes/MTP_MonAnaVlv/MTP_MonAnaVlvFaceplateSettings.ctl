// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonAnaVlv/MTP_MonAnaVlv"
#uses "classes/MTP_View/MTP_ViewFaceplateSettings"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_MonAnaVlvFaceplateSettings
 * @brief Represents the MTP_MonAnaVlvFaceplateSettings class.
 */
class MTP_MonAnaVlvFaceplateSettings : MTP_ViewFaceplateSettings
{
  private shape _btnMonitorDisabled; //!< Reference to the monitor disabled button shape.
  private shape _btnMonitorEnabled; //!< Reference to the monitor enabled button shape.
  private bool _osLevelStation; //!< Indicates if the OS station level is active.

  /**
   * @brief Constructor for MTP_MonAnaVlvFaceplateSettings.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonAnaVlvFaceplateSettings(shared_ptr<MTP_MonAnaVlv> viewModel, const mapping &shapes) : MTP_ViewFaceplateSettings(viewModel, shapes)
  {
    if (MTP_ViewFaceplateSettings::getViewModel().getMonitor().getEnabled())
    {
      _btnMonitorEnabled.backCol = "mtpTitlebar";
      _btnMonitorDisabled.backCol = "mtpBorder";
    }
    else
    {
      _btnMonitorEnabled.backCol = "mtpBorder";
      _btnMonitorDisabled.backCol = "mtpTitlebar";
    }

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Enables the monitor if the OS station level is active.
   */
  public void changeMonitorEnabled()
  {
    if (_osLevelStation)
    {
      MTP_ViewFaceplateSettings::getViewModel().getMonitor().setEnabled(TRUE);

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
      MTP_ViewFaceplateSettings::getViewModel().getMonitor().setEnabled(FALSE);

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
   */
  protected void initializeShapes() override
  {
    _btnMonitorDisabled = MTP_ViewFaceplateSettings::extractShape("_btnMonitorDisabled");
    _btnMonitorEnabled = MTP_ViewFaceplateSettings::extractShape("_btnMonitorEnabled");
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
