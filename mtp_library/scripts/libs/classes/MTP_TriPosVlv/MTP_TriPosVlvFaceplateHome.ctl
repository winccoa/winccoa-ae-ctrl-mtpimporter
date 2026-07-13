// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_TriPosVlv/MTP_TriPosVlv"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_TriPosVlvFaceplateHome
 * @brief Represents the MTP_TriPosVlvFaceplateHome class.
 */
class MTP_TriPosVlvFaceplateHome : MTP_ViewBase
{
  private shape _rectAutomatic; //!< The rectangle automatic shape.
  private shape _rectConfigurationInformation; //!< The rectangle configuration information shape.
  private shape _rectOff; //!< The rectangle off shape.
  private shape _rectOperator; //!< The rectangle operator shape.
  private shape _rectPermission; //!< The rectangle permission shape.
  private shape _rectInterlock; //!< The rectangle interlock shape.
  private shape _rectProtection; //!< The rectangle protection shape.
  private shape _rectPos1; //!< The rectangle pos1 shape.
  private shape _rectPos2; //!< The rectangle pos2 shape.
  private shape _rectPos3; //!< The rectangle pos3 shape.
  private shape _rectPos1Aut; //!< The rectangle pos1 automatic shape.
  private shape _rectPos2Aut; //!< The rectangle pos2 automatic shape.
  private shape _rectPos3Aut; //!< The rectangle pos3 automatic shape.
  private shape _rectReset; //!< The rectangle reset shape.
  private shape _rectSafePosition; //!< The rectangle safe position shape.
  private shape _rectSafetyPositionInformation; //!< The rectangle safety position information shape.
  private shape _rectValve0; //!< The rectangle valve0 shape.
  private shape _rectValve1; //!< The rectangle valve1 shape.
  private shape _rectValve2; //!< The rectangle valve2 shape.
  private shape _txtPermission; //!< The text permission shape.
  private shape _txtInterlock; //!< The text interlock shape.
  private shape _txtProtection; //!< The text protection shape.
  private shape _txtSafePosition; //!< The text safe position shape.

  private bool _pos1FeedbackSignal; //!< Indicates if the pos1 feedback signal is active.
  private bool _pos2FeedbackSignal; //!< Indicates if the pos2 feedback signal is active.
  private bool _pos3FeedbackSignal; //!< Indicates if the pos3 feedback signal is active.
  private bool _pos1Control; //!< Indicates if the pos1 control is active.
  private bool _pos2Control; //!< Indicates if the pos2 control is active.
  private bool _pos3Control; //!< Indicates if the pos3 control is active.
  private bool _pos1Automatic; //!< Indicates if the pos1 automatic is active.
  private bool _pos2Automatic; //!< Indicates if the pos2 automatic is active.
  private bool _pos3Automatic; //!< Indicates if the pos3 automatic is active.
  private int _pos1Configuration; //!< The pos1 configuration.
  private int _pos2Configuration; //!< The pos2 configuration.
  private int _pos3Configuration; //!< The pos3 configuration.

  private bool _safePositionActive; //!< Indicates if the safe position is active.
  private bool _safePositionEnabled; //!< Indicates if the safe position is enabled.

  private bool _permissionEnabled; //!< Indicates if the permission is enabled.
  private bool _permit; //!< Indicates if the permit is active.
  private bool _interlockEnabled; //!< Indicates if the interlock is enabled.
  private bool _interlock; //!< Indicates if the interlock is active.
  private bool _protectionEnabled; //!< Indicates if the protection is enabled.
  private bool _protection; //!< Indicates if the protection is active.

  private bool _stateOffActive; //!< Indicates if the state off is active.
  private bool _stateChannel; //!< Indicates if the state channel is active.
  private bool _stateOperatorActive; //!< Indicates if the state operator is active.
  private bool _stateAutomaticActive; //!< Indicates if the state automatic is active.
  private bool _osLevelStation; //!< Indicates if the OS level station is active.

