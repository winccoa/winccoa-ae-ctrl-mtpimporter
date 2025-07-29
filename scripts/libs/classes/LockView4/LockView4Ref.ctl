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

  /**
     * @brief Constructor for LockView4Ref.
     *
     * @param viewModel A shared pointer to the LockView4 view model.
     * @param shapes A mapping of shapes used in the reference.
     */
  public LockView4Ref(shared_ptr<LockView4> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setOutputCB, MtpViewRef::getViewModel(), LockView4::outputChanged);

    setOutputCB(MtpViewRef::getViewModel().getOutput());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the output shape.
   */
  protected void initializeShapes() override
  {
    _rectOutput = MtpViewRef::extractShape("_rectOutput");
  }

  /**
   * @brief Sets the output state for the reference.
   *
   * @param output The boolean output value to be set.
   */
  private void setOutputCB(const bool &output)
  {
    if (output)
    {
      _rectOutput.backCol = "mtpGreen";
    }
    else
    {
      _rectOutput.backCol = "mtpRed";
    }
  }
};
