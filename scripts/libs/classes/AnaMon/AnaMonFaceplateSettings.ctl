// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "classes/AnaMon/AnaMon"
#uses "classes/MtpView/MtpViewBase"

class AnaMonFaceplateSettings : MtpViewBase
{
  private shape _txtUnitAlert;
  private shape _txtUnitWarning;
  private shape _txtUnitTolerance;
  private shape _txtAlert;
  private shape _txtWarning;
  private shape _txtTolerance;
  private bool _init;

  public AnaMonFaceplateSettings(shared_ptr<AnaMon> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    setUnit(MtpViewBase::getViewModel().getUnit());
  }

  public void setAlertLimit(const float &alertLimit) = 0;

  public void setWarningLimit(const float &warningLimit) = 0;

  public void setToleranceLimit(const float &toleranceLimit) = 0;

  public void switchPage() = 0;

  protected void initializeShapes()
  {
    _txtUnitAlert = MtpViewBase::extractShape("_txtUnitAlert");
    _txtUnitWarning = MtpViewBase::extractShape("_txtUnitWarning");
    _txtUnitTolerance = MtpViewBase::extractShape("_txtUnitTolerance");
    _txtAlert = MtpViewBase::extractShape("_txtAlert");
    _txtWarning = MtpViewBase::extractShape("_txtWarning");
    _txtTolerance = MtpViewBase::extractShape("_txtTolerance");
    _init = TRUE;
  }

  protected bool getInit()
  {
    return _init;
  }

  protected shape getTxtAlert()
  {
    return _txtAlert;
  }

  protected shape getTxtWarning()
  {
    return _txtWarning;
  }

  protected shape getTxtTolerance()
  {
    return _txtTolerance;
  }

  protected void loadPanel(const string &fileName, const string &panelName)
  {
    string moduleName = myModuleName();

    if (isModuleOpen(moduleName) && !isPanelOpen(panelName, moduleName))
    {
      string uiDp = myUiDpName() + ".";

      dpSetWait(uiDp + "RootPanelOrigOn.ModuleName:_original.._value", moduleName,
                uiDp + "RootPanelOrigOn.FileName:_original.._value", fileName,
                uiDp + "RootPanelOrigOn.PanelName:_original.._value", panelName,
                uiDp + "RootPanelOrigOn.Parameter:_original.._value", makeDynString("$dp:" + MtpViewBase::getViewModel().getDp()));
    }
  }

  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtUnitAlert.text = unit.toString();
    _txtUnitWarning.text = unit.toString();
    _txtUnitTolerance.text = unit.toString();
  }
};
