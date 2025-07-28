// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

class MonBinVlvFaceplateMain : MtpFaceplateMainBase
{
  public MonBinVlvFaceplateMain(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
  {
  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/MonBinVlv/MonBinVlvFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "Settings", "object_parts/MonBinVlv/MonBinVlvFaceplateSettings.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
