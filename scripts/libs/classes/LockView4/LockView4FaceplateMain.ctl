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

/**
 * @class LockView4FaceplateMain
 * @brief Represents the main faceplate for LockView4 objects.
 */
class LockView4FaceplateMain : MtpFaceplateMainBase
{

  /**
  * @brief Constructor for LockView4FaceplateMain.
  *
  * @param viewModel A shared pointer to the LockView4 view model.
  * @param shapes A mapping of shapes used in the faceplate.
  * @param layoutNavigation The layout for navigation buttons.
  */
  public LockView4FaceplateMain(shared_ptr<LockView4> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
  {

  }

  /**
  * @brief Retrieves the navigation buttons for the LockView4 faceplate.
  * @details This method overrides the base class method to provide specific navigation buttons for the LockView4 faceplate.
  *
  * @return A vector of shared pointers to the navigation buttons.
  */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/LockView4/LockView4FaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }

};
