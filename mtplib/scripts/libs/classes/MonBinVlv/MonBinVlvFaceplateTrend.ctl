// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class MonBinVlvFaceplateTrend
 * @brief Represents a specialized faceplate trend for MonBinVlv objects.
 */
class MonBinVlvFaceplateTrend : MtpFaceplateTrendBase
{
  /**
   * @brief Constructor for MonBinVlvFaceplateTrend.
   *
   * @param viewModel A shared pointer to the MonBinVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonBinVlvFaceplateTrend(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {

  }

  /**
   * @brief Retrieves the dynamic list of trend DPEs.
   * @details This method overrides the base class method to include the specific DPEs for MonBinVlv trends.
   *
   * @return A dynamic string containing the trend DPEs.
   */
  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".OpenFbk");
    return dpes;
  }
};
