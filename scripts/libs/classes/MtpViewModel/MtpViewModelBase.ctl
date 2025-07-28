// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MtpViewModelBase
 * @brief Base class for MTP View Models.
 */
class MtpViewModelBase
{
  private string _dp; //!< The data point associated with this view model.
  private bool _enabled;
  private langString _tagName;

  /**
   * @brief Constructor for MtpViewModelBase.
   *
   * @param dp The data point of the view model.
   */
  protected MtpViewModelBase(const string &dp)
  {
    _dp = dp;

    if (!dpExists(_dp))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dp));
    }

    if (!dpExists(_dp + ".enabled"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dp + ".enabled"));
    }

    if (!dpExists(_dp + ".tagName"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dp + ".tagName"));
    }

    dpGet(dp + ".tagName", _tagName);
    dpConnect(this, setEnabledCB, dp + ".enabled");
  }

#event enabledChanged(const bool &enabled)

  /**
   * @brief Retrieves the data point of the view model.
   *
   * @return The data point as a string.
   */
  public string getDp()
  {
    return _dp;
  }

  public bool getEnabled()
  {
    return _enabled;
  }

  public langString getTagName()
  {
    return _tagName;
  }

  private void setEnabledCB(const string &dpe, const bool &enabled)
  {
    _enabled = enabled;
    enabledChanged(_enabled);
  }
};
