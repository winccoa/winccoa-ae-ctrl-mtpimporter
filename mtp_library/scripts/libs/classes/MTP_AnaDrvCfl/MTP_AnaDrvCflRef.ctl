// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaDrv/MTP_AnaDrvRef"
#uses "classes/MTP_AnaDrvCfl/MTP_AnaDrvCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_AnaDrvCflRef
 * @brief Represents the MTP_AnaDrvCflRef class.
 */
class MTP_AnaDrvCflRef : MTP_AnaDrvRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_AnaDrvCflRef.
   *
   * @param viewModel A shared pointer to the MTP_AnaDrvCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_AnaDrvCflRef(shared_ptr<MTP_AnaDrvCfl> viewModel, const mapping &shapes) : MTP_AnaDrvRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_AnaDrvCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_AnaDrvRef::initializeShapes();
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
      _rectLocked.visible = FALSE;
      _rectMode.visible = FALSE;
      _rectDirection.visible = FALSE;
      _rectSource.visible = FALSE;
      _txtUnit.text = "undefined";
      _txtRpm.text = "0,00";
      _txtUnit2.text = "undefined";
      _txtRpmFbk.text = "0,00";
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorStopped.svg]]";

      _rectError.enabled = FALSE;
      _rectLocked.enabled = FALSE;
      _rectMode.enabled = FALSE;
      _rectDirection.enabled = FALSE;
      _rectSource.enabled = FALSE;
      _txtUnit.enabled = FALSE;
      _txtRpm.enabled = FALSE;
      _txtUnit2.enabled = FALSE;
      _txtRpmFbk.enabled = FALSE;
      _rectMotor.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectError.enabled = TRUE;
      _rectLocked.enabled = TRUE;
      _rectMode.enabled = TRUE;
      _rectDirection.enabled = TRUE;
      _rectSource.enabled = TRUE;
      _txtUnit.enabled = TRUE;
      _txtRpm.enabled = TRUE;
      _txtUnit2.enabled = TRUE;
      _txtRpmFbk.enabled = TRUE;
      _rectMotor.enabled = TRUE;

      setUnit(MTP_ViewRef::getViewModel().getRpmUnit());
      setErrorCB("_driveSafetyIndicator", _driveSafetyIndicator);
      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setSourceCB("_sourceManualActive", _sourceManualActive);
      setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
      setDirectionCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
      setRpmFeedbackSignalCB(MTP_ViewRef::getViewModel().getRpmFeedbackSignal());
      setRpmCB(MTP_ViewRef::getViewModel().getRpm());
    }
  }
};
