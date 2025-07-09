// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/PIDCtrl/PIDCtrl"
#uses "classes/MtpView/MtpViewBase"

class PIDCtrlFaceplateHome : MtpViewBase
{
  private shape _refWqc;
  private shape _rectAutomatic;
  private shape _rectError;
  private shape _rectInternal;
  private shape _rectManual;
  private shape _rectOff;
  private shape _rectOperator;
  private shape _txtError;
  private shape _txtMV;
  private shape _txtPV;
  private shape _txtSP;
  private shape _txtUnitMV;
  private shape _txtUnitPV;
  private shape _txtUnitSP;
  private shape _txtValueInternal;
  private shape _txtValueManual;

  public PIDCtrlFaceplateHome(shared_ptr<PIDCtrl> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
  }

  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtMV = MtpViewBase::extractShape("_txtMV");
    _txtPV = MtpViewBase::extractShape("_txtPV");
    _txtSP = MtpViewBase::extractShape("_txtSP");
    _txtUnitMV = MtpViewBase::extractShape("_txtUnitMV");
    _txtUnitPV = MtpViewBase::extractShape("_txtUnitPV");
    _txtUnitSP = MtpViewBase::extractShape("_txtUnitSP");
    _txtValueInternal = MtpViewBase::extractShape("_txtValueInternal");
    _txtValueManual = MtpViewBase::extractShape("_txtValueManual");
  }
};
