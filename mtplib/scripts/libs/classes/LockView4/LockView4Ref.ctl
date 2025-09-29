// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/LockView4/LockView4"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class LockView4Ref
 * @brief Represents the reference implementation for the LockView4 objects.
 */
class LockView4Ref : MtpViewRef
{
  private shape _rectOutput; //!< Reference to the output rectangle shape.
  private shape _rectDisabled; //!< Reference to the disabled rectangle shape.
  private bool _enabled; //!< Indicates if enabled is active..

  /**
     * @brief Constructor for LockView4Ref.
     *
     * @param viewModel A shared pointer to the LockView4 view model.
     * @param shapes A mapping of shapes used in the reference.
     */
  public LockView4Ref(shared_ptr<LockView4> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setOutputCB, MtpViewRef::getViewModel(), LockView4::outputChanged);
    classConnect(this, setEnabledCB, MtpViewRef::getViewModel(), LockView4::enabledChanged);

    setEnabledCB(MtpViewRef::getViewModel().getEnabled());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the output shape.
   */
  protected void initializeShapes() override
  {
    _rectOutput = MtpViewRef::extractShape("_rectOutput");
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
      _rectOutput.backCol = "mtpBorder";
    }
    else
    {
      _rectDisabled.visible = FALSE;
      setOutputCB(MtpViewRef::getViewModel().getOutput());
    }
  }

  /**
   * @brief Sets the output state for the reference.
   *
   * @param output The boolean output value to be set.
   */
  private void setOutputCB(const bool &output)
  {
    if (output && _enabled)
    {
      _rectOutput.backCol = "mtpGreen";
    }
    else if (!output && _enabled)
    {
      _rectOutput.backCol = "mtpRed";
    }
  }
};
