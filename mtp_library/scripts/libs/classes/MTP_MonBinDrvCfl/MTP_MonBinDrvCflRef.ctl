// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonBinDrv/MTP_MonBinDrvRef"
#uses "classes/MTP_MonBinDrvCfl/MTP_MonBinDrvCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_MonBinDrvCflRef
 * @brief Represents the MTP_MonBinDrvCflRef class.
 */
class MTP_MonBinDrvCflRef : MTP_MonBinDrvRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_MonBinDrvCflRef.
   *
   * @param viewModel A shared pointer to the MTP_MonBinDrvCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_MonBinDrvCflRef(shared_ptr<MTP_MonBinDrvCfl> viewModel, const mapping &shapes) : MTP_MonBinDrvRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_MonBinDrvCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_MonBinDrvRef::initializeShapes();
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
      _rectMotor.fill = "[pattern,[fit,any,MTP_Icones/MotorStopped.svg]]";

      _rectError.enabled = FALSE;
      _rectLocked.enabled = FALSE;
      _rectMode.enabled = FALSE;
      _rectDirection.enabled = FALSE;
      _rectMotor.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectError.enabled = TRUE;
      _rectLocked.enabled = TRUE;
      _rectMode.enabled = TRUE;
      _rectDirection.enabled = TRUE;
      _rectMotor.enabled = TRUE;

      setErrorCB("_staticError", _staticError);
      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
      setDirectionCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
    }
  }
};
