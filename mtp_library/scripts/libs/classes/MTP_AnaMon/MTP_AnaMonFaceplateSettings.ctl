// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_View/MTP_ViewFaceplateSettings"
#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_AnaMon/MTP_AnaMon"

/**
 * @class MTP_AnaMonFaceplateSettings
 * @brief Represents the MTP_AnaMonFaceplateSettings class.
 */
class MTP_AnaMonFaceplateSettings : MTP_ViewFaceplateSettings
{
  private shape _txtUnitAlert; //!< Reference to the alert unit text shape.
  private shape _txtUnitWarning; //!< Reference to the warning unit text shape.
  private shape _txtUnitTolerance; //!< Reference to the tolerance unit text shape.
  private shape _txtAlert; //!< Reference to the alert text shape.
  private shape _txtWarning; //!< Reference to the warning text shape.
  private shape _txtTolerance; //!< Reference to the tolerance text shape.
  private bool _init; //!< Indicates if the shapes have been initialized.

  /**
   * @brief Constructor for MTP_AnaMonFaceplateSettings.
   *
   * @param viewModel A shared pointer to the MTP_AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_AnaMonFaceplateSettings(shared_ptr<MTP_AnaMon> viewModel, const mapping &shapes) : MTP_ViewFaceplateSettings(viewModel, shapes)
  {
    setUnit(MTP_ViewFaceplateSettings::getViewModel().getUnit());
  }


  /**
   * @brief Pure virtual function to set the alert limit.
   *
   * @param alertLimit The alert limit value to be set.
   */
  public void setAlertLimit(const float &alertLimit) = 0;

  /**
   * @brief Pure virtual function to set the warning limit.
   *
   * @param warningLimit The warning limit value to be set.
   */
  public void setWarningLimit(const float &warningLimit) = 0;

  /**
   * @brief Pure virtual function to set the tolerance limit.
   *
   * @param toleranceLimit The tolerance limit value to be set.
   */
  public void setToleranceLimit(const float &toleranceLimit) = 0;

  /**
   * @brief Pure virtual function to switch the page.
   */
  public void switchPage() = 0;

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _txtUnitAlert = MTP_ViewFaceplateSettings::extractShape("_txtUnitAlert");
    _txtUnitWarning = MTP_ViewFaceplateSettings::extractShape("_txtUnitWarning");
    _txtUnitTolerance = MTP_ViewFaceplateSettings::extractShape("_txtUnitTolerance");
    _txtAlert = MTP_ViewFaceplateSettings::extractShape("_txtAlert");
    _txtWarning = MTP_ViewFaceplateSettings::extractShape("_txtWarning");
    _txtTolerance = MTP_ViewFaceplateSettings::extractShape("_txtTolerance");
    _init = TRUE;
  }

  /**
   * @brief Gets the initialization status of the shapes.
   * @return True if the shapes have been initialized, false otherwise.
   */
  protected bool getInit()
  {
    return _init;
  }

  /**
   * @brief Gets the alert text shape.
   * @return The alert text shape.
   */
  protected shape getTxtAlert()
  {
    return _txtAlert;
  }

  /**
   * @brief Gets the warning text shape.
   * @return The warning text shape.
   */
  protected shape getTxtWarning()
  {
    return _txtWarning;
  }

  /**
   * @brief Gets the tolerance text shape.
   * @return The tolerance text shape.
   */
  protected shape getTxtTolerance()
  {
    return _txtTolerance;
  }

  /**
   * @brief Sets the unit for the faceplate settings.
   * @param unit A shared pointer to the MTP_Unit object representing the unit.
   */
  private void setUnit(shared_ptr<MTP_Unit> unit)
  {
    _txtUnitAlert.text = "[" + unit.toString() + "]";
    _txtUnitWarning.text = "[" + unit.toString() + "]";
    _txtUnitTolerance.text = "[" + unit.toString() + "]";
  }
};
