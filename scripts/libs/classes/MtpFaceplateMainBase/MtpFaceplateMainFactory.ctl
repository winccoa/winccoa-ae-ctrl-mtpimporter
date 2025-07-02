// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/LockView4/LockView4FaceplateMain"
#uses "classes/BinMon/BinMonFaceplateMain"
#uses "classes/AnaMon/AnaMonFaceplateMain"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

class MtpFaceplateMainFactory
{
  private MtpFaceplateMainFactory()
  {

  }

  public static shared_ptr<MtpFaceplateMainBase> create(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes, const string &layoutNavigation)
  {

    switch (getTypeName(viewModel))
    {
      case "AnaMon": return new AnaMonFaceplateMain(viewModel, shapes, layoutNavigation);

      case "BinMon": return new BinMonFaceplateMain(viewModel, shapes, layoutNavigation);

      case "LockView4": return new LockView4FaceplateMain(viewModel, shapes, layoutNavigation);

      default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, ErrCode::UNEXPECTEDSTATE, "datapoint type not defined '" + dpTypeName(dp) + "'"));
    }

  }
};
