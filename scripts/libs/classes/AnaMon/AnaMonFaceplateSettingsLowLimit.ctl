// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/AnaMon/AnaMonFaceplateSettings"

/**
 * @class AnaMonFaceplateSettingsLowLimit
 * @brief Represents the low limit settings faceplate for the AnaMon objects.
 */
class AnaMonFaceplateSettingsLowLimit : AnaMonFaceplateSettings
{
  /**
   * @brief Constructor for AnaMonFaceplateSettingsLowLimit.
   *
   * @param viewModel A shared pointer to the AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public AnaMonFaceplateSettingsLowLimit(shared_ptr<AnaMon> viewModel, const mapping &shapes) : AnaMonFaceplateSettings(viewModel, shapes)
  {
    // we need to slow down a little.
    while (!AnaMonFaceplateSettings::getInit())
    {
      delay(0, 50);
    }

    shape txtAlert = AnaMonFaceplateSettings::getTxtAlert();
    shape txtWarning = AnaMonFaceplateSettings::getTxtWarning();
    shape txtTolerance = AnaMonFaceplateSettings::getTxtTolerance();

    txtAlert.text = AnaMonFaceplateSettings::getViewModel().getAlertLowLimit().getLimit();
    txtWarning.text = AnaMonFaceplateSettings::getViewModel().getWarningLowLimit().getLimit();
    txtTolerance.text = AnaMonFaceplateSettings::getViewModel().getToleranceLowLimit().getLimit();

    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    setValueLimitsEnabled(MtpViewBase::getViewModel().getAlertLowLimit(), MtpViewBase::getViewModel().getWarningLowLimit(), MtpViewBase::getViewModel().getToleranceLowLimit());
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Sets the alert limit for the low limit settings.
   * @details This method overrides the base class method to set the alert limit for the low limit settings.
   *
   * @param alertLimit The alert limit value to be set.
   */
  public void setAlertLimit(const float &alertLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getAlertLowLimit().setLimit(alertLimit);
  }

  /**
   * @brief Sets the warning limit for the low limit settings.
   * @details This method overrides the base class method to set the warning limit for the low limit settings.
   *
   * @param warningLimit The warning limit value to be set.
   */
  public void setWarningLimit(const float &warningLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getWarningLowLimit().setLimit(warningLimit);
  }

  /**
   * @brief Sets the tolerance limit for the low limit settings.
   * @details This method overrides the base class method to set the tolerance limit for the low limit settings.
   *
   * @param toleranceLimit The tolerance limit value to be set.
   */
  public void setToleranceLimit(const float &toleranceLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getToleranceLowLimit().setLimit(toleranceLimit);
  }

  /**
   * @brief Switches the page to the high limit settings.
   * @details This method overrides the base class method to load the high limit settings panel.
   */
  public void switchPage()override
  {
    loadPanel("object_parts/AnaMon/AnaMonFaceplateSettingsHighLimit.xml", "HighLimit");
  }

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

  private void setValueLimitsEnabled(shared_ptr<MtpValueLimitFloat> alarmLow, shared_ptr<MtpValueLimitFloat> warningLow, shared_ptr<MtpValueLimitFloat> toleranceLow)
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
