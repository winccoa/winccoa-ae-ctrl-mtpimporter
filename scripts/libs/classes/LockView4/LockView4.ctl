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

class LockView4 : MtpViewModelBase
{
  private bool _logic;
  private bool _output;
  private shared_ptr <MtpInput> _input1;
  private shared_ptr <MtpInput> _input2;
  private shared_ptr <MtpInput> _input3;
  private shared_ptr <MtpInput> _input4;
  private shared_ptr <MtpQualityCode> _wqc;
  private shared_ptr <MtpQualityCode> _outputQualityCode;

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


    classConnect(this, inputChangedCB, _input1, MtpInput::enabledChanged);
    classConnect(this, inputChangedCB, _input1, MtpInput::valueChanged);
    classConnect(this, inputChangedCB, _input1, MtpInput::invertedChanged);
    classConnect(this, inputChangedCB, _input2, MtpInput::enabledChanged);
    classConnect(this, inputChangedCB, _input2, MtpInput::valueChanged);
    classConnect(this, inputChangedCB, _input2, MtpInput::invertedChanged);
    classConnect(this, inputChangedCB, _input3, MtpInput::enabledChanged);
    classConnect(this, inputChangedCB, _input3, MtpInput::valueChanged);
    classConnect(this, inputChangedCB, _input3, MtpInput::invertedChanged);
    classConnect(this, inputChangedCB, _input4, MtpInput::enabledChanged);
    classConnect(this, inputChangedCB, _input4, MtpInput::valueChanged);
    classConnect(this, inputChangedCB, _input4, MtpInput::invertedChanged);

    updateOutput();
  }

#event outputChanged(const bool &output)
#event logicChanged(const bool &logic)

  public bool getLogic()
  {
    return _logic;
  }

  public bool getOutput()
  {
    return _output;
  }

  public shared_ptr<MtpQualityCode> getWqc()
  {
    return _wqc;
  }

  public shared_ptr<MtpQualityCode> getOutputQualityCode()
  {
    return _outputQualityCode;
  }

  public shared_ptr<MtpInput> getInput1()
  {
    return _input1;
  }

  public shared_ptr<MtpInput> getInput2()
  {
    return _input2;
  }

  public shared_ptr<MtpInput> getInput3()
  {
    return _input3;
  }

  public shared_ptr<MtpInput> getInput4()
  {
    return _input4;
  }

  private void setOutputCB(const string &dpe, const bool &output)
  {
    if (_output != output)
    {
      _output = output;
      outputChanged(_output);
    }
  }

  private void setLogicCB(const string &dpe, const bool &logic)
  {
    if (_logic != logic)
    {
      _logic = logic;
      logicChanged(_logic);
      updateOutput();
    }
  }

  private void inputChangedCB(const bool &value)
  {
    updateOutput();
  }

  private void updateOutput()
  {
    bool newOutput;
    bool hasEnabledInputs = false;
    dyn_bool effectiveValues;

    if (_input1.getEnabled())
    {
      bool effective = _input1.getValue() != _input1.getInverted();
      effectiveValues.append(effective);
      hasEnabledInputs = true;
    }

    if (_input2.getEnabled())
    {
      bool effective = _input2.getValue() != _input2.getInverted();
      effectiveValues.append(effective);
      hasEnabledInputs = true;
    }

    if (_input3.getEnabled())
    {
      bool effective = _input3.getValue() != _input3.getInverted();
      effectiveValues.append(effective);
      hasEnabledInputs = true;
    }

    if (_input4.getEnabled())
    {
      bool effective = _input4.getValue() != _input4.getInverted();
      effectiveValues.append(effective);
      hasEnabledInputs = true;
    }

    if (!hasEnabledInputs)
    {
      newOutput = _logic ? true : false;
    }
    else if (_logic)
    {
      newOutput = true;

      for (int i = 1; i <= effectiveValues.count(); i++)
      {
        newOutput = newOutput && effectiveValues[i];
      }
    }
    else
    {
      newOutput = false;

      for (int i = 1; i <= effectiveValues.count(); i++)
      {
        newOutput = newOutput || effectiveValues[i];
      }
    }

    if (_output != newOutput)
    {
      _output = newOutput;
      dpSetWait(getDp() + ".Out", _output);
      outputChanged(_output);
    }
  }
};
