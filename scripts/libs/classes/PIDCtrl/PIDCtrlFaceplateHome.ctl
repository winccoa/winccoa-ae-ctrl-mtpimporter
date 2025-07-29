// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpState/MtpState"
#uses "classes/PIDCtrl/PIDCtrl"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class PIDCtrlFaceplateHome
 * @brief Represents the home faceplate for PIDCtrl objects.
 */
class PIDCtrlFaceplateHome : MtpViewBase
{
  private shape _refWqc; //!< Reference to the quality code shape.
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
   * @brief Constructor for PIDCtrlFaceplateHome.
   * @details Initializes the faceplate by connecting callbacks to view model events and setting initial values for states, values, and units.
   *
   * @param viewModel A shared pointer to the PIDCtrl view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public PIDCtrlFaceplateHome(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setProcessValueCB, MtpViewBase::getViewModel(), PIDCtrl::processValueChanged);
    classConnect(this, setSetpointCB, MtpViewBase::getViewModel(), PIDCtrl::setpointChanged);
    classConnect(this, setManipulatedValueCB, MtpViewBase::getViewModel(), PIDCtrl::manipulatedValueChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setSetpointInternalCB, MtpViewBase::getViewModel(), PIDCtrl::setpointInternalChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    classConnect(this, setSetpointManualCB, MtpViewBase::getViewModel(), PIDCtrl::setpointManualChanged);

    classConnectUserData(this, setProcessValueScaleCB, "min", MtpViewBase::getViewModel(), PIDCtrl::processValueScaleMinChanged);
    classConnectUserData(this, setProcessValueScaleCB, "max", MtpViewBase::getViewModel(), PIDCtrl::processValueScaleMaxChanged);
    classConnectUserData(this, setSetpointValueScaleCB, "min", MtpViewBase::getViewModel(), PIDCtrl::setpointScaleMinChanged);
    classConnectUserData(this, setSetpointValueScaleCB, "max", MtpViewBase::getViewModel(), PIDCtrl::setpointScaleMaxChanged);
    classConnectUserData(this, setManipulatedValueScaleCB, "min", MtpViewBase::getViewModel(), PIDCtrl::manipulatedValueScaleMinChanged);
    classConnectUserData(this, setManipulatedValueScaleCB, "max", MtpViewBase::getViewModel(), PIDCtrl::manipulatedValueScaleMaxChanged);

    classConnectUserData(this, setStateCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setStateCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);

    //Buttons:
    classConnectUserData(this, setManualActiveCB, "_manualActive", MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);
    classConnectUserData(this, setInternalActiveCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setStateOffActiveCB, "_stateOffActive", MtpViewBase::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setStateOffActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setOperatorActiveCB, "_stateOperatorActive", MtpViewBase::getViewModel().getState(), MtpState::operatorActiveChanged);
    classConnectUserData(this, setOperatorActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    classConnectUserData(this, setAutomaticActiveCB, "_stateAutomaticActive", MtpViewBase::getViewModel().getState(), MtpState::automaticActiveChanged);
    classConnectUserData(this, setAutomaticActiveCB, "_stateChannel", MtpViewBase::getViewModel().getState(), MtpState::channelChanged);

    _stateOffActive =  MtpViewBase::getViewModel().getState().getOffActive();
    _stateChannel =  MtpViewBase::getViewModel().getState().getChannel();
    _stateAutomaticActive = MtpViewBase::getViewModel().getState().getAutomaticActive();
    _stateOperatorActive = MtpViewBase::getViewModel().getState().getOperatorActive();

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();

    _pvSclMin =  MtpViewBase::getViewModel().getProcessValueScaleMin();
    _pvSclMax =  MtpViewBase::getViewModel().getProcessValueScaleMax();
    _pv = MtpViewBase::getViewModel().getProcessValue();

    _spSclMin =  MtpViewBase::getViewModel().getSetpointScaleMin();
    _spSclMax =  MtpViewBase::getViewModel().getSetpointScaleMax();
    _sp = MtpViewBase::getViewModel().getSetpoint();

    _mvSclMin =  MtpViewBase::getViewModel().getManipulatedValueScaleMin();
    _mvSclMax =  MtpViewBase::getViewModel().getManipulatedValueScaleMax();
    _mv = MtpViewBase::getViewModel().getManipulatedValue();

    setUnit(MtpViewBase::getViewModel().getProcessValueUnit(), MtpViewBase::getViewModel().getSetpointUnit(), MtpViewBase::getViewModel().getManipulatedValueUnit());

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setProcessValueCB(MtpViewBase::getViewModel().getProcessValue());
    setSetpointCB(MtpViewBase::getViewModel().getSetpoint());
    setManipulatedValueCB(MtpViewBase::getViewModel().getManipulatedValue());
    setStateCB("_stateAutomaticActive", _stateAutomaticActive);
    setSetpointInternalCB(MtpViewBase::getViewModel().getSetpointInternal());
    setSetpointManualCB(MtpViewBase::getViewModel().getSetpointManual());
    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setStateOffActiveCB("_stateOffActive", _stateOffActive);
    setOperatorActiveCB("_stateOperatorActive", _stateOperatorActive);
    setAutomaticActiveCB("_stateAutomaticActive", _stateAutomaticActive);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());

    setProcessValueScaleCB("min", _pvSclMin);
    setSetpointValueScaleCB("min", _spSclMin);
    setManipulatedValueScaleCB("min", _mvSclMin);
  }

