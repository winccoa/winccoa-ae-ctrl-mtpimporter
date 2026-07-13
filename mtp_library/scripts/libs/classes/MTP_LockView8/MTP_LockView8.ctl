// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_LockView4/MTP_LockView4"
#uses "classes/MTP_Input/MTP_Input"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_LockView8
 * @brief Represents the MTP_LockView8 class.
 */
class MTP_LockView8 : MTP_LockView4
{
  private shared_ptr<MTP_Input> _input5; //!< The fifth input for the lock view.
  private shared_ptr<MTP_Input> _input6; //!< The sixth input for the lock view.
  private shared_ptr<MTP_Input> _input7; //!< The seventh input for the lock view.
  private shared_ptr<MTP_Input> _input8; //!< The eighth input for the lock view.

  /**
   * @brief Constructor for the LockView4 object.
   *
   * @param dp The data point of the LockView4.
   */
  public MTP_LockView8(const string &dp) : MTP_LockView4(dp)
  {
    _input5 = new MTP_Input(getDp() + ".In5En", getDp() + ".In5", getDp() + ".In5Inv", getDp() + ".In5Txt", getDp() + ".In5QC");
    _input6 = new MTP_Input(getDp() + ".In6En", getDp() + ".In6", getDp() + ".In6Inv", getDp() + ".In6Txt",  getDp() + ".In6QC");
    _input7 = new MTP_Input(getDp() + ".In7En", getDp() + ".In7", getDp() + ".In7Inv", getDp() + ".In7Txt", getDp() + ".In7QC");
    _input8 = new MTP_Input(getDp() + ".In8En", getDp() + ".In8", getDp() + ".In8Inv", getDp() + ".In8Txt", getDp() + ".In8QC");
  }

  /**
   * @brief Retrieves the fifth input.
   *
   * @return The shared pointer to the MtpInput instance for the fifth input.
   */
  public shared_ptr<MTP_Input> getInput5()
  {
    return _input5;
  }

  /**
   * @brief Retrieves the sixth input.
   *
   * @return The shared pointer to the MtpInput instance for the sixth input.
   */
  public shared_ptr<MTP_Input> getInput6()
  {
    return _input6;
  }

  /**
   * @brief Retrieves the seventh input.
   *
   * @return The shared pointer to the MtpInput instance for the seventh input.
   */
  public shared_ptr<MTP_Input> getInput7()
  {
    return _input7;
  }

  /**
   * @brief Retrieves the eighth input.
   *
   * @return The shared pointer to the MtpInput instance for the eighth input.
   */
  public shared_ptr<MTP_Input> getInput8()
  {
    return _input8;
  }
};
