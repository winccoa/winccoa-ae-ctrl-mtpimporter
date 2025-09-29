// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MonBinVlvFaceplateSafetyPositionInformation
 * @brief Represents the safety position information faceplate for the MonBinVlv objects.
 */
class MonBinVlvFaceplateSafetyPositionInformation : MtpViewBase
{
  private shape _txtSafetyPosition; //!< Reference to the safety position text shape.

  /**
     * @brief Constructor for MonBinVlvFaceplateSafetyPositionInformation.
     *
     * @param viewModel A shared pointer to the MonBinVlv view model.
     * @param shapes A mapping of shapes used in the faceplate.
     */
  public MonBinVlvFaceplateSafetyPositionInformation(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, MtpViewBase::getViewModel(), MonBinVlv::safetyPositionChanged);

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
      _txtSafetyPosition.text = getCatStr("MonBinVlv", "safetyPositionTrue");
    }
    else
    {
      _txtSafetyPosition.text = getCatStr("MonBinVlv", "safetyPositionFalse");
    }
  }
};
