// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinDrv/MTP_BinDrv"
#uses "classes/MTP_Monitor/MTP_Monitor"
#uses "std"

/**
 * @class MTP_MonBinDrv
 * @brief Represents the MTP_MonBinDrv class.
 */
class MTP_MonBinDrv : MTP_BinDrv
{
  private shared_ptr<MTP_Monitor> _monitor; //!< The monitor associated with the monitored value.

  /**
     * @brief Constructor for MTP_MonBinDrv.
     *
     * @param dp The data point identifier for the binary drive.
     */
  public MTP_MonBinDrv(const string &dp) : MTP_BinDrv(dp)
  {
    _monitor = new MTP_Monitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".MonStatErr", getDp() + ".MonDynErr", getDp() + ".MonStatTi", getDp() + ".MonDynTi");
  }

  /**
   * @brief Retrieves the monitor information.
   * @return The shared pointer to the MtpMonitor instance.
   */
  public shared_ptr<MTP_Monitor> getMonitor()
  {
    return _monitor;
  }
};
