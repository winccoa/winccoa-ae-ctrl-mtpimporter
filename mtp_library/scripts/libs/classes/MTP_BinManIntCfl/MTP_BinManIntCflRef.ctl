// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinManIntCfl/MTP_BinManIntCfl"
#uses "classes/MTP_BinManInt/MTP_BinManIntRef"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_BinManInt/MTP_BinManInt"

/**
 * @class MTP_BinManIntCflRef
 * @brief Represents the MTP_BinManIntCflRef class.
 */
class MTP_BinManIntCflRef : MTP_BinManIntRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_BinManIntCflRef.
   *
   * @param viewModel A shared pointer to the BinManInt view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinManIntCflRef(shared_ptr<MTP_BinManIntCfl> viewModel, const mapping &shapes) : MTP_BinManIntRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_BinManIntCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_BinManIntRef::initializeShapes();
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
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";

      _rectStatus.enabled = FALSE;
      _rectValue.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;

      _rectStatus.enabled = TRUE;
      _rectValue.enabled = TRUE;

      setValueCB(MTP_ViewRef::getViewModel().getValueOut());
      setStatusCB("_manualActive", MTP_ViewRef::getViewModel().getSource().getManualActive());
      setStatusCB("_internalActive", MTP_ViewRef::getViewModel().getSource().getInternalActive());
    }
  }
};
