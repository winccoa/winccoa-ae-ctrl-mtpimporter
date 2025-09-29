// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MonBinVlvFaceplateErrorInformation
 * @brief A faceplate class for displaying error-related information for a binary valve, including safe position status and static/dynamic error times.
 */
class MonBinVlvFaceplateErrorInformation : MtpViewBase
{
  private shape _txtDynamicTime; //!< Reference to the text shape for the dynamic time label.
  private shape _txtDynamicTimeValue; //!< Reference to the text shape for the dynamic time value.
  private shape _txtSafePosition; //!< Reference to the text shape for the safe position status.
  private shape _txtStaticTime; //!< Reference to the text shape for the static time label.
  private shape _txtStaticTimeValue; //!< Reference to the text shape for the static time value.

  /**
   * @brief Constructor for MonBinVlvFaceplateErrorInformation.
   * @details Initializes the faceplate by connecting to the view model's monitor signals for safe position, static time, and dynamic time, and sets initial values for the shapes.
   *
   * @param viewModel A shared pointer to the MonBinVlv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonBinVlvFaceplateErrorInformation(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
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
   * @details Overrides the base class method to extract the required text shapes for displaying error information.
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
   * @details Updates the safe position text shape based on the safe position state, using localized strings.
   *
   * @param safePosition The new safe position state.
   */
  private void setSafePositionCB(const bool &safePosition)
  {
    if (safePosition)
    {
      _txtSafePosition.text = getCatStr("MonBinVlv", "safePositionOn");
    }
    else
    {
      _txtSafePosition.text = getCatStr("MonBinVlv", "safePositionOff");
    }
  }

  /**
   * @brief Callback function to update the static time value text.
   * @details Updates the static time value text shape with the provided static time.
   *
   * @param staticTime The new static time value.
   */
  private void setStaticTimeCB(const float &staticTime)
  {
    _txtStaticTimeValue.text = staticTime;
  }

  /**
   * @brief Callback function to update the dynamic time value text.
   * @details Updates the dynamic time value text shape with the provided dynamic time.
   *
   * @param dynamicTime The new dynamic time value.
   */
  private void setDynamicTimeCB(const float &dynamicTime)
  {
    _txtDynamicTimeValue.text = dynamicTime;
  }
};
