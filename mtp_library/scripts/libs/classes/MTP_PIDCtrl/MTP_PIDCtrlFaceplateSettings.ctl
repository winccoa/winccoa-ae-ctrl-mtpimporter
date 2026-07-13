// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_PIDCtrl/MTP_PIDCtrl"
#uses "classes/MTP_View/MTP_ViewFaceplateSettings"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_PIDCtrlFaceplateSettings
 * @brief Represents the MTP_PIDCtrlFaceplateSettings class.
 */
class MTP_PIDCtrlFaceplateSettings : MTP_ViewFaceplateSettings
{
  private shape _txtP; //!< Reference to the proportional parameter text shape.
  private shape _txtTd; //!< Reference to the derivation parameter text shape.
  private shape _txtTi; //!< Reference to the integration parameter text shape.

  /**
   * @brief Constructor for MTP_PIDCtrlFaceplateSettings.
   *
   * @param viewModel A shared pointer to the MTP_PIDCtrl view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_PIDCtrlFaceplateSettings(shared_ptr<MTP_PIDCtrl> viewModel, const mapping &shapes) : MTP_ViewFaceplateSettings(viewModel, shapes)
  {
    _txtP.text = MTP_ViewFaceplateSettings::getViewModel().getProportionalParameter();
    _txtTd.text = MTP_ViewFaceplateSettings::getViewModel().getDerivationParameter();
    _txtTi.text = MTP_ViewFaceplateSettings::getViewModel().getIntegrationParameter();

    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Sets the proportional parameter for the PID controller.
   *
   * @param proportionalParameter The proportional parameter value to be set.
   */
  public void setProportionalParameter(const float &proportionalParameter)
  {
    MTP_ViewFaceplateSettings::getViewModel().setProportionalParameter(proportionalParameter);
  }

  /**
   * @brief Sets the integration parameter for the PID controller.
   *
   * @param integrationParameter The integration parameter value to be set.
   */
  public void setIntegrationParameter(const float &integrationParameter)
  {
    MTP_ViewFaceplateSettings::getViewModel().setIntegrationParameter(integrationParameter);
  }

  /**
   * @brief Sets the derivation parameter for the PID controller.
   *
   * @param derivationParameter The derivation parameter value to be set.
   */
  public void setDerivationParameter(const float &derivationParameter)
  {
    MTP_ViewFaceplateSettings::getViewModel().setDerivationParameter(derivationParameter);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _txtP = MTP_ViewFaceplateSettings::extractShape("_txtP");
    _txtTd = MTP_ViewFaceplateSettings::extractShape("_txtTd");
    _txtTi = MTP_ViewFaceplateSettings::extractShape("_txtTi");
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
