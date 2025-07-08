
// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/AnaManInt/AnaManIntFaceplateTrend"
#uses "classes/BinManInt/BinManIntFaceplateTrend"
#uses "classes/LockView4/LockView4FaceplateTrend"
#uses "classes/MtpViewModel/MtpViewModelBase"
#uses "classes/AnaMon/AnaMonFaceplateTrend"
#uses "classes/BinMon/BinMonFaceplateTrend"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class MtpFaceplateTrendFactory
 * @brief Factory class for creating and managing MTP faceplate trend instances.
 */
class MtpFaceplateTrendFactory
{

  /**
   * @brief Private constructor for the MtpFaceplateTrendFactory class.
   *
   * This constructor is declared private to prevent direct instantiation
   * of the MtpFaceplateTrendFactory class.
   */
  private MtpFaceplateTrendFactory()
  {

  }

  /**
   * @brief Creates a new instance of a faceplate trend.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the faceplate.
   * @return A shared pointer to the created faceplate trend instance.
   */
  public static shared_ptr<MtpFaceplateTrendBase> create(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes)
  {
    switch (getTypeName(viewModel))
    {
      case "AnaMon": return new AnaMonFaceplateTrend(viewModel, shapes);

      case "BinMon": return new BinMonFaceplateTrend(viewModel, shapes);

      case "LockView4": return new LockView4FaceplateTrend(viewModel, shapes);

      case "BinManInt": return new BinManIntFaceplateTrend(viewModel, shapes);

      case "AnaManInt": return new AnaManIntFaceplateTrend(viewModel, shapes);

      default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, ErrCode::UNEXPECTEDSTATE, "viewModel not defined '" + getTypeName(viewModel) + "'"));
    }
  }
};
