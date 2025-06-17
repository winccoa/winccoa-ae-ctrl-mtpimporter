// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"
#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/AnaMon/AnaMon"

class AnaMonFaceplateMain : MtpFaceplateMainBase
{
  public AnaMonFaceplateMain(shared_ptr<AnaMon> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpFaceplateMainBase(viewModel, shapes, layoutNavigation)
  {

  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons()
  {
    vector<shared_ptr<MtpNavigationButton> > buttons;

    buttons.append(new MtpNavigationButton("picture", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("picture", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
