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

/**
 * @class AnaManIntFaceplateMain
 * @brief Represents the main faceplate for AnaManInt objects.
 */
class AnaManIntFaceplateMain : MtpFaceplateMainBase
{
   /**
   * @brief Constructor for AnaManIntFaceplateMain.
   *
   * @param viewModel A shared pointer to the AnaManInt view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public AnaManIntFaceplateMain(shared_ptr<AnaManInt> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
  {
  }

    /**
   * @brief Retrieves the navigation buttons for the AnaManInt faceplate.
   * @details This method overrides the base class method to provide specific navigation buttons for the AnaManInt faceplate.
   *
   * @return A vector of shared pointers to the navigation buttons.
   */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/AnaManInt/AnaManIntFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
