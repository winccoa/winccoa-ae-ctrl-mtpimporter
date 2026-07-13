// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Services/ServParam/StringServParam"
#uses "classes/MTP_Services/ServParam/DIntServParam"
#uses "classes/MTP_Services/ServParam/AnaServParam"
#uses "classes/MTP_Services/ServParam/BinServParam"
#uses "classes/MTP_Services/ServParam/ServParamBase"
#uses "std"

/**
 * @class ServParamBaseFactory
 * @brief Represents the ServParamBaseFactory class.
 */
class ServParamBaseFactory
{

  /**
  * @brief Private constructor for the ServParamBaseFactory class.
  */
  private ServParamBaseFactory()
  {
  }

  /**
  * @brief Creates an instance of ServParamBase.
  *
  * @param dp The datapoint of the element.
  * @return A shared pointer to the created ServParamBase instance.
  */
  public static shared_ptr<ServParamBase> create(const string &dp)
  {
    switch (dpTypeName(dp))
    {
      case "MTP_BinServParam": return new BinServParam(dp);

      case "MTP_AnaServParam": return new AnaServParam(dp);

      case "MTP_DIntServParam": return new DIntServParam(dp);

      case "MTP_StringServParam": return new StringServParam(dp);

    default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::UNEXPECTEDSTATE, "datapoint type not defined '" + dpTypeName(dp) + "'"));
    }
  }
};
