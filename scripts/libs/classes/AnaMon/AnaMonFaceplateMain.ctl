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

/**
 * @class AnaMonFaceplateMain
 * @brief Represents the main faceplate for AnaMon objects.
 */
class AnaMonFaceplateMain : MtpFaceplateMainBase
{
  /**
   * @brief Constructor for AnaMonFaceplateMain.
   *
   * @param viewModel A shared pointer to the AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   * @param layoutNavigation The layout for navigation buttons.
   */
  public AnaMonFaceplateMain(shared_ptr<AnaMon> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpFaceplateMainBase(viewModel, shapes, layoutNavigation)
  {
    
  }

  /**
   * @brief Retrieves the navigation buttons for the AnaMon faceplate.
   * @details This method overrides the base class method to provide specific navigation buttons for the AnaMon faceplate.
   *
   * @return A vector of shared pointers to the navigation buttons.
   */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/AnaMon/AnaMonFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "HighLimit", "object_parts/AnaMon/AnaMonFaceplateSettingsHighLimit.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
