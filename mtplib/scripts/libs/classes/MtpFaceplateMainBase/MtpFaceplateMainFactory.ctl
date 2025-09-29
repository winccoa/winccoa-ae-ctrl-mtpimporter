// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/Services/ServicesFaceplateMain"
#uses "classes/MonAnaDrv/MonAnaDrvFaceplateMain"
#uses "classes/MonBinVlv/MonBinVlvFaceplateMain"
#uses "classes/MonBinDrv/MonBinDrvFaceplateMain"
#uses "classes/PIDCtrl/PIDCtrlFaceplateMain"
#uses "classes/AnaManInt/AnaManIntFaceplateMain"
#uses "classes/BinManInt/BinManIntFaceplateMain"
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
   * @return A shared pointer to the created MtpFaceplateMainBase instance.
   */
  public static shared_ptr<MtpFaceplateMainBase> create(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes)
  {

    switch (getTypeName(viewModel))
    {
      case "AnaMon": return new AnaMonFaceplateMain(viewModel, shapes);

      case "BinMon": return new BinMonFaceplateMain(viewModel, shapes);

      case "LockView4": return new LockView4FaceplateMain(viewModel, shapes);

      case "BinManInt": return new BinManIntFaceplateMain(viewModel, shapes);

      case "AnaManInt": return new AnaManIntFaceplateMain(viewModel, shapes);

      case "PIDCtrl": return new PIDCtrlFaceplateMain(viewModel, shapes);

      case "MonBinDrv": return new MonBinDrvFaceplateMain(viewModel, shapes);

      case "MonBinVlv": return new MonBinVlvFaceplateMain(viewModel, shapes);

      case "MonAnaDrv": return new MonAnaDrvFaceplateMain(viewModel, shapes);

      case "Services": return new ServicesFaceplateMain(viewModel, shapes);

      default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, ErrCode::UNEXPECTEDSTATE, "datapoint type not defined '" + dpTypeName(viewModel.getDp()) + "'"));
    }
  }
};
