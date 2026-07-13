// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinManCfl/MTP_BinManCfl"
#uses "classes/MTP_BinMan/MTP_BinManRef"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_BinManCflRef
 * @brief Represents the MTP_BinManCflRef class.
 */
class MTP_BinManCflRef : MTP_BinManRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_BinManCflRef.
   *
   * @param viewModel A shared pointer to the BinManCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinManCflRef(shared_ptr<MTP_BinManCfl> viewModel, const mapping &shapes) : MTP_BinManRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_BinManCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_BinManRef::initializeShapes();
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
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _rectValue.enabled = FALSE;
    }
    else
    {
      _rectDisabled.visible = FALSE;
      _rectValue.enabled = TRUE;
      setValueCB(MTP_ViewRef::getViewModel().getValueOut());
    }
  }
};
