// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_StringView/MTP_StringViewRef"
#uses "classes/MTP_StringViewCfl/MTP_StringViewCfl"

/**
 * @class MTP_StringViewCflRef
 * @brief Represents the MTP_StringViewCflRef class.
 */
class MTP_StringViewCflRef : MTP_StringViewRef
{
  private shape _rectStatus; //!< Reference to the status rectangle shape.
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.

  private bool _enabled; //!< Indicates if enabled is active..

  /**
   * @brief Constructor for MTP_StringViewCflRef.
   *
   * @param viewModel A shared pointer to the MTP_StringViewCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_StringViewCflRef(shared_ptr<MTP_StringViewCfl> viewModel, const mapping &shapes) : MTP_StringViewRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_StringViewCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_StringViewRef::initializeShapes();

    _rectStatus = MTP_ViewRef::extractShape("_rectStatus");
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
      _rectStatus.visible = TRUE;
      _txtText.visible = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;
      _rectStatus.visible = FALSE;
      _txtText.visible = TRUE;
    }
  }
};
