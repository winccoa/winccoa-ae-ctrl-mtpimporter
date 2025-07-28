// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/AnaManInt/AnaManInt"
#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

class AnaManIntFaceplateMain : MtpFaceplateMainBase
{
  public AnaManIntFaceplateMain(shared_ptr<AnaManInt> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
  {
  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/AnaManInt/AnaManIntFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
