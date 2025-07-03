// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpView/MtpViewBase"
#uses "classes/BinMon/BinMon"

class BinMonFaceplateHome : MtpViewBase
{
  private shape _txtValue;
  private shape _rectValue;
  private shape _refWqc;
  private shape _rectFlutterActive;

  public BinMonFaceplateHome(shared_ptr<BinMon> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setValueCB, MtpViewBase::getViewModel(), BinMon::valueChanged);
    classConnect(this, setFlutterActiveCB, MtpViewBase::getViewModel(), BinMon::flutterActiveChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setValueCB(MtpViewBase::getViewModel().getValue());
    setFlutterActiveCB(MtpViewBase::getViewModel().getFlutterActive());
  }

  protected void initializeShapes()
  {
    _txtValue = MtpViewBase::extractShape("_txtValue");
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectValue = MtpViewBase::extractShape("_rectValue");
    _rectFlutterActive = MtpViewBase::extractShape("_rectFlutterActive");
  }

  private void setValueCB(const bool &value)
  {
    if (value)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
      _txtValue.text = MtpViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
      _txtValue.text = MtpViewBase::getViewModel().getValueStateFalseText();
    }
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  private void setFlutterActiveCB(const bool &active)
  {
    if (active)
    {
      _rectFlutterActive.fill = "[pattern,[fit,any,MTP_Icones/Mainenance.svg]]";
      _rectFlutterActive.sizeAsDyn = makeDynInt(25, 25);
    }
    else
    {
      _rectFlutterActive.fill = "[pattern,[fit,any,MTP_Icones/Ok.svg]]";
      _rectFlutterActive.sizeAsDyn = makeDynInt(30, 25);
    }
  }

};
