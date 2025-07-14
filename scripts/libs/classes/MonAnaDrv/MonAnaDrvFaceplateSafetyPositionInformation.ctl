// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MonAnaDrv/MonAnaDrv"
#uses "classes/MtpView/MtpViewBase"

class MonAnaDrvFaceplateSafetyPositionInformation : MtpViewBase
{
  private shape _txtSafetyPosition;

  public MonAnaDrvFaceplateSafetyPositionInformation(shared_ptr<MonAnaDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setSafetyPositionCB, MtpViewBase::getViewModel(), MonAnaDrv::safetyPositionChanged);

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
      _txtSafetyPosition.text = getCatStr("MonAnaDrv", "safetyPositionTrue");
    }
    else
    {
      _txtSafetyPosition.text = getCatStr("MonAnaDrv", "safetyPositionFalse");
    }
  }

};
