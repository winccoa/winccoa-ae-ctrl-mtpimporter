// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/BinMon/BinMon"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

class BinMonFaceplateTrend : MtpFaceplateTrendBase
{

  public BinMonFaceplateTrend(shared_ptr<BinMon> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {

  }

  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".V");
    return dpes;
  }
};
