// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonTriPosVlv/MTP_MonTriPosVlv"
#uses "classes/MTP_View/MTP_ViewFaceplateSettings"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_MonTriPosVlvFaceplateSettings
 * @brief Represents the MTP_MonTriPosVlvFaceplateSettings class.
 */
class MTP_MonTriPosVlvFaceplateSettings : MTP_ViewFaceplateSettings
{
  private shape _btnMonitorDisabled; //!< The button monitor disabled shape.
  private shape _btnMonitorEnabled; //!< The button monitor enabled shape.
  private bool _osLevelStation; //!< Indicates if the OS level station is active.

  /**
   * @brief Constructor for the MTP_MonTriPosVlvFaceplateSettings object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_MonTriPosVlvFaceplateSettings object.
   */
  public MTP_MonTriPosVlvFaceplateSettings(shared_ptr<MTP_MonTriPosVlv> viewModel, const mapping &shapes) : MTP_ViewFaceplateSettings(viewModel, shapes)
  {
    classConnect(this, setOsLevelCB, getMonTriPosVlv().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    updateButtons(getMonTriPosVlv().getPos1Monitor().getEnabled());
    setOsLevelCB(getMonTriPosVlv().getOsLevel().getStationLevel());
  }

  /**
   * @brief Executes the change monitor enabled operation.
   */
  public void changeMonitorEnabled()
  {
    if (_osLevelStation)
    {
      getMonTriPosVlv().getPos1Monitor().setEnabled(TRUE);
      updateButtons(TRUE);
    }
  }

  /**
   * @brief Executes the change monitor disabled operation.
   */
  public void changeMonitorDisabled()
  {
    if (_osLevelStation)
    {
      getMonTriPosVlv().getPos1Monitor().setEnabled(FALSE);
      updateButtons(FALSE);
    }
  }

  /**
   * @brief Executes the switch page forward operation.
   */
  public void switchPageForward()
  {
  }

  protected void initializeShapes() override
  {
    _btnMonitorDisabled = MTP_ViewFaceplateSettings::extractShape("_btnMonitorDisabled");
    _btnMonitorEnabled = MTP_ViewFaceplateSettings::extractShape("_btnMonitorEnabled");
  }

  /**
   * @brief Retrieves the mon tri position vlv.
   *
   * @return The mon tri position vlv.
   */
  private shared_ptr<MTP_MonTriPosVlv> getMonTriPosVlv()
  {
    return MTP_ViewBase::getViewModel();
  }

  /**
   * @brief Sets the OS level from the connected data point element.
   *
   * @param oslevel The new OS level value.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;
  }

  /**
   * @brief Updates the buttons.
   *
   * @param monitorEnabled The monitor enabled.
   */
  private void updateButtons(const bool &monitorEnabled)
  {
    _btnMonitorEnabled.backCol = monitorEnabled ? "mtpTitlebar" : "mtpBorder";
    _btnMonitorDisabled.backCol = monitorEnabled ? "mtpBorder" : "mtpTitlebar";
  }
};
