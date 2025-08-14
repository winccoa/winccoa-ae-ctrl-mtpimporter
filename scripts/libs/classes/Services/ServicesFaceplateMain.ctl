// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/Services/Services"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

/**
 * @class ServicesFaceplateMain
 * @brief Represents the main faceplate for Services objects.
 */
class ServicesFaceplateMain : MtpFaceplateMainBase
{
  /**
     * @brief Constructor for ServicesFaceplateMain.
     * @details Initializes the main faceplate for a Services controller by calling the base class constructor.
     *
     * @param viewModel A shared pointer to the Services view model.
     * @param shapes A mapping of shapes used in the faceplate.
     */
  public ServicesFaceplateMain(shared_ptr<Services> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
  {
  }

  /**
   * @brief Retrieves the navigation buttons for the Services faceplate.
   * @details This method overrides the base class method to provide specific navigation buttons for the Services faceplate.
   *
   * @return A vector of shared pointers to the navigation buttons.
   */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/Services/ServicesFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/ConfigParam.svg", "ConfigParams", "object_parts/Services/ServicesFaceplateConfigParam.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Procedures.svg", "Procedures", "object_parts/Services/ServicesFaceplateProcedureParam.xml"));

    return buttons;
  }
};
