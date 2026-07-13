// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinMan/MTP_BinMan"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_BinManFaceplateHome
 * @brief Represents the MTP_BinManFaceplateHome class.
 */
class MTP_BinManFaceplateHome : MTP_ViewBase
{
  private shape _txtValue; //!< Reference to the value text shape.
  private shape _rectValue; //!< Reference to the value rectangle shape.
  private shape _btnFalse; //!< Reference to the false button shape.
  private shape _btnTrue; //!< Reference to the true button shape.
  private shape _txtVFbk; //!< Reference to the feedback value text shape.

  private bool _valueOut; //!< The current output value.
  private bool _osLevelStation; //!< Indicates the station-level operational state.

  /**
   * @brief Constructor for MTP_BinManFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_BinMan view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_BinManFaceplateHome(shared_ptr<MTP_BinMan> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setValueOutCB, MTP_ViewBase::getViewModel(), MTP_BinMan::valueOutChanged);
    classConnect(this, setValueFeedbackCB, MTP_ViewBase::getViewModel(), MTP_BinMan::valueFeedbackChanged);
    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    classConnectUserData(this, setValueManualCB, "_valueOut", MTP_ViewBase::getViewModel(), MTP_BinMan::valueOutChanged);

    _valueOut = MTP_ViewBase::getViewModel().getValueOut();
    _osLevelStation = MTP_ViewBase::getViewModel().getOsLevel().getStationLevel();

    _btnTrue.text = getCatStr("MTP_BinMan", "True");
    _btnFalse.text = getCatStr("MTP_BinMan", "False");

    setValueOutCB(_valueOut);
    setValueFeedbackCB(MTP_ViewBase::getViewModel().getValueFeedback());
    setValueManualCB("_valueOut", _valueOut);
    setOsLevelCB(_osLevelStation);

  }

  /**
   * @brief Sets the manual value to true.
   */
  public void changeValueTrue()
  {
    MTP_ViewBase::getViewModel().setValueManual(true);
  }

  /**
   * @brief Sets the manual value to false.
   */
  public void changeValueFalse()
  {
    MTP_ViewBase::getViewModel().setValueManual(false);
  }

  /**
   * @brief Sets the value manual from the connected data point element.
   *
   * @param varName The new var name value.
   * @param valueManual The new value manual value.
   */
  private void setValueManualCB(const string &varName, const bool &valueManual)
  {
    switch (varName)
    {
      case "_valueOut":
        _valueOut = valueManual;
        break;
    }

    if (!_osLevelStation)
    {
      _btnTrue.backCol = "mtpSidebar";
    }
    else if (_osLevelStation && _valueOut)
    {
      _btnTrue.backCol = "mtpTitlebar";
    }
    else
    {
      _btnTrue.backCol = "mtpBorder";
    }

    _btnTrue.transparentForMouse = (_btnTrue.backCol == "mtpSidebar");

    if (!_osLevelStation)
    {
      _btnFalse.backCol = "mtpSidebar";
    }
    else if (_osLevelStation && !_valueOut)
    {
      _btnFalse.backCol = "mtpTitlebar";
    }
    else
    {
      _btnFalse.backCol = "mtpBorder";
    }

    _btnFalse.transparentForMouse = (_btnFalse.backCol == "mtpSidebar");
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtValue = MTP_ViewBase::extractShape("_txtValue");
    _rectValue = MTP_ViewBase::extractShape("_rectValue");
    _btnTrue = MTP_ViewBase::extractShape("_btnTrue");
    _btnFalse = MTP_ViewBase::extractShape("_btnFalse");
    _txtVFbk = MTP_ViewBase::extractShape("_txtVFbk");
  }

  /**
   * @brief Callback function to update the operational state level.
   *
   * @param oslevel The new operational state level.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    _btnTrue.transparentForMouse = !_osLevelStation;
    _btnFalse.transparentForMouse = !_osLevelStation;

    setValueOutCB(_valueOut);
  }

  /**
   * @brief Callback function to update the output value and its display.
   *
   * @param value The new output value.
   */
  private void setValueOutCB(const bool &value)
  {
    if (value)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
      _txtValue.text = MTP_ViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _txtValue.text = MTP_ViewBase::getViewModel().getValueStateFalseText();
    }
  }

  /**
   * @brief Callback function to update the feedback value text.
   *
   * @param value The new feedback value.
   */
  private void setValueFeedbackCB(const bool &value)
  {
    if (value)
    {
      _txtVFbk.text = MTP_ViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _txtVFbk.text = MTP_ViewBase::getViewModel().getValueStateFalseText();
    }
  }
};
