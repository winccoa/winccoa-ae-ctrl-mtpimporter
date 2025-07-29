// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class MonBinDrvFaceplateTrend
 * @brief Represents a specialized faceplate trend for MonBinDrv objects.
 */
class MonBinDrvFaceplateTrend : MtpFaceplateTrendBase
{
  /**
   * @brief Constructor for MonBinDrvFaceplateTrend.
   *
   * @param viewModel A shared pointer to the MonBinDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonBinDrvFaceplateTrend(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {
  }

  /**
   * @brief Retrieves the dynamic list of trend DPEs.
   * @details This method overrides the base class method to include the specific DPEs for MonBinDrv trends.
   *
   * @return A dynamic string containing the trend DPEs.
   */
  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".FwdFbk");
    return dpes;
  }
};
