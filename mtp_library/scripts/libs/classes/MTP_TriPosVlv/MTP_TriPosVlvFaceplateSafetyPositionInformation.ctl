// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_TriPosVlv/MTP_TriPosVlv"
#uses "classes/MTP_View/MTP_ViewBase"

/**
 * @class MTP_TriPosVlvFaceplateSafetyPositionInformation
 * @brief Represents the MTP_TriPosVlvFaceplateSafetyPositionInformation class.
 */
class MTP_TriPosVlvFaceplateSafetyPositionInformation : MTP_ViewBase
{
  private shape _txtSafetyPosition; //!< The text safety position shape.

  /**
   * @brief Constructor for the MTP_TriPosVlvFaceplateSafetyPositionInformation object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_TriPosVlvFaceplateSafetyPositionInformation object.
   */
  public MTP_TriPosVlvFaceplateSafetyPositionInformation(shared_ptr<MTP_TriPosVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, getTriPosVlv(), MTP_TriPosVlv::safePositionChanged);
    setSafetyPositionCB(getTriPosVlv().getSafePosition());
  }

  /**
   * @brief Initializes the MTP_TriPosVlvFaceplateSafetyPositionInformation object.
   */
  protected void initializeShapes()
  {
    _txtSafetyPosition = MTP_ViewBase::extractShape("_txtSafetyPosition");
  }

  /**
   * @brief Retrieves the tri position vlv.
   *
   * @return The tri position vlv.
   */
  private shared_ptr<MTP_TriPosVlv> getTriPosVlv()
  {
    return MTP_ViewBase::getViewModel();
  }

  /**
   * @brief Sets the safety position from the connected data point element.
   *
   * @param safetyPosition The new safety position value.
   */
  private void setSafetyPositionCB(const int &safetyPosition)
  {
    switch (safetyPosition)
    {
      case 1:
        _txtSafetyPosition.text = getCatStr("MTP_TriPosVlv", "safetyPosition1");
        break;

      case 2:
        _txtSafetyPosition.text = getCatStr("MTP_TriPosVlv", "safetyPosition2");
        break;

      case 3:
        _txtSafetyPosition.text = getCatStr("MTP_TriPosVlv", "safetyPosition3");
        break;

      default:
        _txtSafetyPosition.text = getCatStr("MTP_TriPosVlv", "safetyPositionUnknown");
        break;
    }
  }
};
