// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_MonAnaDrv/MTP_MonAnaDrv"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_MonAnaDrvFaceplateHome2
 * @brief Represents the MTP_MonAnaDrvFaceplateHome2 class.
 */
class MTP_MonAnaDrvFaceplateHome2 : MTP_ViewBase
{
  private shape _rectInternal; //!< Reference to the internal mode rectangle shape.
  private shape _rectManual; //!< Reference to the manual mode rectangle shape.
  private shape _txtRpmValueManual; //!< Reference to the text shape for displaying the manual RPM value.
  private shape _txtRpmValueInternal; //!< Reference to the text shape for displaying the internal RPM value.
  private shape _txtRpmFeedbackValue; //!< Reference to the text shape for displaying the RPM feedback value.

  private bool _manualActive; //!< Indicates if manual mode is active.
  private bool _internalActive; //!< Indicates if internal mode is active.
  private bool _channel; //!< Indicates the channel state.
  private bool _osLevelStation; //!< Indicates the operational station level.

  private shared_ptr<MTP_BarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MTP_MonAnaDrvFaceplateHome2.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonAnaDrvFaceplateHome2(shared_ptr<MTP_MonAnaDrv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MTP_BarIndicator::setValueCustomLimit, MTP_ViewBase::getViewModel(), MTP_MonAnaDrv::rpmChanged);
    classConnect(this, setRpmFeedbackValueCB, MTP_ViewBase::getViewModel(), MTP_MonAnaDrv::rpmFeedbackSignalChanged);
    classConnect(this, setRpmValueInternalCB, MTP_ViewBase::getViewModel(), MTP_MonAnaDrv::rpmInternalChanged);
    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    classConnect(this, setRpmManualCB, MTP_ViewBase::getViewModel(), MTP_MonAnaDrv::rpmManualChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    _manualActive =  MTP_ViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MTP_ViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MTP_ViewBase::getViewModel().getSource().getChannel();
    _osLevelStation = MTP_ViewBase::getViewModel().getOsLevel().getStationLevel();

    _refBarIndicator.setAlertHighShape(FALSE, MTP_ViewBase::getViewModel().getRpmMax());
    _refBarIndicator.setAlertLowShape(FALSE, MTP_ViewBase::getViewModel().getRpmMin());
    _refBarIndicator.setScale(MTP_ViewBase::getViewModel().getRpmScaleMin(), MTP_ViewBase::getViewModel().getRpmScaleMax());
    _refBarIndicator.setUnit(MTP_ViewBase::getViewModel().getRpmUnit());

    setRpmManualCB(MTP_ViewBase::getViewModel().getRpmManual());
    _refBarIndicator.setValueCustomLimit(MTP_ViewBase::getViewModel().getRpm());
    setUnit(MTP_ViewBase::getViewModel().getRpmUnit());
    setRpmFeedbackValueCB(MTP_ViewBase::getViewModel().getRpmFeedbackSignal());
    setRpmValueInternalCB(MTP_ViewBase::getViewModel().getRpmInternal());

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
   * @brief Sets the manual RPM value.
   *
   * @param valueManual The new manual RPM value.
   */
  public void setRpmValueManual(const float &valueManual)
  {
    MTP_ViewBase::getViewModel().setRpmManual(valueManual);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _rectManual = MTP_ViewBase::extractShape("_rectManual");
    _rectInternal = MTP_ViewBase::extractShape("_rectInternal");
    _txtRpmFeedbackValue = MTP_ViewBase::extractShape("_txtRpmFeedbackValue");
    _txtRpmValueInternal = MTP_ViewBase::extractShape("_txtRpmValueInternal");
    _txtRpmValueManual = MTP_ViewBase::extractShape("_txtRpmValueManual");

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
   * @brief Callback function to update the manual RPM text display.
   *
   * @param valueManual The new manual RPM value.
   */
  private void setRpmManualCB(const float &valueManual)
  {
    _txtRpmValueManual.text = valueManual;
  }

  /**
   * @brief Callback function to update the RPM feedback text display.
   *
   * @param value The new RPM feedback value.
   */
  private void setRpmFeedbackValueCB(const float &value)
  {
    _txtRpmFeedbackValue.text = value;
  }

  /**
   * @brief Callback function to update the internal RPM text display.
   *
   * @param valueInternal The new internal RPM value.
   */
  private void setRpmValueInternalCB(const float &valueInternal)
  {
    _txtRpmValueInternal.text = valueInternal;
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
      _txtRpmValueManual.editable = FALSE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
    }
    else if (_osLevelStation && _manualActive && !_channel)
    {
      _txtRpmValueManual.editable = TRUE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else
    {
      _txtRpmValueManual.editable = FALSE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]");
  }
};
