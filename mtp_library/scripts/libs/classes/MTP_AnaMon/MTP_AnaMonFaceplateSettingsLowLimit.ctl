// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimitFloat"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_AnaMon/MTP_AnaMonFaceplateSettings"

/**
 * @class MTP_AnaMonFaceplateSettingsLowLimit
 * @brief Represents the MTP_AnaMonFaceplateSettingsLowLimit class.
 */
class MTP_AnaMonFaceplateSettingsLowLimit : MTP_AnaMonFaceplateSettings
{
  /**
   * @brief Constructor for MTP_AnaMonFaceplateSettingsLowLimit.
   *
   * @param viewModel A shared pointer to the MTP_AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_AnaMonFaceplateSettingsLowLimit(shared_ptr<MTP_AnaMon> viewModel, const mapping &shapes) : MTP_AnaMonFaceplateSettings(viewModel, shapes)
  {
    // we need to slow down a little.
    while (!MTP_AnaMonFaceplateSettings::getInit())
    {
      delay(0, 50);
    }

    shape txtAlert = MTP_AnaMonFaceplateSettings::getTxtAlert();
    shape txtWarning = MTP_AnaMonFaceplateSettings::getTxtWarning();
    shape txtTolerance = MTP_AnaMonFaceplateSettings::getTxtTolerance();

    txtAlert.text = MTP_AnaMonFaceplateSettings::getViewModel().getAlertLowLimit().getLimit();
    txtWarning.text = MTP_AnaMonFaceplateSettings::getViewModel().getWarningLowLimit().getLimit();
    txtTolerance.text = MTP_AnaMonFaceplateSettings::getViewModel().getToleranceLowLimit().getLimit();

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    setValueLimitsEnabled(MTP_ViewBase::getViewModel().getAlertLowLimit(), MTP_ViewBase::getViewModel().getWarningLowLimit(), MTP_ViewBase::getViewModel().getToleranceLowLimit());
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Sets the alert limit for the low limit settings.
   *
   * @param alertLimit The alert limit value to be set.
   */
  public void setAlertLimit(const float &alertLimit)override
  {
    MTP_AnaMonFaceplateSettings::getViewModel().getAlertLowLimit().setLimit(alertLimit);
  }

  /**
   * @brief Sets the warning limit for the low limit settings.
   *
   * @param warningLimit The warning limit value to be set.
   */
  public void setWarningLimit(const float &warningLimit)override
  {
    MTP_AnaMonFaceplateSettings::getViewModel().getWarningLowLimit().setLimit(warningLimit);
  }

  /**
   * @brief Sets the tolerance limit for the low limit settings.
   *
   * @param toleranceLimit The tolerance limit value to be set.
   */
  public void setToleranceLimit(const float &toleranceLimit)override
  {
    MTP_AnaMonFaceplateSettings::getViewModel().getToleranceLowLimit().setLimit(toleranceLimit);
  }

  /**
   * @brief Switches the page to the high limit settings.
   */
  public void switchPage()override
  {
    loadPanel("objects_parts/faceplates/MTP_AnaMonCfl/setting.pnl", "HighLimit");
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
  private void setValueLimitsEnabled(shared_ptr<MTP_ValueLimitFloat> alarmLow, shared_ptr<MTP_ValueLimitFloat> warningLow, shared_ptr<MTP_ValueLimitFloat> toleranceLow)
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
