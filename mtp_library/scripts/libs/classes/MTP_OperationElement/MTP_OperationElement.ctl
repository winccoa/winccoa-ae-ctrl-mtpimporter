// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_DataAssembly/MTP_DataAssembly"

/**
 * @class MTP_OperationElement
 * @brief Represents the MTP_OperationElement class.
 */
class MTP_OperationElement : MTP_DataAssembly
{
  private shared_ptr<MTP_OsLevel> _osLevel; //!< The operational state level of the monitored binary value.

  /**
   * @brief Constructor for the MTP_OperationElement object.
   *
   * @param dp The data point of the MTP_OperationElement.
   */
  public MTP_OperationElement(const string &dp) : MTP_DataAssembly(dp)
  {
    _osLevel = new MTP_OsLevel(getDp() + ".OSLevel");
  }

  /**
   * @brief Retrieves the operating system level.
   *
   * @return The shared pointer to the MTP_OsLevel instance.
   */
  public shared_ptr<MTP_OsLevel> getOsLevel()
  {
    return _osLevel;
  }
};
