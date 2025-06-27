// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpView/MtpViewFaceplateSettings"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/AnaMon/AnaMon"

class AnaMonFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _txtUnitAlert;
  private shape _txtUnitWarning;
  private shape _txtUnitTolerance;
  private shape _txtAlert;
  private shape _txtWarning;
  private shape _txtTolerance;
  private bool _init;

  public AnaMonFaceplateSettings(shared_ptr<AnaMon> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    setUnit(MtpViewFaceplateSettings::getViewModel().getUnit());
  }

  public void setAlertLimit(const float &alertLimit) = 0;

  public void setWarningLimit(const float &warningLimit) = 0;

  public void setToleranceLimit(const float &toleranceLimit) = 0;

  public void switchPage() = 0;

  protected void initializeShapes()
  {
    _txtUnitAlert = MtpViewFaceplateSettings::extractShape("_txtUnitAlert");
    _txtUnitWarning = MtpViewFaceplateSettings::extractShape("_txtUnitWarning");
    _txtUnitTolerance = MtpViewFaceplateSettings::extractShape("_txtUnitTolerance");
    _txtAlert = MtpViewFaceplateSettings::extractShape("_txtAlert");
    _txtWarning = MtpViewFaceplateSettings::extractShape("_txtWarning");
    _txtTolerance = MtpViewFaceplateSettings::extractShape("_txtTolerance");
    _init = TRUE;
  }

  protected bool getInit()
  {
    return _init;
  }

  protected shape getTxtAlert()
  {
    return _txtAlert;
  }

  protected shape getTxtWarning()
  {
    return _txtWarning;
  }

  protected shape getTxtTolerance()
  {
    return _txtTolerance;
  }

  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtUnitAlert.text = "[" + unit.toString() + "]";
    _txtUnitWarning.text = "[" + unit.toString() + "]";
    _txtUnitTolerance.text = "[" + unit.toString() + "]";
  }
};
