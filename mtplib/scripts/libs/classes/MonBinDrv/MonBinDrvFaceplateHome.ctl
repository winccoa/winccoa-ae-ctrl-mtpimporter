// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSecurity/MtpSecurity"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MonBinDrvFaceplateHome
 * @brief Represents the primary faceplate for MonBinDrv objects, providing control and monitoring of binary drive states, security, and error conditions.
 */
class MonBinDrvFaceplateHome : MtpViewBase
{
  private shape _refWqc; //!< Reference to the shape for displaying quality code status.
  private shape _rectAutomatic; //!< Reference to the rectangle shape for automatic mode control.
  private shape _rectError; //!< Reference to the rectangle shape for error indication.
  private shape _rectErrorInformation; //!< Reference to the rectangle shape for opening error information panel.
  private shape _rectForward; //!< Reference to the rectangle shape for forward control.
  private shape _rectForwardAut; //!< Reference to the rectangle shape for forward automatic mode indication.
  private shape _rectLock; //!< Reference to the rectangle shape for interlock status.
  private shape _rectMotor; //!< Reference to the rectangle shape for motor status.
  private shape _rectMotorProtection; //!< Reference to the rectangle shape for motor protection status.
  private shape _rectOff; //!< Reference to the rectangle shape for off state control.
  private shape _rectOperator; //!< Reference to the rectangle shape for operator mode control.
  private shape _rectPermission; //!< Reference to the rectangle shape for permission status.
  private shape _rectProtection; //!< Reference to the rectangle shape for protection status.
  private shape _rectReset; //!< Reference to the rectangle shape for reset control.
  private shape _rectReverse; //!< Reference to the rectangle shape for reverse control.
  private shape _rectReverseAut; //!< Reference to the rectangle shape for reverse automatic mode indication.
  private shape _rectSafetyPosition; //!< Reference to the rectangle shape for safety position status.
  private shape _rectSafetyPositionInformation; //!< Reference to the rectangle shape for opening safety position information panel.
  private shape _rectStop; //!< Reference to the rectangle shape for stop control.
  private shape _rectStopAut; //!< Reference to the rectangle shape for stop automatic mode indication.
  private shape _txtError; //!< Reference to the text shape for error status label.
  private shape _txtLock; //!< Reference to the text shape for interlock status label.
  private shape _txtMotorProtection; //!< Reference to the text shape for motor protection status label.
  private shape _txtPermission; //!< Reference to the text shape for permission status label.
  private shape _txtProtection; //!< Reference to the text shape for protection status label.
  private shape _txtSafetyPosition; //!< Reference to the text shape for safety position status label.

  private bool _forwardFeedbackSignal; //!< Indicates the forward feedback signal state.
  private bool _reverseFeedbackSignal; //!< Indicates the reverse feedback signal state.
  private bool _forwardControl; //!< Indicates the forward control state.
  private bool _reverseControl; //!< Indicates the reverse control state.
  private bool _staticError; //!< Indicates if a static error is present.
  private bool _dynamicError; //!< Indicates if a dynamic error is present.
  private bool _monitorEnabled; //!< Indicates if monitoring is enabled.
  private bool _stateAutomaticActive; //!< Indicates if automatic mode is active.
  private bool _forwardAutomatic; //!< Indicates if forward automatic command is active.
  private bool _stopAutomatic; //!< Indicates if stop automatic command is active.
  private bool _reverseAutomatic; //!< Indicates if reverse automatic command is active.
  private bool _permissionEnabled; //!< Indicates if permission is enabled.
  private bool _permit; //!< Indicates the permission state.
  private bool _interlockEnabled; //!< Indicates if interlock is enabled.
  private bool _interlock; //!< Indicates the interlock state.
  private bool _protectionEnabled; //!< Indicates if protection is enabled.
  private bool _protection; //!< Indicates the protection state.
  private bool _stateOffActive; //!< Indicates if off state is active.
  private bool _stateChannel; //!< Indicates the channel state.
  private bool _stateOperatorActive; //!< Indicates if operator mode is active.
  private bool _driveSafetyIndicator; //!< Indicates the drive safety indicator state.
  private bool _osLevelStation; //!< Indicates the operational station level.

