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

class ServParamNumberRef : MtpRefBase
{
  private shared_ptr<ServParamBase> _param;
  private shape _txtName;
  private shape _txtRequired;
  private shape _txtCurrent;
  private shape _rectStatus;
  private shape _rectApply;

  public ServParamNumberRef(shared_ptr<ServParamBase> param, const mapping &shapes) : MtpRefBase(shapes)
  {
    assignPtr(_param, param);
    classConnect(this, setCurrentCB, param, ServParamBase::valueFeedbackChanged);
    classConnect(this, setWqcCB, param.getWqc(), MtpQualityCode::qualityGoodChanged);
    setWqcCB(param.getWqc().getQualityGood());
    setCurrentCB(param.getValueFeedback());

    _txtRequired.text = param.getValueRequested();
    _txtName.text = param.getName();
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

  private void setCurrentCB(const int &value)
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
