// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_PIDCtrl/MTP_PIDCtrlRef"
#uses "classes/MTP_PIDCtrlCfl/MTP_PIDCtrlCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_PIDCtrlCflRef
 * @brief Represents the MTP_PIDCtrlCflRef class.
 */
class MTP_PIDCtrlCflRef : MTP_PIDCtrlRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_PIDCtrlCflRef.
   *
   * @param viewModel A shared pointer to the PIDCtrl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_PIDCtrlCflRef(shared_ptr<MTP_PIDCtrlCfl> viewModel, const mapping &shapes) : MTP_PIDCtrlRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_PIDCtrlCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
     * @brief Initializes the shapes used in the faceplate.
     */
  protected void initializeShapes() override
  {
    MTP_PIDCtrlRef::initializeShapes();
    _rectDisabled = MTP_ViewRef::extractShape("_rectDisabled");
  }

  /**
  * @brief Sets the enabled state for the reference.
  *
  * @param enabled The bool enabled value to be set.
  */
  private void setEnabledCB(const bool &enabled)
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

      _rectError.enabled = FALSE;
      _rectLimits.enabled = FALSE;
      _rectMode.enabled = FALSE;
      _rectSource.enabled = FALSE;
      _txtUnitPV.enabled = FALSE;
      _txtUnitSP.enabled = FALSE;
      _txtProcessValue.enabled = FALSE;
      _txtSetpoint.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectError.enabled = TRUE;
      _rectLimits.enabled = TRUE;
      _rectMode.enabled = TRUE;
      _rectSource.enabled = TRUE;
      _txtUnitPV.enabled = TRUE;
      _txtUnitSP.enabled = TRUE;
      _txtProcessValue.enabled = TRUE;
      _txtSetpoint.enabled = TRUE;

      setProcessValueCB(MTP_ViewRef::getViewModel().getProcessValue());
      setSetpointCB(MTP_ViewRef::getViewModel().getSetpoint());
      setUnitPV(MTP_ViewRef::getViewModel().getProcessValueUnit());
      setUnitSP(MTP_ViewRef::getViewModel().getSetpointUnit());
      setModeCB("_stateOffActive", _stateOffActive);
      setSourceCB("_sourceManualActive", _sourceManualActive);
    }
  }
};
