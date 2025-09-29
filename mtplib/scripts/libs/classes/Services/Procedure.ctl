// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/Services/ServParam/ServParamBaseFactory"
#uses "classes/Services/ServParam/ServParamBase"
#uses "std"

/**
 * @class Procedure
 * @brief Represents a service procedure.
 */
class Procedure
{
  private string _dp; //!< The data point representing the procedure.
  private vector<shared_ptr<ServParamBase> > _parameters; //!< The parameters of the procedure.
  private langString _name; //!< The name of the procedure.

  /**
   * @brief Represents a service procedure.
   * @param dp A constant reference to a string representing the data point.
   */
  public Procedure(const string &dp)
  {
    _dp = dp;

    if (!dpExists(_dp))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dp));
    }

    if (!dpExists(_dp + ".Name"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".Name"));
    }

    if (!dpExists(_dp + ".parameters"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".parameters"));
    }

    dyn_string parametersDPs;

    dpGet(dp + ".parameters", parametersDPs,
          dp + ".Name", _name);

    for (int i = 0; i < parametersDPs.count(); i++)
    {
      _parameters.append(ServParamBaseFactory::create(parametersDPs.at(i)));
    }
  }

  /**
   * @brief Retrieves the parameters associated with the procedure.
   * @return A vector of shared pointers to ServParamBase objects.
   */
  public vector<shared_ptr<ServParamBase> > getParameters()
  {
    return _parameters;
  }

  /**
   * @brief Retrieves the name associated with the procedure.
   * @return A string representing the name of the procedure.
   */
  public string getName()
  {
    return _name.text();
  }
};
