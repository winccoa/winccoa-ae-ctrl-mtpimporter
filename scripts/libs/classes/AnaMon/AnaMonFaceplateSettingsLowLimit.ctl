// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/AnaMon/AnaMonFaceplateSettings"

class AnaMonFaceplateSettingsLowLimit : AnaMonFaceplateSettings
{
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
  }

  public void setAlertLimit(const float &alertLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getAlertLowLimit().setLimit(alertLimit);
  }

  public void setWarningLimit(const float &warningLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getWarningLowLimit().setLimit(warningLimit);
  }

  public void setToleranceLimit(const float &toleranceLimit)override
  {
    AnaMonFaceplateSettings::getViewModel().getToleranceLowLimit().setLimit(toleranceLimit);
  }

  public void switchPage()override
  {
    loadPanel("object_parts/AnaMon/AnaMonFaceplateSettingsHighLimit.xml", "HighLimit");
  }
};
