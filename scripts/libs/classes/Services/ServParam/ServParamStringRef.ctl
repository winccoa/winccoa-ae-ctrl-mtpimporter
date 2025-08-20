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
 * @class ServParamStringRef
 * @brief Manages the reference faceplate for a string service parameter.
 */
class ServParamStringRef : MtpRefBase
{
  private shared_ptr<ServParamBase> _param; //!< Reference to the string service parameter object.
  private shape _txtName; //!< Reference to the text shape displaying the parameter name.
  private shape _txtRequired; //!< Reference to the text shape displaying the requested value.
  private shape _txtCurrent; //!< Reference to the text shape displaying the current value.
  private shape _rectStatus; //!< Reference to the rectangle shape indicating the quality status.
  private shape _rectApply; //!< Reference to the rectangle shape for applying the requested value.

  /**
   * @brief Constructor for ServParamStringRef.
   * @details Initializes the faceplate by setting up the parameter reference, connecting callbacks for value and quality changes, and updating the UI with initial values.
   * @param param A shared pointer to the ServParamBase object representing the string parameter.
   *
   * @param shapes A mapping of shapes used in the faceplate.
   */
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

  /**
   * @brief Applies the requested value to the parameter.
   * @details Sets the requested value of the parameter based on the current text in the _txtRequired shape.
   */
  public void apply()
  {
    _param.setValueRequested(_txtRequired.text);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details Overrides the base class method to extract required shapes for displaying the parameter name, requested value, current value, status, and apply button.
   */
  private void initializeShapes()
  {
    _txtName = MtpRefBase::extractShape("_txtName");
    _txtRequired = MtpRefBase::extractShape("_txtRequired");
    _txtCurrent = MtpRefBase::extractShape("_txtCurrent");
    _rectStatus = MtpRefBase::extractShape("_rectStatus");
    _rectApply = MtpRefBase::extractShape("_rectApply");
  }

  /**
   * @brief Callback function to update the current value display.
   * @details Updates the text of the current value shape based on the current string value from the view model.
   *
   * @param value The current string value.
   */
  private void setCurrentCB(const string &value)
  {
    _txtCurrent.text = value;
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
