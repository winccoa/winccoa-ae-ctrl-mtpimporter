// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpView/MtpViewFaceplateSettings"

class MonBinVlvFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _btnMonitorDisabled;
  private shape _btnMonitorEnabled;
  private bool _osLevelStation;

  public MonBinVlvFaceplateSettings(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
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
