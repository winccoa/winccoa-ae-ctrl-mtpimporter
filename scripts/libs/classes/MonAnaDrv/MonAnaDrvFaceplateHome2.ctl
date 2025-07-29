// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpBarIndicator/MtpBarIndicator"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MonAnaDrvFaceplateHome2
 * @brief Represents the secondary faceplate for MonAnaDrv objects, handling manual and internal mode controls and RPM display.
 */
class MonAnaDrvFaceplateHome2 : MtpViewBase
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

  private shared_ptr<MtpBarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MonAnaDrvFaceplateHome2.
   *
   * @param viewModel A shared pointer to the MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonAnaDrvFaceplateHome2(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MtpBarIndicator::setValueCustomLimit, MtpViewBase::getViewModel(), MonAnaDrv::rpmChanged);
    classConnect(this, setRpmFeedbackValueCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmFeedbackSignalChanged);
    classConnect(this, setRpmValueInternalCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmInternalChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    classConnect(this, setRpmManualCB, MtpViewBase::getViewModel(), MonAnaDrv::rpmManualChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();
    _osLevelStation = MtpViewBase::getViewModel().getOsLevel().getStationLevel();

    _refBarIndicator.setAlertHighShape(FALSE, MtpViewBase::getViewModel().getRpmMax());
    _refBarIndicator.setAlertLowShape(FALSE, MtpViewBase::getViewModel().getRpmMin());
    _refBarIndicator.setScale(MtpViewBase::getViewModel().getRpmScaleMin(), MtpViewBase::getViewModel().getRpmScaleMax());
    _refBarIndicator.setUnit(MtpViewBase::getViewModel().getRpmUnit());

    setRpmManualCB(MtpViewBase::getViewModel().getRpmManual());
    _refBarIndicator.setValueCustomLimit(MtpViewBase::getViewModel().getRpm());
    setUnit(MtpViewBase::getViewModel().getRpmUnit());
    setRpmFeedbackValueCB(MtpViewBase::getViewModel().getRpmFeedbackSignal());
    setRpmValueInternalCB(MtpViewBase::getViewModel().getRpmInternal());

    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates manual mode.
   * @details Calls the setManualOperator method on the view model's source.
   */
  public void changeManual()
  {
    MtpViewBase::getViewModel().getSource().setManualOperator(true);
  }

  /**
   * @brief Activates internal mode.
   * @details Calls the setInternalOperator method on the view model's source.
   */
  public void changeInternal()
  {
    MtpViewBase::getViewModel().getSource().setInternalOperator(true);
  }

  /**
   * @brief Sets the manual RPM value.
   * @details Updates the manual RPM value in the view model.
   *
   * @param valueManual The new manual RPM value.
   */
  public void setRpmValueManual(const float &valueManual)
  {
    MtpViewBase::getViewModel().setRpmManual(valueManual);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the required shapes.
   */
  protected void initializeShapes()
  {
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _txtRpmFeedbackValue = MtpViewBase::extractShape("_txtRpmFeedbackValue");
    _txtRpmValueInternal = MtpViewBase::extractShape("_txtRpmValueInternal");
    _txtRpmValueManual = MtpViewBase::extractShape("_txtRpmValueManual");

    _refBarIndicator = MtpViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
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
     * @param unit The shared pointer to the MtpUnit instance.
     */
  private void setUnit(shared_ptr<MtpUnit> unit)
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
