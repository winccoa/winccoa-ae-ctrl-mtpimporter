// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_PIDCtrl/MTP_PIDCtrl"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_PIDCtrlFaceplateHome
 * @brief Represents the MTP_PIDCtrlFaceplateHome class.
 */
class MTP_PIDCtrlFaceplateHome : MTP_ViewBase
{
  private shape _rectAutomatic; //!< Reference to the automatic state rectangle shape.
  private shape _rectError; //!< Reference to the error state rectangle shape.
  private shape _rectInternal; //!< Reference to the internal mode rectangle shape.
  private shape _rectManual; //!< Reference to the manual mode rectangle shape.
  private shape _rectOff; //!< Reference to the off state rectangle shape.
  private shape _rectOperator; //!< Reference to the operator state rectangle shape.
  private shape _txtError; //!< Reference to the error text shape.
  private shape _txtMV; //!< Reference to the manipulated value text shape.
  private shape _txtPV; //!< Reference to the process value text shape.
  private shape _txtSP; //!< Reference to the setpoint text shape.
  private shape _txtUnitMV; //!< Reference to the manipulated value unit text shape.
  private shape _txtUnitPV; //!< Reference to the process value unit text shape.
  private shape _txtUnitSP; //!< Reference to the setpoint unit text shape.
  private shape _txtSPInternal; //!< Reference to the internal setpoint text shape.
  private shape _txtSPManual; //!< Reference to the manual setpoint text shape.
  private shape _rectPvViolated; //!< Reference to the process value violation rectangle shape.
  private shape _rectSpViolated; //!< Reference to the setpoint violation rectangle shape.
  private shape _rectMvViolated; //!< Reference to the manipulated value violation rectangle shape.

  private bool _stateAutomaticActive; //!< Indicates if the automatic state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.
  private bool _manualActive; //!< Indicates if manual mode is active.
  private bool _internalActive; //!< Indicates if internal mode is active.
  private bool _channel; //!< Indicates the channel state for source modes.
  private bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateChannel; //!< Indicates the channel state for PID states.
  private bool _osLevelStation; //!< Indicates if the operating system is at station level.

  private float _pv; //!< The current process value.
  private bool _pvLimitViolated; //!< Indicates if the process value violates its limits.
  private float _pvSclMin; //!< The minimum scale value for the process value.
  private float _pvSclMax; //!< The maximum scale value for the process value.

  private float _sp; //!< The current setpoint value.
  private bool _spLimitViolated; //!< Indicates if the setpoint violates its limits.
  private float _spSclMin; //!< The minimum scale value for the setpoint.
  private float _spSclMax; //!< The maximum scale value for the setpoint.

  private float _mv; //!< The current manipulated value.
  private bool _mvLimitViolated; //!< Indicates if the manipulated value violates its limits.
  private float _mvSclMin; //!< The minimum scale value for the manipulated value.
  private float _mvSclMax; //!< The maximum scale value for the manipulated value.

