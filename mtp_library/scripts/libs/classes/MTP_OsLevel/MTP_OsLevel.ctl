// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MTP_OsLevel
 * @brief Represents the MTP_OsLevel class.
 */
class MTP_OsLevel
{
  private int _level; //!< The current operating system level.

  /**
   * @brief Constructor for MTP_OsLevel.
   *
   * @param dpeOsLevel The data point element for the operating system level.
   */
  public MTP_OsLevel(const string &dpeOsLevel)
  {
    if (!dpExists(dpeOsLevel))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOsLevel));
    }

    dpConnect(this, setLevelCB, dpeOsLevel);
  }

#event osStationLevelChanged(const bool &level) //!< Event triggered when the OS level changes.


  /**
   * @brief Retrieves the current operating system level.
   *
   * @return The current operating system level.
   */
  public int getLevel()
  {
    return _level;
  }

  /**
   * @brief Checks if the operating system level is at station level.
   *
   * @return True if at station level, false otherwise.
   */
  public bool getStationLevel()
  {
    return (_level > 0);
  }

  /**
   * @brief Sets the operating system level.
   *
   * @param dpe The data point element.
   * @param level The new operating system level.
   */
  private void setLevelCB(const string &dpe, const int &level)
  {
    _level = level;
    osStationLevelChanged(getStationLevel());
  }
};
