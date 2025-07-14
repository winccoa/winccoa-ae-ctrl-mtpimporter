// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MtpOsLevel
 * @brief Represents the operating system level functionality for the MTP library.
 */
class MtpOsLevel
{
  private int _level; //!< The current operating system level.

  /**
   * @brief Constructor for MtpOsLevel.
   *
   * @param dpeOsLevel The data point element for the operating system level.
   */
  public MtpOsLevel(const string &dpeOsLevel)
  {
    if (!dpExists(dpeOsLevel))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeOsLevel));
    }

    dpConnect(this, setLevelCB, dpeOsLevel);
  }

#event osLevelChanged(const int &level) //!< Event triggered when the OS level changes.

  /**
   * @brief Retrieves the current operating system level.
   *
   * @return The current operating system level.
   */
  public int getLevel()
  {
    return _level;
  }

  public bool getStationLevel()
  {
    return (_level > 0);
  }

  /**
   * @brief Sets the operating system level.
   * @details Triggers the osLevelChanged event.
   *
   * @param dpe The data point element.
   * @param level The new operating system level.
   */
  private void setLevelCB(const string &dpe, const int &level)
  {
    _level = level;
    osLevelChanged(getLevel());
  }
};
