// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonTriPosVlv/MTP_MonTriPosVlv"
#uses "classes/MTP_View/MTP_ViewBase"

/**
 * @class MTP_MonTriPosVlvFaceplateSafetyPositionInformation
 * @brief Represents the MTP_MonTriPosVlvFaceplateSafetyPositionInformation class.
 */
class MTP_MonTriPosVlvFaceplateSafetyPositionInformation : MTP_ViewBase
{
  private shape _txtSafetyPosition; //!< The text safety position shape.

  /**
   * @brief Constructor for the MTP_MonTriPosVlvFaceplateSafetyPositionInformation object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_MonTriPosVlvFaceplateSafetyPositionInformation object.
   */
  public MTP_MonTriPosVlvFaceplateSafetyPositionInformation(shared_ptr<MTP_MonTriPosVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, getMonTriPosVlv(), MTP_MonTriPosVlv::safePositionChanged);
    setSafetyPositionCB(getMonTriPosVlv().getSafePosition());
  }

  /**
   * @brief Initializes the MTP_MonTriPosVlvFaceplateSafetyPositionInformation object.
   */
  protected void initializeShapes()
  {
    _txtSafetyPosition = MTP_ViewBase::extractShape("_txtSafetyPosition");
  }

  /**
   * @brief Retrieves the mon tri position vlv.
   *
   * @return The mon tri position vlv.
   */
  private shared_ptr<MTP_MonTriPosVlv> getMonTriPosVlv()
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
        _txtSafetyPosition.text = getCatStr("MTP_MonTriPosVlv", "safetyPosition1");
        break;

      case 2:
        _txtSafetyPosition.text = getCatStr("MTP_MonTriPosVlv", "safetyPosition2");
        break;

      case 3:
        _txtSafetyPosition.text = getCatStr("MTP_MonTriPosVlv", "safetyPosition3");
        break;

      default:
        _txtSafetyPosition.text = getCatStr("MTP_MonTriPosVlv", "safetyPositionUnknown");
        break;
    }
  }
};
