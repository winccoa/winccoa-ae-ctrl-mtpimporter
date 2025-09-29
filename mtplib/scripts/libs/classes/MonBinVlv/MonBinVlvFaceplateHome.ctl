// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MonBinVlvFaceplateHome
 * @brief A faceplate class for controlling and monitoring binary valve operations, including open/close commands, safety position, and security states.
 */
class MonBinVlvFaceplateHome : MtpViewBase
{
  private shape _refWqc; //!< Reference to the shape for displaying quality code status.
  private shape _rectAutomatic; //!< Reference to the rectangle shape for automatic mode control.
  private shape _rectError; //!< Reference to the rectangle shape for error indication.
  private shape _rectErrorInformation; //!< Reference to the rectangle shape for opening error information panel.
  private shape _rectLock; //!< Reference to the rectangle shape for interlock status.
  private shape _rectMaintenance; //!< Reference to the rectangle shape for maintenance mode status.
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
  private shape _txtMaintenance; //!< Reference to the text shape for maintenance mode status label.
  private shape _txtPermission; //!< Reference to the text shape for permission status label.
  private shape _txtProtection; //!< Reference to the text shape for protection status label.
  private shape _txtSafetyPosition; //!< Reference to the text shape for safety position status label.

  private bool _openCheckbackSignal; //!< Indicates the open checkback signal state.
  private bool _closeCheckbackSignal; //!< Indicates the close checkback signal state.
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

