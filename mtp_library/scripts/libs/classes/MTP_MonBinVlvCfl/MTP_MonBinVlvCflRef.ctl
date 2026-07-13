// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonBinVlv/MTP_MonBinVlvRef"
#uses "classes/MTP_MonBinVlvCfl/MTP_MonBinVlvCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_MonBinVlvCflRef
 * @brief Represents the MTP_MonBinVlvCflRef class.
 */
class MTP_MonBinVlvCflRef : MTP_MonBinVlvRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_MonBinVlvCflRef.
   *
   * @param viewModel A shared pointer to the MTP_MonBinVlv view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_MonBinVlvCflRef(shared_ptr<MTP_MonBinVlvCfl> viewModel, const mapping &shapes) : MTP_MonBinVlvRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_MonBinVlvCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_MonBinVlvRef::initializeShapes();
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
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvClosed.svg]]";

      _rectError.enabled = FALSE;
      _rectLocked.enabled = FALSE;
      _rectMode.enabled = FALSE;
      _rectValve.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectError.enabled = TRUE;
      _rectLocked.enabled = TRUE;
      _rectMode.enabled = TRUE;
      _rectValve.enabled = TRUE;

      setErrorCB("_staticError", _staticError);
      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setValveCB("_openCheckbackSignal", _openCheckbackSignal);
    }
  }
};
