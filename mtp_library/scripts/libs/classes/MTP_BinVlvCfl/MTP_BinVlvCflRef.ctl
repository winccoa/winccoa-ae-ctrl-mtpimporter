// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinVlv/MTP_BinVlvRef"
#uses "classes/MTP_BinVlvCfl/MTP_BinVlvCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_BinVlvCflRef
 * @brief Represents the MTP_BinVlvCflRef class.
 */
class MTP_BinVlvCflRef : MTP_BinVlvRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_BinVlvCflRef.
   *
   * @param viewModel A shared pointer to the MTP_BinVlv view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinVlvCflRef(shared_ptr<MTP_BinVlvCfl> viewModel, const mapping &shapes) : MTP_BinVlvRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_BinVlvCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_BinVlvRef::initializeShapes();
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

      _rectLocked.visible = FALSE;
      _rectMode.visible = FALSE;
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvClosed.svg]]";

      _rectLocked.enabled = FALSE;
      _rectMode.enabled = FALSE;
      _rectValve.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectLocked.enabled = TRUE;
      _rectMode.enabled = TRUE;
      _rectValve.enabled = TRUE;

      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setValveCB("_openCheckbackSignal", _openCheckbackSignal);
    }
  }
};
