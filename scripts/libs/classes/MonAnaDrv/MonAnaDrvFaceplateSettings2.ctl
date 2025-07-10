// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewFaceplateSettings"

class MonAnaDrvFaceplateSettings2 : MtpViewFaceplateSettings
{
  private shape _txtRpmAlarmHighLimit;
  private shape _txtRpmAlarmLowLimit;
  private shape _txtRpmUnit1;
  private shape _txtRpmUnit2;

  public MonAnaDrvFaceplateSettings2(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    setUnit(MtpViewFaceplateSettings::getViewModel().getRpmUnit());
    _txtRpmAlarmHighLimit.text = MtpViewFaceplateSettings::getViewModel().getRpmAlarmHighLimit();
    _txtRpmAlarmLowLimit.text = MtpViewFaceplateSettings::getViewModel().getRpmAlarmLowLimit();
  }

  public void switchPageForward()
  {

  }

  public void switchPageBackward()
  {
    loadPanel("object_parts/MonAnaDrv/MonAnaDrvFaceplateSettings1.xml", "1");
  }

  public void setRpmAlarmHighLimit(const float &rpmAlarmHighLimit)
  {
    MtpViewFaceplateSettings::getViewModel().setRpmAlarmHighLimit(rpmAlarmHighLimit);
  }

  public void setRpmAlarmLowLimit(const float &rpmAlarmLowLimit)
  {
    MtpViewFaceplateSettings::getViewModel().setRpmAlarmLowLimit(rpmAlarmLowLimit);
  }

  protected void initializeShapes() override
  {
    _txtRpmAlarmHighLimit = MtpViewFaceplateSettings::extractShape("_txtRpmAlarmHighLimit");
    _txtRpmAlarmLowLimit = MtpViewFaceplateSettings::extractShape("_txtRpmAlarmLowLimit");
    _txtRpmUnit1 = MtpViewFaceplateSettings::extractShape("_txtRpmUnit1");
    _txtRpmUnit2 = MtpViewFaceplateSettings::extractShape("_txtRpmUnit2");
  }

  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtRpmUnit1.text = "[" + unit.toString() + "]";
    _txtRpmUnit2.text = "[" + unit.toString() + "]";
  }
};
