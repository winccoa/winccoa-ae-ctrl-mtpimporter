// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewFaceplateSettings"

/**
 * @class MonAnaDrvFaceplateSettings2
 * @brief Represents the second settings faceplate for the MonAnaDrv objects.
 */
class MonAnaDrvFaceplateSettings2 : MtpViewFaceplateSettings
{
  private shape _txtRpmAlarmHighLimit; //!< Reference to the RPM high alarm limit text shape.
  private shape _txtRpmAlarmLowLimit; //!< Reference to the RPM low alarm limit text shape.
  private shape _txtRpmUnit1; //!< Reference to the first RPM unit text shape.
  private shape _txtRpmUnit2; //!< Reference to the second RPM unit text shape.

  /**
   * @brief Constructor for MonAnaDrvFaceplateSettings2.
   *
   * @param viewModel A shared pointer to the MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MonAnaDrvFaceplateSettings2(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    setUnit(MtpViewFaceplateSettings::getViewModel().getRpmUnit());
    _txtRpmAlarmHighLimit.text = MtpViewFaceplateSettings::getViewModel().getRpmAlarmHighLimit();
    _txtRpmAlarmLowLimit.text = MtpViewFaceplateSettings::getViewModel().getRpmAlarmLowLimit();

    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);

    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
    setRpmAlarmHighEnabled(MtpViewBase::getViewModel().getRpmAlarmHighEnabled());
    setRpmAlarmLowEnabled(MtpViewBase::getViewModel().getRpmAlarmLowEnabled());
  }

  /**
   * @brief Switches to the next settings faceplate (not implemented -> Maintenance).
   */
  public void switchPageForward()
  {
  }

  /**
   * @brief Switches to the first settings faceplate.
   */
  public void switchPageBackward()
  {
    loadPanel("object_parts/MonAnaDrv/MonAnaDrvFaceplateSettings1.xml", "1");
  }

  /**
   * @brief Sets the RPM high alarm limit.
   *
   * @param rpmAlarmHighLimit The RPM high alarm limit value to be set.
   */
  public void setRpmAlarmHighLimit(const float &rpmAlarmHighLimit)
  {
    MtpViewFaceplateSettings::getViewModel().setRpmAlarmHighLimit(rpmAlarmHighLimit);
  }

  /**
   * @brief Sets the RPM low alarm limit.
   *
   * @param rpmAlarmLowLimit The RPM low alarm limit value to be set.
   */
  public void setRpmAlarmLowLimit(const float &rpmAlarmLowLimit)
  {
    MtpViewFaceplateSettings::getViewModel().setRpmAlarmLowLimit(rpmAlarmLowLimit);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the shapes.
   */
  protected void initializeShapes() override
  {
    _txtRpmAlarmHighLimit = MtpViewFaceplateSettings::extractShape("_txtRpmAlarmHighLimit");
    _txtRpmAlarmLowLimit = MtpViewFaceplateSettings::extractShape("_txtRpmAlarmLowLimit");
    _txtRpmUnit1 = MtpViewFaceplateSettings::extractShape("_txtRpmUnit1");
    _txtRpmUnit2 = MtpViewFaceplateSettings::extractShape("_txtRpmUnit2");
  }

  /**
   * @brief Sets the unit for the RPM alarm limits.
   *
   * @param unit A shared pointer to the MtpUnit object representing the unit.
   */
  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtRpmUnit1.text = "[" + unit.toString() + "]";
    _txtRpmUnit2.text = "[" + unit.toString() + "]";
  }

  /**
   * @brief Sets the editability of the RPM alarm limit text shapes based on the OS level.
   *
   * @param oslevel The boolean OS level state to be set.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    if (oslevel)
    {
      _txtRpmAlarmHighLimit.editable = TRUE;
      _txtRpmAlarmLowLimit.editable = TRUE;
    }
    else
    {
      _txtRpmAlarmHighLimit.editable = FALSE;
      _txtRpmAlarmLowLimit.editable = FALSE;
    }
  }

  /**
   * @brief Sets the visibility of the RPM high alarm limit text shape.
   *
   * @param enabled The boolean state indicating if the RPM high alarm is enabled.
   */
  private void setRpmAlarmHighEnabled(const bool &enabled)
  {
    if (enabled)
    {
      _txtRpmAlarmHighLimit.visible = TRUE;
    }
    else
    {
      _txtRpmAlarmHighLimit.visible = FALSE;
    }
  }

  /**
   * @brief Sets the visibility of the RPM low alarm limit text shape.
   *
   * @param enabled The boolean state indicating if the RPM low alarm is enabled.
   */
  private void setRpmAlarmLowEnabled(const bool &enabled)
  {
    if (enabled)
    {
      _txtRpmAlarmLowLimit.visible = TRUE;
    }
    else
    {
      _txtRpmAlarmLowLimit.visible = FALSE;
    }
  }
};
