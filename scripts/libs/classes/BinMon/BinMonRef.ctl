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

  private bool _flutterActive; //!< Indicates if the flutter is active.

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

    setStatusCB(MtpViewRef::getViewModel().getFlutterActive());
    setValueCB(MtpViewRef::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the shapes.
   */
  protected void initializeShapes() override
  {
    _rectValue = MtpViewRef::extractShape("_rectValue");
    _rectStatus = MtpViewRef::extractShape("_rectStatus");
  }

  /**
   * @brief Sets the value for the BinMon object.
   *
   * @param value The boolean value to be set.
   */
  private void setValueCB(const bool &value)
  {
    if (value)
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
    _rectStatus.visible = active;
  }
};
