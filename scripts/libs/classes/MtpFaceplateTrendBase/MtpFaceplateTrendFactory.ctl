
// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpViewModel/MtpViewModelBase"
#uses "classes/AnaMon/AnaMonFaceplateTrend"
#uses "classes/MtpFaceplateTrendBase/MtpFaceplateTrendBase"
class MtpFaceplateTrendFactory
{
  private MtpFaceplateTrendFactory()
  {

  }

  public static shared_ptr<MtpFaceplateTrendBase> create(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes)
  {
    switch (getTypeName(viewModel))
    {
      case "AnaMon": return new AnaMonFaceplateTrend(viewModel, shapes);

      default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, ErrCode::UNEXPECTEDSTATE, "viewModel not defined '" + getTypeName(viewModel) + "'"));
    }
  }
};
