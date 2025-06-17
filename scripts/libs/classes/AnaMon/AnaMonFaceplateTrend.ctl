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

  protected dyn_string getTrendDpes()
  {
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    return makeDynString(dp + ".V");
  }
};
