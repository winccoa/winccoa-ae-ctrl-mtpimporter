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

/**
 * @class ServParamBooleanRef
 * @brief Manages the reference faceplate for a boolean service parameter.
 */
class ServParamBooleanRef : MtpRefBase
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
   * @details Initializes the faceplate by setting up the parameter reference, connecting callbacks for value and quality changes, and updating the UI with initial values.
   *
   * @param param A shared pointer to the ServParamBase object representing the boolean parameter.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServParamBooleanRef(shared_ptr<ServParamBase> param, const mapping &shapes) : MtpRefBase(shapes)
  {
    assignPtr(_param, param);
    classConnect(this, setCurrentCB, param, ServParamBase::valueOutputChanged);
    classConnect(this, setRequestedCB, param, ServParamBase::valueOperatorChanged);
    classConnect(this, setWqcCB, param.getWqc(), MtpQualityCode::qualityGoodChanged);
    setWqcCB(param.getWqc().getQualityGood());
    setCurrentCB(param.getValueOutput());
    setRequestedCB(param.getValueOperator());

    _txtName.text = param.getName();
  }

  /**
   * @brief Toggles the requested boolean value.
   * @details Changes the requested value state, updates the button text and background color, and reflects the new state in the UI.
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
   * @details Sets the requested value of the parameter based on the current button text.
   */
  public void apply()
  {
    _param.setValueOperator(_btnBool.text);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details Overrides the base class method to extract required shapes for displaying the parameter name, value, status, and apply button.
   */
  private void initializeShapes()
  {
    _txtName = MtpRefBase::extractShape("_txtName");
    _btnBool = MtpRefBase::extractShape("_btnBool");
    _rectCurrent = MtpRefBase::extractShape("_rectCurrent");
    _rectStatus = MtpRefBase::extractShape("_rectStatus");
    _rectApply = MtpRefBase::extractShape("_rectApply");
  }

  /**
   * @brief Callback function to update the requested value state.
   * @details Updates the button text and background color based on the requested value change from the view model.
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
   * @details Updates the current value rectangle's fill pattern based on the current boolean value from the view model.
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
   * @details Updates the status rectangle's fill pattern based on the quality good status from the view model.
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
