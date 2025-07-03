// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/BinManInt/BinManInt"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"

class BinManIntFaceplateTrend : MtpFaceplateTrendBase
{
  public BinManIntFaceplateTrend(shared_ptr<BinManInt> viewModel, const mapping &shapes) : MtpFaceplateTrendBase(viewModel, shapes)
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
