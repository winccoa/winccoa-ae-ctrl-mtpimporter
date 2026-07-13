// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_Monitor/MTP_Monitor"
#uses "classes/MTP_MonAnaVlv/MTP_MonAnaVlv"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_MonAnaVlvFaceplateHome
 * @brief Represents the MTP_MonAnaVlvFaceplateHome class.
 */
class MTP_MonAnaVlvFaceplateHome : MTP_ViewBase
{
  private shape _rectAutomatic; //!< Reference to the rectangle shape for automatic mode control.
  private shape _rectError; //!< Reference to the rectangle shape for error indication.
  private shape _rectErrorInformation; //!< Reference to the rectangle shape for opening error information panel.
  private shape _rectLock; //!< Reference to the rectangle shape for interlock status.
  private shape _rectPositionError; //!< Reference to the rectangle shape for positional error.
  private shape _rectPositionErrorInformation; //!< Reference to the rectangle shape for opening positional error information panel.
  private shape _rectOff; //!< Reference to the rectangle shape for off state control.
  private shape _rectOperator; //!< Reference to the rectangle shape for operator mode control.
  private shape _rectPermission; //!< Reference to the rectangle shape for permission status.
  private shape _rectProtection; //!< Reference to the rectangle shape for protection status.
  private shape _rectReset; //!< Reference to the rectangle shape for reset control.
  private shape _rectSafetyPosition; //!< Reference to the rectangle shape for safety position status.
  private shape _rectSafetyPositionInformation; //!< Reference to the rectangle shape for opening safety position information panel.
  private shape _rectValve; //!< Reference to the rectangle shape for valve status.
  private shape _rectValveClose; //!< Reference to the rectangle shape for close control.
  private shape _rectValveOpen; //!< Reference to the rectangle shape for open control.
  private shape _rectValveCloseAut; //!< Reference to the rectangle shape for close automatic mode indication.
  private shape _rectValveOpenAut; //!< Reference to the rectangle shape for open automatic mode indication.
  private shape _txtError; //!< Reference to the text shape for error status label.
  private shape _txtLock; //!< Reference to the text shape for interlock status label.
  private shape _txtPositionError; //!< Reference to the text shape for positional error label.
  private shape _txtPermission; //!< Reference to the text shape for permission status label.
  private shape _txtProtection; //!< Reference to the text shape for protection status label.
  private shape _txtSafetyPosition; //!< Reference to the text shape for safety position status label.

  private bool _valveControl; //!< Indicates the valve control state.
  private bool _staticError; //!< Indicates if a static error is present.
  private bool _dynamicError; //!< Indicates if a dynamic error is present.
  private bool _monitorEnabled; //!< Indicates if monitoring is enabled.

  private bool _safetypositionActive; //!< Indicates if the safety position is active.
  private bool _safetypositionEnabled; //!< Indicates if the safety position is enabled.

  private bool _stateAutomaticActive; //!< Indicates if automatic mode is active.
  private bool _openAutomatic; //!< Indicates if open automatic command is active.
  private bool _closeAutomatic; //!< Indicates if close automatic command is active.

  private bool _permissionEnabled; //!< Indicates if permission is enabled.
  private bool _permit; //!< Indicates the permission state.
  private bool _interlockEnabled; //!< Indicates if interlock is enabled.
  private bool _interlock; //!< Indicates the interlock state.
  private bool _protectionEnabled; //!< Indicates if protection is enabled.
  private bool _protection; //!< Indicates the protection state.

  private bool _stateOffActive; //!< Indicates if off state is active.
  private bool _stateChannel; //!< Indicates the channel state.
  private bool _stateOperatorActive; //!< Indicates if operator mode is active.
  private bool _osLevelStation; //!< Indicates the operational station level.

  private bool _openFeedbackSignal; //!< Indicates if the open feedback signal is active.
  private bool _closeFeedbackSignal; //!< Indicates if the close feedback signal is active.
  private bool _openActive; //!< Indicates if the open is active.
  private bool _closeActive; //!< Indicates if the close is active.
  private bool _monitorPositionError; //!< Indicates if the monitor position error is active.

  private shared_ptr<MTP_BarIndicator> _refBarIndicator;  //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MTP_MonAnaVlvFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonAnaVlvFaceplateHome(shared_ptr<MTP_MonAnaVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MTP_BarIndicator::setValueCustomLimit, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::positionFeedbackChanged);

