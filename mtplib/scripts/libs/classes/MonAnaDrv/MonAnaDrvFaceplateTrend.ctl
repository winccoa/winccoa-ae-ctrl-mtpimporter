// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

/**
 * @class MonAnaDrvFaceplateTrend
 * @brief Represents a specialized faceplate trend for MonAnaDrv objects.
 */
class MonAnaDrvFaceplateTrend : MtpFaceplateTrendBase
{

  /**
  * @brief Constructor for MonAnaDrvFaceplateTrend.
  *
  * @param viewModel A shared pointer to the MonAnaDrv view model.
  * @param shapes A mapping of shapes used in the faceplate.
  */
  public MonAnaDrvFaceplateTrend(shared_ptr< MonAnaDrv> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {

  }

  /**
  * @brief Retrieves the dynamic list of trend DPEs.
  * @details This method overrides the base class method to include the specific DPEs for MonAnaDrv trends.
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
