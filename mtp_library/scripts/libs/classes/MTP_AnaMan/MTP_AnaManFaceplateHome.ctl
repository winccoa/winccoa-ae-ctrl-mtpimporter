// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_AnaMan/MTP_AnaMan"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_AnaManFaceplateHome
 * @brief Represents the MTP_AnaManFaceplateHome class.
 */
class MTP_AnaManFaceplateHome : MTP_ViewBase
{
  private shape _txtValueManual; //!< Reference to the manual value text shape.
  private shape _txtFeedbackValue; //!< Reference to the feedback value text shape.
  private bool _osLevelStation; //!< Indicates the station-level operational state.

  private shared_ptr<MTP_BarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MTP_AnaManFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_AnaMan view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_AnaManFaceplateHome(shared_ptr<MTP_AnaMan> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MTP_BarIndicator::setValueCustomLimit, MTP_ViewBase::getViewModel(), MTP_AnaMan::valueOutChanged);
    classConnect(this, setValueFeedbackCB, MTP_ViewBase::getViewModel(), MTP_AnaMan::valueFeedbackChanged);
    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    _osLevelStation = MTP_ViewBase::getViewModel().getOsLevel().getStationLevel();

    _refBarIndicator.setAlertHighShape(FALSE, MTP_ViewBase::getViewModel().getValueMax());
    _refBarIndicator.setAlertLowShape(FALSE, MTP_ViewBase::getViewModel().getValueMin());
    _refBarIndicator.setScale(MTP_ViewBase::getViewModel().getValueScaleMin(), MTP_ViewBase::getViewModel().getValueScaleMax());
    _refBarIndicator.setUnit(MTP_ViewBase::getViewModel().getValueUnit());

    setValueManualText(MTP_ViewBase::getViewModel().getValueManual());
    _refBarIndicator.setValueCustomLimit(MTP_ViewBase::getViewModel().getValueOut());
    setUnit(MTP_ViewBase::getViewModel().getValueUnit());
    setValueFeedbackCB(MTP_ViewBase::getViewModel().getValueFeedback());
    setOsLevelCB(_osLevelStation);
  }

  /**
   * @brief Sets the manual value for the view model.
   *
   * @param valueManual The new manual value to set.
   */
  public void setValueManual(const float &valueManual)
  {
    MTP_ViewBase::getViewModel().setValueManual(valueManual);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtValueManual = MTP_ViewBase::extractShape("_txtValueManual");
    _txtFeedbackValue = MTP_ViewBase::extractShape("_txtFeedbackValue");

    _refBarIndicator = MTP_ViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
  }

  /**
   * @brief Callback function to update the operational state level.
   *
   * @param oslevel The new operational state level.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;
    _txtValueManual.editable = _osLevelStation;
  }

  /**
   * @brief Sets the unit for the bar indicator.
   *
   * @param unit A shared pointer to the MTP_Unit instance.
   */
  private void setUnit(shared_ptr<MTP_Unit> unit)
  {
    _refBarIndicator.setUnit(unit);
  }

  /**
   * @brief Sets the manual value text for the text shape.
   *
   * @param valueManual The manual value to display.
   */
  private void setValueManualText(const float &valueManual)
  {
    _txtValueManual.text = valueManual;
  }

  /**
   * @brief Callback function to update the feedback value text.
   *
   * @param value The new feedback value to display.
   */
  private void setValueFeedbackCB(const float &value)
  {
    _txtFeedbackValue.text = value;
  }
};
