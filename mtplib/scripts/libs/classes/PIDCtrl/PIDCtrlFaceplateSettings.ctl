// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/PIDCtrl/PIDCtrl"
#uses "classes/MtpView/MtpViewFaceplateSettings"

/**
 * @class PIDCtrlFaceplateSettings
 * @brief Represents the settings faceplate for the PIDCtrl objects.
 */
class PIDCtrlFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _txtP; //!< Reference to the proportional parameter text shape.
  private shape _txtTd; //!< Reference to the derivation parameter text shape.
  private shape _txtTi; //!< Reference to the integration parameter text shape.

  /**
   * @brief Constructor for PIDCtrlFaceplateSettings.
   *
   * @param viewModel A shared pointer to the PIDCtrl view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public PIDCtrlFaceplateSettings(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    _txtP.text = MtpViewFaceplateSettings::getViewModel().getProportionalParameter();
    _txtTd.text = MtpViewFaceplateSettings::getViewModel().getDerivationParameter();
    _txtTi.text = MtpViewFaceplateSettings::getViewModel().getIntegrationParameter();

    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Sets the proportional parameter for the PID controller.
   *
   * @param proportionalParameter The proportional parameter value to be set.
   */
  public void setProportionalParameter(const float &proportionalParameter)
  {
    MtpViewFaceplateSettings::getViewModel().setProportionalParameter(proportionalParameter);
  }

  /**
   * @brief Sets the integration parameter for the PID controller.
   *
   * @param integrationParameter The integration parameter value to be set.
   */
  public void setIntegrationParameter(const float &integrationParameter)
  {
    MtpViewFaceplateSettings::getViewModel().setIntegrationParameter(integrationParameter);
  }

  /**
   * @brief Sets the derivation parameter for the PID controller.
   *
   * @param derivationParameter The derivation parameter value to be set.
   */
  public void setDerivationParameter(const float &derivationParameter)
  {
    MtpViewFaceplateSettings::getViewModel().setDerivationParameter(derivationParameter);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the shapes.
   */
  protected void initializeShapes() override
  {
    _txtP = MtpViewFaceplateSettings::extractShape("_txtP");
    _txtTd = MtpViewFaceplateSettings::extractShape("_txtTd");
    _txtTi = MtpViewFaceplateSettings::extractShape("_txtTi");
  }

  /**
   * @brief Sets the editability of the parameter text shapes based on the OS level.
   *
   * @param oslevel The boolean OS level state to be set.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    if (oslevel)
    {
      _txtP.editable = TRUE;
      _txtTd.editable = TRUE;
      _txtTi.editable = TRUE;
    }
    else
    {
      _txtP.editable = FALSE;
      _txtTd.editable = FALSE;
      _txtTi.editable = FALSE;
    }
  }
};