  /**
   * @brief Constructor for MTP_PIDCtrlFaceplateHome.
   *
   * @param viewModel A shared pointer to theMTP_ PIDCtrl view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_PIDCtrlFaceplateHome(shared_ptr<MTP_PIDCtrl> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setProcessValueCB, MTP_ViewBase::getViewModel(), MTP_PIDCtrl::processValueChanged);
    classConnect(this, setSetpointCB, MTP_ViewBase::getViewModel(), MTP_PIDCtrl::setpointChanged);
    classConnect(this, setManipulatedValueCB, MTP_ViewBase::getViewModel(), MTP_PIDCtrl::manipulatedValueChanged);
    classConnect(this, setSetpointInternalCB, MTP_ViewBase::getViewModel(), MTP_PIDCtrl::setpointInternalChanged);
    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    classConnect(this, setSetpointManualCB, MTP_ViewBase::getViewModel(), MTP_PIDCtrl::setpointManualChanged);

    classConnectUserData(this, setProcessValueScaleCB, "min", MTP_ViewBase::getViewModel(), MTP_PIDCtrl::processValueScaleMinChanged);
    classConnectUserData(this, setProcessValueScaleCB, "max", MTP_ViewBase::getViewModel(), MTP_PIDCtrl::processValueScaleMaxChanged);
    classConnectUserData(this, setSetpointValueScaleCB, "min", MTP_ViewBase::getViewModel(), MTP_PIDCtrl::setpointScaleMinChanged);
    classConnectUserData(this, setSetpointValueScaleCB, "max", MTP_ViewBase::getViewModel(), MTP_PIDCtrl::setpointScaleMaxChanged);
    classConnectUserData(this, setManipulatedValueScaleCB, "min", MTP_ViewBase::getViewModel(), MTP_PIDCtrl::manipulatedValueScaleMinChanged);
    classConnectUserData(this, setManipulatedValueScaleCB, "max", MTP_ViewBase::getViewModel(), MTP_PIDCtrl::manipulatedValueScaleMaxChanged);

    classConnectUserData(this, setStateCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setStateCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);

    //Buttons:
    classConnectUserData(this, setManualActiveCB, "_manualActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);
    classConnectUserData(this, setInternalActiveCB, "_internalActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MTP_ViewBase::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MTP_ViewBase::getViewModel().getState(), MTP_State::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MTP_ViewBase::getViewModel().getState(), MTP_State::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MTP_ViewBase::getViewModel().getState(), MTP_State::channelChanged);

    _stateOffActive =  MTP_ViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MTP_ViewBase::getViewModel().getState().getChannel();
    _stateAutomaticActive = MTP_ViewBase::getViewModel().getState().getAutomaticActive();
    _stateOperatorActive = MTP_ViewBase::getViewModel().getState().getOperatorActive();

    _manualActive =  MTP_ViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MTP_ViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MTP_ViewBase::getViewModel().getSource().getChannel();

    _pvSclMin =  MTP_ViewBase::getViewModel().getProcessValueScaleMin();
    _pvSclMax =  MTP_ViewBase::getViewModel().getProcessValueScaleMax();
    _pv = MTP_ViewBase::getViewModel().getProcessValue();

    _spSclMin =  MTP_ViewBase::getViewModel().getSetpointScaleMin();
    _spSclMax =  MTP_ViewBase::getViewModel().getSetpointScaleMax();
    _sp = MTP_ViewBase::getViewModel().getSetpoint();

    _mvSclMin =  MTP_ViewBase::getViewModel().getManipulatedValueScaleMin();
    _mvSclMax =  MTP_ViewBase::getViewModel().getManipulatedValueScaleMax();
    _mv = MTP_ViewBase::getViewModel().getManipulatedValue();

    setUnit(MTP_ViewBase::getViewModel().getProcessValueUnit(), MTP_ViewBase::getViewModel().getSetpointUnit(), MTP_ViewBase::getViewModel().getManipulatedValueUnit());

    setProcessValueCB(MTP_ViewBase::getViewModel().getProcessValue());
    setSetpointCB(MTP_ViewBase::getViewModel().getSetpoint());
    setManipulatedValueCB(MTP_ViewBase::getViewModel().getManipulatedValue());
    setStateCB("_stateAutomaticActive", _stateAutomaticActive);
    setSetpointInternalCB(MTP_ViewBase::getViewModel().getSetpointInternal());
    setSetpointManualCB(MTP_ViewBase::getViewModel().getSetpointManual());
    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());

    setProcessValueScaleCB("min", _pvSclMin);
    setSetpointValueScaleCB("min", _spSclMin);
    setManipulatedValueScaleCB("min", _mvSclMin);
  }

  /**
   * @brief Sets the process value in the view model.
   *
   * @param value The new process value.
   */
  public void setProcessValue(const float &value)
  {
    MTP_ViewBase::getViewModel().setProcessValue(value);
  }

  /**
   * @brief Sets the setpoint value in the view model.
   *
   * @param value The new setpoint value.
   */
  public void setSetpoint(const float &value)
  {
    MTP_ViewBase::getViewModel().setSetpoint(value);
  }

  /**
   * @brief Sets the manipulated value manually in the view model.
   *
   * @param value The new manipulated value.
   */
  public void setManipulatedValue(const float &value)
  {
    MTP_ViewBase::getViewModel().setManipulatedValueManual(value);
  }

  /**
   * @brief Sets the manual setpoint value in the view model.
   *
   * @param setpointManual The new manual setpoint value.
   */
  public void setSetpointManual(const float &setpointManual)
  {
    MTP_ViewBase::getViewModel().setSetpointManual(setpointManual);
  }

