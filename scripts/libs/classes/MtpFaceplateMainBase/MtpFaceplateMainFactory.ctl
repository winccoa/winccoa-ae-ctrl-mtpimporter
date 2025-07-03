// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/LockView4/LockView4FaceplateMain"
#uses "classes/BinMon/BinMonFaceplateMain"
#uses "classes/AnaMon/AnaMonFaceplateMain"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

/**
 * @class MtpFaceplateMainFactory
 * @brief Factory class for creating instances of MtpFaceplateMainBase objects.
 */
class MtpFaceplateMainFactory
{
  /**
   * @brief Private constructor for the MtpFaceplateMainFactory class.
   *
   * This constructor is declared private to prevent direct instantiation
   * of the MtpFaceplateMainFactory class.
   */
  private MtpFaceplateMainFactory()
  {

  }

  /**
   * @brief Creates an instance of MtpFaceplateMainBase.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the faceplate.
   * @param layoutNavigation The layout for navigation buttons.
   * @return A shared pointer to the created MtpFaceplateMainBase instance.
   */
  public static shared_ptr<MtpFaceplateMainBase> create(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes, const string &layoutNavigation)
  {

    switch (getTypeName(viewModel))
    {
      case "AnaMon": return new AnaMonFaceplateMain(viewModel, shapes, layoutNavigation);

      case "BinMon": return new BinMonFaceplateMain(viewModel, shapes, layoutNavigation);

      case "LockView4": return new LockView4FaceplateMain(viewModel, shapes, layoutNavigation);

      default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, ErrCode::UNEXPECTEDSTATE, "datapoint type not defined '" + dpTypeName(dp) + "'"));
    }

  }
};
