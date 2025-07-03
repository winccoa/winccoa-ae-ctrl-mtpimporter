// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpView/MtpViewFaceplateSettings"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/AnaMon/AnaMon"

/**
 * @class AnaMonFaceplateSettings
 * @brief Represents the settings faceplate for the AnaMon objects.
 */
class AnaMonFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _txtUnitAlert; //!< Reference to the alert unit text shape.
  private shape _txtUnitWarning; //!< Reference to the warning unit text shape.
  private shape _txtUnitTolerance; //!< Reference to the tolerance unit text shape.
  private shape _txtAlert; //!< Reference to the alert text shape.
  private shape _txtWarning; //!< Reference to the warning text shape.
  private shape _txtTolerance; //!< Reference to the tolerance text shape.
  private bool _init; //!< Indicates if the shapes have been initialized.

  /**
   * @brief Constructor for AnaMonFaceplateSettings.
   *
   * @param viewModel A shared pointer to the AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public AnaMonFaceplateSettings(shared_ptr<AnaMon> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    setUnit(MtpViewFaceplateSettings::getViewModel().getUnit());
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
   * @details This method overrides the base class method to extract the table shape.
   */
  protected void initializeShapes() override
  {
    _txtUnitAlert = MtpViewFaceplateSettings::extractShape("_txtUnitAlert");
    _txtUnitWarning = MtpViewFaceplateSettings::extractShape("_txtUnitWarning");
    _txtUnitTolerance = MtpViewFaceplateSettings::extractShape("_txtUnitTolerance");
    _txtAlert = MtpViewFaceplateSettings::extractShape("_txtAlert");
    _txtWarning = MtpViewFaceplateSettings::extractShape("_txtWarning");
    _txtTolerance = MtpViewFaceplateSettings::extractShape("_txtTolerance");
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
   * @param unit A shared pointer to the MtpUnit object representing the unit.
   */
  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtUnitAlert.text = "[" + unit.toString() + "]";
    _txtUnitWarning.text = "[" + unit.toString() + "]";
    _txtUnitTolerance.text = "[" + unit.toString() + "]";
  }
};
