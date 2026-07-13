// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimit"

/**
 * @class MTP_ValueLimitInt
 * @brief Represents the MTP_ValueLimitInt class.
 */
class MTP_ValueLimitInt : MTP_ValueLimit
{
  /**
   * @brief Constructor for MTP_ValueLimitInt.
   *
   * @param dpeLimit The data point element for the limit value.
   * @param dpeEnabled The data point element indicating if the limit is enabled.
   * @param dpeActive The data point element indicating if the limit is active.
   */
  public MTP_ValueLimitInt(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive) : MTP_ValueLimit(dpeLimit, dpeEnabled, dpeActive)
  {

  }

  /**
   * @brief Retrieves the integer limit value.
   *
   * @return The integer limit value.
   */
  public int getLimit() override
  {
    return MTP_ValueLimit::getLimit();
  }

  /**
   * @brief Sets the limit for the integer value.
   *
   * @param value The value to set as the limit.
   */
  public void setLimit(const int &value) override
  {
    MTP_ValueLimit::setLimit(value);
  }
};
