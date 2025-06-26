// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/AnaMon/AnaMonFaceplateSettings"

class AnaMonFaceplateSettingsHighLimit : AnaMonFaceplateSettings
{
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
  }

  public void setAlertLimit(const float &alertLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getAlertHighLimit().setLimit(alertLimit);
  }

  public void setWarningLimit(const float &warningLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getWarningHighLimit().setLimit(warningLimit);
  }

  public void setToleranceLimit(const float &toleranceLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getToleranceHighLimit().setLimit(toleranceLimit);
  }

  public void switchPage()override
  {
    loadPanel("object_parts/AnaMon/AnaMonFaceplateSettingsLowLimit.xml", "LowLimit");
  }
};
