// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewFaceplateSettings"

class MonAnaDrvFaceplateSettings1 : MtpViewFaceplateSettings
{
  private shape _btnMonitorDisabled;
  private shape _btnMonitorEnabled;
  private bool _osLevelStation;

  public MonAnaDrvFaceplateSettings1(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    if (MtpViewFaceplateSettings::getViewModel().getMonitor().getEnabled())
    {
      _btnMonitorEnabled.backCol = "mtpTitlebar";
      _btnMonitorDisabled.backCol = "mtpBorder";
    }
    else
    {
      _btnMonitorEnabled.backCol = "mtpBorder";
      _btnMonitorDisabled.backCol = "mtpTitlebar";
    }

    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  public void changeMonitorEnabled()
  {
    if (_osLevelStation)
    {
      MtpViewFaceplateSettings::getViewModel().getMonitor().setEnabled(TRUE);

      _btnMonitorEnabled.backCol = "mtpTitlebar";
      _btnMonitorDisabled.backCol = "mtpBorder";
    }
  }

  public void changeMonitorDisabled()
  {
    if (_osLevelStation)
    {
      MtpViewFaceplateSettings::getViewModel().getMonitor().setEnabled(FALSE);

      _btnMonitorEnabled.backCol = "mtpBorder";
      _btnMonitorDisabled.backCol = "mtpTitlebar";
    }
  }

  public void switchPage()
  {
    loadPanel("object_parts/MonAnaDrv/MonAnaDrvFaceplateSettings2.xml", "2");
  }

  protected void initializeShapes() override
  {
    _btnMonitorDisabled = MtpViewFaceplateSettings::extractShape("_btnMonitorDisabled");
    _btnMonitorEnabled = MtpViewFaceplateSettings::extractShape("_btnMonitorEnabled");
  }

  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;
  }
};
