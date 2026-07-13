// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_ProcessValueIn/MTP_AnaProcessValueIn"

/**
 * @class MTP_AnaProcessValueInFaceplateHome
 * @brief Faceplate controller for analog process value inputs.
 */
class MTP_AnaProcessValueInFaceplateHome : MTP_ViewBase
{
  private shared_ptr<MTP_BarIndicator> _barIndicator; //!< Gauge widget.
  private shape _txtCurrent; //!< Current value input field.

  /**
   * @brief Constructor.
   *
   * @param viewModel Analog process value input model.
   * @param shapes Shape mapping.
   */
  public MTP_AnaProcessValueInFaceplateHome(shared_ptr<MTP_AnaProcessValueIn> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MTP_BarIndicator::setValueLimit, MTP_ViewBase::getViewModel(), MTP_AnaProcessValueIn::valueChanged);
    classConnect(this, setCurrentValueCB, MTP_ViewBase::getViewModel(), MTP_AnaProcessValueIn::valueChanged);

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
    float value;

    if (sscanf(valueText, "%f", value) == 1)
    {
      MTP_ViewBase::getViewModel().setValue(value);
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
   * @param value Current analog value.
   */
  private void setCurrentValueCB(const float &value)
  {
    _txtCurrent.text = value;
  }
};
