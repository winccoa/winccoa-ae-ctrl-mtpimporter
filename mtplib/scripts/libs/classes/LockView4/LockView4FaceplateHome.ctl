// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpInput/MtpInput"
#uses "classes/LockView4/LockView4"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class LockView4FaceplateHome
 * @brief Represents the home faceplate for LockView4 objects.
 */
class LockView4FaceplateHome : MtpViewBase
{
  private shape _circleIn1En; //!< Reference to the enable circle shape for input 1.
  private shape _circleIn2En; //!< Reference to the enable circle shape for input 2.
  private shape _circleIn3En; //!< Reference to the enable circle shape for input 3.
  private shape _circleIn4En; //!< Reference to the enable circle shape for input 4.
  private shape _circleOut; //!< Reference to the output circle shape.
  private shape _lineOut; //!< Reference to the output line shape.
  private shape _lineIn1Hor; //!< Reference to the horizontal line shape for input 1.
  private shape _lineIn2Hor; //!< Reference to the horizontal line shape for input 2.
  private shape _lineIn3Hor; //!< Reference to the horizontal line shape for input 3.
  private shape _lineIn4Hor; //!< Reference to the horizontal line shape for input 4.
  private shape _lineIn1Vert; //!< Reference to the vertical line shape for input 1.
  private shape _lineIn2Vert; //!< Reference to the vertical line shape for input 2.
  private shape _lineIn3Vert; //!< Reference to the vertical line shape for input 3.
  private shape _lineIn4Vert; //!< Reference to the vertical line shape for input 4.
  private shape _rectIn1QC; //!< Reference to the quality code rectangle shape for input 1.
  private shape _rectIn2QC; //!< Reference to the quality code rectangle shape for input 2.
  private shape _rectIn3QC; //!< Reference to the quality code rectangle shape for input 3.
  private shape _rectIn4QC; //!< Reference to the quality code rectangle shape for input 4.
  private shape _txtIn1Txt; //!< Reference to the text shape for input 1.
  private shape _txtIn2Txt; //!< Reference to the text shape for input 2.
  private shape _txtIn3Txt; //!< Reference to the text shape for input 3.
  private shape _txtIn4Txt; //!< Reference to the text shape for input 4.
  private shape _txtLogic; //!< Reference to the logic text shape.
  private shape _txtIn1Label; //!< Reference to the label text shape for input 1.
  private shape _txtIn2Label; //!< Reference to the label text shape for input 2.
  private shape _txtIn3Label; //!< Reference to the label text shape for input 3.
  private shape _txtIn4Label; //!< Reference to the label text shape for input 4.
  private shape _rectOutQC; //!< Reference to the quality code rectangle shape for output.
  private shape _circleIn1Inv; //!< Reference to the inversion circle shape for input 1.
  private shape _circleIn2Inv; //!< Reference to the inversion circle shape for input 2.
  private shape _circleIn3Inv; //!< Reference to the inversion circle shape for input 3.
  private shape _circleIn4Inv; //!< Reference to the inversion circle shape for input 4.

