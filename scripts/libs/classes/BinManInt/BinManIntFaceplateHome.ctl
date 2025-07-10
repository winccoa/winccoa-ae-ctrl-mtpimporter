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

    classConnectUserData(this, setManualActiveCB, "_manualActive", MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setValueManualCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);
    classConnectUserData(this, setValueManualCB, "_valueOut", MtpViewBase::getViewModel(), BinManInt::valueOutChanged);
    classConnectUserData(this, setValueManualCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();
    _valueOut = MtpViewBase::getViewModel().getValueOut();

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setValueOutCB(_valueOut);
    setValueFeedbackCB(MtpViewBase::getViewModel().getValueFeedback());
    setValueInternalCB(MtpViewBase::getViewModel().getValueInternal());

    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setValueManualCB("_valueOut", _valueOut);
  }

  public void changeManual()
  {
    MtpViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  public void changeInternal()
  {
    MtpViewBase::getViewModel().getSource().setInternalOperator(TRUE);
  }

  public void changeValueTrue()
  {
    MtpViewBase::getViewModel().setValueMan(true);
  }

  public void changeValueFalse()
  {
    MtpViewBase::getViewModel().setValueMan(false);
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

  private void setValueManualCB(const string &varName, const bool &valueManual)
  {
    switch (varName)
    {
      case "_channel":
        _channel = valueManual;
        break;

      case "_valueOut":
        _valueOut = valueManual;
        break;

      case "_internalActive":
        _internalActive = valueManual;
        break;
    }

    if (_channel && _internalActive && _valueOut)
    {
      _btnTrue.backCol = "mtpSidebar";
    }
    else if (!_channel && _internalActive && _valueOut)
    {
      _btnTrue.backCol = "mtpTitlebar";
    }
    else
    {
      _btnTrue.backCol = "mtpBorder";
    }

    _btnTrue.transparentForMouse = (_btnTrue.backCol == "mtpSidebar");

    if (_channel && _internalActive && !_valueOut)
    {
      _btnFalse.backCol = "mtpSidebar";
    }
    else if (!_channel && _internalActive && !_valueOut)
    {
      _btnFalse.backCol = "mtpTitlebar";
    }
    else
    {
      _btnFalse.backCol = "mtpBorder";
    }

    _btnFalse.transparentForMouse = (_btnFalse.backCol == "mtpSidebar");
  }

  private void setValueOutCB(const bool &value)
  {
    if (value)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
      _txtValue.text = MtpViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _txtValue.text = MtpViewBase::getViewModel().getValueStateFalseText();
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

  //TODO Linie
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

  private void setManualActiveCB(const string &varName, const bool &manualActive)
  {
    switch (varName)
    {
      case "_manualActive":
        _manualActive = manualActive;
        break;

      case "_channel":
        _channel = manualActive;
        break;
    }

    if (manualActive && !_channel)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else if (_manualActive && _channel)
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
    }
    else
    {
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]");
  }

  private void setInternalActiveCB(const string &varName, const bool &internalActive)
  {
    switch (varName)
    {
      case "_internalActive":
        _internalActive = internalActive;
        break;

      case "_channel":
        _channel = internalActive;
        break;
    }

    if (internalActive && !_channel)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_2_rounded.svg]]";
    }
    else if (internalActive && _channel)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]";
    }
    else
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_3_rounded.svg]]";
    }

    _rectInternal.transparentForMouse = (_rectInternal.fill == "[pattern,[fit,any,MTP_Icones/internal_2_rounded.svg]]");
  }
};
