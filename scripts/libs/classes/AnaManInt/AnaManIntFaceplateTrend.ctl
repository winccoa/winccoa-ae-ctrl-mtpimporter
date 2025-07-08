// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/AnaManInt/AnaManInt"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

class AnaManIntFaceplateTrend : MtpFaceplateTrendBase
{
  public AnaManIntFaceplateTrend(shared_ptr<AnaManInt> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
  {

  }

  protected dyn_string getTrendDpes() override
  {
    dyn_string dpes = MtpFaceplateTrendBase::getTrendDpes();
    string dp = MtpFaceplateTrendBase::getViewModel().getDp();
    dpes.append(dp + ".VOut");
    return dpes;
  }
};
