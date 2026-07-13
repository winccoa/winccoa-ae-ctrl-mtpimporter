// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "std"
#uses "classes/MTP_DIntMon/MTP_DIntMon"

/**
 * @class MTP_DIntMonCfl
 * @brief Represents the MTP_DIntMonCfl class.
 */
class MTP_DIntMonCfl : MTP_DIntMon
{
  private bool _enabled; //!< Indicates if the object is enabled.

  /**
   * @brief Constructor for the MTP_DIntMonCfl object.
   *
   * @param dp The data point of the MTP_DIntMonCfl.
   */
  public MTP_DIntMonCfl(const string &dp) : MTP_DIntMon(dp)
  {
    if (!dpExists(getDp() + ".enabled"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dp + ".enabled"));
    }

    dpConnect(this, setEnabledCB, dp + ".enabled");
  }

  #event enabledChanged(const bool &enabled) //!< Event triggered when the enabled changes.

  /**
   * @brief Retrieves the enabled.
   *
   * @return The enabled.
   */
  public bool getEnabled()
  {
    return _enabled;
  }

  /**
   * @brief Sets the enabled from the connected data point element.
   *
   * @param dpe The data point element.
   * @param enabled The new enabled value.
   */
  private void setEnabledCB(const string &dpe, const bool &enabled)
  {
    _enabled = enabled;
    enabledChanged(_enabled);
  }
};
