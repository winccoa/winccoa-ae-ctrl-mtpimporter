// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonTriPosVlv/MTP_MonTriPosVlv"
#uses "classes/MTP_Monitor/MTP_Monitor"
#uses "classes/MTP_View/MTP_ViewBase"

/**
 * @class MTP_MonTriPosVlvFaceplateMonitorInformation
 * @brief Represents the MTP_MonTriPosVlvFaceplateMonitorInformation class.
 */
class MTP_MonTriPosVlvFaceplateMonitorInformation : MTP_ViewBase
{
  private shape _txtMonitorBehavior; //!< The text monitor behavior shape.
  private shape _txtPos1StaticTime; //!< The text pos1 static time shape.
  private shape _txtPos1DynamicTime; //!< The text pos1 dynamic time shape.
  private shape _txtPos2StaticTime; //!< The text pos2 static time shape.
  private shape _txtPos2DynamicTime; //!< The text pos2 dynamic time shape.
  private shape _txtPos3StaticTime; //!< The text pos3 static time shape.
  private shape _txtPos3DynamicTime; //!< The text pos3 dynamic time shape.

  /**
   * @brief Constructor for the MTP_MonTriPosVlvFaceplateMonitorInformation object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_MonTriPosVlvFaceplateMonitorInformation object.
   */
  public MTP_MonTriPosVlvFaceplateMonitorInformation(shared_ptr<MTP_MonTriPosVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setSafePositionCB, getMonTriPosVlv().getPos1Monitor(), MTP_Monitor::safePositionChanged);
    classConnectUserData(this, setStaticTimeCB, "_txtPos1StaticTime", getMonTriPosVlv().getPos1Monitor(), MTP_Monitor::staticTimeChanged);
    classConnectUserData(this, setDynamicTimeCB, "_txtPos1DynamicTime", getMonTriPosVlv().getPos1Monitor(), MTP_Monitor::dynamicTimeChanged);
    classConnectUserData(this, setStaticTimeCB, "_txtPos2StaticTime", getMonTriPosVlv().getPos2Monitor(), MTP_Monitor::staticTimeChanged);
    classConnectUserData(this, setDynamicTimeCB, "_txtPos2DynamicTime", getMonTriPosVlv().getPos2Monitor(), MTP_Monitor::dynamicTimeChanged);
    classConnectUserData(this, setStaticTimeCB, "_txtPos3StaticTime", getMonTriPosVlv().getPos3Monitor(), MTP_Monitor::staticTimeChanged);
    classConnectUserData(this, setDynamicTimeCB, "_txtPos3DynamicTime", getMonTriPosVlv().getPos3Monitor(), MTP_Monitor::dynamicTimeChanged);

    setSafePositionCB(getMonTriPosVlv().getPos1Monitor().getSafePosition());
    setStaticTimeCB("_txtPos1StaticTime", getMonTriPosVlv().getPos1Monitor().getStaticTime());
    setDynamicTimeCB("_txtPos1DynamicTime", getMonTriPosVlv().getPos1Monitor().getDynamicTime());
    setStaticTimeCB("_txtPos2StaticTime", getMonTriPosVlv().getPos2Monitor().getStaticTime());
    setDynamicTimeCB("_txtPos2DynamicTime", getMonTriPosVlv().getPos2Monitor().getDynamicTime());
    setStaticTimeCB("_txtPos3StaticTime", getMonTriPosVlv().getPos3Monitor().getStaticTime());
    setDynamicTimeCB("_txtPos3DynamicTime", getMonTriPosVlv().getPos3Monitor().getDynamicTime());
  }

  /**
   * @brief Initializes the MTP_MonTriPosVlvFaceplateMonitorInformation object.
   */
  protected void initializeShapes()
  {
    _txtMonitorBehavior = MTP_ViewBase::extractShape("_txtMonitorBehavior");
    _txtPos1StaticTime = MTP_ViewBase::extractShape("_txtPos1StaticTime");
    _txtPos1DynamicTime = MTP_ViewBase::extractShape("_txtPos1DynamicTime");
    _txtPos2StaticTime = MTP_ViewBase::extractShape("_txtPos2StaticTime");
    _txtPos2DynamicTime = MTP_ViewBase::extractShape("_txtPos2DynamicTime");
    _txtPos3StaticTime = MTP_ViewBase::extractShape("_txtPos3StaticTime");
    _txtPos3DynamicTime = MTP_ViewBase::extractShape("_txtPos3DynamicTime");
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
   * @brief Sets the safe position from the connected data point element.
   *
   * @param safePosition The new safe position value.
   */
  private void setSafePositionCB(const bool &safePosition)
  {
    _txtMonitorBehavior.text = safePosition ? getCatStr("MTP_MonTriPosVlv", "monitorSafePosition") : getCatStr("MTP_MonTriPosVlv", "monitorHoldPosition");
  }

  /**
   * @brief Sets the static time from the connected data point element.
   *
   * @param shapeName The new shape name value.
   * @param staticTime The new static time value.
   */
  private void setStaticTimeCB(const string &shapeName, const float &staticTime)
  {
    switch (shapeName)
    {
      case "_txtPos1StaticTime": _txtPos1StaticTime.text = staticTime; break;
      case "_txtPos2StaticTime": _txtPos2StaticTime.text = staticTime; break;
      case "_txtPos3StaticTime": _txtPos3StaticTime.text = staticTime; break;
    }
  }

  /**
   * @brief Sets the dynamic time from the connected data point element.
   *
   * @param shapeName The new shape name value.
   * @param dynamicTime The new dynamic time value.
   */
  private void setDynamicTimeCB(const string &shapeName, const float &dynamicTime)
  {
    switch (shapeName)
    {
      case "_txtPos1DynamicTime": _txtPos1DynamicTime.text = dynamicTime; break;
      case "_txtPos2DynamicTime": _txtPos2DynamicTime.text = dynamicTime; break;
      case "_txtPos3DynamicTime": _txtPos3DynamicTime.text = dynamicTime; break;
    }
  }
};
