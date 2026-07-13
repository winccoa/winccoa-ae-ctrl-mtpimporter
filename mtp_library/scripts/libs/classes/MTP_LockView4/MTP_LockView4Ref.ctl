// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_LockView4/MTP_LockView4"

/**
 * @class MTP_LockView4Ref
 * @brief Represents the MTP_LockView4Ref class.
 */
class MTP_LockView4Ref : MTP_ViewRef
{
  protected shape _rectOutput; //!< Reference to the output rectangle shape.

  /**
     * @brief Constructor for MTP_LockView4Ref.
     *
     * @param viewModel A shared pointer to the LockView4 view model.
     * @param shapes A mapping of shapes used in the reference.
     */
  public MTP_LockView4Ref(shared_ptr<MTP_LockView4> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setOutputCB, MTP_ViewRef::getViewModel(), MTP_LockView4::outputChanged);
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
