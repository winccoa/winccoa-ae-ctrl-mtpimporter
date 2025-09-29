// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/AnaMon/AnaMon"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/AnaMon/AnaMonFaceplateSettings"

/**
 * @class AnaMonFaceplateSettingsHighLimit
 * @brief Represents the high limit settings faceplate for the AnaMon objects.
 */
class AnaMonFaceplateSettingsHighLimit : AnaMonFaceplateSettings
{
  /**
   * @brief Constructor for AnaMonFaceplateSettingsHighLimit.
   *
   * @param viewModel A shared pointer to the AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public AnaMonFaceplateSettingsHighLimit(shared_ptr<AnaMon> viewModel, const mapping &shapes) : AnaMonFaceplateSettings(viewModel, shapes)
  {
    // we need to slow down a little.
    while (!AnaMonFaceplateSettings::getInit())
    {
      delay(0, 50);
    }

    shape txtAlert = AnaMonFaceplateSettings::getTxtAlert();
    shape txtWarning = AnaMonFaceplateSettings::getTxtWarning();
    shape txtTolerance = AnaMonFaceplateSettings::getTxtTolerance();

    txtAlert.text = AnaMonFaceplateSettings::getViewModel().getAlertHighLimit().getLimit();
    txtWarning.text = AnaMonFaceplateSettings::getViewModel().getWarningHighLimit().getLimit();
    txtTolerance.text = AnaMonFaceplateSettings::getViewModel().getToleranceHighLimit().getLimit();

    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    setValueLimitsEnabled(MtpViewBase::getViewModel().getAlertHighLimit(), MtpViewBase::getViewModel().getWarningHighLimit(), MtpViewBase::getViewModel().getToleranceHighLimit());
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }
  /**
   * @brief Sets the alert limit for the high limit settings.
   * @details This method overrides the base class method to set the alert limit for the high limit settings.
   *
   * @param alertLimit The alert limit value to be set.
   */
  public void setAlertLimit(const float &alertLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getAlertHighLimit().setLimit(alertLimit);
  }

  /**
   * @brief Sets the warning limit for the high limit settings.
   * @details This method overrides the base class method to set the warning limit for the high limit settings.
   *
   * @param warningLimit The warning limit value to be set.
   */
  public void setWarningLimit(const float &warningLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getWarningHighLimit().setLimit(warningLimit);
  }

  /**
   * @brief Sets the tolerance limit for the high limit settings.
   * @details This method overrides the base class method to set the tolerance limit for the high limit settings.
   *
   * @param toleranceLimit The tolerance limit value to be set.
   */
  public void setToleranceLimit(const float &toleranceLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getToleranceHighLimit().setLimit(toleranceLimit);
  }

  /**
   * @brief Switches the page to the low limit settings.
   * @details This method overrides the base class method to load the low limit settings panel.
   */
  public void switchPage()override
  {
    loadPanel("object_parts/AnaMon/AnaMonFaceplateSettingsLowLimit.xml", "LowLimit");
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

  private void setValueLimitsEnabled(shared_ptr<MtpValueLimitFloat> alarmHigh, shared_ptr<MtpValueLimitFloat> warningHigh, shared_ptr<MtpValueLimitFloat> toleranceHigh)
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
