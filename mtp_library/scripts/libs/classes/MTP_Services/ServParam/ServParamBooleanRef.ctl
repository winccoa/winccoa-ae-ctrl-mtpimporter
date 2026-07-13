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
 * @class ServParamBooleanRef
 * @brief Represents the ServParamBooleanRef class.
 */
class ServParamBooleanRef : MTP_RefBase
{
  private shared_ptr<ServParamBase> _param; //!< Reference to the boolean service parameter object.
  private shape _txtName; //!< Reference to the text shape displaying the parameter name.
  private shape _btnBool; //!< Reference to the button shape for toggling the boolean value.
  private shape _rectCurrent; //!< Reference to the rectangle shape indicating the current value.
  private shape _rectStatus; //!< Reference to the rectangle shape indicating the quality status.
  private shape _rectApply; //!< Reference to the rectangle shape for applying the requested value.

  private bool _required; //!< Indicates the requested boolean value state.

  /**
   * @brief Constructor for ServParamBooleanRef.
   *
   * @param param A shared pointer to the ServParamBase object representing the boolean parameter.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServParamBooleanRef(shared_ptr<ServParamBase> param, const mapping &shapes) : MTP_RefBase(shapes)
  {
    assignPtr(_param, param);
    classConnect(this, setCurrentCB, param, ServParamBase::valueOutputChanged);
    classConnect(this, setRequestedCB, param, ServParamBase::valueOperatorChanged);
    classConnect(this, setWqcCB, param.getWqc(), MTP_Wqc::qualityGoodChanged);
    setWqcCB(param.getWqc().getQualityGood());
    setCurrentCB(param.getValueOutput());
    setRequestedCB(param.getValueOperator());

    _txtName.text = param.getName();
  }

  /**
   * @brief Toggles the requested boolean value.
   */
  public void changeValue()
  {
    if (_required)
    {
      _required = false;
      _btnBool.text = "false";
      _btnBool.backCol = "mtpSidebar";
    }
    else
    {
      _required = true;
      _btnBool.text = "true";
      _btnBool.backCol = "mtpGreen";
    }
  }

  /**
   * @brief Applies the requested value to the parameter.
   */
  public void apply()
  {
    _param.setValueOperator(_btnBool.text);
    _param.setApplyOperator(true);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  private void initializeShapes()
  {
    _txtName = MTP_RefBase::extractShape("_txtName");
    _btnBool = MTP_RefBase::extractShape("_btnBool");
    _rectCurrent = MTP_RefBase::extractShape("_rectCurrent");
    _rectStatus = MTP_RefBase::extractShape("_rectStatus");
    _rectApply = MTP_RefBase::extractShape("_rectApply");
  }

  /**
   * @brief Callback function to update the requested value state.
   *
   * @param value The new requested boolean value.
   */
  public void setRequestedCB(const bool &value)
  {
    if (value)
    {
      _required = true;
      _btnBool.text = "true";
      _btnBool.backCol = "mtpGreen";
    }
    else
    {
      _required = false;
      _btnBool.text = "false";
      _btnBool.backCol = "mtpSidebar";
    }
  }

  /**
   * @brief Callback function to update the current value icon.
   *
   * @param value The current boolean value.
   */
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
