// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_TriPosVlv/MTP_TriPosVlvRef"
#uses "classes/MTP_TriPosVlvCfl/MTP_TriPosVlvCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_TriPosVlvCflRef
 * @brief Represents the MTP_TriPosVlvCflRef class.
 */
class MTP_TriPosVlvCflRef : MTP_TriPosVlvRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if the block is enabled.

  /**
   * @brief Constructor for the MTP_TriPosVlvCflRef object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_TriPosVlvCflRef object.
   */
  public MTP_TriPosVlvCflRef(shared_ptr<MTP_TriPosVlvCfl> viewModel, const mapping &shapes) : MTP_TriPosVlvRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_TriPosVlvCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  protected void initializeShapes() override
  {
    MTP_TriPosVlvRef::initializeShapes();
    _rectDisabled = MTP_ViewRef::extractShape("_rectDisabled");
  }

  /**
   * @brief Sets the enabled from the connected data point element.
   *
   * @param enabled The new enabled value.
   */
  private void setEnabledCB(const bool &enabled)
  {
    _enabled = enabled;

    if (!_enabled)
    {
      _rectDisabled.visible = TRUE;

      _rectLocked.visible = FALSE;
      _rectMode.visible = FALSE;

      setClosedDisabledValve();

      _rectLocked.enabled = FALSE;
      _rectMode.enabled = FALSE;
      _rectValve0.enabled = FALSE;
      _rectValve1.enabled = FALSE;
      _rectValve2.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectLocked.enabled = TRUE;
      _rectMode.enabled = TRUE;
      _rectValve0.enabled = TRUE;
      _rectValve1.enabled = TRUE;
      _rectValve2.enabled = TRUE;

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
