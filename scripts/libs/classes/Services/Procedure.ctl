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

class Procedure
{
  private string _dp;
  private vector<shared_ptr<ServParamBase> > _parameters;
  private langString _name;

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

  public vector<shared_ptr<ServParamBase> > getParameters()
  {
    return _parameters;
  }

  public string getName()
  {
    return _name.text();
  }
};
