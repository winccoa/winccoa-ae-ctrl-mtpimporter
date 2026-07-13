// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinVlv/MTP_BinVlv"
#uses "std"
#uses "classes/MTP_Monitor/MTP_Monitor"

/**
 * @class MTP_MonBinVlv
 * @brief Represents the MTP_MonBinVlv class.
 */
class MTP_MonBinVlv : MTP_BinVlv
{
  private shared_ptr<MTP_Monitor> _monitor; //!< The monitor associated with the monitored value.

  /**
   * @brief Constructor for MTP_MonBinVlv.
   *
   * @param dp The data point path for the valve.
   */
  public MTP_MonBinVlv(const string &dp) : MTP_BinVlv(dp)
  {
    _monitor = new MTP_Monitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".MonStatErr", getDp() + ".MonDynErr", getDp() + ".MonStatTi", getDp() + ".MonDynTi");
  }

  /**
   * @brief Retrieves the monitor information.
   * @return The shared pointer to the MTP_Monitor instance.
   */
  public shared_ptr<MTP_Monitor> getMonitor()
  {
    return _monitor;
  }
};