  /**
   * @brief Sets the process value in the view model.
   * @details Updates the process value in the PID controller view model.
   *
   * @param value The new process value.
   */
  public void setProcessValue(const float &value)
  {
    MtpViewBase::getViewModel().setProcessValue(value);
  }

  /**
   * @brief Sets the setpoint value in the view model.
   * @details Updates the setpoint value in the PID controller view model.
   *
   * @param value The new setpoint value.
   */
  public void setSetpoint(const float &value)
  {
    MtpViewBase::getViewModel().setSetpoint(value);
  }

  /**
   * @brief Sets the manipulated value manually in the view model.
   * @details Updates the manipulated value in the PID controller view model for manual mode.
   *
   * @param value The new manipulated value.
   */
  public void setManipulatedValue(const float &value)
  {
    MtpViewBase::getViewModel().setManipulatedValueManual(value);
  }

  /**
   * @brief Sets the manual setpoint value in the view model.
   * @details Updates the manual setpoint value in the PID controller view model.
   *
   * @param setpointManual The new manual setpoint value.
   */
  public void setSetpointManual(const float &setpointManual)
  {
    MtpViewBase::getViewModel().setSetpointManual(setpointManual);
  }

  /**
   * @brief Activates manual mode for the PID controller.
   * @details Sets the manual operator mode to active in the view model's source.
   */
  public void activateManual()
  {
    MtpViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  /**
   * @brief Activates internal mode for the PID controller.
   * @details Sets the internal operator mode to active in the view model's source.
   */
  public void activateInternal()
  {
    MtpViewBase::getViewModel().getSource().setInternalOperator(TRUE);
  }

  /**
   * @brief Activates the off state for the PID controller.
   * @details Sets the off operator state to active in the view model's state.
   */
  public void activateStateOff()
  {
    MtpViewBase::getViewModel().getState().setOffOperator(TRUE);
  }

  /**
   * @brief Activates the operator state for the PID controller.
   * @details Sets the operator state to active in the view model's state.
   */
  public void activateStateOperator()
  {
    MtpViewBase::getViewModel().getState().setOperatorOperator(TRUE);
  }

  /**
   * @brief Activates the automatic state for the PID controller.
   * @details Sets the automatic operator state to active in the view model's state.
   */
  public void activateStateAutomatic()
  {
    MtpViewBase::getViewModel().getState().setAutomaticOperator(TRUE);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details Overrides the base class method to extract shapes for the PID controller faceplate.
   */
  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtMV = MtpViewBase::extractShape("_txtMV");
    _txtPV = MtpViewBase::extractShape("_txtPV");
    _txtSP = MtpViewBase::extractShape("_txtSP");
    _txtUnitMV = MtpViewBase::extractShape("_txtUnitMV");
    _txtUnitPV = MtpViewBase::extractShape("_txtUnitPV");
    _txtUnitSP = MtpViewBase::extractShape("_txtUnitSP");
    _txtSPInternal = MtpViewBase::extractShape("_txtSPInternal");
    _txtSPManual = MtpViewBase::extractShape("_txtSPManual");
    _rectPvViolated = MtpViewBase::extractShape("_rectPvViolated");
    _rectSpViolated = MtpViewBase::extractShape("_rectSpViolated");
    _rectMvViolated = MtpViewBase::extractShape("_rectMvViolated");
  }

  /**
   * @brief Sets the units for process value, setpoint, and manipulated value.
   * @details Updates the text shapes for unit display with formatted unit strings.
   *
   * @param pvUnit The unit for the process value.
   * @param spUnit The unit for the setpoint.
   * @param mvUnit The unit for the manipulated value.
   */
  private void setUnit(MtpUnit pvUnit, MtpUnit spUnit, MtpUnit mvUnit)
  {
    _txtUnitMV.text = getCatStr("PIDCtrl", "MV") + " [" + mvUnit.toString() + "]";
    _txtUnitPV.text = getCatStr("PIDCtrl", "PV") + " [" + pvUnit.toString() + "]";
    _txtUnitSP.text = getCatStr("PIDCtrl", "SP") + " [" + spUnit.toString() + "]";
  }

  /**
   * @brief Callback function to update the operating system level status.
   * @details Updates the station level status and triggers state callbacks to refresh the UI.
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
   * @brief Callback function to update the quality code status.
   * @details Updates the quality code shape based on the quality good status change.
   *
   * @param qualityGoodChanged Indicates if the quality good status has changed.
   */
  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  /**
   * @brief Callback function to update the process value.
   * @details Updates the process value text shape and triggers scale checking.
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
     * @details Updates the process value scale and checks for limit violations, updating the UI accordingly.
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
   * @details Sets the error rectangle fill based on whether the process value violates its limits.
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
   * @details Updates the setpoint text shape and triggers scale checking.
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
   * @details Updates the setpoint scale and checks for limit violations, updating the UI accordingly.
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
   * @details Updates the manipulated value text shape in automatic mode and triggers scale checking.
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
   * @details Updates the manipulated value scale and checks for limit violations, updating the UI accordingly.
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
   * @details Updates the internal setpoint text shape with the new value.
   *
   * @param value The new internal setpoint value.
   */
  private void setSetpointInternalCB(const float &value)
  {
    _txtSPInternal.text = value;
  }

  /**
   * @brief Callback function to update the manual setpoint value.
   * @details Updates the manual setpoint text shape with the new value.
   *
   * @param value The new manual setpoint value.
   */
  private void setSetpointManualCB(const float &value)
  {
    _txtSPManual.text = value;
  }

  /**
   * @brief Callback function to update the automatic state.
   * @details Updates the automatic state and channel, adjusting the automatic rectangle's appearance and mouse interaction.
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
     * @details Updates the operator state and channel, adjusting the operator rectangle's appearance and mouse interaction.
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
   * @details Updates the off state and channel, adjusting the off rectangle's appearance and mouse interaction.
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
     * @details Updates the internal mode and channel, adjusting the internal rectangle's appearance and mouse interaction.
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
   * @details Updates the manual mode and channel, adjusting the manual rectangle's appearance and mouse interaction.
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
    }
    else if (_manualActive && !_channel && _osLevelStation)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the PID controller state.
   * @details Updates the automatic or operator state and adjusts the manipulated value text shape's editability and value.
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
      _txtMV.text = MtpViewBase::getViewModel().getManipulatedValueManual();
    }
    else
    {
      _txtMV.editable = FALSE;
      _txtMV.text = MtpViewBase::getViewModel().getManipulatedValue();
    }
  }
};
