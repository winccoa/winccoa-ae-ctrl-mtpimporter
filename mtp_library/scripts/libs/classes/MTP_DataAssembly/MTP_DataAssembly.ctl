// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MTP_DataAssembly
 * @brief Represents the MTP_DataAssembly class.
 */
class MTP_DataAssembly
{
  private string _dp; //!< The data point.
  private langString _tagName; //!< The tag name.

  /**
   * @brief Constructor for the MTP_DataAssembly object.
   *
   * @param dp The data point of the MTP_DataAssembly.
   */
  public MTP_DataAssembly(const string &dp)
  {
    _dp = dp;

    if (!dpExists(_dp))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dp));
    }

    if (!dpExists(getDp() + ".tagName"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp + ".tagName"));
    }

    dpGet(dp + ".tagName", _tagName);
  }

  /**
   * @brief Retrieves the data point.
   *
   * @return The data point.
   */
  public string getDp()
  {
    return _dp;
  }

  /**
   * @brief Retrieves the tag name.
   *
   * @return The tag name.
   */
  public langString getTagName()
  {
    return _tagName;
  }
};
