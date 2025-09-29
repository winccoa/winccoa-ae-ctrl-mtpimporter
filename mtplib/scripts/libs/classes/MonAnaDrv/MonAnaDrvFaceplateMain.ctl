// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpNavigationButton/MtpNavigationButton"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

/**
 * @class MonAnaDrvFaceplateMain
 * @brief Represents the main faceplate for MonAnaDrv objects.
 */
class MonAnaDrvFaceplateMain : MtpFaceplateMainBase
{

  /**
  * @brief Constructor for MonAnaDrvFaceplateMain.
  *
  * @param viewModel A shared pointer to the MonAnaDrv view model.
  * @param shapes A mapping of shapes used in the faceplate.
  */
  public MonAnaDrvFaceplateMain(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpFaceplateMainBase(viewModel, shapes)
  {
  }

  /**
  * @brief Retrieves the navigation buttons for the MonAnaDrv faceplate.
  * @details This method overrides the base class method to provide specific navigation buttons for the MonAnaDrv faceplate.
  *
  * @return A vector of shared pointers to the navigation buttons.
  */
  protected vector<shared_ptr<MtpNavigationButton> > getNavigationButtons() override
  {
    vector<shared_ptr<MtpNavigationButton> > buttons = MtpFaceplateMainBase::getNavigationButtons();

    buttons.append(new MtpNavigationButton(makeDynString("MTP_Icones/Home1.svg", "MTP_Icones/Home2.svg", "MTP_Icones/Home3.svg"), "Home", makeDynString("object_parts/MonAnaDrv/MonAnaDrvFaceplateHome1.xml",
                                           "object_parts/MonAnaDrv/MonAnaDrvFaceplateHome2.xml",
                                           "object_parts/MonAnaDrv/MonAnaDrvFaceplateHome3.xml")));
    buttons.append(new MtpNavigationButton("MTP_Icones/Param.svg", "Settings", "object_parts/MonAnaDrv/MonAnaDrvFaceplateSettings1.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Alarms.svg", "Alarm", "object_parts/MtpFaceplate/AlarmTable.xml"));
    buttons.append(new MtpNavigationButton("MTP_Icones/Trend.svg", "Trend", "object_parts/MtpFaceplate/Trend.xml"));

    return buttons;
  }
};
