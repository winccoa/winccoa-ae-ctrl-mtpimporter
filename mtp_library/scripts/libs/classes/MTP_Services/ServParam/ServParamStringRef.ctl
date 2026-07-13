// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Ref/MTP_RefBase"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_Services/ServParam/ServParamBase"

/**
 * @class ServParamStringRef
 * @brief Represents the ServParamStringRef class.
 */
class ServParamStringRef : MTP_RefBase
{
  private shared_ptr<ServParamBase> _param; //!< Reference to the string service parameter object.
  private shape _txtName; //!< Reference to the text shape displaying the parameter name.
  private shape _txtRequired; //!< Reference to the text shape displaying the requested value.
  private shape _txtCurrent; //!< Reference to the text shape displaying the current value.
  private shape _rectStatus; //!< Reference to the rectangle shape indicating the quality status.
  private shape _rectApply; //!< Reference to the rectangle shape for applying the requested value.

  /**
   * @brief Constructor for ServParamStringRef.
   * @param param A shared pointer to the ServParamBase object representing the string parameter.
   *
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServParamStringRef(shared_ptr<ServParamBase> param, const mapping &shapes) : MTP_RefBase(shapes)
  {
    assignPtr(_param, param);

    classConnect(this, setCurrentCB, _param, ServParamBase::valueOutputChanged);
    classConnect(this, setWqcCB, _param.getWqc(), MTP_Wqc::qualityGoodChanged);
    setWqcCB(_param.getWqc().getQualityGood());
    setCurrentCB(_param.getValueOutput());

    _txtRequired.text = _param.getValueOperator();
    _txtName.text = _param.getName();
  }

  /**
   * @brief Applies the requested value to the parameter.
   */
  public void apply()
  {
    _param.setValueOperator(_txtRequired.text);
    _param.setApplyOperator(true);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  private void initializeShapes()
  {
    _txtName = MTP_RefBase::extractShape("_txtName");
    _txtRequired = MTP_RefBase::extractShape("_txtRequired");
    _txtCurrent = MTP_RefBase::extractShape("_txtCurrent");
    _rectStatus = MTP_RefBase::extractShape("_rectStatus");
    _rectApply = MTP_RefBase::extractShape("_rectApply");
  }

  /**
   * @brief Callback function to update the current value display.
   *
   * @param value The current string value.
   */
  private void setCurrentCB(const string &value)
  {
    _txtCurrent.text = value;
  }

  /**
   * @brief Callback function to update the quality status icon.
   *
   * @param value The new quality good status.
   */
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
