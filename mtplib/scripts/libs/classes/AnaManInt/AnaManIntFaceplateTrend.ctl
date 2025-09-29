// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/AnaManInt/AnaManInt"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class AnaManIntFaceplateTrend
 * @brief Represents a specialized faceplate trend for AnaManInt objects.
 */
class AnaManIntFaceplateTrend : MtpFaceplateTrendBase
{

  /**
  * @brief Constructor for AnaManIntFaceplateTrend.
  *
  * @param viewModel A shared pointer to the AnaManInt view model.
  * @param shapes A mapping of shapes used in the faceplate.
  */
  public AnaManIntFaceplateTrend(shared_ptr<AnaManInt> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {

  }

  /**
  * @brief Retrieves the dynamic list of trend DPEs.
  * @details This method overrides the base class method to include the specific DPEs for AnaManInt trends.
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
