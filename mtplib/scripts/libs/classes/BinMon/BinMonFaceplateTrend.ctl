// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/BinMon/BinMon"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class BinMonFaceplateTrend
 * @brief Represents a specialized faceplate trend for BinMon objects.
 */
class BinMonFaceplateTrend : MtpFaceplateTrendBase
{
  /**
   * @brief Constructor for BinMonFaceplateTrend.
   *
   * @param viewModel A shared pointer to the BinMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public BinMonFaceplateTrend(shared_ptr<BinMon> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {
  }

  /**
   * @brief Retrieves the dynamic list of trend DPEs.
   * @details This method overrides the base class method to include the specific DPEs for BinMon trends.
   *
   * @return A dynamic string containing the trend DPEs.
   */
  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".V");
    return dpes;
  }
};
