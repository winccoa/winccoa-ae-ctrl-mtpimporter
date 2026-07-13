// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinDrv/MTP_BinDrv"
#uses "classes/MTP_View/MTP_ViewBase"

/**
 * @class MTP_BinDrvFaceplateSafetyPositionInformation
 * @brief Represents the MTP_BinDrvFaceplateSafetyPositionInformation class.
 */
class MTP_BinDrvFaceplateSafetyPositionInformation : MTP_ViewBase
{
  private shape _txtSafetyPosition; //!< Reference to the safety position text shape.

  /**
     * @brief Constructor for MTP_BinDrvFaceplateSafetyPositionInformation.
     *
     * @param viewModel A shared pointer to the MTP_BinDrv view model.
     * @param shapes A mapping of shapes used in the faceplate.
     */
  public MTP_BinDrvFaceplateSafetyPositionInformation(shared_ptr<MTP_BinDrv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, MTP_ViewBase::getViewModel(), MTP_BinDrv::safetyPositionChanged);

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
      _txtSafetyPosition.text = getCatStr("MTP_BinDrv", "safetyPositionTrue");
    }
    else
    {
      _txtSafetyPosition.text = getCatStr("MTP_BinDrv", "safetyPositionFalse");
    }
  }
};
