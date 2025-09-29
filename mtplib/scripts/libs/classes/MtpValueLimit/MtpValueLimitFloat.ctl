// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpValueLimit/MtpValueLimit"

/**
 * @class MtpValueLimitFloat
 * @brief A class that represents a float value limit within the MTP library.
 */
class MtpValueLimitFloat : MtpValueLimit
{
  /**
   * @brief Constructor for MtpValueLimitFloat.
   *
   * @param dpeLimit The data point element for the limit value.
   * @param dpeEnabled The data point element indicating if the limit is enabled.
   * @param dpeActive The data point element indicating if the limit is active.
   */
  public MtpValueLimitFloat(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive) : MtpValueLimit(dpeLimit, dpeEnabled, dpeActive)
  {

  }

  /**
   * @brief Retrieves the float limit value.
   * @details This method overrides the base class method to return the limit as a float.
   *
   * @return The float limit value.
   */
  public float getLimit() override
  {
    return MtpValueLimit::getLimit();
  }

  /**
   * @brief Sets the limit for the float value.
   * @details This method overrides the base class method to set the limit as a float.
   *
   * @param value The value to set as the limit.
   */
  public void setLimit(const float &value) override
  {
    MtpValueLimit::setLimit(value);
  }
};
