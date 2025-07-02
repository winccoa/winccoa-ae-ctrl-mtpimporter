// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/LockView4/LockView4"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

class LockView4FaceplateTrend : MtpFaceplateTrendBase
{
  public LockView4FaceplateTrend(shared_ptr<LockView4> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {

  }

  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".Out");
    return dpes;
  }
};
