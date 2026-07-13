// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_TriPosVlv/MTP_TriPosVlv"
#uses "classes/MTP_Monitor/MTP_Monitor"
#uses "std"

/**
 * @class MTP_MonTriPosVlv
 * @brief Represents the MTP_MonTriPosVlv class.
 */
class MTP_MonTriPosVlv : MTP_TriPosVlv
{
  private shared_ptr<MTP_Monitor> _pos1Monitor; //!< Monitor instance for position 1.
  private shared_ptr<MTP_Monitor> _pos2Monitor; //!< Monitor instance for position 2.
  private shared_ptr<MTP_Monitor> _pos3Monitor; //!< Monitor instance for position 3.

  /**
   * @brief Constructor for MTP_MonTriPosVlv.
   *
   * @param dp The datapoint path for the monitored tri-position valve.
   */
  public MTP_MonTriPosVlv(const string &dp) : MTP_TriPosVlv(dp)
  {
    _pos1Monitor = new MTP_Monitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".Pos1MonStatErr", getDp() + ".Pos1MonDynErr", getDp() + ".Pos1MonStatTi", getDp() + ".Pos1MonDynTi");
    _pos2Monitor = new MTP_Monitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".Pos2MonStatErr", getDp() + ".Pos2MonDynErr", getDp() + ".Pos2MonStatTi", getDp() + ".Pos2MonDynTi");
    _pos3Monitor = new MTP_Monitor(getDp() + ".MonEn", getDp() + ".MonSafePos", getDp() + ".Pos3MonStatErr", getDp() + ".Pos3MonDynErr", getDp() + ".Pos3MonStatTi", getDp() + ".Pos3MonDynTi");
  }

  /** @brief Returns monitor information for position 1. */
  /**
   * @brief Retrieves the pos1 monitor.
   *
   * @return The pos1 monitor.
   */
  public shared_ptr<MTP_Monitor> getPos1Monitor()
  {
    return _pos1Monitor;
  }

  /** @brief Returns monitor information for position 2. */
  /**
   * @brief Retrieves the pos2 monitor.
   *
   * @return The pos2 monitor.
   */
  public shared_ptr<MTP_Monitor> getPos2Monitor()
  {
    return _pos2Monitor;
  }

  /** @brief Returns monitor information for position 3. */
  /**
   * @brief Retrieves the pos3 monitor.
   *
   * @return The pos3 monitor.
   */
  public shared_ptr<MTP_Monitor> getPos3Monitor()
  {
    return _pos3Monitor;
  }
};
