// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaManInt/MTP_AnaManIntRef"
#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_AnaManIntCfl/MTP_AnaManIntCfl"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_AnaManIntCflRef
 * @brief Represents the MTP_AnaManIntCflRef class.
 */
class MTP_AnaManIntCflRef : MTP_AnaManIntRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_MTP_AnaManIntCflRef.
   *
   * @param viewModel A shared pointer to the MTP_AnaManInt view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_AnaManIntCflRef(shared_ptr<MTP_AnaManIntCfl> viewModel, const mapping &shapes) : MTP_AnaManIntRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_AnaManIntCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    MTP_AnaManIntRef::initializeShapes();
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
      _txtValue.text = "0,00";

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
