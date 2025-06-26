// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"
#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/BinMon/BinMon"

class BinMonFaceplateMain : MtpFaceplateMainBase
{
  public BinMonFaceplateMain(shared_ptr<BinMon> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpFaceplateMainBase(viewModel, shapes, layoutNavigation)
  {

  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/BinMon/BinMonFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "Settings", "object_parts/BinMon/BinMonFaceplateSettings.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
