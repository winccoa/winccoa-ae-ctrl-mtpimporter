// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_DataAssembly/MTP_DataAssembly"

/**
 * @class MTP_InputElement
 * @brief Represents the MTP_InputElement class.
 */
class MTP_InputElement : MTP_DataAssembly
{
  private shared_ptr<MTP_Wqc> _wqc; //!< Worst quality code variable.
  private shared_ptr<MTP_Wqc> _vqc; //!< Quality code of the incoming information.

  /**
   * @brief Constructor for the MTP_InputElement object.
   *
   * @param dp The data point of the input element.
   */
  public MTP_InputElement(const string &dp) : MTP_DataAssembly(dp)
  {
    _wqc = new MTP_Wqc(getDp() + ".WQC");
    _vqc = new MTP_Wqc(getDp() + ".VQC");
  }

  /**
   * @brief Retrieves the worst quality code variable.
   *
   * @return The worst quality code as a shared pointer to MTP_Wqc.
   */
  public shared_ptr<MTP_Wqc> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the quality code of the incoming information.
   *
   * @return The value quality code as a shared pointer to MTP_Wqc.
   */
  public shared_ptr<MTP_Wqc> getVqc()
  {
    return _vqc;
  }
};
