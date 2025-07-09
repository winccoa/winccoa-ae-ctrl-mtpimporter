// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

//--------------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpView/MtpViewFaceplateSettings"


//--------------------------------------------------------------------------------
// Variables and Constants

//--------------------------------------------------------------------------------
/**
*/
class MonBinVlvFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _btnMonitorDisabled;
  private shape _btnMonitorEnabled;

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
