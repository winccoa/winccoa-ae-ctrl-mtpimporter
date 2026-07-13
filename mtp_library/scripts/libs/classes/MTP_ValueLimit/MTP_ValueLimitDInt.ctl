// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimit"

/**
 * @class MTP_ValueLimitDInt
 * @brief Represents the MTP_ValueLimitDInt class.
 */
class MTP_ValueLimitDInt : MTP_ValueLimit
{
  /**
   * @brief Constructor for MTP_ValueLimitDInt.
   *
   * @param dpeLimit The data point element for the limit value.
   * @param dpeEnabled The data point element indicating if the limit is enabled.
   * @param dpeActive The data point element indicating if the limit is active.
   */
  public MTP_ValueLimitDInt(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive) : MTP_ValueLimit(dpeLimit, dpeEnabled, dpeActive)
  {

  }

  /**
   * @brief Retrieves the int limit value.
   *
   * @return The int limit value.
   */
  public int getLimit() override
  {
    return MTP_ValueLimit::getLimit();
  }

  /**
   * @brief Sets the limit for the int value.
   *
   * @param value The value to set as the limit.
   */
  public void setLimit(const int &value) override
  {
    MTP_ValueLimit::setLimit(value);
  }
};
