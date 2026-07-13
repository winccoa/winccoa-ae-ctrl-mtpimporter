// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonAnaDrv/MTP_MonAnaDrv"
#uses "classes/MTP_View/MTP_ViewFaceplateSettings"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_MonAnaDrvFaceplateSettings2
 * @brief Represents the MTP_MonAnaDrvFaceplateSettings2 class.
 */
class MTP_MonAnaDrvFaceplateSettings2 : MTP_ViewFaceplateSettings
{
  private shape _txtRpmAlarmHighLimit; //!< Reference to the RPM high alarm limit text shape.
  private shape _txtRpmAlarmLowLimit; //!< Reference to the RPM low alarm limit text shape.
  private shape _txtAlarmUpper; //!< Reference to the RPM low alarm title limit text shape.
  private shape _txtAlarmLower; //!< Reference to the RPM low alarm title limit text shape.
  private shape _txtRpmUnit1; //!< Reference to the first RPM unit text shape.
  private shape _txtRpmUnit2; //!< Reference to the second RPM unit text shape.

  /**
   * @brief Constructor for MTP_MonAnaDrvFaceplateSettings2.
   *
   * @param viewModel A shared pointer to the MTP_MonAnaDrv view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_MonAnaDrvFaceplateSettings2(shared_ptr<MTP_MonAnaDrv> viewModel, const mapping &shapes) : MTP_ViewFaceplateSettings(viewModel, shapes)
  {
    setUnit(MTP_ViewFaceplateSettings::getViewModel().getRpmUnit());
    _txtRpmAlarmHighLimit.text = MTP_ViewFaceplateSettings::getViewModel().getRpmAlarmHighLimit();
    _txtRpmAlarmLowLimit.text = MTP_ViewFaceplateSettings::getViewModel().getRpmAlarmLowLimit();

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
    setRpmAlarmHighEnabled(MTP_ViewBase::getViewModel().getRpmAlarmHighEnabled());
    setRpmAlarmLowEnabled(MTP_ViewBase::getViewModel().getRpmAlarmLowEnabled());
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
    loadPanel("objects_parts/faceplates/MTP_MonAnaDrv/setting.pnl", "1");
  }

  /**
   * @brief Sets the RPM high alarm limit.
   *
   * @param rpmAlarmHighLimit The RPM high alarm limit value to be set.
   */
  public void setRpmAlarmHighLimit(const float &rpmAlarmHighLimit)
  {
    MTP_ViewFaceplateSettings::getViewModel().setRpmAlarmHighLimit(rpmAlarmHighLimit);
  }

  /**
   * @brief Sets the RPM low alarm limit.
   *
   * @param rpmAlarmLowLimit The RPM low alarm limit value to be set.
   */
  public void setRpmAlarmLowLimit(const float &rpmAlarmLowLimit)
  {
    MTP_ViewFaceplateSettings::getViewModel().setRpmAlarmLowLimit(rpmAlarmLowLimit);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _txtRpmAlarmHighLimit = MTP_ViewFaceplateSettings::extractShape("_txtRpmAlarmHighLimit");
    _txtRpmAlarmLowLimit = MTP_ViewFaceplateSettings::extractShape("_txtRpmAlarmLowLimit");
    _txtAlarmUpper = MTP_ViewFaceplateSettings::extractShape("_txtAlarmUpper");
    _txtAlarmLower = MTP_ViewFaceplateSettings::extractShape("_txtAlarmLower");
    _txtRpmUnit1 = MTP_ViewFaceplateSettings::extractShape("_txtRpmUnit1");
    _txtRpmUnit2 = MTP_ViewFaceplateSettings::extractShape("_txtRpmUnit2");
  }

  /**
   * @brief Sets the unit for the RPM alarm limits.
   *
   * @param unit A shared pointer to the MTP_Unit object representing the unit.
   */
  private void setUnit(shared_ptr<MTP_Unit> unit)
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
      _txtRpmUnit1.visible = TRUE;
      _txtAlarmUpper.visible = TRUE;
    }
    else
    {
      _txtRpmAlarmHighLimit.visible = FALSE;
      _txtRpmUnit1.visible = FALSE;
      _txtAlarmUpper.visible = FALSE;
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
      _txtRpmUnit2.visible = TRUE;
      _txtAlarmLower.visible = TRUE;
    }
    else
    {
      _txtRpmAlarmLowLimit.visible = FALSE;
      _txtRpmUnit2.visible = FALSE;
      _txtAlarmLower.visible = FALSE;
    }
  }
};