  /**
   * @brief Constructor for LockView4FaceplateHome.
   *
   * @param viewModel A shared pointer to the LockView4 view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public LockView4FaceplateHome(shared_ptr<LockView4> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    if (MtpViewBase::getViewModel().getInput1().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in1", MtpViewBase::getViewModel().getInput1(), MtpInput::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in1", MtpViewBase::getViewModel().getInput1(), MtpInput::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn1QC", MtpViewBase::getViewModel().getInput1().getQualityCode(), MtpQualityCode::qualityGoodChanged);
      setInputChangedCB("_in1", true);
      setInputTexts("_In1Txt", MtpViewBase::getViewModel().getInput1());
      setQualityCodeCB("_rectIn1QC", MtpViewBase::getViewModel().getInput1().getQualityCode().getQualityGood());
    }
    else
    {
      _circleIn1En.visible = false;
      _lineIn1Hor.visible = false;
      _lineIn1Vert.visible = false;
      _rectIn1QC.visible = false;
      _txtIn1Txt.visible = false;
      _txtIn1Label.visible = false;
      _circleIn1Inv.visible = false;
    }

    if (MtpViewBase::getViewModel().getInput2().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in2", MtpViewBase::getViewModel().getInput2(), MtpInput::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in2", MtpViewBase::getViewModel().getInput2(), MtpInput::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn2QC", MtpViewBase::getViewModel().getInput2().getQualityCode(), MtpQualityCode::qualityGoodChanged);
      setInputChangedCB("_in2", true);
      setInputTexts("_In2Txt", MtpViewBase::getViewModel().getInput2());
      setQualityCodeCB("_rectIn2QC", MtpViewBase::getViewModel().getInput2().getQualityCode().getQualityGood());
    }
    else
    {
      _circleIn2En.visible = false;
      _lineIn2Hor.visible = false;
      _lineIn2Vert.visible = false;
      _rectIn2QC.visible = false;
      _txtIn2Txt.visible = false;
      _txtIn2Label.visible = false;
      _circleIn2Inv.visible = false;
    }

    if (MtpViewBase::getViewModel().getInput3().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in3", MtpViewBase::getViewModel().getInput3(), MtpInput::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in3", MtpViewBase::getViewModel().getInput3(), MtpInput::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn3QC", MtpViewBase::getViewModel().getInput3().getQualityCode(), MtpQualityCode::qualityGoodChanged);
      setInputChangedCB("_in3", true);
      setInputTexts("_In3Txt", MtpViewBase::getViewModel().getInput3());
      setQualityCodeCB("_rectIn3QC", MtpViewBase::getViewModel().getInput3().getQualityCode().getQualityGood());
    }
    else
    {
      _circleIn3En.visible = false;
      _lineIn3Hor.visible = false;
      _lineIn3Vert.visible = false;
      _rectIn3QC.visible = false;
      _txtIn3Txt.visible = false;
      _txtIn3Label.visible = false;
      _circleIn3Inv.visible = false;
    }

    if (MtpViewBase::getViewModel().getInput4().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in4", MtpViewBase::getViewModel().getInput4(), MtpInput::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in4", MtpViewBase::getViewModel().getInput4(), MtpInput::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn4QC", MtpViewBase::getViewModel().getInput4().getQualityCode(), MtpQualityCode::qualityGoodChanged);
      setInputChangedCB("_in4", true);
      setInputTexts("_In4Txt", MtpViewBase::getViewModel().getInput4());
      setQualityCodeCB("_rectIn4QC", MtpViewBase::getViewModel().getInput4().getQualityCode().getQualityGood());
    }
    else
    {
      _circleIn4En.visible = false;
      _lineIn4Hor.visible = false;
      _lineIn4Vert.visible = false;
      _rectIn4QC.visible = false;
      _txtIn4Txt.visible = false;
      _txtIn4Label.visible = false;
      _circleIn4Inv.visible = false;
    }

    classConnect(this, setOutqcCB, MtpViewBase::getViewModel().getOutputQualityCode(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setOutputCB, MtpViewBase::getViewModel(), LockView4::outputChanged);
    classConnect(this, setLogicCB, MtpViewBase::getViewModel(), LockView4::logicChanged);

    setOutputCB(MtpViewBase::getViewModel().getOutput());
    setLogicCB(MtpViewBase::getViewModel().getLogic());
    setOutqcCB(MtpViewBase::getViewModel().getOutputQualityCode().getQualityGood());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the required shapes.
   */
  protected void initializeShapes()
  {
    _circleIn1En = MtpViewBase::extractShape("_circleIn1En");
    _circleIn2En = MtpViewBase::extractShape("_circleIn2En");
    _circleIn3En = MtpViewBase::extractShape("_circleIn3En");
    _circleIn4En = MtpViewBase::extractShape("_circleIn4En");
    _circleOut = MtpViewBase::extractShape("_circleOut");
    _lineOut = MtpViewBase::extractShape("_lineOut");
    _lineIn1Hor = MtpViewBase::extractShape("_lineIn1Hor");
    _lineIn2Hor = MtpViewBase::extractShape("_lineIn2Hor");
    _lineIn3Hor = MtpViewBase::extractShape("_lineIn3Hor");
    _lineIn4Hor = MtpViewBase::extractShape("_lineIn4Hor");
    _lineIn1Vert = MtpViewBase::extractShape("_lineIn1Vert");
    _lineIn2Vert = MtpViewBase::extractShape("_lineIn2Vert");
    _lineIn3Vert = MtpViewBase::extractShape("_lineIn3Vert");
    _lineIn4Vert = MtpViewBase::extractShape("_lineIn4Vert");
    _rectIn1QC = MtpViewBase::extractShape("_rectIn1QC");
    _rectIn2QC = MtpViewBase::extractShape("_rectIn2QC");
    _rectIn3QC = MtpViewBase::extractShape("_rectIn3QC");
    _rectIn4QC = MtpViewBase::extractShape("_rectIn4QC");
    _txtIn1Txt = MtpViewBase::extractShape("_txtIn1Txt");
    _txtIn2Txt = MtpViewBase::extractShape("_txtIn2Txt");
    _txtIn3Txt = MtpViewBase::extractShape("_txtIn3Txt");
    _txtIn4Txt = MtpViewBase::extractShape("_txtIn4Txt");
    _txtLogic = MtpViewBase::extractShape("_txtLogic");
    _txtIn1Label = MtpViewBase::extractShape("_txtIn1Label");
    _txtIn2Label = MtpViewBase::extractShape("_txtIn2Label");
    _txtIn3Label = MtpViewBase::extractShape("_txtIn3Label");
    _txtIn4Label = MtpViewBase::extractShape("_txtIn4Label");
    _rectOutQC = MtpViewBase::extractShape("_rectOutQC");
    _circleIn1Inv = MtpViewBase::extractShape("_circleIn1Inv");
    _circleIn2Inv = MtpViewBase::extractShape("_circleIn2Inv");
    _circleIn3Inv = MtpViewBase::extractShape("_circleIn3Inv");
    _circleIn4Inv = MtpViewBase::extractShape("_circleIn4Inv");
  }