  /**
   * @brief Constructor for the MTP_TriPosVlvFaceplateHome object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_TriPosVlvFaceplateHome object.
   */
  public MTP_TriPosVlvFaceplateHome(shared_ptr<MTP_TriPosVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setValveCB, "_pos1FeedbackSignal", getTriPosVlv(), MTP_TriPosVlv::pos1FeedbackSignalChanged);
    classConnectUserData(this, setValveCB, "_pos2FeedbackSignal", getTriPosVlv(), MTP_TriPosVlv::pos2FeedbackSignalChanged);
    classConnectUserData(this, setValveCB, "_pos3FeedbackSignal", getTriPosVlv(), MTP_TriPosVlv::pos3FeedbackSignalChanged);
    classConnectUserData(this, setValveCB, "_pos1Control", getTriPosVlv(), MTP_TriPosVlv::pos1ControlChanged);
    classConnectUserData(this, setValveCB, "_pos2Control", getTriPosVlv(), MTP_TriPosVlv::pos2ControlChanged);
    classConnectUserData(this, setValveCB, "_pos3Control", getTriPosVlv(), MTP_TriPosVlv::pos3ControlChanged);
    classConnectUserData(this, setConfigurationCB, "_pos1Configuration", getTriPosVlv(), MTP_TriPosVlv::pos1ConfigurationChanged);
    classConnectUserData(this, setConfigurationCB, "_pos2Configuration", getTriPosVlv(), MTP_TriPosVlv::pos2ConfigurationChanged);
    classConnectUserData(this, setConfigurationCB, "_pos3Configuration", getTriPosVlv(), MTP_TriPosVlv::pos3ConfigurationChanged);

    classConnectUserData(this, setSafePositionActiveCB, "_safePositionActive", getTriPosVlv(), MTP_TriPosVlv::safePositionActiveChanged);
    classConnectUserData(this, setSafePositionActiveCB, "_safePositionEnabled", getTriPosVlv(), MTP_TriPosVlv::safePositionEnabledChanged);

    classConnectUserData(this, setAutomaticPreviewLineCB, "_stateAutomaticActive", getTriPosVlv().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_pos1Automatic", getTriPosVlv(), MTP_TriPosVlv::pos1AutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_pos2Automatic", getTriPosVlv(), MTP_TriPosVlv::pos2AutomaticChanged);
    classConnectUserData(this, setAutomaticPreviewLineCB, "_pos3Automatic", getTriPosVlv(), MTP_TriPosVlv::pos3AutomaticChanged);

