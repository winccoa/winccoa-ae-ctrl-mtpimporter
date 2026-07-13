// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MTP_Unit
 * @brief Represents the MTP_Unit class.
 */
class MTP_Unit
{
  private int _value; //!< The value of the unit.

  /**
   * @brief Constructor for MTP_Unit.
   *
   * @param dpeUnit The data point element for the unit value.
   */
  public MTP_Unit(const string &dpeUnit)
  {
    if (!dpExists(dpeUnit))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeUnit));
    }

    dpGet(dpeUnit, _value);
  }

  /**
   * @brief Converts the MTP_Unit object to its string representation.
   * 
   * @return A string representation of the MTP_Unit object.
   */
  public string toString()
  {
    return getCatStr("LCFL_Unit", _value);
  }
};
