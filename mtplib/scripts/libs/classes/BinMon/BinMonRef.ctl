// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/BinMon/BinMon"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class BinMonRef
 * @brief Represents the reference for the BinMon objects.
 */
class BinMonRef : MtpViewRef
{
  private shape _rectValue; //!< Reference to the value rectangle shape.
  private shape _rectStatus; //!< Reference to the status rectangle shape.
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.

  private bool _flutterActive; //!< Indicates if the flutter is active.
  private bool _enabled; //!< Indicates if enabled is active.

  /**
   * @brief Constructor for BinMonRef.
   *
   * @param viewModel A shared pointer to the BinMon view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public BinMonRef(shared_ptr<BinMon> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MtpViewRef::getViewModel(), BinMon::valueChanged);
    classConnect(this, setStatusCB, MtpViewRef::getViewModel(), BinMon::flutterActiveChanged);
    classConnect(this, setEnabledCB, MtpViewRef::getViewModel(), BinMon::enabledChanged);

    setEnabledCB(MtpViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the shapes.
   */
  protected void initializeShapes() override
  {
    _rectValue = MtpViewRef::extractShape("_rectValue");
    _rectStatus = MtpViewRef::extractShape("_rectStatus");
    _rectDisabled = MtpViewRef::extractShape("_rectDisabled");
  }

  /**
  * @brief Sets the enabled state for the reference.
  *
  * @param enabled The bool enabled value to be set.
  */
  private void setEnabledCB(const long &enabled)
  {
    _enabled = enabled;

    if (!enabled)
    {
      _rectDisabled.visible = TRUE;

      _rectStatus.visible = FALSE;
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
    }
    else
    {
      _rectDisabled.visible = FALSE;

      setStatusCB(MtpViewRef::getViewModel().getFlutterActive());
      setValueCB(MtpViewRef::getViewModel().getValue());
    }
  }

  /**
   * @brief Sets the value for the BinMon object.
   *
   * @param value The boolean value to be set.
   */
  private void setValueCB(const bool &value)
  {
    if (value && _enabled)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
    }
  }

  /**
   * @brief Sets the status for the BinMon object.
   *
   * @param active The boolean value indicating the status.
   */
  private void setStatusCB(const bool &active)
  {
    if (_enabled)
    {
      _rectStatus.visible = active;
    }
  }
};
