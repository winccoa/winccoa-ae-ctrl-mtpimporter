// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonAnaVlv/MTP_MonAnaVlv"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Monitor/MTP_Monitor"

/**
 * @class MTP_MonAnaVlvFaceplatePositionError
 * @brief Represents the MTP_MonAnaVlvFaceplatePositionError class.
 */
class MTP_MonAnaVlvFaceplatePositionError : MTP_ViewBase
{
  private shape _txtPositionTolerance; //!< The text position tolerance shape.
  private shape _txtPositionToleranceValue; //!< The text position tolerance value shape.
  private shape _txtSafePosition; //!< Reference to the text shape for the safe position status.
  private shape _txtPositionTimeValue; //!< The text position time value shape.
  private shape _txtPositionTime; //!< The text position time shape.

  /**
   * @brief Constructor for MTP_MonAnaVlvFaceplatePositionError.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonAnaVlvFaceplatePositionError(shared_ptr<MTP_MonAnaVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setSafePositionCB, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::safetyPositionChanged);
    classConnect(this, setPositionTimeCB, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::monitorPositionTimeChanged);
    classConnect(this, setPositionToleranceCB, MTP_ViewBase::getViewModel(), MTP_MonAnaVlv::positionToleranceChanged);

    setSafePositionCB(MTP_ViewBase::getViewModel().getSafetyPosition());
    setPositionTimeCB(MTP_ViewBase::getViewModel().getMonitorPositionTime());
    setPositionToleranceCB(MTP_ViewBase::getViewModel().getPositionTolerance());

    _txtPositionTolerance.text = _txtPositionTolerance.text +  " [" + MTP_ViewBase::getViewModel().getPositionUnit().toString() + "]";
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtPositionTolerance = MTP_ViewBase::extractShape("_txtPositionTolerance");
    _txtPositionToleranceValue = MTP_ViewBase::extractShape("_txtPositionToleranceValue");
    _txtSafePosition = MTP_ViewBase::extractShape("_txtSafePosition");
    _txtPositionTimeValue = MTP_ViewBase::extractShape("_txtPositionTimeValue");
    _txtPositionTime = MTP_ViewBase::extractShape("_txtPositionTime");
  }

  /**
   * @brief Callback function to update the safe position status text.
   *
   * @param safePosition The new safe position state.
   */
  private void setSafePositionCB(const bool &safePosition)
  {
    if (safePosition)
    {
      _txtSafePosition.text = getCatStr("MTP_MonAnaVlv", "safePositionOn");
    }
    else
    {
      _txtSafePosition.text = getCatStr("MTP_MonAnaVlv", "safePositionOff");
    }
  }

  /**
   * @brief Sets the position time from the connected data point element.
   *
   * @param staticTime The new static time value.
   */
  private void setPositionTimeCB(const float &staticTime)
  {
    _txtPositionTimeValue.text = staticTime;
  }

  /**
   * @brief Sets the position tolerance from the connected data point element.
   *
   * @param dynamicTime The new dynamic time value.
   */
  private void setPositionToleranceCB(const float &dynamicTime)
  {
    _txtPositionToleranceValue.text = dynamicTime;
  }
};
