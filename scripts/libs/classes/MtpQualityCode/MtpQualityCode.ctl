// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

/**
 * @class MtpQualityCode
 * @brief Represents the MtpQualityCode class used for managing quality codes in the MTP library.
 */
class MtpQualityCode
{
  private bit32 _value; //!< The quality code value.

  /**
   * @brief Constructor for MtpQualityCode.
   *
   * @param dpeQc The data point element for the quality code.
   */
  public MtpQualityCode(const string &dpeQc)
  {
    if (!dpExists(dpeQc))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeQc));
    }

    dpConnect(this, setQcCB, dpeQc);
  }

  #event qualityGoodChanged(const bool &qualityGood) //!< Event triggered when quality good state changes.

  /**
   * @brief Retrieves if the current quality code value is considered "good".
   *
   * @return True if the current quality code value is good, false otherwise.
   */
  public bool getQualityGood()
  {
    return (_value == 0x80 || _value == 0xFF);
  }

  /**
   * @brief Sets the quality code value.
   * @details Triggers the qualityGoodChanged event.
   *
   * @param dpe The data point element.
   * @param value The new quality code value.
   */
  private void setQcCB(const string &dpe, const bit32 value)
  {
    _value = value;

    qualityGoodChanged(getQualityGood());
  }
};
