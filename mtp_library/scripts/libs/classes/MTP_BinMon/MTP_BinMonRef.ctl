// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_BinMon/MTP_BinMon"

/**
 * @class MTP_BinMonRef
 * @brief Represents the MTP_BinMonRef class.
 */
class MTP_BinMonRef : MTP_ViewRef
{
  protected shape _rectValue; //!< Reference to the value rectangle shape.
  protected shape _rectStatus; //!< Reference to the status rectangle shape.

  private bool _flutterActive; //!< Indicates if the flutter is active.

  /**
   * @brief Constructor for MTP_BinMonRef.
   *
   * @param viewModel A shared pointer to the MTP_BinMon view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinMonRef(shared_ptr<MTP_BinMon> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MTP_ViewRef::getViewModel(), MTP_BinMon::valueChanged);
    classConnect(this, setStatusCB, MTP_ViewRef::getViewModel(), MTP_BinMon::flutterActiveChanged);

    setStatusCB(MTP_ViewRef::getViewModel().getFlutterActive());
    setValueCB(MTP_ViewRef::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _rectValue = MTP_ViewRef::extractShape("_rectValue");
    _rectStatus = MTP_ViewRef::extractShape("_rectStatus");
  }

  /**
   * @brief Sets the value for the MTP_BinMon object.
   *
   * @param value The boolean value to be set.
   */
  protected void setValueCB(const bool &value)
  {
    if (value && _rectValue.enabled())
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
    }
  }

  /**
   * @brief Sets the status for the MTP_BinMon object.
   *
   * @param active The boolean value indicating the status.
   */
  protected void setStatusCB(const bool &active)
  {
    if (_rectStatus.enabled())
    {
      _rectStatus.visible = active;
    }
  }
};
