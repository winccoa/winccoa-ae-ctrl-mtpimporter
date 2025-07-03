// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/BinManInt/BinManInt"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

class BinManIntFaceplateMain : MtpFaceplateMainBase
{
  public BinManIntFaceplateMain(shared_ptr<BinManInt> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpFaceplateMainBase(viewModel, shapes, layoutNavigation)
  {
  }

  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/BinManInt/BinManIntFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
