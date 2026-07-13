// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_BinVlv/MTP_BinVlv"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_BinVlvFaceplateHome
 * @brief Represents the MTP_BinVlvFaceplateHome class.
 */
class MTP_BinVlvFaceplateHome : MTP_ViewBase
{
  private shape _rectAutomatic; //!< Reference to the rectangle shape for automatic mode control.
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
  private shape _txtLock; //!< Reference to the text shape for interlock status label.
  private shape _txtMaintenance; //!< Reference to the text shape for maintenance mode status label.
  private shape _txtPermission; //!< Reference to the text shape for permission status label.
  private shape _txtProtection; //!< Reference to the text shape for protection status label.
  private shape _txtSafetyPosition; //!< Reference to the text shape for safety position status label.

  private bool _openCheckbackSignal; //!< Indicates the open checkback signal state.
  private bool _closeCheckbackSignal; //!< Indicates the close checkback signal state.
  private bool _valveControl; //!< Indicates the valve control state.

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
   * @brief Constructor for MTP_BinVlvFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_BinVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_BinVlvFaceplateHome(shared_ptr<MTP_BinVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setValveCB, "_openCheckbackSignal", MTP_ViewBase::getViewModel(), MTP_BinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_closeCheckbackSignal", MTP_ViewBase::getViewModel(), MTP_BinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveCB, "_valveControl", MTP_ViewBase::getViewModel(), MTP_BinVlv::valveControlChanged);

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    classConnectUserData(this, setSafetyPositionActiveCB, "_safetypositionActive", MTP_ViewBase::getViewModel(), MTP_BinVlv::safetyPositionActiveChanged);
    classConnectUserData(this, setSafetyPositionActiveCB, "_safetypositionEnabled", MTP_ViewBase::getViewModel(), MTP_BinVlv::safetyPositionEnabledChanged);

    classConnectUserData(this, setAutomaticPreviewLineCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_openAutomatic", MTP_ViewBase::getViewModel(), MTP_BinVlv::openAutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_closeAutomatic", MTP_ViewBase::getViewModel(), MTP_BinVlv::closeAutomaticChanged);

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
    classConnectUserData(this, setValveCloseCB, "_openCheckbackSignal", MTP_ViewBase::getViewModel(), MTP_BinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveCloseCB, "_closeCheckbackSignal", MTP_ViewBase::getViewModel(), MTP_BinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveCloseCB, "_valveControl", MTP_ViewBase::getViewModel(), MTP_BinVlv::valveControlChanged);

    classConnectUserData(this, setValveOpenCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setValveOpenCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setValveOpenCB, "_openCheckbackSignal", MTP_ViewBase::getViewModel(), MTP_BinVlv::openCheckbackSignalChanged);
    classConnectUserData(this, setValveOpenCB, "_closeCheckbackSignal", MTP_ViewBase::getViewModel(), MTP_BinVlv::closeCheckbackSignalChanged);
    classConnectUserData(this, setValveOpenCB, "_valveControl", MTP_ViewBase::getViewModel(), MTP_BinVlv::valveControlChanged);

    classConnectUserData(this, setResetCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setResetCB, "_protectionEnabled", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::protectionEnabledChanged);
    classConnectUserData(this, setResetCB, "_protection", MTP_ViewBase::getViewModel().getSecurity(), MTP_Security::protectionChanged);

    _stateOffActive =  MTP_ViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MTP_ViewBase::getViewModel().getState().getChannel();
    _stateOperatorActive =  MTP_ViewBase::getViewModel().getState().getOperatorActive();
    _safetypositionEnabled = MTP_ViewBase::getViewModel().getSafetyPositionEnabled();
    _safetypositionActive = MTP_ViewBase::getViewModel().getSafetyPositionActive();

    _openCheckbackSignal = MTP_ViewBase::getViewModel().getOpenCheckbackSignal();
    _closeCheckbackSignal = MTP_ViewBase::getViewModel().getCloseCheckbackSignal();
    _valveControl = MTP_ViewBase::getViewModel().getValveControl();
    _stateAutomaticActive = MTP_ViewBase::getViewModel().getState().getAutomaticActive();
    _openAutomatic =  MTP_ViewBase::getViewModel().getOpenAutomatic();
    _closeAutomatic =  MTP_ViewBase::getViewModel().getCloseAutomatic();

    _permissionEnabled =  MTP_ViewBase::getViewModel().getSecurity().getPermissionEnabled();
    _permit =  MTP_ViewBase::getViewModel().getSecurity().getPermit();
    _interlockEnabled =  MTP_ViewBase::getViewModel().getSecurity().getInterlockEnabled();
    _interlock =  MTP_ViewBase::getViewModel().getSecurity().getInterlock();
    _protectionEnabled =  MTP_ViewBase::getViewModel().getSecurity().getProtectionEnabled();
    _protection =  MTP_ViewBase::getViewModel().getSecurity().getProtection();

    setValveCB("_openCheckbackSignal", _openCheckbackSignal);
    setSafetyPositionActiveCB("_safetypositionActive", _safetypositionActive);
    setAutomaticPreviewLineCB("_stateAutomaticActive", _stateAutomaticActive);
    setSecurityCB("_permissionEnabled", _permissionEnabled);

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
   * @brief Opens the safety position information child panel.
   */
  public void openSafetyPositionInformation()
  {
    MTP_ViewBase::openChildPanel("objects_parts/faceplates/MTP_BinVlv/BinVlvFaceplateSafetyPositionInformation.pnl", "SafetyPosition Information");
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _rectAutomatic = MTP_ViewBase::extractShape("_rectAutomatic");
    _rectLock = MTP_ViewBase::extractShape("_rectLock");
    _rectMaintenance = MTP_ViewBase::extractShape("_rectMaintenance");
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
    _txtLock = MTP_ViewBase::extractShape("_txtLock");
    _txtMaintenance = MTP_ViewBase::extractShape("_txtMaintenance");
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
    }

    if (_stateOperatorActive && _osLevelStation && (_protectionEnabled && !_protection))
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
   * @brief Callback function to update the valve status shape.
   *
   * @param varName The name of the variable to set.
   * @param valve The new valve state.
   */
  private void setValveCB(const string &varName, const bool &valve)
  {
    switch (varName)
    {
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

    if (_openCheckbackSignal && _valveControl)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvOpen.svg]]";
      _rectValve.visible = TRUE;
      return;
    }
    else if (_closeCheckbackSignal && !_valveControl)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvStopped.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (!_openCheckbackSignal && !_closeCheckbackSignal && _valveControl)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStarted.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (!_openCheckbackSignal && !_closeCheckbackSignal && !_valveControl)
    {
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvMfwdStopped.svg]]";
      _rectValve.visible = TRUE;
    }
    else if (_openCheckbackSignal && _closeCheckbackSignal)
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
