// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

/**
 * @class MonBinDrvFaceplateMain
 * @brief Represents the main faceplate for MonBinDrv objects.
 */
class MonBinDrvFaceplateMain : MtpFaceplateMainBase
{

  /**
  * @brief Constructor for MonBinDrvFaceplateMain.
  *
  * @param viewModel A shared pointer to the MonBinDrv view model.
  * @param shapes A mapping of shapes used in the faceplate.
  */
  public MonBinDrvFaceplateMain(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
  {
  }

  /**
  * @brief Retrieves the navigation buttons for the MonBinDrv faceplate.
  * @details This method overrides the base class method to provide specific navigation buttons for the MonBinDrv faceplate.
  *
  * @return A vector of shared pointers to the navigation buttons.
  */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton("MTP_Icones/Home.svg", "Home", "object_parts/MonBinDrv/MonBinDrvFaceplateHome.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "Settings", "object_parts/MonBinDrv/MonBinDrvFaceplateSettings.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