  /**
   * @brief Activates manual mode for the PID controller.
   */
  public void activateManual()
  {
    MTP_ViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  /**
   * @brief Activates internal mode for the PID controller.
   */
  public void activateInternal()
  {
    MTP_ViewBase::getViewModel().getSource().setInternalOperator(TRUE);
  }

  /**
   * @brief Activates the off state for the PID controller.
   */
  public void activateStateOff()
  {
    MTP_ViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  /**
   * @brief Activates the operator state for the PID controller.
   */
  public void activateStateOperator()
  {
    MTP_ViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  /**
   * @brief Activates the automatic state for the PID controller.
   */
  public void activateStateAutomatic()
  {
    MTP_ViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _rectAutomatic = MTP_ViewBase::extractShape("_rectAutomatic");
    _rectError = MTP_ViewBase::extractShape("_rectError");
    _rectInternal = MTP_ViewBase::extractShape("_rectInternal");
    _rectManual = MTP_ViewBase::extractShape("_rectManual");
    _rectOff = MTP_ViewBase::extractShape("_rectOff");
    _rectOperator = MTP_ViewBase::extractShape("_rectOperator");
    _txtError = MTP_ViewBase::extractShape("_txtError");
    _txtMV = MTP_ViewBase::extractShape("_txtMV");
    _txtPV = MTP_ViewBase::extractShape("_txtPV");
    _txtSP = MTP_ViewBase::extractShape("_txtSP");
    _txtUnitMV = MTP_ViewBase::extractShape("_txtUnitMV");
    _txtUnitPV = MTP_ViewBase::extractShape("_txtUnitPV");
    _txtUnitSP = MTP_ViewBase::extractShape("_txtUnitSP");
    _txtSPInternal = MTP_ViewBase::extractShape("_txtSPInternal");
    _txtSPManual = MTP_ViewBase::extractShape("_txtSPManual");
    _rectPvViolated = MTP_ViewBase::extractShape("_rectPvViolated");
    _rectSpViolated = MTP_ViewBase::extractShape("_rectSpViolated");
    _rectMvViolated = MTP_ViewBase::extractShape("_rectMvViolated");
  }

  /**
   * @brief Sets the units for process value, setpoint, and manipulated value.
   *
   * @param pvUnit The unit for the process value.
   * @param spUnit The unit for the setpoint.
   * @param mvUnit The unit for the manipulated value.
   */
  private void setUnit(MTP_Unit pvUnit, MTP_Unit spUnit, MTP_Unit mvUnit)
  {
    _txtUnitMV.text = getCatStr("MTP_PIDCtrl", "MV") + " [" + mvUnit.toString() + "]";
    _txtUnitPV.text = getCatStr("MTP_PIDCtrl", "PV") + " [" + pvUnit.toString() + "]";
    _txtUnitSP.text = getCatStr("MTP_PIDCtrl", "SP") + " [" + spUnit.toString() + "]";
  }

  /**
   * @brief Callback function to update the operating system level status.
   *
   * @param oslevel The new operating system level status.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setStateOffActiveCB("", FALSE);
    setOperatorActiveCB("", FALSE);
    setAutomaticActiveCB("", FALSE);
    setInternalActiveCB("", FALSE);
    setManualActiveCB("", FALSE);
  }

  /**
   * @brief Callback function to update the process value.
   *
   * @param value The new process value.
   */
  private void setProcessValueCB(const float &value)
  {
    _pv = value;
    _txtPV.text = value;
    setProcessValueScaleCB("min", _pvSclMin);
  }

  /**
     * @brief Callback function to update the process value scale.
     *
     * @param varName The variable name ("min" or "max") indicating which scale value is updated.
     * @param value The new scale value.
     */
  private void setProcessValueScaleCB(const string &varName, const float &value)
  {
    switch (varName)
    {
      case "min":
        _pvSclMin = value;
        break;

      case "max":
        _pvSclMax = value;
        break;
    }

    if (_pv < _pvSclMin || _pv > _pvSclMax)
    {
      _pvLimitViolated = TRUE;
      _rectPvViolated.visible = TRUE;
      errorShow();
    }
    else
    {
      _pvLimitViolated = FALSE;
      _rectPvViolated.visible = FALSE;
      errorShow();
    }
  }

  /**
   * @brief Updates the error state display.
   */
  private void errorShow()
  {
    if (_pvLimitViolated)
    {
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
    }
    else
    {
      _rectError.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
    }
  }

  /**
   * @brief Callback function to update the setpoint value.
   *
   * @param value The new setpoint value.
   */
  private void setSetpointCB(const float &value)
  {
    _txtSP.text = value;
    _sp = value;
    setSetpointValueScaleCB("min", _spSclMin);
  }

  /**
   * @brief Callback function to update the setpoint scale.
   *
   * @param varName The variable name ("min" or "max") indicating which scale value is updated.
   * @param value The new scale value.
   */
  private void setSetpointValueScaleCB(const string &varName, const float &value)
  {
    switch (varName)
    {
      case "min":
        _spSclMin = value;
        break;

      case "max":
        _spSclMax = value;
        break;
    }

    if (_sp < _spSclMin || _sp > _spSclMax)
    {
      _spLimitViolated = TRUE;
      _rectSpViolated.visible = TRUE;
      errorShow();
    }
    else
    {
      _spLimitViolated = FALSE;
      _rectSpViolated.visible = FALSE;
      errorShow();
    }
  }

  /**
   * @brief Callback function to update the manipulated value.
   *
   * @param value The new manipulated value.
   */
  private void setManipulatedValueCB(const float &value)
  {
    if (_stateAutomaticActive)
    {
      _txtMV.text = value;
    }

    _mv = value;
    setManipulatedValueScaleCB("min", _mvSclMin);
  }

  /**
   * @brief Callback function to update the manipulated value scale.
   *
   * @param varName The variable name ("min" or "max") indicating which scale value is updated.
   * @param value The new scale value.
   */
  private void setManipulatedValueScaleCB(const string &varName, const float &value)
  {
    switch (varName)
    {
      case "min":
        _mvSclMin = value;
        break;

      case "max":
        _mvSclMax = value;
        break;
    }

    if (_mv < _mvSclMin || _mv > _mvSclMax)
    {
      _mvLimitViolated = TRUE;
      _rectMvViolated.visible = TRUE;
      errorShow();
    }
    else
    {
      _mvLimitViolated = FALSE;
      _rectMvViolated.visible = FALSE;
      errorShow();
    }
  }

  /**
   * @brief Callback function to update the internal setpoint value.
   *
   * @param value The new internal setpoint value.
   */
  private void setSetpointInternalCB(const float &value)
  {
    _txtSPInternal.text = value;
  }

  /**
   * @brief Callback function to update the manual setpoint value.
   *
   * @param value The new manual setpoint value.
   */
  private void setSetpointManualCB(const float &value)
  {
    _txtSPManual.text = value;
  }

  /**
   * @brief Callback function to update the automatic state.
   *
   * @param varName The variable name ("_stateAutomaticActive" or "_stateChannel") indicating which state is updated.
   * @param state The new state value.
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
     * @brief Callback function to update the operator state.
     *
     * @param varName The variable name ("_stateOperatorActive" or "_stateChannel") indicating which state is updated.
     * @param state The new state value.
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
   * @brief Callback function to update the off state.
   *
   * @param varName The variable name ("_stateOffActive" or "_stateChannel") indicating which state is updated.
   * @param state The new state value.
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
     * @brief Callback function to update the internal mode.
     *
     * @param varName The variable name ("_internalActive" or "_channel") indicating which state is updated.
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

    if ((_internalActive && _channel) || (!_osLevelStation && !_channel && _internalActive))
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]";
    }
    else if (_internalActive && !_channel && _osLevelStation)
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
   * @brief Callback function to update the manual mode.
   *
   * @param varName The variable name ("_manualActive" or "_channel") indicating which state is updated.
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

    if ((_manualActive && _channel) || (!_osLevelStation && !_channel && _manualActive))
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
      _txtSPManual.editable = FALSE;
    }
    else if (_manualActive && !_channel && _osLevelStation)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
      _txtSPManual.editable = TRUE;
    }
    else
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
      _txtSPManual.editable = FALSE;
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the PID controller state.
   *
   * @param varName The variable name ("_stateAutomaticActive" or "_stateOperatorActive") indicating which state is updated.
   * @param state The new state value.
   */
  private void setStateCB(const string &varName, const bool &state)
  {
    switch (varName)
    {
      case "_stateAutomaticActive":
        _stateAutomaticActive = state;
        break;

      case "_stateOperatorActive":
        _stateOperatorActive = state;
        break;
    }

    if (_stateOperatorActive)
    {
      _txtMV.editable = TRUE;
      _txtMV.text = MTP_ViewBase::getViewModel().getManipulatedValueManual();
    }
    else
    {
      _txtMV.editable = FALSE;
      _txtMV.text = MTP_ViewBase::getViewModel().getManipulatedValue();
    }
  }
};
