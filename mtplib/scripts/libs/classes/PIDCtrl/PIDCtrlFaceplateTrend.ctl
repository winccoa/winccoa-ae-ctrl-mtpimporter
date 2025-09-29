// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/PIDCtrl/PIDCtrl"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class PIDCtrlFaceplateTrend
 * @brief Represents a specialized faceplate trend for PIDCtrl objects.
 */
class PIDCtrlFaceplateTrend : MtpFaceplateTrendBase
{
  /**
   * @brief Constructor for PIDCtrlFaceplateTrend.
   *
   * @param viewModel A shared pointer to the PIDCtrl view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public PIDCtrlFaceplateTrend(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {
  }

  /**
   * @brief Retrieves the dynamic list of trend DPEs.
   * @details This method overrides the base class method to include the specific DPEs for PIDCtrl trends.
   *
   * @return A dynamic string containing the trend DPEs.
   */
  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".MV");
    return dpes;
  }
};
