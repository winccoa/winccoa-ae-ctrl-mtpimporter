// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/Services/ServParam/StringServParam"
#uses "classes/Services/ServParam/DIntServParam"
#uses "classes/Services/ServParam/AnaServParam"
#uses "classes/Services/ServParam/BinServParam"
#uses "classes/Services/ServParam/ServParamBase"
#uses "std"

/**
 * @class ServParamBaseFactory
 * @brief Factory class for creating instances of ServParamBase objects.
 */
class ServParamBaseFactory
{

  /**
  * @brief Private constructor for the ServParamBaseFactory class.
  *
  * This constructor is declared private to prevent direct instantiation
  * of the ServParamBaseFactory class.
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
      case "BinServParam": return new BinServParam(dp);

      case "AnaServParam": return new AnaServParam(dp);

      case "DIntServParam": return new DIntServParam(dp);

      case "StringServParam": return new StringServParam(dp);

      default: throw (makeError("", PRIO_SEVERE, ERR_PARAM, ErrCode::UNEXPECTEDSTATE, "datapoint type not defined '" + dpTypeName(dp) + "'"));
    }
  }
};
