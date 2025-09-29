// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MonAnaDrvFaceplateErrorInformation
 * @brief Represents the error information faceplate for MonAnaDrv objects, displaying safe position and error timing details.
 */
class MonAnaDrvFaceplateErrorInformation : MtpViewBase
{
  private shape _txtDynamicTime; //!< Reference to the text shape for the dynamic time label.
  private shape _txtDynamicTimeValue; //!< Reference to the text shape for the dynamic time value.
  private shape _txtSafePosition; //!< Reference to the text shape for the safe position status.
  private shape _txtStaticTime; //!< Reference to the text shape for the static time label.
  private shape _txtStaticTimeValue; //!< Reference to the text shape for the static time value.

  /**
   * @brief Constructor for MonAnaDrvFaceplateErrorInformation.
   *
   * @param viewModel A shared pointer to the MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonAnaDrvFaceplateErrorInformation(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setSafePositionCB, MtpViewBase::getViewModel().getMonitor(), MtpMonitor::safePositionChanged);
    classConnect(this, setStaticTimeCB, MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticTimeChanged);
    classConnect(this, setDynamicTimeCB, MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicTimeChanged);

    setSafePositionCB(MtpViewBase::getViewModel().getMonitor().getSafePosition());
    setStaticTimeCB(MtpViewBase::getViewModel().getMonitor().getStaticTime());
    setDynamicTimeCB(MtpViewBase::getViewModel().getMonitor().getDynamicTime());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the required shapes.
   */
  protected void initializeShapes()
  {
    _txtDynamicTime = MtpViewBase::extractShape("_txtDynamicTime");
    _txtDynamicTimeValue = MtpViewBase::extractShape("_txtDynamicTimeValue");
    _txtSafePosition = MtpViewBase::extractShape("_txtSafePosition");
    _txtStaticTime = MtpViewBase::extractShape("_txtStaticTime");
    _txtStaticTimeValue = MtpViewBase::extractShape("_txtStaticTimeValue");
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
      _txtSafePosition.text = getCatStr("MonAnaDrv", "safePositionOn");
    }
    else
    {
      _txtSafePosition.text = getCatStr("MonAnaDrv", "safePositionOff");
    }
  }

  /**
   * @brief Callback function to update the static time value text.
   *
   * @param staticTime The new static time value.
   */
  private void setStaticTimeCB(const float &staticTime)
  {
    _txtStaticTimeValue.text = staticTime;
  }

  /**
   * @brief Callback function to update the dynamic time value text.
   *
   * @param dynamicTime The new dynamic time value.
   */
  private void setDynamicTimeCB(const float &dynamicTime)
  {
    _txtDynamicTimeValue.text = dynamicTime;
  }
};
