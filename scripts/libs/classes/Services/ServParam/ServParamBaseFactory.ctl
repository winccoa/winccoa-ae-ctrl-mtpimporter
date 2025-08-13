// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "std"
#uses "classes/Services/ServParamBase"
#uses "classes/Services/StringServParam"
#uses "classes/Services/DIntServParam"
#uses "classes/Services/AnaServParam"
#uses "classes/Services/BinServParam"

class ServParamBaseFactory
{

  public ServParamBaseFactory()
  {
  }

  public static shared_ptr<ServParamBase> create(const string &dp)
  {
    switch (dpTypeName(dp))
    {
      case "BinServParam": return new BinServParam(dp);

      case "AnaServParam": return new AnaServParam(dp);

      case "DIntServParam": return new DIntServParam(dp);

      case "StringServParam": return new StringServParam(dp);

      default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, ErrCode::UNEXPECTEDSTATE, "datapoint type not defined '" + dpTypeName(dp) + "'"));
    }
  }
};
