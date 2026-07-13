// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_DIntManInt/MTP_DIntManIntRef"
#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_DIntManIntCfl/MTP_DIntManIntCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_DIntManIntCflRef
 * @brief Represents the MTP_DIntManIntCflRef class.
 */
class MTP_DIntManIntCflRef : MTP_DIntManIntRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_MTP_DIntManIntCflRef.
   *
   * @param viewModel A shared pointer to the MTP_DIntManIntCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_DIntManIntCflRef(shared_ptr<MTP_DIntManIntCfl> viewModel, const mapping &shapes) : MTP_DIntManIntRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_DIntManIntCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_DIntManIntRef::initializeShapes();
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
      _rectSource.visible = FALSE;
      _txtUnit.text = "undefined";
      _txtValue.text = "0";

      _rectLimit.enabled = FALSE;
      _rectSource.enabled  = FALSE;
      _txtUnit.enabled = FALSE;
      _txtValue.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectLimit.enabled = TRUE;
      _rectSource.enabled  = TRUE;
      _txtUnit.enabled = TRUE;
      _txtValue.enabled = TRUE;

      setUnit(MTP_ViewRef::getViewModel().getValueUnit());
      setValueOutCB(MTP_ViewRef::getViewModel().getValueOut());
      setSourceCB("_sourceManualActive", _sourceManualActive);
      setValueMinMaxCB("_valueMin", _valueMin);
    }
  }
};
