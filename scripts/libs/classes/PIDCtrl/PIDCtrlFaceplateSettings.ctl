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

class PIDCtrlFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _txtP;
  private shape _txtTd;
  private shape _txtTi;

  public PIDCtrlFaceplateSettings(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    _txtP.text = MtpViewFaceplateSettings::getViewModel().getProportionalParameter();
    _txtTd.text = MtpViewFaceplateSettings::getViewModel().getDerivationParameter();
    _txtTi.text = MtpViewFaceplateSettings::getViewModel().getIntegrationParameter();

    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  public void setProportionalParameter(const float &proportionalParameter)
  {
    MtpViewFaceplateSettings::getViewModel().setProportionalParameter(proportionalParameter);
  }

  public void setIntegrationParameter(const float &integrationParameter)
  {
    MtpViewFaceplateSettings::getViewModel().setIntegrationParameter(integrationParameter);
  }

  public void setDerivationParameter(const float &derivationParameter)
  {
    MtpViewFaceplateSettings::getViewModel().setDerivationParameter(derivationParameter);
  }

  protected void initializeShapes() override
  {
    _txtP = MtpViewFaceplateSettings::extractShape("_txtP");
    _txtTd = MtpViewFaceplateSettings::extractShape("_txtTd");
    _txtTi = MtpViewFaceplateSettings::extractShape("_txtTi");
  }

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
