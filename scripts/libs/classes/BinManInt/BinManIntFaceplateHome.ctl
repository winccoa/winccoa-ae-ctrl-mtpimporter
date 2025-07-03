// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpView/MtpViewBase"
#uses "classes/BinManInt/BinManInt"

class BinManIntFaceplateHome : MtpViewBase
{
  private shape _txtValue;
  private shape _rectValue;
  private shape _refWqc;
  private shape _btnFalse;
  private shape _btnTrue;
  private shape _txtVFbk;
  private shape _rectManual;
  private shape _rectInternal;
  private shape _rectVInt;

  private bool _manualActive;
  private bool _internalActive;
  private bool _channel;
  private bool _valueOut;

  public BinManIntFaceplateHome(shared_ptr<BinManInt> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setValueOutCB, MtpViewBase::getViewModel(), BinManInt::valueOutChanged);
    classConnect(this, setValueFeedbackCB, MtpViewBase::getViewModel(), BinManInt::valueFeedbackChanged);
    classConnect(this, setValueInternalCB, MtpViewBase::getViewModel(), BinManInt::valueInternalChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);

    classConnect(this, setManualActiveCB, MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnect(this, setInternalActiveCB, MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setValueOutCB(MtpViewBase::getViewModel().getValueOut());
    setValueFeedbackCB(MtpViewBase::getViewModel().getValueFeedback());
    setValueInternalCB(MtpViewBase::getViewModel().getValueInternal());

    setManualActiveCB(_manualActive);
    setInternalActiveCB(_internalActive);
  }

  public void changeManual()
  {
    if (_manualActive)
    {
      MtpViewBase::getViewModel().getSource().setManualActive(false);
    }
    else
    {
      MtpViewBase::getViewModel().getSource().setManualActive(true);
    }
  }

  public void changeInternal()
  {
    if (_internalActive)
    {
      MtpViewBase::getViewModel().getSource().setInternalActive(false);
    }
    else
    {
      MtpViewBase::getViewModel().getSource().setInternalActive(true);
    }
  }

  public void changeValueOut()
  {
    if (_valueOut)
    {
      MtpViewBase::getViewModel().setValueOut(false);
    }
    else
    {
      MtpViewBase::getViewModel().setValueOut(true);
    }
  }

  protected void initializeShapes()
  {
    _txtValue = MtpViewBase::extractShape("_txtValue");
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectValue = MtpViewBase::extractShape("_rectValue");
    _btnTrue = MtpViewBase::extractShape("_btnTrue");
    _btnFalse = MtpViewBase::extractShape("_btnFalse");
    _txtVFbk = MtpViewBase::extractShape("_txtVFbk");
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _rectVInt = MtpViewBase::extractShape("_rectVInt");
  }

  private void setValueOutCB(const bool &value)
  {
    _valueOut = value;

    if (value)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
      _txtValue.text = MtpViewBase::getViewModel().getValueStateTrueText();

      _btnTrue.backCol = "mtpTitlebar";
      _btnFalse.backCol = "mtpBackground2";
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _txtValue.text = MtpViewBase::getViewModel().getValueStateFalseText();

      _btnTrue.backCol = "mtpBackground2";
      _btnFalse.backCol = "mtpTitlebar";
    }
  }

  private void setValueFeedbackCB(const bool &value)
  {
    if (value)
    {
      _txtVFbk.text = "true";
    }
    else
    {
      _txtVFbk.text = "false";
    }
  }

  private void setValueInternalCB(const bool &value)
  {
    if (value)
    {
      _rectVInt.visible = true;
    }
    else
    {
      _rectVInt.visible = false;
    }
  }

  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  private void setManual()
  {
    if (value)
    {
      _rectVInt.visible = true;
    }
    else
    {
      _rectVInt.visible = false;
    }
  }

  private void setManualActiveCB(const bool &manualActive)
  {
    _manualActive = manualActive;

    if (manualActive && !_channel)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }
  }

  private void setInternalActiveCB(const bool &internalActive)
  {
    _internalActive = internalActive;

    if (internalActive && !_channel)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_2_rounded.svg]]";
    }
    else
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_3_rounded.svg]]";
    }
  }
};
