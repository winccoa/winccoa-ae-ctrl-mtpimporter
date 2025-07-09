// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

class MonAnaDrvFaceplateMain : MtpFaceplateMainBase
{
  public MonAnaDrvFaceplateMain(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpFaceplateMainBase(viewModel, shapes, layoutNavigation)
  {
  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/MonAnaDrv/MonAnaDrvFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "HighLimit", "object_parts/MonAnaDrv/MonAnaDrvFaceplateSettingsHighLimit.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
