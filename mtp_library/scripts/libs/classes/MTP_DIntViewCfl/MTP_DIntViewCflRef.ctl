// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_DIntView/MTP_DIntViewRef"
#uses "classes/MTP_DIntViewCfl/MTP_DIntViewCfl"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_DIntViewCflRef
 * @brief Represents the MTP_DIntViewCflRef class.
 */
class MTP_DIntViewCflRef : MTP_DIntViewRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for the MTP_DIntViewCflRef object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_DIntViewCflRef object.
   */
  public MTP_DIntViewCflRef(shared_ptr<MTP_DIntViewCfl> viewModel, const mapping &shapes) : MTP_DIntViewRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_DIntViewCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_DIntViewRef::initializeShapes();
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
      _txtUnit.text = "undefined";
      _txtValue.text = "0";

      _txtUnit.enabled = FALSE;
      _txtValue.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _txtUnit.enabled = TRUE;
      _txtValue.enabled = TRUE;

      setUnit(MTP_ViewRef::getViewModel().getUnit());
      setValueCB(MTP_ViewRef::getViewModel().getValue());
    }
  }
};
