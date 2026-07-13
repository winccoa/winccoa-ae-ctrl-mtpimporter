// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_BinManInt/MTP_BinManInt"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_BinManIntFaceplateHome
 * @brief Represents the MTP_BinManIntFaceplateHome class.
 */
class MTP_BinManIntFaceplateHome : MTP_ViewBase
{
  private shape _txtValue; //!< Reference to the value text shape.
  private shape _rectValue; //!< Reference to the value rectangle shape.
  private shape _btnFalse; //!< Reference to the false button shape.
  private shape _btnTrue; //!< Reference to the true button shape.
  private shape _txtVFbk; //!< Reference to the feedback value text shape.
  private shape _rectManual; //!< Reference to the manual mode rectangle shape.
  private shape _rectInternal; //!< Reference to the internal mode rectangle shape.
  private shape _rectVIntFalse; //!< Reference to the internal false value rectangle shape.
  private shape _rectVIntTrue; //!< Reference to the internal true value rectangle shape.

  private bool _manualActive; //!< Indicates if the manual mode is active.
  private bool _internalActive; //!< Indicates if the internal mode is active.
  private bool _channel; //!< Indicates the channel state.
  private bool _valueOut; //!< The current output value.
  private bool _valueInternal; //!< The current internal value.
  private bool _osLevelStation; //!< Indicates the station-level operational state.

  /**
   * @brief Constructor for MTP_BinManIntFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_BinManInt view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_BinManIntFaceplateHome(shared_ptr<MTP_BinManInt> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setValueOutCB, MTP_ViewBase::getViewModel(), MTP_BinManInt::valueOutChanged);
    classConnect(this, setValueFeedbackCB, MTP_ViewBase::getViewModel(), MTP_BinManInt::valueFeedbackChanged);
    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    classConnectUserData(this, setValueManualCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);
    classConnectUserData(this, setValueManualCB, "_valueOut", MTP_ViewBase::getViewModel(), MTP_BinManInt::valueOutChanged);
    classConnectUserData(this, setValueManualCB, "_internalActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::internalActiveChanged);

    classConnectUserData(this, setValueInternalCB, "_valueInternal", MTP_ViewBase::getViewModel(), MTP_BinManInt::valueInternalChanged);
    classConnectUserData(this, setValueInternalCB, "_internalActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::internalActiveChanged);

    _manualActive =  MTP_ViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MTP_ViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MTP_ViewBase::getViewModel().getSource().getChannel();
    _valueOut = MTP_ViewBase::getViewModel().getValueOut();
    _valueInternal = MTP_ViewBase::getViewModel().getValueInternal();

    _btnTrue.text = getCatStr("MTP_BinManInt", "True");
    _btnFalse.text = getCatStr("MTP_BinManInt", "False");

    setValueOutCB(_valueOut);
    setValueFeedbackCB(MTP_ViewBase::getViewModel().getValueFeedback());

    setValueInternalCB("_valueInternal", _valueInternal);
    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setValueManualCB("_valueOut", _valueOut);
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates the manual mode.
   */
  public void activateManual()
  {
    MTP_ViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  /**
   * @brief Activates the internal mode.
   */
  public void activateInternal()
  {
    MTP_ViewBase::getViewModel().getSource().setInternalOperator(TRUE);
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
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtValue = MTP_ViewBase::extractShape("_txtValue");
    _rectValue = MTP_ViewBase::extractShape("_rectValue");
    _btnTrue = MTP_ViewBase::extractShape("_btnTrue");
    _btnFalse = MTP_ViewBase::extractShape("_btnFalse");
    _txtVFbk = MTP_ViewBase::extractShape("_txtVFbk");
    _rectManual = MTP_ViewBase::extractShape("_rectManual");
    _rectInternal = MTP_ViewBase::extractShape("_rectInternal");
    _rectVIntTrue = MTP_ViewBase::extractShape("_rectVIntTrue");
    _rectVIntFalse = MTP_ViewBase::extractShape("_rectVIntFalse");
  }

  /**
   * @brief Callback function to update the operational state level.
   *
   * @param oslevel The new operational state level.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setValueManualCB("", FALSE);
    setInternalActiveCB("", FALSE);
    setManualActiveCB("", FALSE);
  }

  /**
   * @brief Callback function to update the manual value and related states.
   *
   * @param varName The name of the variable to set.
   * @param valueManual The new manual value, channel, or internal active state.
   */
  private void setValueManualCB(const string &varName, const bool &valueManual)
  {
    switch (varName)
    {
      case "_channel":
        _channel = valueManual;
        break;

      case "_valueOut":
        _valueOut = valueManual;
        break;

      case "_internalActive":
        _internalActive = valueManual;
        break;
    }

    if ((!_osLevelStation && !_channel && !_internalActive && _valueOut) || (_channel && _internalActive && _valueOut))
    {
      _btnTrue.backCol = "mtpSidebar";
    }
    else if (_osLevelStation && !_channel && !_internalActive && _valueOut)
    {
      _btnTrue.backCol = "mtpTitlebar";
    }
    else
    {
      _btnTrue.backCol = "mtpBorder";
    }

    _btnTrue.transparentForMouse = (_btnTrue.backCol == "mtpSidebar");

    if ((!_osLevelStation && !_channel && !_internalActive && !_valueOut) || (_channel && _internalActive && !_valueOut))
    {
      _btnFalse.backCol = "mtpSidebar";
    }
    else if (_osLevelStation && !_channel && !_internalActive && !_valueOut)
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

  /**
   * @brief Callback function to update the internal value and its display.
   *
   * @param varName The name of the variable to set.
   * @param value The new internal value or internal active state.
   */
  private void setValueInternalCB(const string &varName, const bool &value)
  {
    switch (varName)
    {
      case "_valueInternal":
        _valueInternal = value;
        break;

      case "_internalActive":
        _internalActive = value;
        break;
    }

    if (!_internalActive && _valueInternal)
    {
      _rectVIntTrue.visible = true;
      _rectVIntFalse.visible = false;
    }
    else if (!_internalActive && !_valueInternal)
    {
      _rectVIntTrue.visible = false;
      _rectVIntFalse.visible = true;
    }
    else
    {
      _rectVIntTrue.visible = false;
      _rectVIntFalse.visible = false;
    }
  }

  /**
   * @brief Callback function to update the internal active state and channel.
   *
   * @param varName The name of the variable to set.
   * @param internalActive The new internal active state or channel value.
   */
  private void setInternalActiveCB(const string &varName, const bool &internalActive)
  {
    switch (varName)
    {
      case "_internalActive":
        _internalActive = internalActive;
        break;

      case "_channel":
        _channel = internalActive;
        break;
    }

    if ((!_osLevelStation && _internalActive && !_channel) || (_internalActive && _channel))
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]";
    }
    else if (_osLevelStation && _internalActive && !_channel)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_2_rounded.svg]]";
    }
    else
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_3_rounded.svg]]";
    }

    _rectInternal.transparentForMouse = (_rectInternal.fill == "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the manual active state and channel.
   *
   * @param varName The name of the variable to set.
   * @param manualActive The new manual active state or channel value.
   */
  private void setManualActiveCB(const string &varName, const bool &manualActive)
  {
    switch (varName)
    {
      case "_manualActive":
        _manualActive = manualActive;
        break;

      case "_channel":
        _channel = manualActive;
        break;
    }

    if ((!_osLevelStation && !_channel && _manualActive) || (_manualActive && _channel))
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
    }
    else if (_osLevelStation && _manualActive && !_channel)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]");
  }
};