  /**
   * @brief Callback function to update the output quality code status.
   *
   * @param qualityGoodChanged Indicates if the quality good status has changed.
   */
  private void setOutqcCB(const bool &qualityGoodChanged)
  {
    if (!qualityGoodChanged)
    {
      _rectOutQC.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
      _rectOutQC.sizeAsDyn = makeDynInt(25, 25);
    }
    else
    {
      _rectOutQC.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectOutQC.sizeAsDyn = makeDynInt(30, 25);
    }
  }

  /**
   * @brief Sets the text for input text shapes.
   *
   * @param varName The name of the variable to set.
   * @param input A shared pointer to the MtpInput instance.
   */
  private void setInputTexts(const string &varName, shared_ptr<MtpInput> input)
  {
    switch (varName)
    {
      case "_In1Txt":
        _txtIn1Txt.text = input.getText();
        break;

      case "_In2Txt":
        _txtIn2Txt.text =  input.getText();
        break;

      case "_In3Txt":
        _txtIn3Txt.text =  input.getText();
        break;

      case "_In4Txt":
        _txtIn4Txt.text =  input.getText();
        break;
    }
  }

  /**
   * @brief Callback function to update the input state and its display.
   *
   * @param varName The name of the variable to set.
   * @param value The new input value or inversion state.
   */
  private void setInputChangedCB(const string &varName, const bool &value)
  {
    shape circle;
    shape lineHor;
    shape lineVert;
    shape circleInv;
    shared_ptr<MtpInput> input;

    switch (varName)
    {
      case "_in1":
        circle = _circleIn1En;
        lineHor = _lineIn1Hor;
        lineVert = _lineIn1Vert;
        circleInv = _circleIn1Inv;
        assignPtr(input, MtpViewBase::getViewModel().getInput1());
        break;

      case "_in2":
        circle = _circleIn2En;
        lineHor = _lineIn2Hor;
        lineVert = _lineIn2Vert;
        circleInv = _circleIn2Inv;
        assignPtr(input, MtpViewBase::getViewModel().getInput2());
        break;

      case "_in3":
        circle = _circleIn3En;
        lineHor = _lineIn3Hor;
        lineVert = _lineIn3Vert;
        circleInv = _circleIn3Inv;
        assignPtr(input, MtpViewBase::getViewModel().getInput3());
        break;

      case "_in4":
        circle = _circleIn4En;
        lineHor = _lineIn4Hor;
        lineVert = _lineIn4Vert;
        circleInv = _circleIn4Inv;
        assignPtr(input, MtpViewBase::getViewModel().getInput4());
        break;
    }

    bool effectiveValue = input.getValue() != input.getInverted();

    if (!input.getInverted())
    {
      circleInv.visible = false;
    }
    else
    {
      circleInv.visible = true;
    }

    if (effectiveValue)
    {
      circle.backCol = "mtpGreen";
      lineHor.foreCol = "mtpGreen";
      lineVert.foreCol = "mtpGreen";
      circleInv.backCol = "mtpGreen";
    }
    else
    {
      circle.backCol = "mtpRed";
      lineHor.foreCol = "mtpRed";
      lineVert.foreCol = "mtpRed";
      circleInv.backCol = "mtpRed";
    }
  }

  /**
   * @brief Callback function to update the output state and its display.
   *
   * @param output The new output value.
   */
  private void setOutputCB(const bool &output)
  {
    if (output)
    {
      _circleOut.backCol = "mtpGreen";
      _lineOut.foreCol = "mtpGreen";
    }
    else
    {
      _circleOut.backCol = "mtpRed";
      _lineOut.foreCol = "mtpRed";
    }
  }

  /**
   * @brief Callback function to update the logic text.
   *
   * @param logic The new logic state.
   */
  private void setLogicCB(const bool &logic)
  {
    _txtLogic.text = logic ?  getCatStr("LockView4", "AND") :  getCatStr("LockView4", "OR");
  }

  /**
   * @brief Callback function to update the quality code status for inputs.
   *
   * @param varName The name of the variable to set.
   * @param qualityGood Indicates if the quality good status has changed.
   */
  private void setQualityCodeCB(const string &varName, const bool &qualityGood)
  {
    shape rectQC;

    switch (varName)
    {
      case "_rectIn1QC":
        rectQC = _rectIn1QC;
        break;

      case "_rectIn2QC":
        rectQC = _rectIn2QC;
        break;

      case "_rectIn3QC":
        rectQC = _rectIn3QC;
        break;

      case "_rectIn4QC":
        rectQC = _rectIn4QC;
        break;
    }

    if (qualityGood)
    {
      rectQC.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      rectQC.sizeAsDyn = makeDynInt(30, 25);
    }
    else
    {
      rectQC.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
      rectQC.sizeAsDyn = makeDynInt(25, 25);
    }
  }
};
