// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_AnaMon/MTP_AnaMonRef"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_ValueLimit/MTP_ValueLimitFloat"
#uses "classes/MTP_AnaMonCfl/MTP_AnaMonCfl"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_AnaMonCflRef
 * @brief Represents the MTP_AnaMonCflRef class.
 */
class MTP_AnaMonCflRef : MTP_AnaMonRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for the MTP_AnaMonCflRef object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_AnaMonCflRef object.
   */
  public MTP_AnaMonCflRef(shared_ptr<MTP_AnaMonCfl> viewModel, const mapping &shapes) : MTP_AnaMonRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_AnaMonCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_AnaMonRef::initializeShapes();
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
      _rectStatus.visible = FALSE;
      _txtUnit.text = "undefined";
      _txtValue.text = "0,00";

      _rectStatus.enabled = FALSE;
      _txtUnit.enabled = FALSE;
      _txtValue.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectStatus.enabled = TRUE;
      _txtUnit.enabled = TRUE;
      _txtValue.enabled = TRUE;

      setStatusCB("_alertLowActive", MTP_ViewRef::getViewModel().getAlertLowLimit().getActive());
      setUnit(MTP_ViewRef::getViewModel().getUnit());
      setValueCB(MTP_ViewRef::getViewModel().getValue());
    }
  }
};
