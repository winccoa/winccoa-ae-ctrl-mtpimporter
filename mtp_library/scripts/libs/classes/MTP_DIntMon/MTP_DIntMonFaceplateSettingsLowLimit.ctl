// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimitDInt"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_DIntMon/MTP_DIntMonFaceplateSettings"

/**
 * @class MTP_DIntMonFaceplateSettingsLowLimit
 * @brief Represents the MTP_DIntMonFaceplateSettingsLowLimit class.
 */
class MTP_DIntMonFaceplateSettingsLowLimit : MTP_DIntMonFaceplateSettings
{
  /**
   * @brief Constructor for MTP_DIntMonFaceplateSettingsLowLimit.
   *
   * @param viewModel A shared pointer to the MTP_DIntMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_DIntMonFaceplateSettingsLowLimit(shared_ptr<MTP_DIntMon> viewModel, const mapping &shapes) : MTP_DIntMonFaceplateSettings(viewModel, shapes)
  {
    while (!MTP_DIntMonFaceplateSettings::getInit())
    {
      delay(0, 50);
    }

    shape txtAlert = MTP_DIntMonFaceplateSettings::getTxtAlert();
    shape txtWarning = MTP_DIntMonFaceplateSettings::getTxtWarning();
    shape txtTolerance = MTP_DIntMonFaceplateSettings::getTxtTolerance();

    txtAlert.text = MTP_DIntMonFaceplateSettings::getViewModel().getAlertLowLimit().getLimit();
    txtWarning.text = MTP_DIntMonFaceplateSettings::getViewModel().getWarningLowLimit().getLimit();
    txtTolerance.text = MTP_DIntMonFaceplateSettings::getViewModel().getToleranceLowLimit().getLimit();

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    setValueLimitsEnabled(MTP_ViewBase::getViewModel().getAlertLowLimit(), MTP_ViewBase::getViewModel().getWarningLowLimit(), MTP_ViewBase::getViewModel().getToleranceLowLimit());
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Sets the alert limit for the low limit settings.
   *
   * @param alertLimit The alert limit value to be set.
   */
  public void setAlertLimit(const int &alertLimit) override
  {
    MTP_DIntMonFaceplateSettings::getViewModel().getAlertLowLimit().setLimit(alertLimit);
  }

  /**
   * @brief Sets the warning limit for the low limit settings.
   *
   * @param warningLimit The warning limit value to be set.
   */
  public void setWarningLimit(const int &warningLimit) override
  {
    MTP_DIntMonFaceplateSettings::getViewModel().getWarningLowLimit().setLimit(warningLimit);
  }

  /**
   * @brief Sets the tolerance limit for the low limit settings.
   *
   * @param toleranceLimit The tolerance limit value to be set.
   */
  public void setToleranceLimit(const int &toleranceLimit) override
  {
    MTP_DIntMonFaceplateSettings::getViewModel().getToleranceLowLimit().setLimit(toleranceLimit);
  }

  /**
   * @brief Switches the page to the high limit settings.
   */
  public void switchPage() override
  {
    loadPanel("objects_parts/faceplates/MTP_DIntMonCfl/setting.pnl", "HighLimit");
  }

  /**
   * @brief Sets the OS level from the connected data point element.
   *
   * @param oslevel The new OS level value.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    if (oslevel)
    {
      txtAlert.editable = TRUE;
      txtWarning.editable = TRUE;
      txtTolerance.editable = TRUE;
    }
    else
    {
      txtAlert.editable = FALSE;
      txtWarning.editable = FALSE;
      txtTolerance.editable = FALSE;
    }
  }

  /**
   * @brief Sets the value limits enabled.
   *
   * @param alarmLow The new alarm low value.
   * @param warningLow The new warning low value.
   * @param toleranceLow The new tolerance low value.
   */
  private void setValueLimitsEnabled(shared_ptr<MTP_ValueLimitDInt> alarmLow, shared_ptr<MTP_ValueLimitDInt> warningLow, shared_ptr<MTP_ValueLimitDInt> toleranceLow)
  {
    if (alarmLow.getEnabled())
    {
      txtAlert.visible = TRUE;
    }
    else
    {
      txtAlert.visible = FALSE;
    }

    if (warningLow.getEnabled())
    {
      txtWarning.visible = TRUE;
    }
    else
    {
      txtWarning.visible = FALSE;
    }

    if (toleranceLow.getEnabled())
    {
      txtTolerance.visible = TRUE;
    }
    else
    {
      txtTolerance.visible = FALSE;
    }
  }
};
