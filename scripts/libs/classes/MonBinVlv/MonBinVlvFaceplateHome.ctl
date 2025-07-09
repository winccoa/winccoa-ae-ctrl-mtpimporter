// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonBinVlv/MonBinVlv"
#uses "classes/MtpView/MtpViewBase"

class MonBinVlvFaceplateHome : MtpViewBase
{
  private shape _refWqc;
  private shape _rectAutomatic;
  private shape _rectError;
  private shape _rectErrorInformation;
  private shape _rectLock;
  private shape _rectMaintenance;
  private shape _rectOff;
  private shape _rectOperator;
  private shape _rectPermission;
  private shape _rectProtection;
  private shape _rectReset;
  private shape _rectSafetyPosition;
  private shape _rectSafetyPositionInformation;
  private shape _rectValve;
  private shape _rectValveClose;
  private shape _rectValveOpen;
  private shape _txtError;
  private shape _txtLock;
  private shape _txtMaintenance;
  private shape _txtPermission;
  private shape _txtProtection;
  private shape _txtSafetyPosition;

  public MonBinVlvFaceplateHome(shared_ptr<MonBinVlv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
  }

  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectErrorInformation = MtpViewBase::extractShape("_rectErrorInformation");
    _rectLock = MtpViewBase::extractShape("_rectLock");
    _rectMaintenance = MtpViewBase::extractShape("_rectMaintenance");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _rectPermission = MtpViewBase::extractShape("_rectPermission");
    _rectProtection = MtpViewBase::extractShape("_rectProtection");
    _rectReset = MtpViewBase::extractShape("_rectReset");
    _rectSafetyPosition = MtpViewBase::extractShape("_rectSafetyPosition");
    _rectSafetyPositionInformation = MtpViewBase::extractShape("_rectSafetyPositionInformation");
    _rectValve = MtpViewBase::extractShape("_rectValve");
    _rectValveClose = MtpViewBase::extractShape("_rectValveClose");
    _rectValveOpen = MtpViewBase::extractShape("_rectValveOpen");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtLock = MtpViewBase::extractShape("_txtLock");
    _txtMaintenance = MtpViewBase::extractShape("_txtMaintenance");
    _txtPermission = MtpViewBase::extractShape("_txtPermission");
    _txtProtection = MtpViewBase::extractShape("_txtProtection");
    _txtSafetyPosition = MtpViewBase::extractShape("_txtSafetyPosition");
  }
};
