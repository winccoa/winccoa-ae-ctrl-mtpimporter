// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewFaceplateSettings"

class MonBinDrvFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _btnMonitorDisabled;
  private shape _btnMonitorEnabled;

  public MonBinDrvFaceplateSettings(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
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
  }

  public void changeMonitorEnabled()
  {
    MtpViewFaceplateSettings::getViewModel().getMonitor().setEnabled(TRUE);

    _btnMonitorEnabled.backCol = "mtpTitlebar";
    _btnMonitorDisabled.backCol = "mtpBorder";
  }

  public void changeMonitorDisabled()
  {
    MtpViewFaceplateSettings::getViewModel().getMonitor().setEnabled(FALSE);

    _btnMonitorEnabled.backCol = "mtpBorder";
    _btnMonitorDisabled.backCol = "mtpTitlebar";
  }

  protected void initializeShapes() override
  {
    _btnMonitorDisabled = MtpViewFaceplateSettings::extractShape("_btnMonitorDisabled");
    _btnMonitorEnabled = MtpViewFaceplateSettings::extractShape("_btnMonitorEnabled");
  }
};
