// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Input/MTP_Input"
#uses "classes/MTP_LockView8/MTP_LockView8"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_LockView8FaceplateHome
 * @brief Represents the MTP_LockView8FaceplateHome class.
 */
class MTP_LockView8FaceplateHome : MTP_ViewBase
{
  private shape _circleIn1En; //!< Reference to the enable circle shape for input 1.
  private shape _circleIn2En; //!< Reference to the enable circle shape for input 2.
  private shape _circleIn3En; //!< Reference to the enable circle shape for input 3.
  private shape _circleIn4En; //!< Reference to the enable circle shape for input 4.
  private shape _circleIn5En; //!< Reference to the enable circle shape for input 5.
  private shape _circleIn6En; //!< Reference to the enable circle shape for input 6.
  private shape _circleIn7En; //!< Reference to the enable circle shape for input 7.
  private shape _circleIn8En; //!< Reference to the enable circle shape for input 8.
  private shape _circleOut; //!< Reference to the output circle shape.
  private shape _lineOut; //!< Reference to the output line shape.
  private shape _lineIn1Hor; //!< Reference to the horizontal line shape for input 1.
  private shape _lineIn2Hor; //!< Reference to the horizontal line shape for input 2.
  private shape _lineIn3Hor; //!< Reference to the horizontal line shape for input 3.
  private shape _lineIn4Hor; //!< Reference to the horizontal line shape for input 4.
  private shape _lineIn5Hor; //!< Reference to the horizontal line shape for input 5.
  private shape _lineIn6Hor; //!< Reference to the horizontal line shape for input 6.
  private shape _lineIn7Hor; //!< Reference to the horizontal line shape for input 7.
  private shape _lineIn8Hor; //!< Reference to the horizontal line shape for input 8.
  private shape _lineIn1Vert; //!< Reference to the vertical line shape for input 1.
  private shape _lineIn2Vert; //!< Reference to the vertical line shape for input 2.
  private shape _lineIn3Vert; //!< Reference to the vertical line shape for input 3.
  private shape _lineIn4Vert; //!< Reference to the vertical line shape for input 4.
  private shape _lineIn5Vert; //!< Reference to the vertical line shape for input 5.
  private shape _lineIn6Vert; //!< Reference to the vertical line shape for input 6.
  private shape _lineIn7Vert; //!< Reference to the vertical line shape for input 7.
  private shape _lineIn8Vert; //!< Reference to the vertical line shape for input 8.
  private shape _rectIn1QC; //!< Reference to the quality code rectangle shape for input 1.
  private shape _rectIn2QC; //!< Reference to the quality code rectangle shape for input 2.
  private shape _rectIn3QC; //!< Reference to the quality code rectangle shape for input 3.
  private shape _rectIn4QC; //!< Reference to the quality code rectangle shape for input 4.
  private shape _rectIn5QC; //!< Reference to the quality code rectangle shape for input 5.
  private shape _rectIn6QC; //!< Reference to the quality code rectangle shape for input 6.
  private shape _rectIn7QC; //!< Reference to the quality code rectangle shape for input 7.
  private shape _rectIn8QC; //!< Reference to the quality code rectangle shape for input 8.
  private shape _txtIn1Txt; //!< Reference to the text shape for input 1.
  private shape _txtIn2Txt; //!< Reference to the text shape for input 2.
  private shape _txtIn3Txt; //!< Reference to the text shape for input 3.
  private shape _txtIn4Txt; //!< Reference to the text shape for input 4.
  private shape _txtIn5Txt; //!< Reference to the text shape for input 5.
  private shape _txtIn6Txt; //!< Reference to the text shape for input 6.
  private shape _txtIn7Txt; //!< Reference to the text shape for input 7.
  private shape _txtIn8Txt; //!< Reference to the text shape for input 8.
  private shape _txtLogic; //!< Reference to the logic text shape.
  private shape _txtIn1Label; //!< Reference to the label text shape for input 1.
  private shape _txtIn2Label; //!< Reference to the label text shape for input 2.
  private shape _txtIn3Label; //!< Reference to the label text shape for input 3.
  private shape _txtIn4Label; //!< Reference to the label text shape for input 4.
  private shape _txtIn5Label; //!< Reference to the label text shape for input 5.
  private shape _txtIn6Label; //!< Reference to the label text shape for input 6.
  private shape _txtIn7Label; //!< Reference to the label text shape for input 7.
  private shape _txtIn8Label; //!< Reference to the label text shape for input 8.
  private shape _rectOutQC; //!< Reference to the quality code rectangle shape for output.
  private shape _circleIn1Inv; //!< Reference to the inversion circle shape for input 1.
  private shape _circleIn2Inv; //!< Reference to the inversion circle shape for input 2.
  private shape _circleIn3Inv; //!< Reference to the inversion circle shape for input 3.
  private shape _circleIn4Inv; //!< Reference to the inversion circle shape for input 4.
  private shape _circleIn5Inv; //!< Reference to the inversion circle shape for input 5.
  private shape _circleIn6Inv; //!< Reference to the inversion circle shape for input 6.
  private shape _circleIn7Inv; //!< Reference to the inversion circle shape for input 7.
  private shape _circleIn8Inv; //!< Reference to the inversion circle shape for input 8.

