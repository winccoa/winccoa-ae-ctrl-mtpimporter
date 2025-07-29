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
  private bool _sourceManualActive; //!< Indicates if the manual source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal source is active.
  private bool _stateOffActive; //!< Indicates if the off state is active.
  private bool _stateOperatorActive; //!< Indicates if the operator state is active.

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

    classConnectUserData(this, setModeCB, "_stateOffActive", MtpViewRef::getViewModel().getState(), MtpState::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MtpViewRef::getViewModel().getState(), MtpState::operatorActiveChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MtpViewRef::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MtpViewRef::getViewModel().getSource(), MtpSource::internalActiveChanged);

    _stateOffActive =  MtpViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive =  MtpViewRef::getViewModel().getState().getOperatorActive();
    _sourceManualActive = MtpViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MtpViewRef::getViewModel().getSource().getInternalActive();

    setProcessValueCB(MtpViewRef::getViewModel().getProcessValue());
    setSetpointCB(MtpViewRef::getViewModel().getSetpoint());

    setUnitPV(MtpViewRef::getViewModel().getProcessValueUnit());
    setUnitSP(MtpViewRef::getViewModel().getSetpointUnit());
    setModeCB("_stateOffActive", _stateOffActive);
    setSourceCB("_sourceManualActive", _sourceManualActive);
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
  }

  /**
   * @brief Sets the unit for the process value.
   *
   * @param unit A shared pointer to the MtpUnit object representing the process value unit.
   */
  private void setUnitPV(shared_ptr<MtpUnit> unit)
  {
    _txtUnitPV.text = unit.toString();
  }

  /**
   * @brief Sets the unit for the setpoint.
   *
   * @param unit A shared pointer to the MtpUnit object representing the setpoint unit.
   */
  private void setUnitSP(shared_ptr<MtpUnit> unit)
  {
    _txtUnitSP.text = unit.toString();
  }

  /**
   * @brief Sets the process value text.
   *
   * @param pv The float process value to be set.
   */
  private void setProcessValueCB(const float &pv)
  {
    _txtProcessValue.text = pv;
  }

  /**
   * @brief Sets the setpoint text.
   *
   * @param sp The float setpoint value to be set.
   */
  private void setSetpointCB(const float &sp)
  {
    _txtSetpoint.text = sp;
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

    if (_stateOffActive)
    {
      _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Power.svg]]";
      _rectMode.visible = TRUE;
      return;
    }
    else if (_stateOperatorActive)
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

    if (_sourceManualActive)
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/Manual__2.svg]]";
      _rectSource.visible = TRUE;
      return;
    }
    else if (_sourceInternalActive)
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
