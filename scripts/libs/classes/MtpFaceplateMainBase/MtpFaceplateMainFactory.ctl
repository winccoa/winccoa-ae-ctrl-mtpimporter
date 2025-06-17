// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/AnaMon/AnaMonFaceplateMain"
#uses "classes/MtpFaceplateMainBase/MtpFaceplateMainBase"

class MtpFaceplateMainFactory
{
  private MtpFaceplateMainFactory()
  {

  }

  public static shared_ptr<MtpFaceplateMainBase> create(const string &dp, const mapping &shapes, const string &layoutNavigation)
  {

    switch (dpTypeName(dp))
    {
      case "AnaMon": return new AnaMonFaceplateMain(new AnaMon(dp), shapes, layoutNavigation);

      default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, ErrCode::UNEXPECTEDSTATE, "datapoint type not defined '" + dpTypeName(dp) + "'"));
    }

  }
};
