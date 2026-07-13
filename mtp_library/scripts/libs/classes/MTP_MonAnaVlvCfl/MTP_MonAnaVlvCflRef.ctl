// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonAnaVlv/MTP_MonAnaVlvRef"
#uses "classes/MTP_MonAnaVlvCfl/MTP_MonAnaVlvCfl"

/**
 * @class MTP_MonAnaVlvCflRef
 * @brief Represents the MTP_MonAnaVlvCflRef class.
 */
class MTP_MonAnaVlvCflRef : MTP_MonAnaVlvRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_MonAnaVlvCflRef.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaVlvCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_MonAnaVlvCflRef(shared_ptr<MTP_MonAnaVlvCfl> viewModel, const mapping &shapes) : MTP_MonAnaVlvRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_MonAnaVlvCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_MonAnaVlvRef::initializeShapes();
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
      _rectValve.visible = TRUE;

      _rectError.visible = FALSE;
      _rectLocked.visible = FALSE;
      _rectMode.visible = FALSE;
      _rectSource.visible = FALSE;
      _txtUnit.text = "undefined";
      _txtPosition.text = "0,00";
      _txtUnit2.text = "undefined";
      _txtPositionFbk.text = "0,00";
      _rectValve.fill = "[pattern,[fit,any,MTP_Icones/ValvClosed.svg]]";

      _rectError.enabled = FALSE;
      _rectLocked.enabled = FALSE;
      _rectMode.enabled = FALSE;
      _rectSource.enabled = FALSE;
      _txtUnit.enabled = FALSE;
      _txtPosition.enabled = FALSE;
      _txtUnit2.enabled = FALSE;
      _txtPositionFbk.enabled = FALSE;
      _rectValve.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectError.enabled = TRUE;
      _rectLocked.enabled = TRUE;
      _rectMode.enabled = TRUE;
      _rectSource.enabled = TRUE;
      _txtUnit.enabled = TRUE;
      _txtPosition.enabled = TRUE;
      _txtUnit2.enabled = TRUE;
      _txtPositionFbk.enabled = TRUE;
      _rectValve.enabled = TRUE;

      setUnit(MTP_ViewRef::getViewModel().getPositionUnit());
      setErrorCB("_staticError", _staticError);
      setLockedCB("_permit", _permit);
      setModeCB("_stateOffActive", _stateOffActive);
      setSourceCB("_sourceManualActive", _sourceManualActive);
      setValveCB("_openFeedbackSignal", _openFeedbackSignal);
      setPositionFeedbackCB(MTP_ViewRef::getViewModel().getPositionFeedback());
      setPositionCB(MTP_ViewRef::getViewModel().getPosition());
    }
  }
};
