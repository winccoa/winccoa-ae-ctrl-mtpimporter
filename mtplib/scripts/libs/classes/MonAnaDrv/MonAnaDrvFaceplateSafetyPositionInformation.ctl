// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MonAnaDrvFaceplateSafetyPositionInformation
 * @brief Represents the safety position information faceplate for the MonAnaDrv objects.
 */
class MonAnaDrvFaceplateSafetyPositionInformation : MtpViewBase
{
  private shape _txtSafetyPosition; //!< Reference to the safety position text shape.

  /**
   * @brief Constructor for MonAnaDrvFaceplateSafetyPositionInformation.
   *
   * @param viewModel A shared pointer to the MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonAnaDrvFaceplateSafetyPositionInformation(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, MtpViewBase::getViewModel(), MonAnaDrv::safetyPositionChanged);

    setSafetyPositionCB(MtpViewBase::getViewModel().getSafetyPosition());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the safety position shape.
   */
  protected void initializeShapes()
  {
    _txtSafetyPosition = MtpViewBase::extractShape("_txtSafetyPosition");
  }

  /**
   * @brief Sets the safety position text based on the safety position state.
   *
   * @param safetyPosition The boolean safety position state to be set.
   */
  private void setSafetyPositionCB(const bool &safetyPosition)
  {
    if (safetyPosition)
    {
      _txtSafetyPosition.text = getCatStr("MonAnaDrv", "safetyPositionTrue");
    }
    else
    {
      _txtSafetyPosition.text = getCatStr("MonAnaDrv", "safetyPositionFalse");
    }
  }
};
