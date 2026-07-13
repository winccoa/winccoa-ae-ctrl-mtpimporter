// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_DataAssembly/MTP_DataAssembly"

/**
 * @class MTP_IndicatorElement
 * @brief Represents the MTP_IndicatorElement class.
 */
class MTP_IndicatorElement : MTP_DataAssembly
{
  private shared_ptr<MTP_Wqc> _wqc; //!< The WQC instance.

  /**
   * @brief Constructor for the MTP_IndicatorElement object.
   *
   * @param dp The data point of the MTP_IndicatorElement.
   */
  public MTP_IndicatorElement(const string &dp) : MTP_DataAssembly(dp)
  {
    _wqc = new MTP_Wqc(getDp() + ".WQC");
  }

  /**
   * @brief Retrieves the WQC.
   *
   * @return The WQC.
   */
  public shared_ptr<MTP_Wqc> getWqc()
  {
    return _wqc;
  }
};
