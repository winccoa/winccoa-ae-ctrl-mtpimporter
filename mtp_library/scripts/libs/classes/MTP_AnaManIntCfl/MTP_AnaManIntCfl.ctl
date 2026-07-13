// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaManInt/MTP_AnaManInt"
#uses "classes/MTP_Unit/MTP_Unit"
#uses "std"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_AnaManIntCfl
 * @brief Represents the MTP_AnaManIntCfl class.
 */
class MTP_AnaManIntCfl : MTP_AnaManInt
{
  private bool _enabled; //!< Indicates if the object is enabled.

  /**
   * @brief Constructor for the MTP_AnaManIntCfl object.
   *
   * @param dp The data point of the MTP_AnaManIntCfl.
   */
  public MTP_AnaManIntCfl(const string &dp) : MTP_AnaManInt(dp)
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
