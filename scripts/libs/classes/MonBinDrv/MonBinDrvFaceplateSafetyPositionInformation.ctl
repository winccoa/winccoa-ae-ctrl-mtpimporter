// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewBase"

class MonBinDrvFaceplateSafetyPositionInformation : MtpViewBase
{
  private shape _txtSafetyPosition;

  public MonBinDrvFaceplateSafetyPositionInformation(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, MtpViewBase::getViewModel(), MonBinDrv::safetyPositionChanged);

    setSafetyPositionCB(MtpViewBase::getViewModel().getSafetyPosition());
  }

  protected void initializeShapes()
  {
    _txtSafetyPosition = MtpViewBase::extractShape("_txtSafetyPosition");
  }

  private void setSafetyPositionCB(const bool &safetyPosition)
  {
    if (safetyPosition)
    {
      _txtSafetyPosition.text = getCatStr("MonBinDrv", "safetyPositionTrue");
    }
    else
    {
      _txtSafetyPosition.text = getCatStr("MonBinDrv", "safetyPositionFalse");
    }
  }

};
