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

class ServParamStringRef : MtpRefBase
{
  private shared_ptr<ServParamBase> _param;
  private shape _txtName;
  private shape _txtRequired;
  private shape _txtCurrent;
  private shape _rectStatus;
  private shape _rectApply;

  public ServParamStringRef(shared_ptr<ServParamBase> param, const mapping &shapes) : MtpRefBase(shapes)
  {
    assignPtr(_param, param);

    setWqcCB(_param.getWqc().getQualityGood());
    setCurrentCB(_param.getValueFeedback());
    classConnect(this, setCurrentCB, _param, ServParamBase::valueFeedbackChanged);
    classConnect(this, setWqcCB, _param.getWqc(), MtpQualityCode::qualityGoodChanged);

    _txtRequired.text = _param.getValueRequested();
    _txtName.text = _param.getName();
  }

  public void apply()
  {
    _param.setValueRequested(_txtRequired.text);
  }

  private void initializeShapes()
  {
    _txtName = MtpRefBase::extractShape("_txtName");
    _txtRequired = MtpRefBase::extractShape("_txtRequired");
    _txtCurrent = MtpRefBase::extractShape("_txtCurrent");
    _rectStatus = MtpRefBase::extractShape("_rectStatus");
    _rectApply = MtpRefBase::extractShape("_rectApply");
  }

  private void setCurrentCB(const string &value)
  {
    _txtCurrent.text = value;
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