  /**
   * @brief Constructor for MonBinVlvFaceplateHome.
   * @details Initializes the faceplate by connecting to the view model's signals and setting initial states for valve control and monitoring.
   *
   * @param viewModel A shared pointer to the MonBinVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonBinVlvFaceplateHome(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setValveCB, "_openCheckbackSignal", MtpViewBase::getViewModel(), MonBinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_closeCheckbackSignal", MtpViewBase::getViewModel(), MonBinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_valveControl", MtpViewBase::getViewModel(), MonBinVlv::valveControlChanged);
    classConnectUserData(this, setValveCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setValveCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnectUserData(this, setErrorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    classConnectUserData(this, setSafetyPositionActiveCB, "_safetypositionActive", MtpViewBase::getViewModel(), MonBinVlv::safetyPositionActiveChanged);
    classConnectUserData(this, setSafetyPositionActiveCB, "_safetypositionEnabled", MtpViewBase::getViewModel(), MonBinVlv::safetyPositionEnabledChanged);

    classConnectUserData(this, setAutomaticPreviewLineCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_openAutomatic", MtpViewBase::getViewModel(), MonBinVlv::openAutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_closeAutomatic", MtpViewBase::getViewModel(), MonBinVlv::closeAutomaticChanged);

    classConnectUserData(this, setSecurityCB, "_permissionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permissionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_permit", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permitChanged);
    classConnectUserData(this, setSecurityCB, "_interlockEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_interlock", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockChanged);
    classConnectUserData(this, setSecurityCB, "_protectionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_protection", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionChanged);

    //Buttons:
    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MtpViewBase::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setValveCloseCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setValveCloseCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setValveCloseCB, "_openCheckbackSignal", MtpViewBase::getViewModel(), MonBinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveCloseCB, "_closeCheckbackSignal", MtpViewBase::getViewModel(), MonBinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveCloseCB, "_valveControl", MtpViewBase::getViewModel(), MonBinVlv::valveControlChanged);

    classConnectUserData(this, setValveOpenCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setValveOpenCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setValveOpenCB, "_openCheckbackSignal", MtpViewBase::getViewModel(), MonBinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveOpenCB, "_closeCheckbackSignal", MtpViewBase::getViewModel(), MonBinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveOpenCB, "_valveControl", MtpViewBase::getViewModel(), MonBinVlv::valveControlChanged);

    classConnectUserData(this, setResetCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setResetCB, "_protectionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionEnabledChanged);
    classConnectUserData(this, setResetCB, "_protection", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionChanged);
    classConnectUserData(this, setResetCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setResetCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    _stateOffActive =  MtpViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MtpViewBase::getViewModel().getState().getChannel();
    _stateOperatorActive =  MtpViewBase::getViewModel().getState().getOperatorActive();
    _safetypositionEnabled = MtpViewBase::getViewModel().getSafetyPositionEnabled();
    _safetypositionActive = MtpViewBase::getViewModel().getSafetyPositionActive();

    _staticError =  MtpViewBase::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MtpViewBase::getViewModel().getMonitor().getDynamicError();
    _openCheckbackSignal = MtpViewBase::getViewModel().getOpenCheckbackSignal();
    _closeCheckbackSignal = MtpViewBase::getViewModel().getCloseCheckbackSignal();
    _valveControl = MtpViewBase::getViewModel().getValveControl();
    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();
    _openAutomatic =  MtpViewBase::getViewModel().getOpenAutomatic();
    _closeAutomatic =  MtpViewBase::getViewModel().getCloseAutomatic();
    _monitorEnabled = MtpViewBase::getViewModel().getMonitor().getEnabled();

    _permissionEnabled =  MtpViewBase::getViewModel().getSecurity().getPermissionEnabled();
    _permit =  MtpViewBase::getViewModel().getSecurity().getPermit();
    _interlockEnabled =  MtpViewBase::getViewModel().getSecurity().getInterlockEnabled();
    _interlock =  MtpViewBase::getViewModel().getSecurity().getInterlock();
    _protectionEnabled =  MtpViewBase::getViewModel().getSecurity().getProtectionEnabled();
    _protection =  MtpViewBase::getViewModel().getSecurity().getProtection();

    setValveCB("_openCheckbackSignal", _openCheckbackSignal);
    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setErrorCB("_staticError", _staticError);
    setSafetyPositionActiveCB("_safetypositionActive", _safetypositionActive);
    setAutomaticPreviewLineCB("_stateAutomaticActive", _stateAutomaticActive);
    setSecurityCB("_permissionEnabled", _permissionEnabled);

    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setResetCB("_stateOperatorActive", _stateOperatorActive);
    setValveCloseCB("_stateAutomaticActive", _stateAutomaticActive);
    setValveOpenCB("_stateAutomaticActive", _stateAutomaticActive);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates the off state.
   * @details Calls the setOffOperator method on the view model's state to set the valve to off.
   */
  public void activateStateOff()
  {
    MtpViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  /**
   * @brief Activates operator mode.
   * @details Calls the setOperatorOperator method on the view model's state to enable operator control.
   */
  public void activateStateOperator()
  {
    MtpViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  /**
   * @brief Activates automatic mode.
   * @details Calls the setAutomaticOperator method on the view model's state to enable automatic control.
   */
  public void activateStateAutomatic()
  {
    MtpViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  /**
   * @brief Activates the reset command.
   * @details Calls the setResetOperator method on the view model to reset the valve.
   */
  public void activateReset()
  {
    MtpViewBase::getViewModel().setResetOperator(TRUE);
  }

  /**
   * @brief Activates the valve close command.
   * @details Calls the setCloseOperator method on the view model to close the valve.
   */
  public void activateValveClose()
  {
    MtpViewBase::getViewModel().setCloseOperator(TRUE);
  }

  /**
   * @brief Activates the valve open command.
   * @details Calls the setOpenOperator method on the view model to open the valve.
   */
  public void activateValveOpen()
  {
    MtpViewBase::getViewModel().setOpenOperator(TRUE);
  }

  /**
   * @brief Opens the error information child panel.
   * @details Opens the MonBinVlvFaceplateErrorInformation panel for detailed error information.
   */
  public void openErrorInformation()
  {
    MtpViewBase::openChildPanel("object_parts/MonBinVlv/MonBinVlvFaceplateErrorInformation.xml", "Error Information");
  }

  /**
   * @brief Opens the safety position information child panel.
   * @details Opens the MonBinVlvFaceplateSafetyPositionInformation panel for safety position details.
   */
  public void openSafetyPositionInformation()
  {
    MtpViewBase::openChildPanel("object_parts/MonBinVlv/MonBinVlvFaceplateSafetyPositionInformation.xml", "SafetyPosition Information");
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details Initializes all shapes required for the valve faceplate by extracting them from the provided mapping.
   */
  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectErrorInformation = MtpViewBase::extractShape("_rectErrorInformation");
    _rectLock = MtpViewBase::extractShape("_rectLock");
    _rectMaintenance = MtpViewBase::extractShape("_rectMaintenance");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _rectPermission = MtpViewBase::extractShape("_rectPermission");
    _rectProtection = MtpViewBase::extractShape("_rectProtection");
    _rectReset = MtpViewBase::extractShape("_rectReset");
    _rectSafetyPosition = MtpViewBase::extractShape("_rectSafetyPosition");
    _rectSafetyPositionInformation = MtpViewBase::extractShape("_rectSafetyPositionInformation");
    _rectValve = MtpViewBase::extractShape("_rectValve");
    _rectValveClose = MtpViewBase::extractShape("_rectValveClose");
    _rectValveOpen = MtpViewBase::extractShape("_rectValveOpen");
    _rectValveCloseAut = MtpViewBase::extractShape("_rectValveCloseAut");
    _rectValveOpenAut = MtpViewBase::extractShape("_rectValveOpenAut");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtLock = MtpViewBase::extractShape("_txtLock");
    _txtMaintenance = MtpViewBase::extractShape("_txtMaintenance");
    _txtPermission = MtpViewBase::extractShape("_txtPermission");
    _txtProtection = MtpViewBase::extractShape("_txtProtection");
    _txtSafetyPosition = MtpViewBase::extractShape("_txtSafetyPosition");
  }

  /**
   * @brief Callback function to update the operational station level.
   * @details Updates the operational station level and triggers updates for dependent button states.
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
   * @brief Callback function to update the valve open button state.
   * @details Updates the valve open button appearance based on feedback, control, and operational states.
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

      case "_openCheckbackSignal":
        _openCheckbackSignal = open;
        break;

      case "_closeCheckbackSignal":
        _closeCheckbackSignal = open;
        break;

      case "_valveControl":
        _valveControl = open;
        break;
    }

    if ((_stateAutomaticActive && !_closeCheckbackSignal && _openCheckbackSignal) || (_stateOperatorActive && _openCheckbackSignal && !_closeCheckbackSignal && !_osLevelStation))
    {
      _rectValveOpen.fill = "[pattern,[fit,any,MTP_Icones/ValveOpen1_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_closeCheckbackSignal && _openCheckbackSignal && _osLevelStation)
    {
      _rectValveOpen.fill = "[pattern,[fit,any,MTP_Icones/ValveOpen2_rounded.svg]]";
    }
    else if ((_stateAutomaticActive && _valveControl && !_openCheckbackSignal) || (_stateOperatorActive && _valveControl && !_openCheckbackSignal && !_osLevelStation))
    {
      _rectValveOpen.fill = "[pattern,[fit,any,MTP_Icones/ValveOpen3_rounded.svg]]";
    }
    else if (_stateOperatorActive && _valveControl && !_openCheckbackSignal && _osLevelStation)
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
   * @details Updates the valve close button appearance based on feedback, control, and operational states.
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

      case "_openCheckbackSignal":
        _openCheckbackSignal = close;
        break;

      case "_closeCheckbackSignal":
        _closeCheckbackSignal = close;
        break;

      case "_valveControl":
        _valveControl = close;
        break;
    }

    if ((_stateAutomaticActive && _closeCheckbackSignal && !_openCheckbackSignal) || (_stateOperatorActive && _closeCheckbackSignal && !_openCheckbackSignal && !_osLevelStation))
    {
      _rectValveClose.fill = "[pattern,[fit,any,MTP_Icones/ValveClose1_rounded.svg]]";
    }
    else if (_stateOperatorActive && _closeCheckbackSignal && !_openCheckbackSignal && _osLevelStation)
    {
      _rectValveClose.fill = "[pattern,[fit,any,MTP_Icones/ValveClose2_rounded.svg]]";
    }
    else if ((_stateAutomaticActive && !_valveControl && !_closeCheckbackSignal) || (_stateOperatorActive && !_valveControl && !_closeCheckbackSignal && !_osLevelStation))
    {
      _rectValveClose.fill = "[pattern,[fit,any,MTP_Icones/ValveClose3_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_valveControl && !_closeCheckbackSignal && _osLevelStation)
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
   * @details Updates the reset button appearance based on operator mode, protection, and errors.
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
   * @brief Callback function to update the quality code shape.
   * @details Updates the quality code shape based on the quality good state.
   *
   * @param qualityGoodChanged The new quality good state.
   */
  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  /**
   * @brief Callback function to update the automatic mode button state.
   * @details Updates the automatic mode button appearance based on channel and station level states.
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
     * @details Updates the operator mode button appearance based on channel and station level states.
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
   * @details Updates the off state button appearance based on channel and station level states.
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
   * @details Updates the visibility and appearance of security-related shapes based on permission, interlock, and protection states.
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
   * @details Updates the visibility of open and close automatic mode shapes based on the automatic command states.
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
   * @details Updates the safety position shape and text visibility based on the safety position active and enabled states.
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
   * @details Updates the error shape and related elements based on the monitor and error states.
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
   * @brief Callback function to update the valve status shape.
   * @details Updates the valve status shape based on feedback, control, and error states.
   *
   * @param varName The name of the variable to set.
   * @param valve The new valve state.
   */
  private void setValveCB(const string &varName, const bool &valve)
  {
    switch (varName)
    {
      case "_staticError":
        _staticError = valve;
        break;

      case "_dynamicError":
        _dynamicError = valve;
        break;

      case "_openCheckbackSignal":
        _openCheckbackSignal = valve;
        break;

      case "_closeCheckbackSignal":
        _closeCheckbackSignal = valve;
        break;

      case "_valveControl":
        _valveControl = valve;
        break;
    }

    if (_openCheckbackSignal && _valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvOpen.svg]]";
      _rectValve.visible = TRUE;
      return;
    }
    else if (_closeCheckbackSignal && !_valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvStopped.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (!_openCheckbackSignal && !_closeCheckbackSignal && _valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStarted.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (!_openCheckbackSignal && !_closeCheckbackSignal && !_valveControl && !_dynamicError && !_staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStopped.svg]]";
      _rectValve.visible = TRUE;
    }
    else if ((_openCheckbackSignal && _closeCheckbackSignal) || _dynamicError || _staticError)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvUknownState.svg]]";
      _rectValve.visible = TRUE;
    }
    else
    {
      _rectValve.visible = FALSE;
    }
  }
};
