// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_MonAnaVlv/MTP_MonAnaVlv"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_MonAnaVlvFaceplateHome2
 * @brief Represents the MTP_MonAnaVlvFaceplateHome2 class.
 */
class MTP_MonAnaVlvFaceplateHome2 : MTP_ViewBase
{
  private shape _rectInternal; //!< Reference to the internal mode rectangle shape.
  private shape _rectManual; //!< Reference to the manual mode rectangle shape.
  private shape _txtPosValueManual; //!< Reference to the text shape for displaying the manual Pos value.
  private shape _txtPosValueInternal; //!< Reference to the text shape for displaying the internal Pos value.
  private shape _txtPosFeedbackValue; //!< Reference to the text shape for displaying the Pos feedback value.

  private bool _manualActive; //!< Indicates if manual mode is active.
  private bool _internalActive; //!< Indicates if internal mode is active.
  private bool _channel; //!< Indicates the channel state.
  private bool _osLevelStation; //!< Indicates the operational station level.

  private shared_ptr<MTP_BarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MTP_MonAnaVlvFaceplateHome2.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonAnaVlvFaceplateHome2(shared_ptr<MTP_MonAnaVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MTP_BarIndicator::setValueCustomLimit, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::positionChanged);
    classConnect(this, setPosFeedbackValueCB, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::positionFeedbackChanged);
    classConnect(this, setPosValueInternalCB, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::positionInternalChanged);
    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    classConnect(this, setPosManualCB, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::positionManualChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    _manualActive =  MTP_ViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MTP_ViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MTP_ViewBase::getViewModel().getSource().getChannel();
    _osLevelStation = MTP_ViewBase::getViewModel().getOsLevel().getStationLevel();

    _refBarIndicator.setAlertHighShape(FALSE, MTP_ViewBase::getViewModel().getPositionMax());
    _refBarIndicator.setAlertLowShape(FALSE, MTP_ViewBase::getViewModel().getPositionMin());
    _refBarIndicator.setScale(MTP_ViewBase::getViewModel().getPositionScaleMin(), MTP_ViewBase::getViewModel().getPositionScaleMax());
    _refBarIndicator.setUnit(MTP_ViewBase::getViewModel().getPositionUnit());

    setPosManualCB(MTP_ViewBase::getViewModel().getPositionManual());
    _refBarIndicator.setValueCustomLimit(MTP_ViewBase::getViewModel().getPosition());
    setUnit(MTP_ViewBase::getViewModel().getPositionUnit());
    setPosFeedbackValueCB(MTP_ViewBase::getViewModel().getPositionFeedback());
    setPosValueInternalCB(MTP_ViewBase::getViewModel().getPositionInternal());

    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates manual mode.
   */
  public void changeManual()
  {
    MTP_ViewBase::getViewModel().getSource().setManualOperator(true);
  }

  /**
   * @brief Activates internal mode.
   */
  public void changeInternal()
  {
    MTP_ViewBase::getViewModel().getSource().setInternalOperator(true);
  }

  /**
   * @brief Sets the manual Pos value.
   *
   * @param valueManual The new manual Pos value.
   */
  public void setPosValueManual(const float &valueManual)
  {
    MTP_ViewBase::getViewModel().setPositionManual(valueManual);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _rectManual = MTP_ViewBase::extractShape("_rectManual");
    _rectInternal = MTP_ViewBase::extractShape("_rectInternal");
    _txtPosFeedbackValue = MTP_ViewBase::extractShape("_txtPosFeedbackValue");
    _txtPosValueInternal = MTP_ViewBase::extractShape("_txtPosValueInternal");
    _txtPosValueManual = MTP_ViewBase::extractShape("_txtPosValueManual");

    _refBarIndicator = MTP_ViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
  }

  /**
   * @brief Callback function to update the operational station level and reset mode button states.
   *
   * @param oslevel The new operational station level state.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setInternalActiveCB("", FALSE);
    setManualActiveCB("", FALSE);
  }

  /**
     * @brief Sets the unit for the bar indicator.
     *
     * @param unit The shared pointer to the MTP_Unit instance.
     */
  private void setUnit(shared_ptr<MTP_Unit> unit)
  {
    _refBarIndicator.setUnit(unit);
  }

  /**
   * @brief Callback function to update the manual Pos text display.
   *
   * @param valueManual The new manual Pos value.
   */
  private void setPosManualCB(const float &valueManual)
  {
    _txtPosValueManual.text = valueManual;
  }

  /**
   * @brief Callback function to update the Pos feedback text display.
   *
   * @param value The new Pos feedback value.
   */
  private void setPosFeedbackValueCB(const float &value)
  {
    _txtPosFeedbackValue.text = value;
  }

  /**
   * @brief Callback function to update the internal Pos text display.
   *
   * @param valueInternal The new internal Pos value.
   */
  private void setPosValueInternalCB(const float &valueInternal)
  {
    _txtPosValueInternal.text = valueInternal;
  }

  /**
   * @brief Callback function to update the internal mode button state.
   *
   * @param varName The name of the variable to set.
   * @param internalActive The new internal mode state.
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
   * @brief Callback function to update the manual mode button state.
   *
   * @param varName The name of the variable to set.
   * @param manualActive The new manual mode state.
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
      _txtPosValueManual.editable = FALSE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
    }
    else if (_osLevelStation && _manualActive && !_channel)
    {
      _txtPosValueManual.editable = TRUE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else
    {
      _txtPosValueManual.editable = FALSE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]");
  }
};
