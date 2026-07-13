// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimitFloat"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_AnaMon/MTP_AnaMon"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_AnaMon/MTP_AnaMonFaceplateSettings"

/**
 * @class MTP_AnaMonFaceplateSettingsHighLimit
 * @brief Represents the MTP_AnaMonFaceplateSettingsHighLimit class.
 */
class MTP_AnaMonFaceplateSettingsHighLimit : MTP_AnaMonFaceplateSettings
{
  /**
   * @brief Constructor for MTP_AnaMonFaceplateSettingsHighLimit.
   *
   * @param viewModel A shared pointer to the MTP_AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_AnaMonFaceplateSettingsHighLimit(shared_ptr<MTP_AnaMon> viewModel, const mapping &shapes) : MTP_AnaMonFaceplateSettings(viewModel, shapes)
  {
    // we need to slow down a little.
    while (!MTP_AnaMonFaceplateSettings::getInit())
    {
      delay(0, 50);
    }

    shape txtAlert = MTP_AnaMonFaceplateSettings::getTxtAlert();
    shape txtWarning = MTP_AnaMonFaceplateSettings::getTxtWarning();
    shape txtTolerance = MTP_AnaMonFaceplateSettings::getTxtTolerance();

    txtAlert.text = MTP_AnaMonFaceplateSettings::getViewModel().getAlertHighLimit().getLimit();
    txtWarning.text = MTP_AnaMonFaceplateSettings::getViewModel().getWarningHighLimit().getLimit();
    txtTolerance.text = MTP_AnaMonFaceplateSettings::getViewModel().getToleranceHighLimit().getLimit();

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    setValueLimitsEnabled(MTP_ViewBase::getViewModel().getAlertHighLimit(), MTP_ViewBase::getViewModel().getWarningHighLimit(), MTP_ViewBase::getViewModel().getToleranceHighLimit());
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }
  /**
   * @brief Sets the alert limit for the high limit settings.
   *
   * @param alertLimit The alert limit value to be set.
   */
  public void setAlertLimit(const float &alertLimit)override
  {
    MTP_AnaMonFaceplateSettings::getViewModel().getAlertHighLimit().setLimit(alertLimit);
  }

  /**
   * @brief Sets the warning limit for the high limit settings.
   *
   * @param warningLimit The warning limit value to be set.
   */
  public void setWarningLimit(const float &warningLimit)override
  {
    MTP_AnaMonFaceplateSettings::getViewModel().getWarningHighLimit().setLimit(warningLimit);
  }

  /**
   * @brief Sets the tolerance limit for the high limit settings.
   *
   * @param toleranceLimit The tolerance limit value to be set.
   */
  public void setToleranceLimit(const float &toleranceLimit)override
  {
    MTP_AnaMonFaceplateSettings::getViewModel().getToleranceHighLimit().setLimit(toleranceLimit);
  }

  /**
   * @brief Switches the page to the low limit settings.
   */
  public void switchPage()override
  {
    loadPanel("objects_parts/faceplates/MTP_AnaMon/setting_low.pnl", "LowLimit");
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
   * @param alarmHigh The new alarm high value.
   * @param warningHigh The new warning high value.
   * @param toleranceHigh The new tolerance high value.
   */
  private void setValueLimitsEnabled(shared_ptr<MTP_ValueLimitFloat> alarmHigh, shared_ptr<MTP_ValueLimitFloat> warningHigh, shared_ptr<MTP_ValueLimitFloat> toleranceHigh)
  {
    if (alarmHigh.getEnabled())
    {
      txtAlert.visible = TRUE;
    }
    else
    {
      txtAlert.visible = FALSE;
    }

    if (warningHigh.getEnabled())
    {
      txtWarning.visible = TRUE;
    }
    else
    {
      txtWarning.visible = FALSE;
    }

    if (toleranceHigh.getEnabled())
    {
      txtTolerance.visible = TRUE;
    }
    else
    {
      txtTolerance.visible = FALSE;
    }
  }
};