    classConnectUserData(this, setValveCB, "_openFeedbackSignal", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::openFeedbackChanged);
    classConnectUserData(this, setValveCB, "_monitorPositionError", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::monitorPositionErrorChanged);
    classConnectUserData(this, setValveCB, "_closeFeedbackSignal", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::closeFeedbackChanged);
    classConnectUserData(this, setValveCB, "_openActive", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::openActiveChanged);
    classConnectUserData(this, setValveCB, "_closeActive", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::closeActiveChanged);
    classConnectUserData(this, setValveCB, "_staticError", MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setValveCB, "_dynamicError", MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);

    classConnectUserData(this, setErrorCB, "_staticError", MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    classConnect(this, setPositionErrorCB, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::monitorPositionErrorChanged);

    classConnectUserData(this, setSafetyPositionActiveCB, "_safetypositionActive", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::safetyPositionActiveChanged);
    classConnectUserData(this, setSafetyPositionActiveCB, "_safetypositionEnabled", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::safetyPositionEnabledChanged);

    classConnectUserData(this, setAutomaticPreviewLineCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_openAutomatic", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::openAutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_closeAutomatic", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::closeAutomaticChanged);

    classConnectUserData(this, setSecurityCB, "_permissionEnabled", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::permissionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_permit", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::permitChanged);
    classConnectUserData(this, setSecurityCB, "_interlockEnabled", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::interlockEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_interlock", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::interlockChanged);
    classConnectUserData(this, setSecurityCB, "_protectionEnabled", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::protectionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_protection", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::protectionChanged);

    //Buttons:
    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MTP_ViewBase::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    classConnectUserData(this, setValveCloseCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setValveCloseCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setValveCloseCB, "_openFeedbackSignal", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::openFeedbackChanged);
    classConnectUserData(this, setValveCloseCB, "_closeFeedbackSignal", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::closeFeedbackChanged);
    classConnectUserData(this, setValveCloseCB, "_openActive", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::openActiveChanged);
    classConnectUserData(this, setValveCloseCB, "_closeActive", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::closeActiveChanged);

    classConnectUserData(this, setValveOpenCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setValveOpenCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setValveOpenCB, "_openFeedbackSignal", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::openFeedbackChanged);
    classConnectUserData(this, setValveOpenCB, "_closeFeedbackSignal", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::closeFeedbackChanged);
    classConnectUserData(this, setValveOpenCB, "_openActive", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::openActiveChanged);
    classConnectUserData(this, setValveOpenCB, "_closeActive", MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::closeActiveChanged);

    classConnectUserData(this, setResetCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setResetCB, "_protectionEnabled", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::protectionEnabledChanged);
    classConnectUserData(this, setResetCB, "_protection", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::protectionChanged);
    classConnectUserData(this, setResetCB, "_staticError", MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::staticErrorChanged);
    classConnectUserData(this, setResetCB, "_dynamicError", MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::dynamicErrorChanged);

    _stateOffActive =  MTP_ViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MTP_ViewBase::getViewModel().getState().getChannel();
    _stateOperatorActive =  MTP_ViewBase::getViewModel().getState().getOperatorActive();
    _safetypositionEnabled = MTP_ViewBase::getViewModel().getSafetyPositionEnabled();
    _safetypositionActive = MTP_ViewBase::getViewModel().getSafetyPositionActive();

    _staticError =  MTP_ViewBase::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MTP_ViewBase::getViewModel().getMonitor().getDynamicError();
    _openFeedbackSignal = MTP_ViewBase::getViewModel().getOpenFeedback();
    _closeFeedbackSignal = MTP_ViewBase::getViewModel().getCloseFeedback();
    _openActive =  MTP_ViewBase::getViewModel().getOpenActive();
    _closeActive =  MTP_ViewBase::getViewModel().getCloseActive();
    _monitorPositionError =  MTP_ViewBase::getViewModel().getMonitorPositionError();
    _stateAutomaticActive = MTP_ViewBase::getViewModel().getState().getAutomaticActive();
    _openAutomatic =  MTP_ViewBase::getViewModel().getOpenAutomatic();
    _closeAutomatic =  MTP_ViewBase::getViewModel().getCloseAutomatic();
    _monitorEnabled = MTP_ViewBase::getViewModel().getMonitor().getEnabled();

    _permissionEnabled =  MTP_ViewBase::getViewModel().getSecurity().getPermissionEnabled();
    _permit =  MTP_ViewBase::getViewModel().getSecurity().getPermit();
    _interlockEnabled =  MTP_ViewBase::getViewModel().getSecurity().getInterlockEnabled();
    _interlock =  MTP_ViewBase::getViewModel().getSecurity().getInterlock();
    _protectionEnabled =  MTP_ViewBase::getViewModel().getSecurity().getProtectionEnabled();
    _protection =  MTP_ViewBase::getViewModel().getSecurity().getProtection();

    _refBarIndicator.setAlertHighShape(FALSE, MTP_ViewBase::getViewModel().getPositionMax());
    _refBarIndicator.setAlertLowShape(FALSE, MTP_ViewBase::getViewModel().getPositionMin());
    _refBarIndicator.setScale(MTP_ViewBase::getViewModel().getPositionScaleMin(), MTP_ViewBase::getViewModel().getPositionScaleMax());
    _refBarIndicator.hideUnit();
    _refBarIndicator.hideValue();

    _refBarIndicator.setValueCustomLimit(MTP_ViewBase::getViewModel().getPositionFeedback());

    setValveCB("_openFeedbackSignal", _openFeedbackSignal);
    setErrorCB("_staticError", _staticError);
    setSafetyPositionActiveCB("_safetypositionActive", _safetypositionActive);
    setAutomaticPreviewLineCB("_stateAutomaticActive", _stateAutomaticActive);
    setSecurityCB("_permissionEnabled", _permissionEnabled);
    setPositionErrorCB(_monitorPositionError);

    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setResetCB("_stateOperatorActive", _stateOperatorActive);
    setValveCloseCB("_stateAutomaticActive", _stateAutomaticActive);
    setValveOpenCB("_stateAutomaticActive", _stateAutomaticActive);
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates the off state.
   */
  public void activateStateOff()
  {
    MTP_ViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  /**
   * @brief Activates operator mode.
   */
  public void activateStateOperator()
  {
    MTP_ViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  /**
   * @brief Activates automatic mode.
   */
  public void activateStateAutomatic()
  {
    MTP_ViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  /**
   * @brief Activates the reset command.
   */
  public void activateReset()
  {
    MTP_ViewBase::getViewModel().setResetOperator(TRUE);
  }

  /**
   * @brief Activates the valve close command.
   */
  public void activateValveClose()
  {
    MTP_ViewBase::getViewModel().setCloseOperator(TRUE);
  }

  /**
   * @brief Activates the valve open command.
   */
  public void activateValveOpen()
  {
    MTP_ViewBase::getViewModel().setOpenOperator(TRUE);
  }

  /**
   * @brief Opens the error information child panel.
   */
  public void openErrorInformation()
  {
    MTP_ViewBase::openChildPanel("objects_parts/faceplates/MTP_MonAnaVlv/main_FeedbackError.pnl", "Error Information");
  }

  /**
   * @brief Opens the position error information.
   */
  public void openPositionErrorInformation()
  {
    MTP_ViewBase::openChildPanel("objects_parts/faceplates/MTP_MonAnaVlv/main_PositionError.pnl", "Position Error Information");
  }

  /**
   * @brief Opens the safety position information child panel.
   */
  public void openSafetyPositionInformation()
  {
    MTP_ViewBase::openChildPanel("objects_parts/faceplates/MTP_MonAnaVlv/main_SafetyPositionInformation.pnl", "SafetyPosition Information");
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _refBarIndicator = MTP_ViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();

    _rectAutomatic = MTP_ViewBase::extractShape("_rectAutomatic");
    _rectError = MTP_ViewBase::extractShape("_rectError");
    _rectErrorInformation = MTP_ViewBase::extractShape("_rectErrorInformation");
    _rectLock = MTP_ViewBase::extractShape("_rectLock");
    _rectPositionError = MTP_ViewBase::extractShape("_rectPositionError");
    _rectPositionErrorInformation = MTP_ViewBase::extractShape("_rectPositionErrorInformation");
    _rectOff = MTP_ViewBase::extractShape("_rectOff");
    _rectOperator = MTP_ViewBase::extractShape("_rectOperator");
    _rectPermission = MTP_ViewBase::extractShape("_rectPermission");
    _rectProtection = MTP_ViewBase::extractShape("_rectProtection");
    _rectReset = MTP_ViewBase::extractShape("_rectReset");
    _rectSafetyPosition = MTP_ViewBase::extractShape("_rectSafetyPosition");
    _rectSafetyPositionInformation = MTP_ViewBase::extractShape("_rectSafetyPositionInformation");
    _rectValve = MTP_ViewBase::extractShape("_rectValve");
    _rectValveClose = MTP_ViewBase::extractShape("_rectValveClose");
    _rectValveOpen = MTP_ViewBase::extractShape("_rectValveOpen");
    _rectValveCloseAut = MTP_ViewBase::extractShape("_rectValveCloseAut");
    _rectValveOpenAut = MTP_ViewBase::extractShape("_rectValveOpenAut");
    _txtError = MTP_ViewBase::extractShape("_txtError");
    _txtLock = MTP_ViewBase::extractShape("_txtLock");
    _txtPositionError = MTP_ViewBase::extractShape("_txtPositionError");
    _txtPermission = MTP_ViewBase::extractShape("_txtPermission");
    _txtProtection = MTP_ViewBase::extractShape("_txtProtection");
    _txtSafetyPosition = MTP_ViewBase::extractShape("_txtSafetyPosition");
  }

  /**
   * @brief Callback function to update the operational station level.
   *
   * @param oslevel The new operational station level state.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setStateOffActiveCB("", FALSE);
    setOperatorActiveCB("", FALSE);
    setAutomaticActiveCB("", FALSE);
    setValveOpenCB("", FALSE);
    setValveCloseCB("", FALSE);
    setResetCB("", FALSE);
  }

  /**
   * @brief Sets the position error from the connected data point element.
   *
   * @param error The new error value.
   */
  private void setPositionErrorCB(const bool &error)
  {
    _monitorPositionError = error;

    if (_monitorEnabled && _monitorPositionError)
    {
      _rectPositionError.visible = TRUE;
      _txtPositionError.visible = TRUE;
      _rectPositionErrorInformation.visible = TRUE;
      _rectPositionError.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectPositionError.sizeAsDyn = makeDynInt(30, 25);
    }
    else if (_monitorEnabled && !_monitorPositionError)
    {
      _rectPositionError.visible = TRUE;
      _txtPositionError.visible = TRUE;
      _rectPositionErrorInformation.visible = TRUE;
      _rectPositionError.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectPositionError.sizeAsDyn = makeDynInt(30, 25);
    }
    else if (!_monitorEnabled)
    {
      _rectPositionError.visible = FALSE;
      _txtPositionError.visible = FALSE;
      _rectPositionErrorInformation.visible = FALSE;
    }
  }

  /**
   * @brief Callback function to update the valve open button state.
   *
   * @param varName The name of the variable to set.
   * @param open The new open state.
   */
  private void setValveOpenCB(const string &varName, const bool &open)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = open;
        break;

      case "_stateOperatorActive":
        _stateOperatorActive = open;
        break;

      case "_openFeedbackSignal":
        _openFeedbackSignal = open;
        break;

      case "_closeFeedbackSignal":
        _closeFeedbackSignal = open;
        break;

      case "_openActive":
        _openActive = open;
        break;

      case "_closeActive":
        _closeActive = open;
        break;
    }

    if ((_stateAutomaticActive && !_closeFeedbackSignal && _openFeedbackSignal) || (_stateOperatorActive && _openFeedbackSignal && !_closeFeedbackSignal && !_osLevelStation))
    {
      _rectValveOpen.fill = "[pattern,[fit,any,MTP_Icones/ValveOpen1_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_closeFeedbackSignal && _openFeedbackSignal && _osLevelStation)
    {
      _rectValveOpen.fill = "[pattern,[fit,any,MTP_Icones/ValveOpen2_rounded.svg]]";
    }
    else if ((_stateAutomaticActive && _openActive && !_openFeedbackSignal) || (_stateOperatorActive && _openActive && !_openFeedbackSignal && !_osLevelStation))
    {
      _rectValveOpen.fill = "[pattern,[fit,any,MTP_Icones/ValveOpen3_rounded.svg]]";
    }
    else if (_stateOperatorActive && _openActive && !_openFeedbackSignal && _osLevelStation)
    {
      _rectValveOpen.fill = "[pattern,[fit,any,MTP_Icones/ValveOpen4_rounded.svg]]";
    }
    else
    {
      _rectValveOpen.fill = "[pattern,[fit,any,MTP_Icones/ValveOpen5_rounded.svg]]";
    }

    _rectValveOpen.transparentForMouse = (_rectValveOpen.fill == "[pattern,[fit,any,MTP_Icones/ValveOpen1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the valve close button state.
   *
   * @param varName The name of the variable to set.
   * @param close The new close state.
   */
  private void setValveCloseCB(const string &varName, const bool &close)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = close;
        break;

      case "_stateOperatorActive":
        _stateOperatorActive = close;
        break;

      case "_openFeedbackSignal":
        _openFeedbackSignal = close;
        break;

      case "_closeFeedbackSignal":
        _closeFeedbackSignal = close;
        break;

      case "_openActive":
        _openActive = close;
        break;

      case "_closeActive":
        _closeActive = close;
        break;
    }

    if ((_stateAutomaticActive && _closeFeedbackSignal && !_openFeedbackSignal) || (_stateOperatorActive && _closeFeedbackSignal && !_openFeedbackSignal && !_osLevelStation))
    {
      _rectValveClose.fill = "[pattern,[fit,any,MTP_Icones/ValveClose1_rounded.svg]]";
    }
    else if (_stateOperatorActive && _closeFeedbackSignal && !_openFeedbackSignal && _osLevelStation)
    {
      _rectValveClose.fill = "[pattern,[fit,any,MTP_Icones/ValveClose2_rounded.svg]]";
    }
    else if ((_stateAutomaticActive && _closeActive && !_closeFeedbackSignal) || (_stateOperatorActive && _closeActive && !_closeFeedbackSignal && !_osLevelStation))
    {
      _rectValveClose.fill = "[pattern,[fit,any,MTP_Icones/ValveClose3_rounded.svg]]";
    }
    else if (_stateOperatorActive && _closeActive && !_closeFeedbackSignal && _osLevelStation)
    {
      _rectValveClose.fill = "[pattern,[fit,any,MTP_Icones/ValveClose4_rounded.svg]]";
    }
    else
    {
      _rectValveClose.fill = "[pattern,[fit,any,MTP_Icones/ValveClose5_rounded.svg]]";
    }

    _rectValveClose.transparentForMouse = (_rectValveClose.fill == "[pattern,[fit,any,MTP_Icones/ValveClose1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the reset button state.
   *
   * @param varName The name of the variable to set.
   * @param reset The new reset state.
   */
  private void setResetCB(const string &varName, const bool &reset)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = reset;
        break;

      case "_protectionEnabled":
        _protectionEnabled = reset;
        break;

      case "_protection":
        _protection = reset;
        break;

      case "_staticError":
        _staticError = reset;
        break;

      case "_dynamicError":
        _dynamicError = reset;
        break;
    }

    if (_stateOperatorActive && _osLevelStation && ((_protectionEnabled && !_protection) || _staticError || _dynamicError))
    {
      _rectReset.fill = "[pattern,[fit,any,MTP_Icones/reset_2.svg]]";
    }
    else
    {
      _rectReset.fill = "[pattern,[fit,any,MTP_Icones/reset_1.svg]]";
    }

    _rectReset.transparentForMouse = (_rectReset.fill == "[pattern,[fit,any,MTP_Icones/reset_1.svg]]");
  }

  /**
   * @brief Callback function to update the automatic mode button state.
   *
   * @param varName The name of the variable to set.
   * @param state The new automatic mode state.
   */
  private void setAutomaticActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if ((_stateAutomaticActive && _stateChannel) || (!_stateChannel && _stateAutomaticActive && !_osLevelStation))
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]";
    }
    else if (_stateAutomaticActive && !_stateChannel && _osLevelStation)
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_2_rounded.svg]]";
    }
    else
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_3_rounded.svg]]";
    }

    _rectAutomatic.transparentForMouse = (_rectAutomatic.fill == "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]");
  }

  /**
     * @brief Callback function to update the operator mode button state.
     *
     * @param varName The name of the variable to set.
     * @param state The new operator mode state.
     */
  private void setOperatorActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if ((_stateOperatorActive && _stateChannel) || (!_stateChannel && _stateOperatorActive && !_osLevelStation))
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_1_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_stateChannel && _osLevelStation)
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_2_rounded.svg]]";
    }
    else
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_3_rounded.svg]]";
    }

    _rectOperator.transparentForMouse = (_rectOperator.fill == "[pattern,[fit,any,MTP_Icones/Operator_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the off state button state.
   *
   * @param varName The name of the variable to set.
   * @param state The new off state.
   */
  private void setStateOffActiveCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOffActive":
        _stateOffActive = state;
        break;

      case "_stateChannel":
        _stateChannel = state;
        break;
    }

    if ((_stateOffActive && _stateChannel) || (!_stateChannel && _stateOffActive && !_osLevelStation))
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]";
    }
    else if (_stateOffActive && !_stateChannel && _osLevelStation)
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_3_rounded.svg]]";
    }
    else
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_1_rounded.svg]]";
    }

    _rectOff.transparentForMouse = (_rectOff.fill == "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]");
  }

  /**
   * @brief Callback function to update security-related shapes.
   *
   * @param varName The name of the variable to set.
   * @param security The new security state.
   */
  private void setSecurityCB(const string &varName, const bool &security)
  {
    switch (varName)
    {
      case "_permissionEnabled":
        _permissionEnabled = security;
        break;

      case "_permit":
        _permit = security;
        break;

      case "_interlockEnabled":
        _interlockEnabled = security;
        break;

      case "_interlock":
        _interlock = security;
        break;

      case "_protectionEnabled":
        _protectionEnabled = security;
        break;

      case "_protection":
        _protection = security;
        break;
    }

    if (_permissionEnabled && _permit)
    {
      _rectPermission.visible = TRUE;
      _txtPermission.visible = TRUE;
      _rectPermission.fill = "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]";
    }
    else if (_permissionEnabled && !_permit)
    {
      _rectPermission.visible = TRUE;
      _txtPermission.visible = TRUE;
      _rectPermission.fill = "[pattern,[fit,any,MTP_Icones/Locked_2.svg]]";
    }
    else
    {
      _rectPermission.visible = FALSE;
      _txtPermission.visible = FALSE;
    }

    if (_interlockEnabled && _interlock)
    {
      _rectLock.visible = TRUE;
      _txtLock.visible = TRUE;
      _rectLock.fill = "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]";
    }
    else if (_interlockEnabled && !_interlock)
    {
      _rectLock.visible = TRUE;
      _txtLock.visible = TRUE;
      _rectLock.fill = "[pattern,[fit,any,MTP_Icones/Locked_2.svg]]";
    }
    else
    {
      _rectLock.visible = FALSE;
      _txtLock.visible = FALSE;
    }

    if (_protectionEnabled && _protection)
    {
      _rectProtection.visible = TRUE;
      _txtProtection.visible = TRUE;
      _rectProtection.fill = "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]";
    }
    else if (_protectionEnabled && !_protection)
    {
      _rectProtection.visible = TRUE;
      _txtProtection.visible = TRUE;
      _rectProtection.fill = "[pattern,[fit,any,MTP_Icones/Locked_2.svg]]";
    }
    else
    {
      _rectProtection.visible = FALSE;
      _txtProtection.visible = FALSE;
    }
  }

  /**
   * @brief Callback function to update the automatic mode preview line shapes.
   *
   * @param varName The name of the variable to set.
   * @param state The new automatic mode state.
   */
  private void setAutomaticPreviewLineCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_openAutomatic":
        _openAutomatic = state;
        break;

      case "_closeAutomatic":
        _closeAutomatic = state;
        break;
    }

    if (!_stateAutomaticActive && _openAutomatic)
    {
      _rectValveOpenAut.visible = TRUE;
      _rectValveCloseAut.visible = FALSE;
    }
    else if (!_stateAutomaticActive && _closeAutomatic)
    {
      _rectValveOpenAut.visible = FALSE;
      _rectValveCloseAut.visible = TRUE;
    }
    else
    {
      _rectValveOpenAut.visible = FALSE;
      _rectValveCloseAut.visible = FALSE;
    }
  }

  /**
   * @brief Callback function to update the safety position shape.
   *
   * @param varName The name of the variable to set.
   * @param value The new safety position state.
   */
  private void setSafetyPositionActiveCB(const string &varName, const bool &value)
  {
    switch (varName)
    {
      case "_safetypositionActive":
        _safetypositionActive = value;
        break;

      case "_safetypositionEnabled":
        _safetypositionEnabled = value;
        break;
    }

    if (_safetypositionActive && _safetypositionEnabled)
    {
      _rectSafetyPosition.visible = TRUE;
      _txtSafetyPosition.visible = TRUE;
      _rectSafetyPositionInformation.visible = TRUE;
      _rectSafetyPosition.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
      _rectSafetyPosition.sizeAsDyn = makeDynInt(25, 25);
    }
    else if (!_safetypositionActive && _safetypositionEnabled)
    {
      _rectSafetyPosition.visible = TRUE;
      _txtSafetyPosition.visible = TRUE;
      _rectSafetyPositionInformation.visible = TRUE;
      _rectSafetyPosition.fill = "[pattern,[fit,any,MTP_Icones/GreyOk.svg]]";
      _rectSafetyPosition.sizeAsDyn = makeDynInt(30, 25);
    }
    else
    {
      _rectSafetyPosition.visible = FALSE;
      _txtSafetyPosition.visible = FALSE;
      _rectSafetyPositionInformation.visible = FALSE;
    }
  }

  /**
   * @brief Callback function to update the error shape.
   *
   * @param varName The name of the variable to set.
   * @param error The new error state.
   */
  private void setErrorCB(const string &varName, const bool &error)
  {
    switch (varName)
    {
      case "_staticError":
        _staticError = error;
        break;

      case "_dynamicError":
        _dynamicError = error;
        break;
    }

    if (_monitorEnabled && !_staticError && !_dynamicError)
    {
      _rectError.visible = TRUE;
      _txtError.visible = TRUE;
      _rectErrorInformation.visible = TRUE;
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectError.sizeAsDyn = makeDynInt(30, 25);
    }
    else if (_monitorEnabled && (_staticError || _dynamicError))
    {
      _rectError.visible = TRUE;
      _txtError.visible = TRUE;
      _rectErrorInformation.visible = TRUE;
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectError.sizeAsDyn = makeDynInt(30, 25);
    }
    else if (!_monitorEnabled)
    {
      _rectError.visible = FALSE;
      _txtError.visible = FALSE;
      _rectErrorInformation.visible = FALSE;
    }
  }

  /**
   * @brief Sets the valve status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param valve The valve state to be set.
   */
  protected void setValveCB(const string &varName, const bool &valve)
  {
    switch (varName)
    {
      case "_openFeedbackSignal":
        _openFeedbackSignal = valve;
        break;

      case "_monitorPositionError":
        _monitorPositionError = valve;
        break;

      case "_closeFeedbackSignal":
        _closeFeedbackSignal = valve;
        break;

      case "_openActive":
        _openActive = valve;
        break;

      case "_closeActive":
        _closeActive = valve;
        break;

      case "_staticError":
        _staticError = valve;
        break;

      case "_dynamicError":
        _dynamicError = valve;
        break;
    }

    if (_rectValve.enabled())
    {
      if (_openFeedbackSignal && !_dynamicError && !_staticError && !_monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvOpen.svg]]";
        _rectValve.visible = TRUE;
        return;
      }
      else if (_closeFeedbackSignal && !_dynamicError && !_staticError && !_monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvStopped.svg]]";
        _rectValve.visible = TRUE;
      }
      else if (_openActive && !_dynamicError && !_staticError && !_monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStarted.svg]]";
        _rectValve.visible = TRUE;
      }
      else if (!_openFeedbackSignal && !_closeFeedbackSignal && _closeActive && !_dynamicError && !_staticError && !_monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStopped.svg]]";
        _rectValve.visible = TRUE;
      }
      else if ((_openFeedbackSignal && _closeFeedbackSignal) || _dynamicError || _staticError || _monitorPositionError)
      {
        _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvUknownState.svg]]";
        _rectValve.visible = TRUE;
      }
      else
      {
        _rectValve.visible = FALSE;
      }
    }
  }
};
