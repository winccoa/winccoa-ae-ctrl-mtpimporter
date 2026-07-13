// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

// Libraries used (#uses)
#uses "classes/MTP_PIDCtrl/MTP_PIDCtrl"
#uses "std"

/**
 * @class MTP_PIDCtrlCfl
 * @brief Represents the MTP_PIDCtrlCfl class.
 */
class MTP_PIDCtrlCfl : MTP_PIDCtrl
{
  private bool _enabled; //!< Indicates if the object is enabled.

  /**
   * @brief Constructor for the MTP_PIDCtrlCfl object.
   *
   * @param dp The data point of the MTP_PIDCtrlCfl.
   */
  public MTP_PIDCtrlCfl(const string &dp) : MTP_PIDCtrl(dp)
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
