// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/BinMon/BinMon"
#uses "classes/MtpView/MtpViewRef"

class BinMonRef : MtpViewRef
{
  private shape _rectValue;
  private shape _rectStatus;

  private bool _flutterActive;

  public BinMonRef(shared_ptr<BinMon> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MtpViewRef::getViewModel(), BinMon::valueChanged);
    classConnect(this, setStatusCB, MtpViewRef::getViewModel(), BinMon::flutterActiveChanged);

    setStatusCB(MtpViewRef::getViewModel().getFlutterActive());
    setValueCB(MtpViewRef::getViewModel().getValue());
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
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/Ok.svg]]";
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
    }
  }

  private void setStatusCB(const bool &active)
  {
    _rectStatus.visible = active;
  }
};
