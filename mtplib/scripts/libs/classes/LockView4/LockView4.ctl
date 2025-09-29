// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpInput/MtpInput"
#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class LockView4
 * @brief Represents the LockView4 class for managing a lock view with four inputs.
 */
class LockView4 : MtpViewModelBase
{
  private bool _logic; //!< The logic state of the lock view.
  private bool _output; //!< The output state of the lock view.
  private shared_ptr<MtpInput> _input1; //!< The first input for the lock view.
  private shared_ptr<MtpInput> _input2; //!< The second input for the lock view.
  private shared_ptr<MtpInput> _input3; //!< The third input for the lock view.
  private shared_ptr<MtpInput> _input4; //!< The fourth input for the lock view.
  private shared_ptr<MtpQualityCode> _wqc; //!< The quality code associated with the lock view.
  private shared_ptr<MtpQualityCode> _outputQualityCode; //!< The quality code associated with the output.

  /**
   * @brief Constructor for the LockView4 object.
   *
   * @param dp The data point of the LockView4.
   */
  public LockView4(const string &dp) : MtpViewModelBase(dp)
  {
    if (!dpExists(getDp() + ".Logic"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Logic"));
    }

    if (!dpExists(getDp() + ".Out"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Out"));
    }

    _wqc = new MtpQualityCode(getDp() + ".WQC");
    _outputQualityCode = new MtpQualityCode(getDp() + ".OutQC");
    _input1 = new MtpInput(getDp() + ".In1En", getDp() + ".In1", getDp() + ".In1Inv", getDp() + ".In1Txt", getDp() + ".In1QC");
    _input2 = new MtpInput(getDp() + ".In2En", getDp() + ".In2", getDp() + ".In2Inv", getDp() + ".In2Txt",  getDp() + ".In2QC");
    _input3 = new MtpInput(getDp() + ".In3En", getDp() + ".In3", getDp() + ".In3Inv", getDp() + ".In3Txt", getDp() + ".In3QC");
    _input4 = new MtpInput(getDp() + ".In4En", getDp() + ".In4", getDp() + ".In4Inv", getDp() + ".In4Txt", getDp() + ".In4QC");

    dpConnect(this, setOutputCB, getDp() + ".Out");
    dpConnect(this, setLogicCB, getDp() + ".Logic");
  }

#event outputChanged(const bool &output) //!< Event triggered when the output state changes.
#event logicChanged(const bool &logic) //!< Event triggered when the logic state changes.

  /**
   * @brief Retrieves the logic state.
   *
   * @return The logic state as a boolean.
   */
  public bool getLogic()
  {
    return _logic;
  }

  /**
   * @brief Retrieves the output state.
   *
   * @return The output state as a boolean.
   */
  public bool getOutput()
  {
    return _output;
  }

  /**
   * @brief Retrieves the quality code (WQC) associated with this object.
   *
   * @return The shared pointer to the MtpQualityCode instance.
   */
  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the quality code associated with the output.
   *
   * @return The shared pointer to the MtpQualityCode instance for the output.
   */
  public shared_ptr<MtpQualityCode> getOutputQualityCode()
  {
    return _outputQualityCode;
  }

  /**
   * @brief Retrieves the first input.
   *
   * @return The shared pointer to the MtpInput instance for the first input.
   */
  public shared_ptr<MtpInput> getInput1()
  {
    return _input1;
  }

  /**
   * @brief Retrieves the second input.
   *
   * @return The shared pointer to the MtpInput instance for the second input.
   */
  public shared_ptr<MtpInput> getInput2()
  {
    return _input2;
  }

  /**
   * @brief Retrieves the third input.
   *
   * @return The shared pointer to the MtpInput instance for the third input.
   */
  public shared_ptr<MtpInput> getInput3()
  {
    return _input3;
  }

  /**
   * @brief Retrieves the fourth input.
   *
   * @return The shared pointer to the MtpInput instance for the fourth input.
   */
  public shared_ptr<MtpInput> getInput4()
  {
    return _input4;
  }

  /**
   * @brief Sets the output state of the lock view.
   * @details Triggers the outputChanged event.
   *
   * @param dpe The data point element.
   * @param output The new output value to set.
   */
  private void setOutputCB(const string &dpe, const bool &output)
  {
    _output = output;
    outputChanged(_output);
  }

  /**
   * @brief Sets the logic state of the lock view.
   * @details Triggers the logicChanged event.
   *
   * @param dpe The data point element.
   * @param logic The new logic state to set.
   */
  private void setLogicCB(const string &dpe, const bool &logic)
  {
    _logic = logic;
    logicChanged(_logic);
  }
};