  /**
   * @brief Constructor for MonBinDrvFaceplateHome.
   *
   * @param viewModel A shared pointer to the MonBinDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonBinDrvFaceplateHome(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setMotorCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_forwardControl", MtpViewBase::getViewModel(), MonBinDrv::forwardControlChanged);
    classConnectUserData(this, setMotorCB, "_reverseControl", MtpViewBase::getViewModel(), MonBinDrv::reverseControlChanged);
    classConnectUserData(this, setMotorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setMotorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    classConnectUserData(this, setErrorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setErrorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    classConnectUserData(this, setAutomaticPreviewLineCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_forwardAutomatic", MtpViewBase::getViewModel(), MonBinDrv::forwardAutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_stopAutomatic", MtpViewBase::getViewModel(), MonBinDrv::stopAutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_reverseAutomatic", MtpViewBase::getViewModel(), MonBinDrv::reverseAutomaticChanged);

    classConnectUserData(this, setSecurityCB, "_permissionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permissionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_permit", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::permitChanged);
    classConnectUserData(this, setSecurityCB, "_interlockEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_interlock", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::interlockChanged);
    classConnectUserData(this, setSecurityCB, "_protectionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_protection", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionChanged);

    classConnect(this, setMotorProtectionCB, MtpViewBase::getViewModel(), MonBinDrv::driveSafetyIndicatorChanged);
    classConnect(this, setSafetyPositionActiveCB, MtpViewBase::getViewModel(), MonBinDrv::safetyPositionActiveChanged);

    //Buttons:
    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MtpViewBase::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setResetCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setResetCB, "_protectionEnabled", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionEnabledChanged);
    classConnectUserData(this, setResetCB, "_protection", MtpViewBase::getViewModel().getSecurity(), MtpSecurity::protectionChanged);
    classConnectUserData(this, setResetCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setResetCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);
    classConnectUserData(this, setResetCB, "_driveSafetyIndicator",  MtpViewBase::getViewModel(), MonBinDrv::driveSafetyIndicatorChanged);

    classConnectUserData(this, setReverseCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setReverseCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setReverseCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setReverseCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setReverseCB, "_reverseControl", MtpViewBase::getViewModel(), MonBinDrv::reverseControlChanged);

    classConnectUserData(this, setStopCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setStopCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setStopCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setStopCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setStopCB, "_reverseControl", MtpViewBase::getViewModel(), MonBinDrv::reverseControlChanged);
    classConnectUserData(this, setStopCB, "_forwardControl", MtpViewBase::getViewModel(), MonBinDrv::forwardControlChanged);

    classConnectUserData(this, setForwardCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setForwardCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setForwardCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setForwardCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setForwardCB, "_forwardControl", MtpViewBase::getViewModel(), MonBinDrv::forwardControlChanged);

    _stateOffActive =  MtpViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MtpViewBase::getViewModel().getState().getChannel();
    _stateOperatorActive =  MtpViewBase::getViewModel().getState().getOperatorActive();
    _driveSafetyIndicator =  MtpViewBase::getViewModel().getDriveSafetyIndicator();

    _staticError =  MtpViewBase::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MtpViewBase::getViewModel().getMonitor().getDynamicError();
    _forwardFeedbackSignal =  MtpViewBase::getViewModel().getForwardFeedbackSignal();
    _reverseFeedbackSignal =  MtpViewBase::getViewModel().getReverseFeedbackSignal();
    _forwardControl =  MtpViewBase::getViewModel().getForwardControl();
    _reverseControl =  MtpViewBase::getViewModel().getReverseControl();
    _monitorEnabled = MtpViewBase::getViewModel().getMonitor().getEnabled();
    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();
    _forwardAutomatic =  MtpViewBase::getViewModel().getForwardAutomatic();
    _stopAutomatic =  MtpViewBase::getViewModel().getStopAutomatic();
    _reverseAutomatic =  MtpViewBase::getViewModel().getReverseAutomatic();

    _permissionEnabled =  MtpViewBase::getViewModel().getSecurity().getPermissionEnabled();
    _permit =  MtpViewBase::getViewModel().getSecurity().getPermit();
    _interlockEnabled =  MtpViewBase::getViewModel().getSecurity().getInterlockEnabled();
    _interlock =  MtpViewBase::getViewModel().getSecurity().getInterlock();
    _protectionEnabled =  MtpViewBase::getViewModel().getSecurity().getProtectionEnabled();
    _protection =  MtpViewBase::getViewModel().getSecurity().getProtection();

    setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setErrorCB("_staticError", _staticError);
    setMotorProtectionCB(MtpViewBase::getViewModel().getDriveSafetyIndicator());
    setAutomaticPreviewLineCB("_stateAutomaticActive", _stateAutomaticActive);
    setSafetyPositionActiveCB(MtpViewBase::getViewModel().getSafetyPositionActive());
    setSecurityCB("_permissionEnabled", _permissionEnabled);

    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setResetCB("_stateOperatorActive", _stateOperatorActive);
    setReverseCB("_stateOperatorActive", _stateOperatorActive);
    setStopCB("_stateOperatorActive", _stateOperatorActive);
    setForwardCB("_stateOperatorActive", _stateOperatorActive);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates the off state.
   * @details Calls the setOffOperator method on the view model's state.
   */
  public void activateStateOff()
  {
    MtpViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  /**
   * @brief Activates operator mode.
   * @details Calls the setOperatorOperator method on the view model's state.
   */
  public void activateStateOperator()
  {
    MtpViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  /**
   * @brief Activates automatic mode.
   * @details Calls the setAutomaticOperator method on the view model's state.
   */
  public void activateStateAutomatic()
  {
    MtpViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  /**
   * @brief Activates the reset command.
   * @details Calls the setResetOperator method on the view model.
   */
  public void activateReset()
  {
    MtpViewBase::getViewModel().setResetOperator(TRUE);
  }

  /**
   * @brief Activates the reverse command.
   * @details Calls the setReverseOperator method on the view model.
   */
  public void activateReverse()
  {
    MtpViewBase::getViewModel().setReverseOperator(TRUE);
  }

  /**
   * @brief Activates the stop command.
   * @details Calls the setStopOperator method on the view model.
   */
  public void activateStop()
  {
    MtpViewBase::getViewModel().setStopOperator(TRUE);
  }

  /**
   * @brief Activates the forward command.
   * @details Calls the setForwardOperator method on the view model.
   */
  public void activateForward()
  {
    MtpViewBase::getViewModel().setForwardOperator(TRUE);
  }

  /**
   * @brief Opens the error information child panel.
   * @details Opens the MonBinDrvFaceplateErrorInformation panel.
   */
  public void openErrorInformation()
  {
    MtpViewBase::openChildPanel("object_parts/MonBinDrv/MonBinDrvFaceplateErrorInformation.xml", "Error Information");
  }

  /**
   * @brief Opens the safety position information child panel.
   * @details Opens the MonBinDrvFaceplateSafetyPositionInformation panel.
   */
  public void openSafetyPositionInformation()
  {
    MtpViewBase::openChildPanel("object_parts/MonBinDrv/MonBinDrvFaceplateSafetyPositionInformation.xml", "SafetyPosition Information");
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the required shapes.
   */
  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectErrorInformation = MtpViewBase::extractShape("_rectErrorInformation");
    _rectForward = MtpViewBase::extractShape("_rectForward");
    _rectForwardAut = MtpViewBase::extractShape("_rectForwardAut");
    _rectLock = MtpViewBase::extractShape("_rectLock");
    _rectMotor = MtpViewBase::extractShape("_rectMotor");
    _rectMotorProtection = MtpViewBase::extractShape("_rectMotorProtection");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _rectPermission = MtpViewBase::extractShape("_rectPermission");
    _rectProtection = MtpViewBase::extractShape("_rectProtection");
    _rectReset = MtpViewBase::extractShape("_rectReset");
    _rectReverse = MtpViewBase::extractShape("_rectReverse");
    _rectReverseAut = MtpViewBase::extractShape("_rectReverseAut");
    _rectSafetyPosition = MtpViewBase::extractShape("_rectSafetyPosition");
    _rectSafetyPositionInformation = MtpViewBase::extractShape("_rectSafetyPositionInformation");
    _rectStop = MtpViewBase::extractShape("_rectStop");
    _rectStopAut = MtpViewBase::extractShape("_rectStopAut");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtLock = MtpViewBase::extractShape("_txtLock");
    _txtMotorProtection = MtpViewBase::extractShape("_txtMotorProtection");
    _txtPermission = MtpViewBase::extractShape("_txtPermission");
    _txtProtection = MtpViewBase::extractShape("_txtProtection");
    _txtSafetyPosition = MtpViewBase::extractShape("_txtSafetyPosition");
  }

  /**
   * @brief Callback function to update the operational station level and reset button states.
   *
   * @param oslevel The new operational station level state.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setStateOffActiveCB("", FALSE);
    setOperatorActiveCB("", FALSE);
    setAutomaticActiveCB("", FALSE);
    setReverseCB("", FALSE);
    setStopCB("", FALSE);
    setForwardCB("", FALSE);
    setResetCB("", FALSE);
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

      case "_driveSafetyIndicator":
        _driveSafetyIndicator = reset;
        break;
    }

    if (_stateOperatorActive && _osLevelStation && ((_protectionEnabled && !_protection) || _staticError || _dynamicError || !_driveSafetyIndicator))
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
   * @brief Callback function to update security-related shapes (permission, interlock, protection).
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
   * @brief Callback function to update the motor protection shape.
   *
   * @param driveSafetyIndicator The new drive safety indicator state.
   */
  private void setMotorProtectionCB(const bool &_driveSafetyIndicator)
  {
    if (_driveSafetyIndicator)
    {
      _rectMotorProtection.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectMotorProtection.sizeAsDyn = makeDynInt(30, 25);
    }
    else
    {
      _rectMotorProtection.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectMotorProtection.sizeAsDyn = makeDynInt(30, 25);
    }
  }

  /**
   * @brief Callback function to update the safety position shape.
   *
   * @param safetyPositionActive The new safety position active state.
   */
  private void setSafetyPositionActiveCB(const bool &safetypositionActive)
  {
    if (safetypositionActive)
    {
      _rectSafetyPosition.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
      _rectSafetyPosition.sizeAsDyn = makeDynInt(25, 25);
    }
    else
    {
      _rectSafetyPosition.fill = "[pattern,[fit,any,MTP_Icones/GreyOk.svg]]";
      _rectSafetyPosition.sizeAsDyn = makeDynInt(30, 25);
    }
  }

  /**
   * @brief Callback function to update the quality code shape.
   *
   * @param qualityGoodChanged The new quality good state.
   */
  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
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

      case "_forwardAutomatic":
        _forwardAutomatic = state;
        break;

      case "_stopAutomatic":
        _stopAutomatic = state;
        break;

      case "_reverseAutomatic":
        _reverseAutomatic = state;
        break;
    }

    if (!_stateAutomaticActive && _forwardAutomatic)
    {
      _rectForwardAut.visible = TRUE;
      _rectStopAut.visible = FALSE;
      _rectReverseAut.visible = FALSE;
    }
    else if (!_stateAutomaticActive && _stopAutomatic)
    {
      _rectForwardAut.visible = FALSE;
      _rectStopAut.visible = TRUE;
      _rectReverseAut.visible = FALSE;
    }
    else if (!_stateAutomaticActive && _reverseAutomatic)
    {
      _rectForwardAut.visible = FALSE;
      _rectStopAut.visible = FALSE;
      _rectReverseAut.visible = TRUE;
    }
    else
    {
      _rectForwardAut.visible = FALSE;
      _rectStopAut.visible = FALSE;
      _rectReverseAut.visible = FALSE;
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
   * @brief Callback function to update the motor status shape.
   *
   * @param varName The name of the variable to set.
   * @param motor The new motor state.
   */
  private void setMotorCB(const string &varName, const bool &motor)
  {
    switch (varName)
    {
      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = motor;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = motor;
        break;

      case "_forwardControl":
        _forwardControl = motor;
        break;

      case "_reverseControl":
        _reverseControl = motor;
        break;

      case "_staticError":
        _staticError = motor;
        break;

      case "_dynamicError":
        _dynamicError = motor;
        break;
    }

    if (((_forwardFeedbackSignal && _forwardControl) || (_reverseFeedbackSignal && _reverseControl)) && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorRun.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if (!_forwardFeedbackSignal && !_forwardControl && !_reverseFeedbackSignal && !_reverseControl && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorStopped.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if (((_forwardFeedbackSignal && !_reverseFeedbackSignal) || (!_forwardFeedbackSignal && _reverseFeedbackSignal)) && !_forwardControl && !_reverseControl && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorMfwdStopped.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if (((_forwardControl && !_reverseControl) || (!_forwardControl && _reverseControl)) && !_forwardFeedbackSignal && !_reverseFeedbackSignal && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorMfwdStarted.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if ((_forwardFeedbackSignal && _reverseFeedbackSignal) || _dynamicError || _staticError)
    {
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorUnknown.svg]]";
      _rectMotor.visible = TRUE;
    }
    else
    {
      _rectMotor.visible = FALSE;
    }
  }

  /**
   * @brief Callback function to update the reverse button state.
   *
   * @param varName The name of the variable to set.
   * @param state The new reverse state.
   */
  private void setReverseCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = state;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = state;
        break;

      case "_reverseControl":
        _reverseControl = state;
        break;
    }

    if ((_stateAutomaticActive && _reverseFeedbackSignal && !_forwardFeedbackSignal) || (_stateOperatorActive && _reverseFeedbackSignal && !_forwardFeedbackSignal && !_osLevelStation))
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_1_rounded.svg]]";
    }
    else if (_stateOperatorActive && _reverseFeedbackSignal && !_forwardFeedbackSignal && _osLevelStation)
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_2_rounded.svg]]";
    }
    else if ((_stateAutomaticActive && _reverseControl && !_reverseFeedbackSignal) || (_stateOperatorActive && _reverseControl && !_reverseFeedbackSignal && !_osLevelStation))
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_3_rounded.svg]]";
    }
    else if (_stateOperatorActive && _reverseControl && !_reverseFeedbackSignal && _osLevelStation)
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_4_rounded.svg]]";
    }
    else
    {
      _rectReverse.fill = "[pattern,[fit,any,MTP_Icones/revers_5_rounded.svg]]";
    }

    _rectReverse.transparentForMouse = (_rectReverse.fill == "[pattern,[fit,any,MTP_Icones/revers_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the stop button state.
   *
   * @param varName The name of the variable to set.
   * @param state The new stop state.
   */
  private void setStopCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = state;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = state;
        break;

      case "_reverseControl":
        _reverseControl = state;
        break;

      case "_forwardControl":
        _forwardControl = state;
        break;
    }

    if ((_stateAutomaticActive && !_reverseFeedbackSignal && !_forwardFeedbackSignal) || (_stateOperatorActive && !_reverseFeedbackSignal && !_forwardFeedbackSignal && !_osLevelStation))
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_1_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_reverseFeedbackSignal && !_forwardFeedbackSignal && _osLevelStation)
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_2_rounded.svg]]";
    }
    else if ((_stateAutomaticActive && !_reverseControl && !_forwardControl) || (_stateOperatorActive && !_reverseControl && !_forwardControl && !_osLevelStation))
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_3_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_reverseControl && !_forwardControl && _osLevelStation)
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_4_rounded.svg]]";
    }
    else
    {
      _rectStop.fill = "[pattern,[fit,any,MTP_Icones/stop_5_rounded.svg]]";
    }

    _rectStop.transparentForMouse = (_rectStop.fill == "[pattern,[fit,any,MTP_Icones/stop_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the forward button state.
   *
   * @param varName The name of the variable to set.
   * @param state The new forward state.
   */
  private void setForwardCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;

      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = state;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = state;
        break;

      case "_forwardControl":
        _forwardControl = state;
        break;
    }

    if ((_stateAutomaticActive && !_reverseFeedbackSignal && _forwardFeedbackSignal) || (_stateOperatorActive && _forwardFeedbackSignal && !_osLevelStation))
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_1_rounded.svg]]";
    }
    else if (_stateOperatorActive && !_reverseFeedbackSignal && _forwardFeedbackSignal && _osLevelStation)
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_2_rounded.svg]]";
    }
    else if ((_stateAutomaticActive && _forwardControl && !_forwardFeedbackSignal) || (_stateOperatorActive && _forwardControl && !_forwardFeedbackSignal && !_osLevelStation))
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_3_rounded.svg]]";
    }
    else if (_stateOperatorActive && _forwardControl && !_forwardFeedbackSignal && _osLevelStation)
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_4_rounded.svg]]";
    }
    else
    {
      _rectForward.fill = "[pattern,[fit,any,MTP_Icones/forward_5_rounded.svg]]";
    }

    _rectForward.transparentForMouse = (_rectForward.fill == "[pattern,[fit,any,MTP_Icones/forward_1_rounded.svg]]");
  }
};
