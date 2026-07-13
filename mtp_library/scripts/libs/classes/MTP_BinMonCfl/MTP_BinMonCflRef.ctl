// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinMon/MTP_BinMonRef"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_BinMonCfl/MTP_BinMonCfl"

/**
 * @class MTP_BinMonCflRef
 * @brief Represents the MTP_BinMonCflRef class.
 */
class MTP_BinMonCflRef : MTP_BinMonRef
{
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for MTP_BinMonCflRef.
   *
   * @param viewModel A shared pointer to the MTP_BinMonCfl view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinMonCflRef(shared_ptr<MTP_BinMonCfl> viewModel, const mapping &shapes) : MTP_BinMonRef(viewModel, shapes)
  {
    classConnect(this, setEnabledCB, MTP_ViewRef::getViewModel(), MTP_BinMonCfl::enabledChanged);
    setEnabledCB(MTP_ViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    MTP_BinMonRef::initializeShapes();
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

      setStatusCB(MTP_ViewRef::getViewModel().getFlutterActive());
      setValueCB(MTP_ViewRef::getViewModel().getValue());
    }
  }
};
