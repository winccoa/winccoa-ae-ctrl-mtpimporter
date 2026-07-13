// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_DataAssembly/MTP_DataAssembly"

/**
 * @class MTP_ActiveElement
 * @brief Represents the MTP_ActiveElement class.
 */
class MTP_ActiveElement : MTP_DataAssembly
{
  private shared_ptr<MTP_Wqc> _wqc; //!< The quality code associated with the monitored value.
  private shared_ptr<MTP_OsLevel> _osLevel; //!< The operational state level of the monitored value.

  /**
   * @brief Constructor for the MTP_ActiveElement object.
   *
   * @param dp The data point of the MTP_ActiveElement.
   */
  public MTP_ActiveElement(const string &dp) : MTP_DataAssembly(dp)
  {
    _wqc = new MTP_Wqc(getDp() + ".WQC");
    _osLevel = new MTP_OsLevel(getDp() + ".OSLevel");
  }

    /**
   * @brief Retrieves the quality code associated with the monitored value.
   *
   * @return The quality code as a shared pointer to MTP_Wqc.
   */
  public shared_ptr<MTP_Wqc> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the operational state level of the monitored value.
   *
   * @return The operational state level as a shared pointer to MTP_OsLevel.
   */
  public shared_ptr<MTP_OsLevel> getOsLevel()
  {
    return _osLevel;
  }
};
