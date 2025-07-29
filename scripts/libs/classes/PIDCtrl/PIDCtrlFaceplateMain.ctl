// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/PIDCtrl/PIDCtrl"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

/**
 * @class PIDCtrlFaceplateMain
 * @brief Represents the main faceplate for PIDCtrl objects.
 */
class PIDCtrlFaceplateMain : MtpFaceplateMainBase
{
  /**
     * @brief Constructor for PIDCtrlFaceplateMain.
     * @details Initializes the main faceplate for a PID controller by calling the base class constructor.
     *
     * @param viewModel A shared pointer to the PIDCtrl view model.
     * @param shapes A mapping of shapes used in the faceplate.
     */
  public PIDCtrlFaceplateMain(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
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

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/PIDCtrl/PIDCtrlFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "Settings", "object_parts/PIDCtrl/PIDCtrlFaceplateSettings.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
