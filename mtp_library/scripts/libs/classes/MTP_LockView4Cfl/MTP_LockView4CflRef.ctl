// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_LockView4/MTP_LockView4Ref"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_LockView4Cfl/MTP_LockView4Cfl"

/**
 * @class MTP_LockView4CflRef
 * @brief Represents the MTP_LockView4CflRef class.
 */
class MTP_LockView4CflRef : MTP_LockView4Ref
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active..

  /**
     * @brief Constructor for MTP_LockView4CflRef.
     *
     * @param viewModel A shared pointer to the LockView4 view model.
     * @param shapes A mapping of shapes used in the reference.
     */
  public MTP_LockView4CflRef(shared_ptr<MTP_LockView4Cfl> viewModel, const mapping &shapes) : MTP_LockView4Ref(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_LockView4Cfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_LockView4Ref::initializeShapes();
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
      _rectOutput.backCol = "mtpBorder";

      _rectOutput.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;
      _rectOutput.enabled = TRUE;

      setOutputCB(MTP_ViewRef::getViewModel().getOutput());
    }
  }
};
