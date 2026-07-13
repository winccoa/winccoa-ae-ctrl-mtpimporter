// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonTriPosVlv/MTP_MonTriPosVlvRef"
#uses "classes/MTP_MonTriPosVlvCfl/MTP_MonTriPosVlvCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_MonTriPosVlvCflRef
 * @brief Represents the MTP_MonTriPosVlvCflRef class.
 */
class MTP_MonTriPosVlvCflRef : MTP_MonTriPosVlvRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if the block is enabled.

  /**
   * @brief Constructor for MTP_MonTriPosVlvCflRef.
   *
   * @param viewModel A shared pointer to the MTP_MonTriPosVlvCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_MonTriPosVlvCflRef(shared_ptr<MTP_MonTriPosVlvCfl> viewModel, const mapping &shapes) : MTP_MonTriPosVlvRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_MonTriPosVlvCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the reference.
   */
  protected void initializeShapes() override
  {
    MTP_MonTriPosVlvRef::initializeShapes();
    _rectDisabled = MTP_ViewRef::extractShape("_rectDisabled");
  }

  /**
   * @brief Sets the enabled state for the reference.
   *
   * @param enabled The enabled value to be set.
   */
  private void setEnabledCB(const bool &enabled)
  {
    _enabled = enabled;

    if (!_enabled)
    {
      _rectDisabled.visible = TRUE;

      _rectError.visible = FALSE;
      _rectLocked.visible = FALSE;
      _rectMode.visible = FALSE;

      setClosedDisabledValve();

      _rectError.enabled = FALSE;
      _rectLocked.enabled = FALSE;
      _rectMode.enabled = FALSE;
      _rectValve0.enabled = FALSE;
      _rectValve1.enabled = FALSE;
      _rectValve2.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectError.enabled = TRUE;
      _rectLocked.enabled = TRUE;
      _rectMode.enabled = TRUE;
      _rectValve0.enabled = TRUE;
      _rectValve1.enabled = TRUE;
      _rectValve2.enabled = TRUE;

      setErrorCB("_pos1StaticError", _pos1StaticError);
      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setValveCB("_pos1FeedbackSignal", _pos1FeedbackSignal);
    }
  }

  /**
   * @brief Sets the closed disabled valve.
   */
  private void setClosedDisabledValve()
  {
    _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/closed-valve0.svg]]";
    _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/closed-valve1.svg]]";
    _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/closed-valve2.svg]]";

    _rectValve0.visible = TRUE;
    _rectValve1.visible = TRUE;
    _rectValve2.visible = TRUE;
  }
};
