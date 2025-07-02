// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/LockView4/LockView4"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

class LockView4FaceplateMain : MtpFaceplateMainBase
{

  public LockView4FaceplateMain(shared_ptr<LockView4> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpFaceplateMainBase(viewModel, shapes, layoutNavigation)
  {

  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/LockView4/LockView4FaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }

};
