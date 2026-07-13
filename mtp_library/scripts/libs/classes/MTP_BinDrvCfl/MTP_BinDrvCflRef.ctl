// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinDrv/MTP_BinDrvRef"
#uses "classes/MTP_BinDrvCfl/MTP_BinDrvCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_BinDrvCflRef
 * @brief Represents the MTP_BinDrvCflRef class.
 */
class MTP_BinDrvCflRef : MTP_BinDrvRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_BinDrvCflRef.
   *
   * @param viewModel A shared pointer to the MTP_BinDrvCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinDrvCflRef(shared_ptr<MTP_BinDrvCfl> viewModel, const mapping &shapes) : MTP_BinDrvRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_BinDrvCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_BinDrvRef::initializeShapes();
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

      setErrorCB("_driveSafetyIndicator", _driveSafetyIndicator);
      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
      setDirectionCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
    }
  }
};
