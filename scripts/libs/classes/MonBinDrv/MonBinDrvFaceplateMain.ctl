// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

class MonBinDrvFaceplateMain : MtpFaceplateMainBase
{
  public MonBinDrvFaceplateMain(shared_ptr<MonBinDrv> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpFaceplateMainBase(viewModel, shapes, layoutNavigation)
  {
  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/MonBinDrv/MonBinDrvFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "Settings", "object_parts/MonBinDrv/MonBinDrvFaceplateSettings.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
