// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimit"

/**
 * @class MTP_ValueLimitFloat
 * @brief Represents the MTP_ValueLimitFloat class.
 */
class MTP_ValueLimitFloat : MTP_ValueLimit
{
  /**
   * @brief Constructor for MTP_ValueLimitFloat.
   *
   * @param dpeLimit The data point element for the limit value.
   * @param dpeEnabled The data point element indicating if the limit is enabled.
   * @param dpeActive The data point element indicating if the limit is active.
   */
  public MTP_ValueLimitFloat(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive) : MTP_ValueLimit(dpeLimit, dpeEnabled, dpeActive)
  {

  }

  /**
   * @brief Retrieves the float limit value.
   *
   * @return The float limit value.
   */
  public float getLimit() override
  {
    return MTP_ValueLimit::getLimit();
  }

  /**
   * @brief Sets the limit for the float value.
   *
   * @param value The value to set as the limit.
   */
  public void setLimit(const float &value) override
  {
    MTP_ValueLimit::setLimit(value);
  }
};
