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
  }

  /**
   * @brief Retrieves the data point of the view model.
   * 
   * @return The data point as a string.
   */
  public string getDp()
  {
    return _dp;
  }
};
