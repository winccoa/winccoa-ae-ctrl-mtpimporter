// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpRef/MtpRefBase"
#uses "classes/Services/ServParam/ServParamBase"

class ServParamBooleanRef : MtpRefBase
{
  private shared_ptr<ServParamBase> _param;
  private shape _txtName;
  private shape _btnBool;
  private shape _rectCurrent;
  private shape _rectStatus;
  private shape _rectApply;

  private bool _required;

  public ServParamBooleanRef(shared_ptr<ServParamBase> param, const mapping &shapes) : MtpRefBase(shapes)
  {
    assignPtr(_param, param);
    classConnect(this, setCurrentCB, param, ServParamBase::valueFeedbackChanged);
    classConnect(this, setRequestedCB, param, ServParamBase::valueRequestedChanged);
    classConnect(this, setWqcCB, param.getWqc(), MtpQualityCode::qualityGoodChanged);
    setWqcCB(param.getWqc().getQualityGood());
    setCurrentCB(param.getValueFeedback());
    setRequestedCB(param.getValueRequested());

    _txtName.text = param.getName();
  }

  public void changeValue()
  {
    if (_required)
    {
      _required = false;
      _btnBool.text = "false";
      btnBool.backCol = "mtpSidebar";
    }
    else
    {
      _required = true;
      _btnBool.text = "true";
      btnBool.backCol = "mtpGreen";
    }
  }

  public void setRequestedCB(const bool &value)
  {
    if (value)
    {
      _required = true;
      _btnBool.text = "true";
      btnBool.backCol = "mtpGreen";
    }
    else
    {
      _required = false;
      _btnBool.text = "false";
      btnBool.backCol = "mtpSidebar";
    }
  }

  public void apply()
  {
    _param.setValueRequested(_btnBool.text);
  }

  private void initializeShapes()
  {
    _txtName = MtpRefBase::extractShape("_txtName");
    _btnBool = MtpRefBase::extractShape("_btnBool");
    _rectCurrent = MtpRefBase::extractShape("_rectCurrent");
    _rectStatus = MtpRefBase::extractShape("_rectStatus");
    _rectApply = MtpRefBase::extractShape("_rectApply");
  }

  private void setCurrentCB(const bool &value)
  {
    if (value)
    {
      _rectCurrent.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
    }
    else
    {
      _rectCurrent.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
    }
  }

  private void setWqcCB(const bool &value)
  {
    if (value)
    {
      _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/GreyOk.svg]]";
    }
    else
    {
      _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
    }
  }
};
