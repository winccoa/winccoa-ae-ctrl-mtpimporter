// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaMan/MTP_AnaManRef"
#uses "classes/MTP_AnaManCfl/MTP_AnaManCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_AnaManCflRef
 * @brief Represents the MTP_AnaManCflRef class.
 */
class MTP_AnaManCflRef : MTP_AnaManRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_AnaManCflRef.
   *
   * @param viewModel A shared pointer to the MTP_AnaManCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_AnaManCflRef(shared_ptr<MTP_AnaManCfl> viewModel, const mapping &shapes) : MTP_AnaManRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_AnaManCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_AnaManRef::initializeShapes();
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

      _rectLimit.visible = FALSE;
      _txtUnit.text = "undefined";
      _txtValue.text = "0,00";

      _rectLimit.enabled = FALSE;
      _txtUnit.enabled = FALSE;
      _txtValue.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectLimit.enabled = TRUE;
      _txtUnit.enabled = TRUE;
      _txtValue.enabled = TRUE;

      setUnit(MTP_ViewRef::getViewModel().getValueUnit());
      setValueOutCB(MTP_ViewRef::getViewModel().getValueOut());
      setValueMinMaxCB("_valueMin", _valueMin);
    }
  }
};
