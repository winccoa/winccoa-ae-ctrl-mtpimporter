// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Services/MTP_ServicesRef"
#uses "classes/MTP_ServicesCfl/MTP_ServicesCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_ServicesCflRef
 * @brief Represents the MTP_ServicesCflRef class.
 */
class MTP_ServicesCflRef : MTP_ServicesRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_ServicesCflRef.
   *
   * @param viewModel A shared pointer to the MTP_Services view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_ServicesCflRef(shared_ptr<MTP_ServicesCfl> viewModel, const mapping &shapes) : MTP_ServicesRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_ServicesCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_ServicesRef::initializeShapes();
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
      _rectMode.visible = FALSE;
      _rectSource.visible = FALSE;
      _blinkingActive = FALSE;
      _rectCurrentState.fill = "[pattern,[fit,any,MTP_Icones/ProcedureInactive.svg]]";
      _rectCurrentState.visible = TRUE;
      _txtCurrentProcedure.visible = FALSE;

      _rectMode.enabled = FALSE;
      _rectSource.enabled = FALSE;
      _rectCurrentState.enabled = FALSE;
      _txtCurrentProcedure.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;
      _txtCurrentProcedure.visible = TRUE;

      _rectMode.enabled = TRUE;
      _rectSource.enabled = TRUE;
      _txtCurrentProcedure.enabled = TRUE;
      _rectCurrentState.enabled = TRUE;

      setModeCB("_stateOffActive", _stateOffActive);
      setSourceCB("_srcExternalActive", _srcExternalActive);
      setCurrentStateCB(MTP_ViewRef::getViewModel().getCurrentState());
    }
  }
};
