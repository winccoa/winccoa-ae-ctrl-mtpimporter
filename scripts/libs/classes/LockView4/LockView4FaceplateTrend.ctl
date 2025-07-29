// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/LockView4/LockView4"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class LockView4FaceplateTrend
 * @brief Represents a specialized faceplate trend for LockView4 objects.
 */
class LockView4FaceplateTrend : MtpFaceplateTrendBase
{
  /**
  * @brief Constructor for LockView4FaceplateTrend.
  *
  * @param viewModel A shared pointer to the LockView4 view model.
  * @param shapes A mapping of shapes used in the faceplate.
  */
  public LockView4FaceplateTrend(shared_ptr<LockView4> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {
  }

  /**
  * @brief Retrieves the dynamic list of trend DPEs.
  * @details This method overrides the base class method to include the specific DPEs for LockView4 trends.
  *
  * @return A dynamic string containing the trend DPEs.
  */
  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".Out");
    return dpes;
  }
};
