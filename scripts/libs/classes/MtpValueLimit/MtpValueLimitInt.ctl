// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpValueLimit/MtpValueLimit"

/**
 * @class MtpValueLimitInt
 * @brief A class that represents an integer value limit within the MTP library.
 */
class MtpValueLimitInt : MtpValueLimit
{
  /**
   * @brief Constructor for MtpValueLimitInt.
   *
   * @param dpeLimit The data point element for the limit value.
   * @param dpeEnabled The data point element indicating if the limit is enabled.
   * @param dpeActive The data point element indicating if the limit is active.
   */
  public MtpValueLimitInt(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive) : MtpValueLimit(dpeLimit, dpeEnabled, dpeActive)
  {

  }

  /**
   * @brief Retrieves the integer limit value.
   * @details This method overrides the base class method to return the limit as an integer.
   *
   * @return The integer limit value.
   */
  public int getLimit() override
  {
    return MtpValueLimit::getLimit();
  }

  /**
   * @brief Sets the limit for the integer value.
   * @details This method overrides the base class method to set the limit as an integer.
   *
   * @param value The value to set as the limit.
   */
  public void setLimit(const int &value) override
  {
    MtpValueLimit::setLimit(value);
  }
};
