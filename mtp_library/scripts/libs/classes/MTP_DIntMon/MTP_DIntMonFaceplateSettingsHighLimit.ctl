// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimitDInt"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_DIntMon/MTP_DIntMon"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_DIntMon/MTP_DIntMonFaceplateSettings"

/**
 * @class MTP_DIntMonFaceplateSettingsHighLimit
 * @brief Represents the MTP_DIntMonFaceplateSettingsHighLimit class.
 */
class MTP_DIntMonFaceplateSettingsHighLimit : MTP_DIntMonFaceplateSettings
{
  /**
   * @brief Constructor for MTP_DIntMonFaceplateSettingsHighLimit.
   *
   * @param viewModel A shared pointer to the MTP_DIntMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_DIntMonFaceplateSettingsHighLimit(shared_ptr<MTP_DIntMon> viewModel, const mapping &shapes) : MTP_DIntMonFaceplateSettings(viewModel, shapes)
  {
    while (!MTP_DIntMonFaceplateSettings::getInit())
    {
      delay(0, 50);
    }

    shape txtAlert = MTP_DIntMonFaceplateSettings::getTxtAlert();
    shape txtWarning = MTP_DIntMonFaceplateSettings::getTxtWarning();
    shape txtTolerance = MTP_DIntMonFaceplateSettings::getTxtTolerance();

    txtAlert.text = MTP_DIntMonFaceplateSettings::getViewModel().getAlertHighLimit().getLimit();
    txtWarning.text = MTP_DIntMonFaceplateSettings::getViewModel().getWarningHighLimit().getLimit();
    txtTolerance.text = MTP_DIntMonFaceplateSettings::getViewModel().getToleranceHighLimit().getLimit();

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    setValueLimitsEnabled(MTP_ViewBase::getViewModel().getAlertHighLimit(), MTP_ViewBase::getViewModel().getWarningHighLimit(), MTP_ViewBase::getViewModel().getToleranceHighLimit());
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Sets the alert limit for the high limit settings.
   *
   * @param alertLimit The alert limit value to be set.
   */
  public void setAlertLimit(const int &alertLimit) override
  {
    MTP_DIntMonFaceplateSettings::getViewModel().getAlertHighLimit().setLimit(alertLimit);
  }

  /**
   * @brief Sets the warning limit for the high limit settings.
   *
   * @param warningLimit The warning limit value to be set.
   */
  public void setWarningLimit(const int &warningLimit) override
  {
    MTP_DIntMonFaceplateSettings::getViewModel().getWarningHighLimit().setLimit(warningLimit);
  }

  /**
   * @brief Sets the tolerance limit for the high limit settings.
   *
   * @param toleranceLimit The tolerance limit value to be set.
   */
  public void setToleranceLimit(const int &toleranceLimit) override
  {
    MTP_DIntMonFaceplateSettings::getViewModel().getToleranceHighLimit().setLimit(toleranceLimit);
  }

  /**
   * @brief Switches the page to the low limit settings.
   */
  public void switchPage() override
  {
    loadPanel("objects_parts/faceplates/MTP_DIntMon/setting_low.pnl", "LowLimit");
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
  private void setValueLimitsEnabled(shared_ptr<MTP_ValueLimitDInt> alarmHigh, shared_ptr<MTP_ValueLimitDInt> warningHigh, shared_ptr<MTP_ValueLimitDInt> toleranceHigh)
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
