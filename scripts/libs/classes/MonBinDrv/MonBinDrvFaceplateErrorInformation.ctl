// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewBase"

class MonBinDrvFaceplateErrorInformation : MtpViewBase
{
  private shape _txtDynamicTime;
  private shape _txtDynamicTimeValue;
  private shape _txtSafePosition;
  private shape _txtStaticTime;
  private shape _txtStaticTimeValue;

  public MonBinDrvFaceplateErrorInformation(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setSafePositionCB, MtpViewBase::getViewModel().getMonitor(), MtpMonitor::safePositionChanged);
    classConnect(this, setStaticTimeCB, MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticTimeChanged);
    classConnect(this, setDynamicTimeCB, MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicTimeChanged);

    setSafePositionCB(MtpViewBase::getViewModel().getMonitor().getSafePosition());
    setStaticTimeCB(MtpViewBase::getViewModel().getMonitor().getStaticTime());
    setDynamicTimeCB(MtpViewBase::getViewModel().getMonitor().getDynamicTime());
  }

  protected void initializeShapes()
  {
    _txtDynamicTime = MtpViewBase::extractShape("_txtDynamicTime");
    _txtDynamicTimeValue = MtpViewBase::extractShape("_txtDynamicTimeValue");
    _txtSafePosition = MtpViewBase::extractShape("_txtSafePosition");
    _txtStaticTime = MtpViewBase::extractShape("_txtStaticTime");
    _txtStaticTimeValue = MtpViewBase::extractShape("_txtStaticTimeValue");
  }

  private void setSafePositionCB(const bool &safePosition)
  {
    if (safePosition)
    {
      _txtSafePosition.text = getCatStr("MonBinDrv", "safePositionOn");
    }
    else
    {
      _txtSafePosition.text = getCatStr("MonBinDrv", "safePositionOff");
    }
  }

  private void setStaticTimeCB(const float &staticTime)
  {
    _txtStaticTimeValue.text = staticTime;
  }

  private void setDynamicTimeCB(const float &dynamicTime)
  {
    _txtDynamicTimeValue.text = dynamicTime;
  }

};
