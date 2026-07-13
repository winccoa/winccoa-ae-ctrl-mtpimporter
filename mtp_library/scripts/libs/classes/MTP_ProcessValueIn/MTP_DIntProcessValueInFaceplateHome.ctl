// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_ProcessValueIn/MTP_DIntProcessValueIn"

/**
 * @class MTP_DIntProcessValueInFaceplateHome
 * @brief Faceplate controller for DINT process value inputs.
 */
class MTP_DIntProcessValueInFaceplateHome : MTP_ViewBase
{
  private shared_ptr<MTP_BarIndicator> _barIndicator; //!< Gauge widget.
  private shape _txtCurrent; //!< Current value input field.

  /**
   * @brief Constructor.
   *
   * @param viewModel DINT process value input model.
   * @param shapes Shape mapping.
   */
  public MTP_DIntProcessValueInFaceplateHome(shared_ptr<MTP_DIntProcessValueIn> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MTP_BarIndicator::setValueLimit, MTP_ViewBase::getViewModel(), MTP_DIntProcessValueIn::valueChanged);
    classConnect(this, setCurrentValueCB, MTP_ViewBase::getViewModel(), MTP_DIntProcessValueIn::valueChanged);

    _barIndicator.makeIntegerBarIndicator();
    _barIndicator.setScale(MTP_ViewBase::getViewModel().getScaleMinCur(), MTP_ViewBase::getViewModel().getScaleMaxCur());
    _barIndicator.setUnit(MTP_ViewBase::getViewModel().getUnitCur());
    setCurrentValueCB(MTP_ViewBase::getViewModel().getValue());
    _barIndicator.setValueLimit(MTP_ViewBase::getViewModel().getValue());
  }

  /**
   * @brief Writes user-entered current value.
   *
   * @param valueText Entered text.
   */
  public void setCurrentValue(const string &valueText)
  {
    int parsedValue;

    if (sscanf(valueText, "%d", parsedValue) == 1)
    {
      MTP_ViewBase::getViewModel().setValue((int)parsedValue);
    }
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _barIndicator = MTP_ViewBase::extractShape("_barIndicator").getMtpBarIndicator();
    _txtCurrent = MTP_ViewBase::extractShape("_txtCurrent");
  }

  /**
   * @brief Updates displayed current value.
   *
   * @param value Current DINT value.
   */
  private void setCurrentValueCB(const int &value)
  {
    _txtCurrent.text = value;
  }
};
