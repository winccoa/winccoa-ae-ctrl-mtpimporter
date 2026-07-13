// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Monitor/MTP_Monitor"
#uses "classes/MTP_MonBinDrv/MTP_MonBinDrv"

/**
 * @class MTP_MonBinDrvFaceplateErrorInformation
 * @brief Represents the MTP_MonBinDrvFaceplateErrorInformation class.
 */
class MTP_MonBinDrvFaceplateErrorInformation : MTP_ViewBase
{
  private shape _txtDynamicTime; //!< Reference to the text shape for the dynamic time label.
  private shape _txtDynamicTimeValue; //!< Reference to the text shape for the dynamic time value.
  private shape _txtSafePosition; //!< Reference to the text shape for the safe position status.
  private shape _txtStaticTime; //!< Reference to the text shape for the static time label.
  private shape _txtStaticTimeValue; //!< Reference to the text shape for the static time value.

  /**
   * @brief Constructor for MTP_MonBinDrvFaceplateErrorInformation.
   *
   * @param viewModel A shared pointer to the MTP_MonBinDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonBinDrvFaceplateErrorInformation(shared_ptr<MTP_MonBinDrv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setSafePositionCB, MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::safePositionChanged);
    classConnect(this, setStaticTimeCB, MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::staticTimeChanged);
    classConnect(this, setDynamicTimeCB, MTP_ViewBase::getViewModel().getMonitor(), MTP_Monitor::dynamicTimeChanged);

    setSafePositionCB(MTP_ViewBase::getViewModel().getMonitor().getSafePosition());
    setStaticTimeCB(MTP_ViewBase::getViewModel().getMonitor().getStaticTime());
    setDynamicTimeCB(MTP_ViewBase::getViewModel().getMonitor().getDynamicTime());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtDynamicTime = MTP_ViewBase::extractShape("_txtDynamicTime");
    _txtDynamicTimeValue = MTP_ViewBase::extractShape("_txtDynamicTimeValue");
    _txtSafePosition = MTP_ViewBase::extractShape("_txtSafePosition");
    _txtStaticTime = MTP_ViewBase::extractShape("_txtStaticTime");
    _txtStaticTimeValue = MTP_ViewBase::extractShape("_txtStaticTimeValue");
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
      _txtSafePosition.text = getCatStr("MTP_MonBinDrv", "safePositionOn");
    }
    else
    {
      _txtSafePosition.text = getCatStr("MTP_MonBinDrv", "safePositionOff");
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
