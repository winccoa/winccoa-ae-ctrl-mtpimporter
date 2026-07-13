// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonAnaVlv/MTP_MonAnaVlv"
#uses "classes/MTP_View/MTP_ViewBase"

/**
 * @class MTP_MonAnaVlvFaceplateSafetyPositionInformation
 * @brief Represents the MTP_MonAnaVlvFaceplateSafetyPositionInformation class.
 */
class MTP_MonAnaVlvFaceplateSafetyPositionInformation : MTP_ViewBase
{
  private shape _txtSafetyPosition; //!< Reference to the safety position text shape.

  /**
   * @brief Constructor for MTP_MonAnaVlvFaceplateSafetyPositionInformation.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonAnaVlvFaceplateSafetyPositionInformation(shared_ptr<MTP_MonAnaVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::safetyPositionChanged);

    setSafetyPositionCB(MTP_ViewBase::getViewModel().getSafetyPosition());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtSafetyPosition = MTP_ViewBase::extractShape("_txtSafetyPosition");
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
      _txtSafetyPosition.text = getCatStr("MTP_MonAnaVlv", "safetyPositionTrue");
    }
    else
    {
      _txtSafetyPosition.text = getCatStr("MTP_MonAnaVlv", "safetyPositionFalse");
    }
  }
};
