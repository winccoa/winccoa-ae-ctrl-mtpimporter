// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"
#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/BinMon/BinMon"

/**
 * @class BinMonFaceplateMain
 * @brief Represents the main faceplate for BinMon objects.
 */
class BinMonFaceplateMain : MtpFaceplateMainBase
{
  /**
   * @brief Constructor for BinMonFaceplateMain.
   *
   * @param viewModel A shared pointer to the BinMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   * @param layoutNavigation The layout for navigation buttons.
   */
  public BinMonFaceplateMain(shared_ptr<BinMon> viewModel, const mapping &shapes, const string &layoutNavigation) : MtpFaceplateMainBase(viewModel, shapes, layoutNavigation)
  {

  }

  /**
   * @brief Retrieves the navigation buttons for the BinMon faceplate.
   * @details This method overrides the base class method to provide specific navigation buttons for the BinMon faceplate.
   *
   * @return A vector of shared pointers to the navigation buttons.
   */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/BinMon/BinMonFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "Settings", "object_parts/BinMon/BinMonFaceplateSettings.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
