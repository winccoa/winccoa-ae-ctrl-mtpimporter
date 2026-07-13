// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Input/MTP_Input"
#uses "classes/MTP_DiagnosticElement/MTP_DiagnosticElement"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_LockView4
 * @brief Represents the MTP_LockView4 class.
 */
class MTP_LockView4 : MTP_DiagnosticElement
{
  private bool _logic; //!< The logic state of the lock view.
  private bool _output; //!< The output state of the lock view.
  private shared_ptr<MTP_Input> _input1; //!< The first input for the lock view.
  private shared_ptr<MTP_Input> _input2; //!< The second input for the lock view.
  private shared_ptr<MTP_Input> _input3; //!< The third input for the lock view.
  private shared_ptr<MTP_Input> _input4; //!< The fourth input for the lock view.
  private shared_ptr<MTP_Wqc> _outputQualityCode; //!< The quality code associated with the output.

  /**
   * @brief Constructor for the LockView4 object.
   *
   * @param dp The data point of the LockView4.
   */
  public MTP_LockView4(const string &dp) : MTP_DiagnosticElement(dp)
  {
    if (!dpExists(getDp() + ".Logic"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Logic"));
    }

    if (!dpExists(getDp() + ".Out"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Out"));
    }

    _outputQualityCode = new MTP_Wqc(getDp() + ".OutQC");
    _input1 = new MTP_Input(getDp() + ".In1En", getDp() + ".In1", getDp() + ".In1Inv", getDp() + ".In1Txt", getDp() + ".In1QC");
    _input2 = new MTP_Input(getDp() + ".In2En", getDp() + ".In2", getDp() + ".In2Inv", getDp() + ".In2Txt",  getDp() + ".In2QC");
    _input3 = new MTP_Input(getDp() + ".In3En", getDp() + ".In3", getDp() + ".In3Inv", getDp() + ".In3Txt", getDp() + ".In3QC");
    _input4 = new MTP_Input(getDp() + ".In4En", getDp() + ".In4", getDp() + ".In4Inv", getDp() + ".In4Txt", getDp() + ".In4QC");

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
   * @brief Retrieves the quality code associated with the output.
   *
   * @return The shared pointer to the MTP_Wqc instance for the output.
   */
  public shared_ptr<MTP_Wqc> getOutputQualityCode()
  {
    return _outputQualityCode;
  }

  /**
   * @brief Retrieves the first input.
   *
   * @return The shared pointer to the MtpInput instance for the first input.
   */
  public shared_ptr<MTP_Input> getInput1()
  {
    return _input1;
  }

  /**
   * @brief Retrieves the second input.
   *
   * @return The shared pointer to the MtpInput instance for the second input.
   */
  public shared_ptr<MTP_Input> getInput2()
  {
    return _input2;
  }

  /**
   * @brief Retrieves the third input.
   *
   * @return The shared pointer to the MtpInput instance for the third input.
   */
  public shared_ptr<MTP_Input> getInput3()
  {
    return _input3;
  }

  /**
   * @brief Retrieves the fourth input.
   *
   * @return The shared pointer to the MtpInput instance for the fourth input.
   */
  public shared_ptr<MTP_Input> getInput4()
  {
    return _input4;
  }

  /**
   * @brief Sets the output state of the lock view.
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
