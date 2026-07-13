// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_LockView8/MTP_LockView8"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_LockView8Ref
 * @brief Represents the MTP_LockView8Ref class.
 */
class MTP_LockView8Ref : MTP_ViewRef
{
  protected shape _rectOutput; //!< Reference to the output rectangle shape.

  /**
     * @brief Constructor for MTP_LockView8Ref.
     *
     * @param viewModel A shared pointer to the LockView88 view model.
     * @param shapes A mapping of shapes used in the reference.
     */
  public MTP_LockView8Ref(shared_ptr<MTP_LockView8> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setOutputCB, MTP_ViewRef::getViewModel(), MTP_LockView8::outputChanged);
    setOutputCB(MTP_ViewRef::getViewModel().getOutput());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _rectOutput = MTP_ViewRef::extractShape("_rectOutput");
  }

  /**
   * @brief Sets the output state for the reference.
   *
   * @param output The boolean output value to be set.
   */
  protected void setOutputCB(const bool &output)
  {
    if (output && _rectOutput.enabled())
    {
      _rectOutput.backCol = "mtpGreen";
    }
    else if (!output && _rectOutput.enabled())
    {
      _rectOutput.backCol = "mtpRed";
    }
  }
};
