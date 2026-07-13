// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_PIDCtrl/MTP_PIDCtrl"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_PIDCtrlRef
 * @brief Represents the MTP_PIDCtrlRef class.
 */
class MTP_PIDCtrlRef : MTP_ViewRef
{
  protected shape _rectError; //!< Reference to the error rectangle shape.
  protected shape _rectMode; //!< Reference to the mode rectangle shape.
  protected shape _rectSource; //!< Reference to the source rectangle shape.
  protected shape _rectLimits; //!< Reference to the limits rectangle shape.
  protected shape _txtUnitPV; //!< Reference to the process value unit text shape.
  protected shape _txtUnitSP; //!< Reference to the setpoint unit text shape.
  protected shape _txtProcessValue; //!< Reference to the process value text shape.
  protected shape _txtSetpoint; //!< Reference to the setpoint text shape.
  protected bool _sourceManualActive; //!< Indicates if the manual source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal source is active.
  protected bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.

  /**
   * @brief Constructor for MTP_PIDCtrlRef.
   *
   * @param viewModel A shared pointer to the PIDCtrl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_PIDCtrlRef(shared_ptr<MTP_PIDCtrl> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setProcessValueCB, MTP_ViewRef::getViewModel(), MTP_PIDCtrl::processValueChanged);
    classConnect(this, setSetpointCB, MTP_ViewRef::getViewModel(), MTP_PIDCtrl::setpointChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MTP_ViewRef::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MTP_ViewRef::getViewModel().getState(), MTP_State::operatorActiveChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::internalActiveChanged);

    _stateOffActive =  MTP_ViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MTP_ViewRef::getViewModel().getState().getOperatorActive();
    _sourceManualActive = MTP_ViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MTP_ViewRef::getViewModel().getSource().getInternalActive();

    setProcessValueCB(MTP_ViewRef::getViewModel().getProcessValue());
    setSetpointCB(MTP_ViewRef::getViewModel().getSetpoint());
    setUnitPV(MTP_ViewRef::getViewModel().getProcessValueUnit());
    setUnitSP(MTP_ViewRef::getViewModel().getSetpointUnit());
    setModeCB("_stateOffActive", _stateOffActive);
    setSourceCB("_sourceManualActive", _sourceManualActive);
  }

  /**
     * @brief Initializes the shapes used in the faceplate.
     */
  protected void initializeShapes() override
  {
    _rectError = MTP_ViewRef::extractShape("_rectError");
    _rectLimits = MTP_ViewRef::extractShape("_rectLimits");
    _rectMode = MTP_ViewRef::extractShape("_rectMode");
    _rectSource = MTP_ViewRef::extractShape("_rectSource");
    _txtUnitPV = MTP_ViewRef::extractShape("_txtUnitPV");
    _txtUnitSP = MTP_ViewRef::extractShape("_txtUnitSP");
    _txtProcessValue = MTP_ViewRef::extractShape("_txtProcessValue");
    _txtSetpoint = MTP_ViewRef::extractShape("_txtSetpoint");
  }

  /**
   * @brief Sets the unit for the process value.
   *
   * @param unit A shared pointer to the MTP_Unit object representing the process value unit.
   */
  protected void setUnitPV(shared_ptr<MTP_Unit> unit)
  {
    if (_txtUnitPV.enabled())
    {
      _txtUnitPV.text = unit.toString();
    }
  }

  /**
   * @brief Sets the unit for the setpoint.
   *
   * @param unit A shared pointer to the MTP_Unit object representing the setpoint unit.
   */
  protected void setUnitSP(shared_ptr<MTP_Unit> unit)
  {
    if (_txtUnitSP.enabled())
    {
      _txtUnitSP.text = unit.toString();
    }
  }

  /**
   * @brief Sets the process value text.
   *
   * @param pv The float process value to be set.
   */
  protected void setProcessValueCB(const float &pv)
  {
    if (_txtProcessValue.enabled())
    {
      _txtProcessValue.text = pv;
    }
  }

  /**
   * @brief Sets the setpoint text.
   *
   * @param sp The float setpoint value to be set.
   */
  protected void setSetpointCB(const float &sp)
  {
    if (_txtSetpoint.enabled())
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
  protected void setModeCB(const string &varName, const bool &mode)
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

    if (_stateOffActive && _rectMode.enabled())
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Power.svg]]";
      _rectMode.visible = TRUE;
      return;
    }
    else if (_stateOperatorActive && _rectMode.enabled())
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
  protected void setSourceCB(const string &varName, const bool &source)
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

    if (_sourceManualActive && _rectSource.enabled())
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/Manual__2.svg]]";
      _rectSource.visible = TRUE;
      return;
    }
    else if (_sourceInternalActive && _rectSource.enabled())
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