  /**
   * @brief Constructor for MTP_LockView8FaceplateHome.
   *
   * @param viewModel A shared pointer to the LockView8 view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_LockView8FaceplateHome(shared_ptr<MTP_LockView8> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    if (MTP_ViewBase::getViewModel().getInput1().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in1", MTP_ViewBase::getViewModel().getInput1(), MTP_Input::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in1", MTP_ViewBase::getViewModel().getInput1(), MTP_Input::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn1QC", MTP_ViewBase::getViewModel().getInput1().getQualityCode(), MTP_Wqc::qualityGoodChanged);
      setInputChangedCB("_in1", true);
      setInputTexts("_In1Txt", MTP_ViewBase::getViewModel().getInput1());
      setQualityCodeCB("_rectIn1QC", MTP_ViewBase::getViewModel().getInput1().getQualityCode().getQualityGood());
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

    if (MTP_ViewBase::getViewModel().getInput2().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in2", MTP_ViewBase::getViewModel().getInput2(), MTP_Input::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in2", MTP_ViewBase::getViewModel().getInput2(), MTP_Input::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn2QC", MTP_ViewBase::getViewModel().getInput2().getQualityCode(), MTP_Wqc::qualityGoodChanged);
      setInputChangedCB("_in2", true);
      setInputTexts("_In2Txt", MTP_ViewBase::getViewModel().getInput2());
      setQualityCodeCB("_rectIn2QC", MTP_ViewBase::getViewModel().getInput2().getQualityCode().getQualityGood());
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

    if (MTP_ViewBase::getViewModel().getInput3().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in3", MTP_ViewBase::getViewModel().getInput3(), MTP_Input::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in3", MTP_ViewBase::getViewModel().getInput3(), MTP_Input::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn3QC", MTP_ViewBase::getViewModel().getInput3().getQualityCode(), MTP_Wqc::qualityGoodChanged);
      setInputChangedCB("_in3", true);
      setInputTexts("_In3Txt", MTP_ViewBase::getViewModel().getInput3());
      setQualityCodeCB("_rectIn3QC", MTP_ViewBase::getViewModel().getInput3().getQualityCode().getQualityGood());
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

    if (MTP_ViewBase::getViewModel().getInput4().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in4", MTP_ViewBase::getViewModel().getInput4(), MTP_Input::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in4", MTP_ViewBase::getViewModel().getInput4(), MTP_Input::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn4QC", MTP_ViewBase::getViewModel().getInput4().getQualityCode(), MTP_Wqc::qualityGoodChanged);
      setInputChangedCB("_in4", true);
      setInputTexts("_In4Txt", MTP_ViewBase::getViewModel().getInput4());
      setQualityCodeCB("_rectIn4QC", MTP_ViewBase::getViewModel().getInput4().getQualityCode().getQualityGood());
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

    if (MTP_ViewBase::getViewModel().getInput5().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in5", MTP_ViewBase::getViewModel().getInput5(), MTP_Input::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in5", MTP_ViewBase::getViewModel().getInput5(), MTP_Input::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn5QC", MTP_ViewBase::getViewModel().getInput5().getQualityCode(), MTP_Wqc::qualityGoodChanged);
      setInputChangedCB("_in5", true);
      setInputTexts("_In5Txt", MTP_ViewBase::getViewModel().getInput5());
      setQualityCodeCB("_rectIn5QC", MTP_ViewBase::getViewModel().getInput5().getQualityCode().getQualityGood());
    }
    else
    {
      _circleIn5En.visible = false;
      _lineIn5Hor.visible = false;
      _lineIn5Vert.visible = false;
      _rectIn5QC.visible = false;
      _txtIn5Txt.visible = false;
      _txtIn5Label.visible = false;
      _circleIn5Inv.visible = false;
    }

    if (MTP_ViewBase::getViewModel().getInput6().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in6", MTP_ViewBase::getViewModel().getInput6(), MTP_Input::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in6", MTP_ViewBase::getViewModel().getInput6(), MTP_Input::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn6QC", MTP_ViewBase::getViewModel().getInput6().getQualityCode(), MTP_Wqc::qualityGoodChanged);
      setInputChangedCB("_in6", true);
      setInputTexts("_In6Txt", MTP_ViewBase::getViewModel().getInput6());
      setQualityCodeCB("_rectIn6QC", MTP_ViewBase::getViewModel().getInput6().getQualityCode().getQualityGood());
    }
    else
    {
      _circleIn6En.visible = false;
      _lineIn6Hor.visible = false;
      _lineIn6Vert.visible = false;
      _rectIn6QC.visible = false;
      _txtIn6Txt.visible = false;
      _txtIn6Label.visible = false;
      _circleIn6Inv.visible = false;
    }

    if (MTP_ViewBase::getViewModel().getInput7().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in7", MTP_ViewBase::getViewModel().getInput7(), MTP_Input::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in7", MTP_ViewBase::getViewModel().getInput7(), MTP_Input::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn7QC", MTP_ViewBase::getViewModel().getInput7().getQualityCode(), MTP_Wqc::qualityGoodChanged);
      setInputChangedCB("_in7", true);
      setInputTexts("_In7Txt", MTP_ViewBase::getViewModel().getInput7());
      setQualityCodeCB("_rectIn7QC", MTP_ViewBase::getViewModel().getInput7().getQualityCode().getQualityGood());
    }
    else
    {
      _circleIn7En.visible = false;
      _lineIn7Hor.visible = false;
      _lineIn7Vert.visible = false;
      _rectIn7QC.visible = false;
      _txtIn7Txt.visible = false;
      _txtIn7Label.visible = false;
      _circleIn7Inv.visible = false;
    }

    if (MTP_ViewBase::getViewModel().getInput8().getEnabled())
    {
      classConnectUserData(this, setInputChangedCB, "_in8", MTP_ViewBase::getViewModel().getInput8(), MTP_Input::valueChanged);
      classConnectUserData(this, setInputChangedCB, "_in8", MTP_ViewBase::getViewModel().getInput8(), MTP_Input::invertedChanged);
      classConnectUserData(this, setQualityCodeCB, "_rectIn8QC", MTP_ViewBase::getViewModel().getInput8().getQualityCode(), MTP_Wqc::qualityGoodChanged);
      setInputChangedCB("_in8", true);
      setInputTexts("_In8Txt", MTP_ViewBase::getViewModel().getInput8());
      setQualityCodeCB("_rectIn8QC", MTP_ViewBase::getViewModel().getInput8().getQualityCode().getQualityGood());
    }
    else
    {
      _circleIn8En.visible = false;
      _lineIn8Hor.visible = false;
      _lineIn8Vert.visible = false;
      _rectIn8QC.visible = false;
      _txtIn8Txt.visible = false;
      _txtIn8Label.visible = false;
      _circleIn8Inv.visible = false;
    }

    classConnect(this, setOutqcCB, MTP_ViewBase::getViewModel().getOutputQualityCode(), MTP_Wqc::qualityGoodChanged);
    classConnect(this, setOutputCB, MTP_ViewBase::getViewModel(), MTP_LockView8::outputChanged);
    classConnect(this, setLogicCB, MTP_ViewBase::getViewModel(), MTP_LockView8::logicChanged);

    setOutputCB(MTP_ViewBase::getViewModel().getOutput());
    setLogicCB(MTP_ViewBase::getViewModel().getLogic());
    setOutqcCB(MTP_ViewBase::getViewModel().getOutputQualityCode().getQualityGood());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _circleIn1En = MTP_ViewBase::extractShape("_circleIn1En");
    _circleIn2En = MTP_ViewBase::extractShape("_circleIn2En");
    _circleIn3En = MTP_ViewBase::extractShape("_circleIn3En");
    _circleIn4En = MTP_ViewBase::extractShape("_circleIn4En");
    _circleIn5En = MTP_ViewBase::extractShape("_circleIn5En");
    _circleIn6En = MTP_ViewBase::extractShape("_circleIn6En");
    _circleIn7En = MTP_ViewBase::extractShape("_circleIn7En");
    _circleIn8En = MTP_ViewBase::extractShape("_circleIn8En");
    _circleOut = MTP_ViewBase::extractShape("_circleOut");
    _lineOut = MTP_ViewBase::extractShape("_lineOut");
    _lineIn1Hor = MTP_ViewBase::extractShape("_lineIn1Hor");
    _lineIn2Hor = MTP_ViewBase::extractShape("_lineIn2Hor");
    _lineIn3Hor = MTP_ViewBase::extractShape("_lineIn3Hor");
    _lineIn4Hor = MTP_ViewBase::extractShape("_lineIn4Hor");
    _lineIn5Hor = MTP_ViewBase::extractShape("_lineIn5Hor");
    _lineIn6Hor = MTP_ViewBase::extractShape("_lineIn6Hor");
    _lineIn7Hor = MTP_ViewBase::extractShape("_lineIn7Hor");
    _lineIn8Hor = MTP_ViewBase::extractShape("_lineIn8Hor");
    _lineIn1Vert = MTP_ViewBase::extractShape("_lineIn1Vert");
    _lineIn2Vert = MTP_ViewBase::extractShape("_lineIn2Vert");
    _lineIn3Vert = MTP_ViewBase::extractShape("_lineIn3Vert");
    _lineIn4Vert = MTP_ViewBase::extractShape("_lineIn4Vert");
    _lineIn5Vert = MTP_ViewBase::extractShape("_lineIn5Vert");
    _lineIn6Vert = MTP_ViewBase::extractShape("_lineIn6Vert");
    _lineIn7Vert = MTP_ViewBase::extractShape("_lineIn7Vert");
    _lineIn8Vert = MTP_ViewBase::extractShape("_lineIn8Vert");
    _rectIn1QC = MTP_ViewBase::extractShape("_rectIn1QC");
    _rectIn2QC = MTP_ViewBase::extractShape("_rectIn2QC");
    _rectIn3QC = MTP_ViewBase::extractShape("_rectIn3QC");
    _rectIn4QC = MTP_ViewBase::extractShape("_rectIn4QC");
    _rectIn5QC = MTP_ViewBase::extractShape("_rectIn5QC");
    _rectIn6QC = MTP_ViewBase::extractShape("_rectIn6QC");
    _rectIn7QC = MTP_ViewBase::extractShape("_rectIn7QC");
    _rectIn8QC = MTP_ViewBase::extractShape("_rectIn8QC");
    _txtIn1Txt = MTP_ViewBase::extractShape("_txtIn1Txt");
    _txtIn2Txt = MTP_ViewBase::extractShape("_txtIn2Txt");
    _txtIn3Txt = MTP_ViewBase::extractShape("_txtIn3Txt");
    _txtIn4Txt = MTP_ViewBase::extractShape("_txtIn4Txt");
    _txtIn5Txt = MTP_ViewBase::extractShape("_txtIn5Txt");
    _txtIn6Txt = MTP_ViewBase::extractShape("_txtIn6Txt");
    _txtIn7Txt = MTP_ViewBase::extractShape("_txtIn7Txt");
    _txtIn8Txt = MTP_ViewBase::extractShape("_txtIn8Txt");
    _txtLogic = MTP_ViewBase::extractShape("_txtLogic");
    _txtIn1Label = MTP_ViewBase::extractShape("_txtIn1Label");
    _txtIn2Label = MTP_ViewBase::extractShape("_txtIn2Label");
    _txtIn3Label = MTP_ViewBase::extractShape("_txtIn3Label");
    _txtIn4Label = MTP_ViewBase::extractShape("_txtIn4Label");
    _txtIn5Label = MTP_ViewBase::extractShape("_txtIn5Label");
    _txtIn6Label = MTP_ViewBase::extractShape("_txtIn6Label");
    _txtIn7Label = MTP_ViewBase::extractShape("_txtIn7Label");
    _txtIn8Label = MTP_ViewBase::extractShape("_txtIn8Label");
    _rectOutQC = MTP_ViewBase::extractShape("_rectOutQC");
    _circleIn1Inv = MTP_ViewBase::extractShape("_circleIn1Inv");
    _circleIn2Inv = MTP_ViewBase::extractShape("_circleIn2Inv");
    _circleIn3Inv = MTP_ViewBase::extractShape("_circleIn3Inv");
    _circleIn4Inv = MTP_ViewBase::extractShape("_circleIn4Inv");
    _circleIn5Inv = MTP_ViewBase::extractShape("_circleIn5Inv");
    _circleIn6Inv = MTP_ViewBase::extractShape("_circleIn6Inv");
    _circleIn7Inv = MTP_ViewBase::extractShape("_circleIn7Inv");
    _circleIn8Inv = MTP_ViewBase::extractShape("_circleIn8Inv");
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
  private void setInputTexts(const string &varName, shared_ptr<MTP_Input> input)
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

      case "_In5Txt":
        _txtIn5Txt.text = input.getText();
        break;

      case "_In6Txt":
        _txtIn6Txt.text = input.getText();
        break;

      case "_In7Txt":
        _txtIn7Txt.text = input.getText();
        break;

      case "_In8Txt":
        _txtIn8Txt.text = input.getText();
        break;

      default:
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
    shared_ptr<MTP_Input> input;

    switch (varName)
    {
      case "_in1":
        circle = _circleIn1En;
        lineHor = _lineIn1Hor;
        lineVert = _lineIn1Vert;
        circleInv = _circleIn1Inv;
        assignPtr(input, MTP_ViewBase::getViewModel().getInput1());
        break;

      case "_in2":
        circle = _circleIn2En;
        lineHor = _lineIn2Hor;
        lineVert = _lineIn2Vert;
        circleInv = _circleIn2Inv;
        assignPtr(input, MTP_ViewBase::getViewModel().getInput2());
        break;

      case "_in3":
        circle = _circleIn3En;
        lineHor = _lineIn3Hor;
        lineVert = _lineIn3Vert;
        circleInv = _circleIn3Inv;
        assignPtr(input, MTP_ViewBase::getViewModel().getInput3());
        break;

      case "_in4":
        circle = _circleIn4En;
        lineHor = _lineIn4Hor;
        lineVert = _lineIn4Vert;
        circleInv = _circleIn4Inv;
        assignPtr(input, MTP_ViewBase::getViewModel().getInput4());
        break;

      case "_in5":
        circle = _circleIn5En;
        lineHor = _lineIn5Hor;
        lineVert = _lineIn5Vert;
        circleInv = _circleIn5Inv;
        assignPtr(input, MTP_ViewBase::getViewModel().getInput5());
        break;

      case "_in6":
        circle = _circleIn6En;
        lineHor = _lineIn6Hor;
        lineVert = _lineIn6Vert;
        circleInv = _circleIn6Inv;
        assignPtr(input, MTP_ViewBase::getViewModel().getInput6());
        break;

      case "_in7":
        circle = _circleIn7En;
        lineHor = _lineIn7Hor;
        lineVert = _lineIn7Vert;
        circleInv = _circleIn7Inv;
        assignPtr(input, MTP_ViewBase::getViewModel().getInput7());
        break;

      case "_in8":
        circle = _circleIn8En;
        lineHor = _lineIn8Hor;
        lineVert = _lineIn8Vert;
        circleInv = _circleIn8Inv;
        assignPtr(input, MTP_ViewBase::getViewModel().getInput8());
        break;

      default:
        return;
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
    _txtLogic.text = logic ?  getCatStr("MTP_LockView8", "AND") :  getCatStr("MTP_LockView8", "OR");
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

      case "_rectIn5QC":
        rectQC = _rectIn5QC;
        break;

      case "_rectIn6QC":
        rectQC = _rectIn6QC;
        break;

      case "_rectIn7QC":
        rectQC = _rectIn7QC;
        break;

      case "_rectIn8QC":
        rectQC = _rectIn8QC;
        break;

      default:
        return;
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
