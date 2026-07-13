// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonBinVlv/MTP_MonBinVlv"
#uses "std"

/**
 * @class MTP_MonBinVlvCfl
 * @brief Represents the MTP_MonBinVlvCfl class.
 */
class MTP_MonBinVlvCfl : MTP_MonBinVlv
{
  private bool _enabled; //!< Indicates if the object is enabled.

  /**
   * @brief Constructor for the MTP_MonBinVlvCfl object.
   *
   * @param dp The data point of the MTP_MonBinVlvCfl.
   */
  public MTP_MonBinVlvCfl(const string &dp) : MTP_MonBinVlv(dp)
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
