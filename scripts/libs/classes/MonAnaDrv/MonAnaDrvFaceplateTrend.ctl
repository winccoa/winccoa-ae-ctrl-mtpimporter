// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

class MonAnaDrvFaceplateTrend : MtpFaceplateTrendBase
{
  public MonAnaDrvFaceplateTrend(shared_ptr< MonAnaDrv> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {

  }

  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".FwdFbk");
    return dpes;
  }
};
