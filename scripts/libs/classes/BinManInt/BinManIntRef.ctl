// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/BinManInt/BinManInt"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class BinManIntRef
 * @brief Represents the reference implementation for the BinManInt objects.
 */
class BinManIntRef : MtpViewRef
{
  private shape _rectValue; //!< Reference to the value rectangle shape.
  private shape _rectStatus; //!< Reference to the status rectangle shape.

  private bool _manualActive; //!< Indicates if the manual source is active.
  private bool _internalActive; //!< Indicates if the internal source is active.

  /**
   * @brief Constructor for BinManIntRef.
   *
   * @param viewModel A shared pointer to the BinManInt view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public BinManIntRef(shared_ptr<BinManInt> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MtpViewRef::getViewModel(), BinManInt::valueOutChanged);
    classConnectUserData(this, setStatusCB, "_manualActive", MtpViewRef::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setStatusCB, "_internalActive", MtpViewRef::getViewModel().getSource(), MtpSource::internalActiveChanged);

    setValueCB(MtpViewRef::getViewModel().getValueOut());
    setStatusCB("_manualActive", MtpViewRef::getViewModel().getSource().getManualActive());
    setStatusCB("_internalActive", MtpViewRef::getViewModel().getSource().getInternalActive());
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
   * @brief Sets the output value for the reference.
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
   * @brief Sets the status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param active The active state to be set.
   */
  private void setStatusCB(const string &varName, const bool &active)
  {
    switch (varName)
    {
      case "_manualActive":
        _manualActive = active;
        break;

      case "_internalActive":
        _internalActive = active;
        break;
    }

    if (!MtpViewRef::getViewModel().getSource().getChannel() && _manualActive)
    {
      _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/Manual_1.svg]]";
      return;
    }

    if (!MtpViewRef::getViewModel().getSource().getChannel() && _internalActive)
    {
      _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/internal.svg]]";
      return;
    }

    _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/disabled.svg]]";
  }
};
