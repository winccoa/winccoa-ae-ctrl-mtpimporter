// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/AnaMon/AnaMon"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

class AnaMonFaceplateTrend : MtpFaceplateTrendBase
{
  public AnaMonFaceplateTrend(shared_ptr<AnaMon> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
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
