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

/**
 * @class BinManIntFaceplateMain
 * @brief Represents the main faceplate for BinManInt objects.
 */
class BinManIntFaceplateMain : MtpFaceplateMainBase
{
  /**
  * @brief Constructor for BinManIntFaceplateMain.
  *
  * @param viewModel A shared pointer to the BinManInt view model.
  * @param shapes A mapping of shapes used in the faceplate.
  * @param layoutNavigation The layout for navigation buttons.
  */
  public BinManIntFaceplateMain(shared_ptr<BinManInt> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
  {
  }

  /**
  * @brief Retrieves the navigation buttons for the BinManInt faceplate.
  * @details This method overrides the base class method to provide specific navigation buttons for the BinManInt faceplate.
  *
  * @return A vector of shared pointers to the navigation buttons.
  */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/BinManInt/BinManIntFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
