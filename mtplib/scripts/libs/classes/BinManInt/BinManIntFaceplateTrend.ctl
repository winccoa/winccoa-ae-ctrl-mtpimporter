// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/BinManInt/BinManInt"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class BinManIntFaceplateTrend
 * @brief Represents a specialized faceplate trend for BinManInt objects.
 */
class BinManIntFaceplateTrend : MtpFaceplateTrendBase
{

  /**
  * @brief Constructor for BinManIntFaceplateTrend.
  *
  * @param viewModel A shared pointer to the BinManInt view model.
  * @param shapes A mapping of shapes used in the faceplate.
  */
  public BinManIntFaceplateTrend(shared_ptr<BinManInt> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {
  }

  /**
  * @brief Retrieves the dynamic list of trend DPEs.
  * @details This method overrides the base class method to include the specific DPEs for BinManInt trends.
  *
  * @return A dynamic string containing the trend DPEs.
  */
  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".VOut");
    return dpes;
  }
};
