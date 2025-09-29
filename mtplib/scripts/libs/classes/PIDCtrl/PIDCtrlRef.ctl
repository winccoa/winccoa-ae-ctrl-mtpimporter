// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/PIDCtrl/PIDCtrl"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class PIDCtrlRef
 * @brief Represents the reference implementation for the PIDCtrl objects.
 */
class PIDCtrlRef : MtpViewRef
{
  private shape _rectError; //!< Reference to the error rectangle shape.
  private shape _rectMode; //!< Reference to the mode rectangle shape.
  private shape _rectSource; //!< Reference to the source rectangle shape.
  private shape _rectLimits; //!< Reference to the limits rectangle shape.
  private shape _txtUnitPV; //!< Reference to the process value unit text shape.
  private shape _txtUnitSP; //!< Reference to the setpoint unit text shape.
  private shape _txtProcessValue; //!< Reference to the process value text shape.
  private shape _txtSetpoint; //!< Reference to the setpoint text shape.
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _sourceManualActive; //!< Indicates if the manual source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal source is active.
  private bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for PIDCtrlRef.
   *
   * @param viewModel A shared pointer to the PIDCtrl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public PIDCtrlRef(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setProcessValueCB, MtpViewRef::getViewModel(), PIDCtrl::processValueChanged);
    classConnect(this, setSetpointCB, MtpViewRef::getViewModel(), PIDCtrl::setpointChanged);
    classConnect(this, setEnabledCB, MtpViewRef::getViewModel(), PIDCtrl::enabledChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MtpViewRef::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MtpViewRef::getViewModel().getState(), MtpState::operatorActiveChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MtpViewRef::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MtpViewRef::getViewModel().getSource(), MtpSource::internalActiveChanged);

    _stateOffActive =  MtpViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MtpViewRef::getViewModel().getState().getOperatorActive();
    _sourceManualActive = MtpViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MtpViewRef::getViewModel().getSource().getInternalActive();

    setEnabledCB(MtpViewRef::getViewModel().getEnabled());
  }

  /**
     * @brief Initializes the shapes used in the faceplate.
     * @details This method overrides the base class method to extract the shapes.
     */
  protected void initializeShapes() override
  {
    _rectError = MtpViewRef::extractShape("_rectError");
    _rectLimits = MtpViewRef::extractShape("_rectLimits");
    _rectMode = MtpViewRef::extractShape("_rectMode");
    _rectSource = MtpViewRef::extractShape("_rectSource");
    _txtUnitPV = MtpViewRef::extractShape("_txtUnitPV");
    _txtUnitSP = MtpViewRef::extractShape("_txtUnitSP");
    _txtProcessValue = MtpViewRef::extractShape("_txtProcessValue");
    _txtSetpoint = MtpViewRef::extractShape("_txtSetpoint");
    _rectDisabled = MtpViewRef::extractShape("_rectDisabled");
  }

  /**
  * @brief Sets the enabled state for the reference.
  *
  * @param enabled The bool enabled value to be set.
  */
  private void setEnabledCB(const long &enabled)
  {
    _enabled = enabled;

    if (!enabled)
    {
      _rectDisabled.visible = TRUE;

      _rectError.visible = FALSE;
      _rectLimits.visible = FALSE;
      _rectMode.visible = FALSE;
      _rectSource.visible = FALSE;
      _txtUnitPV.text = "undefined";
      _txtUnitSP.text = "undefined";
      _txtProcessValue.text = "0,00";
      _txtSetpoint.text = "0,00";
    }
    else
    {
      _rectDisabled.visible = FALSE;

      setProcessValueCB(MtpViewRef::getViewModel().getProcessValue());
      setSetpointCB(MtpViewRef::getViewModel().getSetpoint());
      setUnitPV(MtpViewRef::getViewModel().getProcessValueUnit());
      setUnitSP(MtpViewRef::getViewModel().getSetpointUnit());
      setModeCB("_stateOffActive", _stateOffActive);
      setSourceCB("_sourceManualActive", _sourceManualActive);
    }
  }

  /**
   * @brief Sets the unit for the process value.
   *
   * @param unit A shared pointer to the MtpUnit object representing the process value unit.
   */
  private void setUnitPV(shared_ptr<MtpUnit> unit)
  {
    if (_enabled)
    {
      _txtUnitPV.text = unit.toString();
    }
  }

  /**
   * @brief Sets the unit for the setpoint.
   *
   * @param unit A shared pointer to the MtpUnit object representing the setpoint unit.
   */
  private void setUnitSP(shared_ptr<MtpUnit> unit)
  {
    if (_enabled)
    {
      _txtUnitSP.text = unit.toString();
    }
  }

  /**
   * @brief Sets the process value text.
   *
   * @param pv The float process value to be set.
   */
  private void setProcessValueCB(const float &pv)
  {
    if (_enabled)
    {
      _txtProcessValue.text = pv;
    }
  }

  /**
   * @brief Sets the setpoint text.
   *
   * @param sp The float setpoint value to be set.
   */
  private void setSetpointCB(const float &sp)
  {
    if (_enabled)
    {
      _txtSetpoint.text = sp;

    }
  }

  /**
   * @brief Sets the mode status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param mode The mode state to be set.
   */
  private void setModeCB(const string &varName, const bool &mode)
  {
    switch (varName)
    {
      case "_stateOffActive":
        _stateOffActive = mode;
        break;

      case "_stateOperatorActive":
        _stateOperatorActive = mode;
        break;
    }

    if (_stateOffActive && _enabled)
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Power.svg]]";
      _rectMode.visible = TRUE;
      return;
    }
    else if (_stateOperatorActive && _enabled)
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Manual_1.svg]]";
      _rectMode.visible = TRUE;
    }
    else
    {
      _rectMode.visible = FALSE;
    }
  }

  /**
   * @brief Sets the source status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param source The source state to be set.
   */
  private void setSourceCB(const string &varName, const bool &source)
  {
    switch (varName)
    {
      case "_sourceManualActive":
        _sourceManualActive = source;
        break;

      case "_sourceInternalActive":
        _sourceInternalActive = source;
        break;
    }

    if (_sourceManualActive && _enabled)
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/Manual__2.svg]]";
      _rectSource.visible = TRUE;
      return;
    }
    else if (_sourceInternalActive && _enabled)
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/internal.svg]]";
      _rectSource.visible = TRUE;
    }
    else
    {
      _rectSource.visible = FALSE;
    }
  }
};
