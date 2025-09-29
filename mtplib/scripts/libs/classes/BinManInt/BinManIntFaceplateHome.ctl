// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpView/MtpViewBase"
#uses "classes/BinManInt/BinManInt"

/**
 * @class BinManIntFaceplateHome
 * @brief Represents the home faceplate for BinManInt objects.
 */
class BinManIntFaceplateHome : MtpViewBase
{
  private shape _txtValue; //!< Reference to the value text shape.
  private shape _rectValue; //!< Reference to the value rectangle shape.
  private shape _refWqc; //!< Reference to the quality code shape.
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
   * @brief Constructor for BinManIntFaceplateHome.
   *
   * @param viewModel A shared pointer to the BinManInt view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public BinManIntFaceplateHome(shared_ptr<BinManInt> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setValueOutCB, MtpViewBase::getViewModel(), BinManInt::valueOutChanged);
    classConnect(this, setValueFeedbackCB, MtpViewBase::getViewModel(), BinManInt::valueFeedbackChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setValueManualCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);
    classConnectUserData(this, setValueManualCB, "_valueOut", MtpViewBase::getViewModel(), BinManInt::valueOutChanged);
    classConnectUserData(this, setValueManualCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);

    classConnectUserData(this, setValueInternalCB, "_valueInternal", MtpViewBase::getViewModel(), BinManInt::valueInternalChanged);
    classConnectUserData(this, setValueInternalCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();
    _valueOut = MtpViewBase::getViewModel().getValueOut();
    _valueInternal = MtpViewBase::getViewModel().getValueInternal();

    _btnTrue.text = MtpViewBase::getViewModel().getValueStateTrueText();
    _btnFalse.text = MtpViewBase::getViewModel().getValueStateFalseText();

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setValueOutCB(_valueOut);
    setValueFeedbackCB(MtpViewBase::getViewModel().getValueFeedback());

    setValueInternalCB("_valueInternal", _valueInternal);
    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setValueManualCB("_valueOut", _valueOut);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates the manual mode.
   * @details Sets the manual operator state to true.
   */
  public void activateManual()
  {
    MtpViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  /**
   * @brief Activates the internal mode.
   * @details Sets the internal operator state to true.
   */
  public void activateInternal()
  {
    MtpViewBase::getViewModel().getSource().setInternalOperator(TRUE);
  }

  /**
   * @brief Sets the manual value to true.
   * @details Updates the manual value in the view model to true.
   */
  public void changeValueTrue()
  {
    MtpViewBase::getViewModel().setValueManual(true);
  }

  /**
   * @brief Sets the manual value to false.
   * @details Updates the manual value in the view model to false.
   */
  public void changeValueFalse()
  {
    MtpViewBase::getViewModel().setValueManual(false);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the required shapes.
   */
  protected void initializeShapes()
  {
    _txtValue = MtpViewBase::extractShape("_txtValue");
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectValue = MtpViewBase::extractShape("_rectValue");
    _btnTrue = MtpViewBase::extractShape("_btnTrue");
    _btnFalse = MtpViewBase::extractShape("_btnFalse");
    _txtVFbk = MtpViewBase::extractShape("_txtVFbk");
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _rectVIntTrue = MtpViewBase::extractShape("_rectVIntTrue");
    _rectVIntFalse = MtpViewBase::extractShape("_rectVIntFalse");
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
      _txtValue.text = MtpViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _txtValue.text = MtpViewBase::getViewModel().getValueStateFalseText();
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
      _txtVFbk.text = MtpViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _txtVFbk.text = MtpViewBase::getViewModel().getValueStateFalseText();
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
   * @brief Callback function to update the quality code status.
   *
   * @param qualityGoodChanged Indicates if the quality good status has changed.
   */
  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
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
