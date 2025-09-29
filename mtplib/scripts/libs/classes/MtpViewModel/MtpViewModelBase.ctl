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
  private bool _enabled; //!< Indicates if the view model is enabled.
  private langString _tagName; //!< The tag name associated with the view model.

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

#event enabledChanged(const bool &enabled) //!< Event triggered when the enabled state changes.

  /**
   * @brief Retrieves the data point of the view model.
   *
   * @return The data point as a string.
   */
  public string getDp()
  {
    return _dp;
  }

  /**
   * @brief Retrieves the enabled state of the view model.
   * @details Returns whether the view model is currently enabled.
   *
   * @return True if the view model is enabled, false otherwise.
   */
  public bool getEnabled()
  {
    return _enabled;
  }

  /**
   * @brief Retrieves the tag name of the view model.
   * @details Returns the tag name associated with the view model's data point.
   *
   * @return The tag name as a langString.
   */
  public langString getTagName()
  {
    return _tagName;
  }

  /**
   * @brief Sets the enabled state of the view model.
   * @details Updates the enabled state and triggers the enabledChanged event.
   *
   * @param dpe The data point element.
   * @param enabled The new enabled state.
   */
  private void setEnabledCB(const string &dpe, const bool &enabled)
  {
    _enabled = enabled;
    enabledChanged(_enabled);
  }
};
