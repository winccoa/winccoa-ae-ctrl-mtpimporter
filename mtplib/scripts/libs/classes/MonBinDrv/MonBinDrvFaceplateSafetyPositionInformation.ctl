// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MonBinDrvFaceplateSafetyPositionInformation
 * @brief Represents the safety position information faceplate for the MonBinDrv objects.
 */
class MonBinDrvFaceplateSafetyPositionInformation : MtpViewBase
{
  private shape _txtSafetyPosition; //!< Reference to the safety position text shape.

  /**
     * @brief Constructor for MonBinDrvFaceplateSafetyPositionInformation.
     *
     * @param viewModel A shared pointer to the MonBinDrv view model.
     * @param shapes A mapping of shapes used in the faceplate.
     */
  public MonBinDrvFaceplateSafetyPositionInformation(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, MtpViewBase::getViewModel(), MonBinDrv::safetyPositionChanged);

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
      _txtSafetyPosition.text = getCatStr("MonBinDrv", "safetyPositionTrue");
    }
    else
    {
      _txtSafetyPosition.text = getCatStr("MonBinDrv", "safetyPositionFalse");
    }
  }
};
