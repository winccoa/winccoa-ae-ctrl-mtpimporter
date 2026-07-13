// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_ProcessValueIn/MTP_BinProcessValueIn"

/**
 * @class MTP_BinProcessValueInFaceplateHome
 * @brief Faceplate controller for binary process value inputs.
 */
class MTP_BinProcessValueInFaceplateHome : MTP_ViewBase
{
  private shape _txtValue; //!< Current state label.
  private shape _rectValue; //!< Current state icon.
  private shape _btnTrue; //!< ON button.
  private shape _btnFalse; //!< OFF button.

  /**
   * @brief Constructor.
   *
   * @param viewModel Binary process value input model.
   * @param shapes Shape mapping.
   */
  public MTP_BinProcessValueInFaceplateHome(shared_ptr<MTP_BinProcessValueIn> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setValueCB, MTP_ViewBase::getViewModel(), MTP_BinProcessValueIn::valueChanged);
    setValueCB(MTP_ViewBase::getViewModel().getValue());
  }

  /**
   * @brief Writes TRUE.
   */
  public void setValueTrue()
  {
    MTP_ViewBase::getViewModel().setValue(true);
  }

  /**
   * @brief Writes FALSE.
   */
  public void setValueFalse()
  {
    MTP_ViewBase::getViewModel().setValue(false);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _txtValue = MTP_ViewBase::extractShape("_txtValue");
    _rectValue = MTP_ViewBase::extractShape("_rectValue");
    _btnTrue = MTP_ViewBase::extractShape("_btnTrue");
    _btnFalse = MTP_ViewBase::extractShape("_btnFalse");
  }

  /**
   * @brief Updates displayed value and button states.
   *
   * @param value Current binary value.
   */
  private void setValueCB(const bool &value)
  {
    if (value)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
      _txtValue.text = MTP_ViewBase::getViewModel().getValueStateTrueText();
      _btnTrue.backCol = "mtpTitlebar";
      _btnFalse.backCol = "mtpBorder";
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _txtValue.text = MTP_ViewBase::getViewModel().getValueStateFalseText();
      _btnTrue.backCol = "mtpBorder";
      _btnFalse.backCol = "mtpTitlebar";
    }
  }
};
