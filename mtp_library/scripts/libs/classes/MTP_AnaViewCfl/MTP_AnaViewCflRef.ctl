// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaView/MTP_AnaViewRef"
#uses "classes/MTP_AnaViewCfl/MTP_AnaViewCfl"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_AnaViewCflRef
 * @brief Represents the MTP_AnaViewCflRef class.
 */
class MTP_AnaViewCflRef : MTP_AnaViewRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for the MTP_AnaViewCflRef object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_AnaViewCflRef object.
   */
  public MTP_AnaViewCflRef(shared_ptr<MTP_AnaViewCfl> viewModel, const mapping &shapes) : MTP_AnaViewRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_AnaViewCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_AnaViewRef::initializeShapes();
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
      _txtValue.text = "0,00";

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
