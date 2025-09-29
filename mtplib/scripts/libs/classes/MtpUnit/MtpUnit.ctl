// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "std"

/**
 * @class MtpUnit
 * @brief Represents a unit in the MTP library.
 */
class MtpUnit
{
  private int _value; //!< The value of the unit.

  /**
   * @brief Constructor for MtpUnit.
   *
   * @param dpeUnit The data point element for the unit value.
   */
  public MtpUnit(const string &dpeUnit)
  {
    if (!dpExists(dpeUnit))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeUnit));
    }

    dpGet(dpeUnit, _value);
  }

  /**
   * @brief Converts the MtpUnit object to its string representation.
   * 
   * @return A string representation of the MtpUnit object.
   */
  public string toString()
  {
    return getCatStr("LCFL_Unit", _value);
  }
};