    classConnectUserData(this, setSecurityCB, "_permissionEnabled", getTriPosVlv().getSecurity(), MTP_Security::permissionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_permit", getTriPosVlv().getSecurity(), MTP_Security::permitChanged);
    classConnectUserData(this, setSecurityCB, "_interlockEnabled", getTriPosVlv().getSecurity(), MTP_Security::interlockEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_interlock", getTriPosVlv().getSecurity(), MTP_Security::interlockChanged);
    classConnectUserData(this, setSecurityCB, "_protectionEnabled", getTriPosVlv().getSecurity(), MTP_Security::protectionEnabledChanged);
    classConnectUserData(this, setSecurityCB, "_protection", getTriPosVlv().getSecurity(), MTP_Security::protectionChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", getTriPosVlv().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", getTriPosVlv().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setModeCB, "_stateAutomaticActive", getTriPosVlv().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setModeCB, "_stateChannel", getTriPosVlv().getState(), MTP_State::channelChanged);

    classConnect(this, setOsLevelCB, getTriPosVlv().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    _pos1FeedbackSignal = getTriPosVlv().getPos1FeedbackSignal();
    _pos2FeedbackSignal = getTriPosVlv().getPos2FeedbackSignal();
    _pos3FeedbackSignal = getTriPosVlv().getPos3FeedbackSignal();
    _pos1Control = getTriPosVlv().getPos1Control();
    _pos2Control = getTriPosVlv().getPos2Control();
    _pos3Control = getTriPosVlv().getPos3Control();
    _pos1Automatic = getTriPosVlv().getPos1Automatic();
    _pos2Automatic = getTriPosVlv().getPos2Automatic();
    _pos3Automatic = getTriPosVlv().getPos3Automatic();
    _pos1Configuration = getTriPosVlv().getPos1Configuration();
    _pos2Configuration = getTriPosVlv().getPos2Configuration();
    _pos3Configuration = getTriPosVlv().getPos3Configuration();

    _safePositionActive = getTriPosVlv().getSafePositionActive();
    _safePositionEnabled = getTriPosVlv().getSafePositionEnabled();

    _permissionEnabled = getTriPosVlv().getSecurity().getPermissionEnabled();
    _permit = getTriPosVlv().getSecurity().getPermit();
    _interlockEnabled = getTriPosVlv().getSecurity().getInterlockEnabled();
    _interlock = getTriPosVlv().getSecurity().getInterlock();
    _protectionEnabled = getTriPosVlv().getSecurity().getProtectionEnabled();
    _protection = getTriPosVlv().getSecurity().getProtection();

    _stateOffActive = getTriPosVlv().getState().getOffActive();
    _stateChannel = getTriPosVlv().getState().getChannel();
    _stateOperatorActive = getTriPosVlv().getState().getOperatorActive();
    _stateAutomaticActive = getTriPosVlv().getState().getAutomaticActive();
    _osLevelStation = getTriPosVlv().getOsLevel().getStationLevel();

    setValveCB("_pos1FeedbackSignal", _pos1FeedbackSignal);
    setSafePositionActiveCB("_safePositionActive", _safePositionActive);
    setSecurityCB("_permissionEnabled", _permissionEnabled);
    setModeCB("_stateOffActive", _stateOffActive);
    setAutomaticPreviewLineCB("_stateAutomaticActive", _stateAutomaticActive);
    setOsLevelCB(_osLevelStation);
  }

  /**
   * @brief Executes the activate state off operation.
   */
  public void activateStateOff()
  {
    getTriPosVlv().getState().setOffOperator(TRUE);
  }

  /**
   * @brief Executes the activate state operator operation.
   */
  public void activateStateOperator()
  {
    getTriPosVlv().getState().setOperatorOperator(TRUE);
  }

  /**
   * @brief Executes the activate state automatic operation.
   */
  public void activateStateAutomatic()
  {
    getTriPosVlv().getState().setAutomaticOperator(TRUE);
  }

  /**
   * @brief Executes the activate reset operation.
   */
  public void activateReset()
  {
    getTriPosVlv().setResetOperator(TRUE);
  }

  /**
   * @brief Executes the activate position1 operation.
   */
  public void activatePosition1()
  {
    getTriPosVlv().setPos1Operator(TRUE);
  }

  /**
   * @brief Executes the activate position2 operation.
   */
  public void activatePosition2()
  {
    getTriPosVlv().setPos2Operator(TRUE);
  }

  /**
   * @brief Executes the activate position3 operation.
   */
  public void activatePosition3()
  {
    getTriPosVlv().setPos3Operator(TRUE);
  }

  /**
   * @brief Opens the configuration information.
   */
  public void openConfigurationInformation()
  {
    MTP_ViewBase::openChildPanel("objects_parts/faceplates/MTP_TriPosVlv/main_ConfigurationInformation.pnl", "Configuration Information");
  }

  /**
   * @brief Opens the safety position information.
   */
  public void openSafetyPositionInformation()
  {
    MTP_ViewBase::openChildPanel("objects_parts/faceplates/MTP_TriPosVlv/main_SafetyPositionInformation.pnl", "SafetyPosition Information");
  }

  /**
   * @brief Initializes the MTP_TriPosVlvFaceplateHome object.
   */
  protected void initializeShapes()
  {
    _rectAutomatic = MTP_ViewBase::extractShape("_rectAutomatic");
    _rectConfigurationInformation = MTP_ViewBase::extractShape("_rectConfigurationInformation");
    _rectOff = MTP_ViewBase::extractShape("_rectOff");
    _rectOperator = MTP_ViewBase::extractShape("_rectOperator");
    _rectPermission = MTP_ViewBase::extractShape("_rectPermission");
    _rectInterlock = MTP_ViewBase::extractShape("_rectInterlock");
    _rectProtection = MTP_ViewBase::extractShape("_rectProtection");
    _rectPos1 = MTP_ViewBase::extractShape("_rectPos1");
    _rectPos2 = MTP_ViewBase::extractShape("_rectPos2");
    _rectPos3 = MTP_ViewBase::extractShape("_rectPos3");
    _rectPos1Aut = MTP_ViewBase::extractShape("_rectPos1Aut");
    _rectPos2Aut = MTP_ViewBase::extractShape("_rectPos2Aut");
    _rectPos3Aut = MTP_ViewBase::extractShape("_rectPos3Aut");
    _rectReset = MTP_ViewBase::extractShape("_rectReset");
    _rectSafePosition = MTP_ViewBase::extractShape("_rectSafePosition");
    _rectSafetyPositionInformation = MTP_ViewBase::extractShape("_rectSafetyPositionInformation");
    _rectValve0 = MTP_ViewBase::extractShape("_rectValve0");
    _rectValve1 = MTP_ViewBase::extractShape("_rectValve1");
    _rectValve2 = MTP_ViewBase::extractShape("_rectValve2");
    _txtPermission = MTP_ViewBase::extractShape("_txtPermission");
    _txtInterlock = MTP_ViewBase::extractShape("_txtInterlock");
    _txtProtection = MTP_ViewBase::extractShape("_txtProtection");
    _txtSafePosition = MTP_ViewBase::extractShape("_txtSafePosition");
  }

  /**
   * @brief Retrieves the tri position vlv.
   *
   * @return The tri position vlv.
   */
  private shared_ptr<MTP_TriPosVlv> getTriPosVlv()
  {
    return MTP_ViewBase::getViewModel();
  }

  /**
   * @brief Sets the valve from the connected data point element.
   *
   * @param varName The new var name value.
   * @param value The new value.
   */
  private void setValveCB(const string &varName, const bool &value)
  {
    switch (varName)
    {
      case "_pos1FeedbackSignal": _pos1FeedbackSignal = value; break;
      case "_pos2FeedbackSignal": _pos2FeedbackSignal = value; break;
      case "_pos3FeedbackSignal": _pos3FeedbackSignal = value; break;
      case "_pos1Control": _pos1Control = value; break;
      case "_pos2Control": _pos2Control = value; break;
      case "_pos3Control": _pos3Control = value; break;
    }

    updateValveSymbol();
    updatePositionButtons();
    updateReset();
  }

  /**
   * @brief Sets the configuration from the connected data point element.
   *
   * @param varName The new var name value.
   * @param value The new value.
   */
  private void setConfigurationCB(const string &varName, const int &value)
  {
    switch (varName)
    {
      case "_pos1Configuration": _pos1Configuration = value; break;
      case "_pos2Configuration": _pos2Configuration = value; break;
      case "_pos3Configuration": _pos3Configuration = value; break;
    }

    updateValveSymbol();
    updatePositionButtons();
  }

  /**
   * @brief Sets the safe position active from the connected data point element.
   *
   * @param varName The new var name value.
   * @param value The new value.
   */
  private void setSafePositionActiveCB(const string &varName, const bool &value)
  {
    switch (varName)
    {
      case "_safePositionActive": _safePositionActive = value; break;
      case "_safePositionEnabled": _safePositionEnabled = value; break;
    }

    updateSafePosition();
  }

  /**
   * @brief Sets the automatic preview line from the connected data point element.
   *
   * @param varName The new var name value.
   * @param value The new value.
   */
  private void setAutomaticPreviewLineCB(const string &varName, const bool &value)
  {
    switch (varName)
    {
      case "_stateAutomaticActive": _stateAutomaticActive = value; break;
      case "_pos1Automatic": _pos1Automatic = value; break;
      case "_pos2Automatic": _pos2Automatic = value; break;
      case "_pos3Automatic": _pos3Automatic = value; break;
    }

    updateAutomaticPreview();
  }

  /**
   * @brief Sets the security from the connected data point element.
   *
   * @param varName The new var name value.
   * @param value The new value.
   */
  private void setSecurityCB(const string &varName, const bool &value)
  {
    switch (varName)
    {
      case "_permissionEnabled": _permissionEnabled = value; break;
      case "_permit": _permit = value; break;
      case "_interlockEnabled": _interlockEnabled = value; break;
      case "_interlock": _interlock = value; break;
      case "_protectionEnabled": _protectionEnabled = value; break;
      case "_protection": _protection = value; break;
    }

    updateSecurity();
    updatePositionButtons();
    updateModeButtons();
    updateReset();
  }

  /**
   * @brief Sets the mode from the connected data point element.
   *
   * @param varName The new var name value.
   * @param value The new value.
   */
  private void setModeCB(const string &varName, const bool &value)
  {
    switch (varName)
    {
      case "_stateOffActive": _stateOffActive = value; break;
      case "_stateOperatorActive": _stateOperatorActive = value; break;
      case "_stateAutomaticActive": _stateAutomaticActive = value; break;
      case "_stateChannel": _stateChannel = value; break;
    }

    updateModeButtons();
    updatePositionButtons();
    updateAutomaticPreview();
    updateReset();
  }

  /**
   * @brief Sets the OS level from the connected data point element.
   *
   * @param value The new value.
   */
  private void setOsLevelCB(const bool &value)
  {
    _osLevelStation = value;
    updateModeButtons();
    updatePositionButtons();
    updateReset();
  }

  /**
   * @brief Updates the safe position.
   */
  private void updateSafePosition()
  {
    _rectSafePosition.visible = _safePositionEnabled;
    _txtSafePosition.visible = _safePositionEnabled;
    _rectSafetyPositionInformation.visible = _safePositionEnabled;

    if (!_safePositionEnabled)
    {
      return;
    }

    _rectSafePosition.fill = _safePositionActive ? "[pattern,[fit,any,MTP_Icones/Close.svg]]" : "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
  }

  /**
   * @brief Updates the security.
   */
  private void updateSecurity()
  {
    _rectPermission.visible = _permissionEnabled;
    _txtPermission.visible = _permissionEnabled;
    if (_permissionEnabled)
    {
      _rectPermission.fill = _permit ? "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]" : "[pattern,[fit,any,MTP_Icones/locked_2.svg]]";
      _txtPermission.text = getCatStr("MTP_TriPosVlv", "permit");
    }

    _rectInterlock.visible = _interlockEnabled;
    _txtInterlock.visible = _interlockEnabled;
    if (_interlockEnabled)
    {
      _rectInterlock.fill = _interlock ? "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]" : "[pattern,[fit,any,MTP_Icones/locked_2.svg]]";
      _txtInterlock.text = getCatStr("MTP_TriPosVlv", "interlock");
    }

    _rectProtection.visible = _protectionEnabled;
    _txtProtection.visible = _protectionEnabled;
    if (_protectionEnabled)
    {
      _rectProtection.fill = _protection ? "[pattern,[fit,any,MTP_Icones/unlocked_2.svg]]" : "[pattern,[fit,any,MTP_Icones/locked_2.svg]]";
      _txtProtection.text = getCatStr("MTP_TriPosVlv", "protect");
    }
  }

  /**
   * @brief Updates the mode buttons.
   */
  private void updateModeButtons()
  {
    bool effectiveAutomaticActive = _stateAutomaticActive;
    bool effectiveOperatorActive = _stateOperatorActive && !effectiveAutomaticActive;
    bool effectiveOffActive = _stateOffActive && !effectiveOperatorActive && !effectiveAutomaticActive;

    if ((effectiveOffActive && _stateChannel) || (!_stateChannel && effectiveOffActive && !_osLevelStation))
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]";
    }
    else if (effectiveOffActive && !_stateChannel && _osLevelStation)
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_3_rounded.svg]]";
    }
    else
    {
      _rectOff.fill = "[pattern,[fit,any,MTP_Icones/Power_1_rounded.svg]]";
    }
    _rectOff.transparentForMouse = (_rectOff.fill == "[pattern,[fit,any,MTP_Icones/Power_2_rounded.svg]]");

    if ((effectiveOperatorActive && _stateChannel) || (!_stateChannel && effectiveOperatorActive && !_osLevelStation))
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_1_rounded.svg]]";
    }
    else if (effectiveOperatorActive && !_stateChannel && _osLevelStation)
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_2_rounded.svg]]";
    }
    else
    {
      _rectOperator.fill = "[pattern,[fit,any,MTP_Icones/Operator_3_rounded.svg]]";
    }
    _rectOperator.transparentForMouse = (_rectOperator.fill == "[pattern,[fit,any,MTP_Icones/Operator_1_rounded.svg]]");

    if ((effectiveAutomaticActive && _stateChannel) || (!_stateChannel && effectiveAutomaticActive && !_osLevelStation))
    {
      _rectAutomatic.fill = "[pattern,[fit,any,MTP_Icones/automatic_1_rounded.svg]]";
    }
    else if (effectiveAutomaticActive && !_stateChannel && _osLevelStation)
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
   * @brief Updates the position buttons.
   */
  private void updatePositionButtons()
  {
    _rectPos1.fill = getPositionConfigurationIcon(_pos1Configuration);
    _rectPos2.fill = getPositionConfigurationIcon(_pos2Configuration);
    _rectPos3.fill = getPositionConfigurationIcon(_pos3Configuration);
  }

  /**
   * @brief Returns the position button icon based on configured valve topology.
   *
   * @param configuration Position configuration value [0..7].
   * @return Icon fill string for the position button.
   */
  private string getPositionConfigurationIcon(const int &configuration)
  {
    switch (configuration)
    {
      case 0: return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg0.svg]]";
      case 1: return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg1.svg]]";
      case 2: return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg2.svg]]";
      case 3: return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg3.svg]]";
      case 4: return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg4.svg]]";
      case 5: return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg5.svg]]";
      case 6: return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg6.svg]]";
      case 7: return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg7.svg]]";
    }
    return "[pattern,[fit,any,MTP_Icones/triposvlv-vmap-cfg0.svg]]";
  }

  /**
   * @brief Updates the automatic preview.
   */
  private void updateAutomaticPreview()
  {
    _rectPos1Aut.visible = !_stateAutomaticActive && _pos1Automatic;
    _rectPos2Aut.visible = !_stateAutomaticActive && _pos2Automatic;
    _rectPos3Aut.visible = !_stateAutomaticActive && _pos3Automatic;
  }

  /**
   * @brief Updates the reset.
   */
  private void updateReset()
  {
    bool effectiveOperatorActive = _stateOperatorActive && !_stateAutomaticActive;
    bool resetRequired = effectiveOperatorActive && _osLevelStation && (_protectionEnabled && !_protection);
    _rectReset.fill = resetRequired ? "[pattern,[fit,any,MTP_Icones/reset_2.svg]]" : "[pattern,[fit,any,MTP_Icones/reset_1.svg]]";
    _rectReset.transparentForMouse = (_rectReset.fill == "[pattern,[fit,any,MTP_Icones/reset_1.svg]]");
  }

  /**
   * @brief Updates the valve symbol.
   */
  private void updateValveSymbol()
  {
    int feedbackCount = (_pos1FeedbackSignal ? 1 : 0) + (_pos2FeedbackSignal ? 1 : 0) + (_pos3FeedbackSignal ? 1 : 0);
    int controlCount = (_pos1Control ? 1 : 0) + (_pos2Control ? 1 : 0) + (_pos3Control ? 1 : 0);

    if (feedbackCount > 1 || controlCount > 1)
    {
      _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve0.svg]]";
      _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve1.svg]]";
      _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve2.svg]]";
      return;
    }

    int activePosition = 0;
    int targetPosition = 0;
    int activeConfiguration = 0;
    int targetConfiguration = 0;

    if (_pos1FeedbackSignal)
    {
      activePosition = 1;
      activeConfiguration = _pos1Configuration;
    }
    else if (_pos2FeedbackSignal)
    {
      activePosition = 2;
      activeConfiguration = _pos2Configuration;
    }
    else if (_pos3FeedbackSignal)
    {
      activePosition = 3;
      activeConfiguration = _pos3Configuration;
    }

    if (_pos1Control)
    {
      targetPosition = 1;
      targetConfiguration = _pos1Configuration;
    }
    else if (_pos2Control)
    {
      targetPosition = 2;
      targetConfiguration = _pos2Configuration;
    }
    else if (_pos3Control)
    {
      targetPosition = 3;
      targetConfiguration = _pos3Configuration;
    }

    if (activePosition > 0 && targetPosition > 0 && activePosition != targetPosition)
    {
      if (activeConfiguration < 0 || activeConfiguration > 7 || targetConfiguration < 0 || targetConfiguration > 7)
      {
        _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve0.svg]]";
        _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve1.svg]]";
        _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve2.svg]]";
        return;
      }

      bool activeValve0Open = activeConfiguration >= 4;
      bool activeValve1Open = activeConfiguration == 2 || activeConfiguration == 3 || activeConfiguration == 6 || activeConfiguration == 7;
      bool activeValve2Open = activeConfiguration == 1 || activeConfiguration == 3 || activeConfiguration == 5 || activeConfiguration == 7;
      bool targetValve0Open = targetConfiguration >= 4;
      bool targetValve1Open = targetConfiguration == 2 || targetConfiguration == 3 || targetConfiguration == 6 || targetConfiguration == 7;
      bool targetValve2Open = targetConfiguration == 1 || targetConfiguration == 3 || targetConfiguration == 5 || targetConfiguration == 7;

      if (activeValve0Open && targetValve0Open) _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/opened-valve0.svg]]";
      else if (activeValve0Open && !targetValve0Open) _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/closing-valve0.svg]]";
      else if (!activeValve0Open && targetValve0Open) _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/opening-valve0.svg]]";
      else _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/closed-valve0.svg]]";

      if (activeValve1Open && targetValve1Open) _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/opened-valve1.svg]]";
      else if (activeValve1Open && !targetValve1Open) _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/closing-valve1.svg]]";
      else if (!activeValve1Open && targetValve1Open) _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/opening-valve1.svg]]";
      else _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/closed-valve1.svg]]";

      if (activeValve2Open && targetValve2Open) _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/opened-valve2.svg]]";
      else if (activeValve2Open && !targetValve2Open) _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/closing-valve2.svg]]";
      else if (!activeValve2Open && targetValve2Open) _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/opening-valve2.svg]]";
      else _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/closed-valve2.svg]]";
      return;
    }

    int configuration = 0;
    string openState = "opened";

    if (activePosition > 0)
    {
      configuration = activeConfiguration;
    }
    else if (targetPosition > 0)
    {
      configuration = targetConfiguration;
      openState = "opening";
    }

    if (configuration < 0 || configuration > 7)
    {
      _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve0.svg]]";
      _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve1.svg]]";
      _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/unknown-valve2.svg]]";
      return;
    }

    _rectValve0.fill = configuration >= 4 ? "[pattern,[fit,any,MTP_Icones/" + openState + "-valve0.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve0.svg]]";
    _rectValve1.fill = configuration == 2 || configuration == 3 || configuration == 6 || configuration == 7 ? "[pattern,[fit,any,MTP_Icones/" + openState + "-valve1.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve1.svg]]";
    _rectValve2.fill = configuration == 1 || configuration == 3 || configuration == 5 || configuration == 7 ? "[pattern,[fit,any,MTP_Icones/" + openState + "-valve2.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve2.svg]]";
  }
};
