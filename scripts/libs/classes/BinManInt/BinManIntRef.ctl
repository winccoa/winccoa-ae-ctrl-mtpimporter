// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/BinManInt/BinManInt"
#uses "classes/MtpView/MtpViewRef"

class BinManIntRef : MtpViewRef
{
  private shape _rectValue;
  private shape _rectStatus;

  private bool _manualActive;
  private bool _internalActive;

  public BinManIntRef(shared_ptr<BinManInt> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MtpViewRef::getViewModel(), BinManInt::valueOutChanged);
    classConnectUserData(this, setStatusCB, "_manualActive", MtpViewRef::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setStatusCB, "_internalActive", MtpViewRef::getViewModel().getSource(), MtpSource::internalActiveChanged);

    setValueCB(MtpViewRef::getViewModel().getValueOut());
    setStatusCB("_manualActive", MtpViewRef::getViewModel().getSource().getManualActive());
    setStatusCB("_internalActive", MtpViewRef::getViewModel().getSource().getInternalActive());
  }

  protected void initializeShapes() override
  {
    _rectValue = MtpViewRef::extractShape("_rectValue");
    _rectStatus = MtpViewRef::extractShape("_rectStatus");
  }

  private void setValueCB(const bool &value)
  {
    if (value)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
    }
  }

  private void setStatusCB(const string &varName, const bool &active)
  {
    switch (varName)
    {
      case "_manualActive":
        _manualActive = active;
        break;

      case "_internalActive":
        _internalActive = active;
        break;
    }

    if (!MtpViewRef::getViewModel().getSource().getChannel() && _manualActive)
    {
      _rectStatus.fill = "[pattern,[tile,any,MTP_Icones/Manual_1.svg]]";
      return;
    }

    if (!MtpViewRef::getViewModel().getSource().getChannel() && _internalActive)
    {
      _rectStatus.fill = "[pattern,[tile,any,MTP_Icones/internal.svg]]";
      return;
    }

    _rectStatus.fill = "[pattern,[tile,any,MTP_Icones/disabled.svg]]";
  }

};
