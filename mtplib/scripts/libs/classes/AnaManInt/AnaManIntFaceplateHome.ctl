// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpBarIndicator/MtpBarIndicator"
#uses "classes/AnaManInt/AnaManInt"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class AnaManIntFaceplateHome
 * @brief Represents the home faceplate for AnaManInt objects.
 */
class AnaManIntFaceplateHome : MtpViewBase
{
  private shape _refWqc; //!< Reference to the quality code shape.
  private shape _txtValueManual; //!< Reference to the manual value text shape.
  private shape _txtValueInternal; //!< Reference to the internal value text shape.
  private shape _txtFeedbackValue; //!< Reference to the feedback value text shape.
  private shape _rectManual; //!< Reference to the manual mode rectangle shape.
  private shape _rectInternal; //!< Reference to the internal mode rectangle shape.

  private bool _manualActive; //!< Indicates if the manual mode is active.
  private bool _internalActive; //!< Indicates if the internal mode is active.
  private bool _channel; //!< Indicates the channel state.
  private bool _osLevelStation; //!< Indicates the station-level operational state.

  private shared_ptr<MtpBarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for AnaManIntFaceplateHome.
   *
   * @param viewModel A shared pointer to the AnaManInt view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public AnaManIntFaceplateHome(shared_ptr<AnaManInt> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MtpBarIndicator::setValueCustomLimit, MtpViewBase::getViewModel(), AnaManInt::valueOutChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnect(this, setValueFeedbackCB, MtpViewBase::getViewModel(), AnaManInt::valueFeedbackChanged);
    classConnect(this, setValueInternalCB, MtpViewBase::getViewModel(), AnaManInt::valueInternalChanged);
    classConnect(this, setOsLevelCB, MtpViewBase::getViewModel().getOsLevel(), MtpOsLevel::osStationLevelChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MtpViewBase::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MtpViewBase::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MtpViewBase::getViewModel().getSource(), MtpSource::channelChanged);

    _manualActive =  MtpViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MtpViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MtpViewBase::getViewModel().getSource().getChannel();
    _osLevelStation = MtpViewBase::getViewModel().getOsLevel().getStationLevel();

    _refBarIndicator.setAlertHighShape(FALSE, MtpViewBase::getViewModel().getValueMax());
    _refBarIndicator.setAlertLowShape(FALSE, MtpViewBase::getViewModel().getValueMin());
    _refBarIndicator.setScale(MtpViewBase::getViewModel().getValueScaleMin(), MtpViewBase::getViewModel().getValueScaleMax());
    _refBarIndicator.setUnit(MtpViewBase::getViewModel().getValueUnit());

    setValueManualText(MtpViewBase::getViewModel().getValueManual());
    _refBarIndicator.setValueCustomLimit(MtpViewBase::getViewModel().getValueOut());
    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setUnit(MtpViewBase::getViewModel().getValueUnit());
    setValueFeedbackCB(MtpViewBase::getViewModel().getValueFeedback());
    setValueInternalCB(MtpViewBase::getViewModel().getValueInternal());

    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setOsLevelCB(MtpViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates the manual mode.
   * @details Sets the manual operator state to true.
   */
  public void activateManual()
  {
    MtpViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  /**
   * @brief Activates the internal mode.
   * @details Sets the internal operator state to true.
   */
  public void activateInternal()
  {
    MtpViewBase::getViewModel().getSource().setInternalOperator(TRUE);
  }

  /**
   * @brief Sets the manual value for the view model.
   * @details Updates the manual value in the view model.
   *
   * @param valueManual The new manual value to set.
   */
  public void setValueManual(const float &valueManual)
  {
    MtpViewBase::getViewModel().setValueManual(valueManual);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the required shapes.
   */
  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectManual = MtpViewBase::extractShape("_rectManual");
    _rectInternal = MtpViewBase::extractShape("_rectInternal");
    _txtValueManual = MtpViewBase::extractShape("_txtValueManual");
    _txtValueInternal = MtpViewBase::extractShape("_txtValueInternal");
    _txtFeedbackValue = MtpViewBase::extractShape("_txtFeedbackValue");

    _refBarIndicator = MtpViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
  }

  /**
   * @brief Callback function to update the operational state level.
   *
   * @param oslevel The new operational state level.
   */
  private void setOsLevelCB(const bool &oslevel)
  {
    _osLevelStation = oslevel;

    setInternalActiveCB("", FALSE);
    setManualActiveCB("", FALSE);
  }

  /**
   * @brief Sets the unit for the bar indicator.
   *
   * @param unit A shared pointer to the MtpUnit instance.
   */
  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _refBarIndicator.setUnit(unit);
  }

  /**
   * @brief Sets the manual value text for the text shape.
   *
   * @param valueManual The manual value to display.
   */
  private void setValueManualText(const float &valueManual)
  {
    _txtValueManual.text = valueManual;
  }

  /**
   * @brief Callback function to update the feedback value text.
   *
   * @param value The new feedback value to display.
   */
  private void setValueFeedbackCB(const float &value)
  {
    _txtFeedbackValue.text = value;
  }

  /**
   * @brief Callback function to update the internal value text.
   *
   * @param valueInternal The new internal value to display.
   */
  private void setValueInternalCB(const float &valueInternal)
  {
    _txtValueInternal.text = valueInternal;
  }

  /**
   * @brief Callback function to update the quality code status.
   *
   * @param qualityGoodChanged Indicates if the quality good status has changed.
   */
  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
  }

  /**
   * @brief Callback function to update the internal active state and channel.
   *
   * @param varName The name of the variable to set.
   * @param internalActive The new internal active state or channel value.
   */
  private void setInternalActiveCB(const string &varName, const bool &internalActive)
  {
    switch (varName)
    {
      case "_internalActive":
        _internalActive = internalActive;
        break;

      case "_channel":
        _channel = internalActive;
        break;
    }

    if ((!_osLevelStation && _internalActive && !_channel) || (_internalActive && _channel))
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]";
    }
    else if (_osLevelStation && _internalActive && !_channel)
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_2_rounded.svg]]";
    }
    else
    {
      _rectInternal.fill = "[pattern,[fit,any,MTP_Icones/internal_3_rounded.svg]]";
    }

    _rectInternal.transparentForMouse = (_rectInternal.fill == "[pattern,[fit,any,MTP_Icones/internal_1_rounded.svg]]");
  }

  /**
   * @brief Callback function to update the manual active state and channel.
   *
   * @param varName The name of the variable to set.
   * @param manualActive The new manual active state or channel value.
   */
  private void setManualActiveCB(const string &varName, const bool &manualActive)
  {
    switch (varName)
    {
      case "_manualActive":
        _manualActive = manualActive;
        break;

      case "_channel":
        _channel = manualActive;
        break;
    }

    if ((!_osLevelStation && !_channel && _manualActive) || (_manualActive && _channel))
    {
      _txtValueManual.editable = FALSE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]";
    }
    else if (_osLevelStation && _manualActive && !_channel)
    {
      _txtValueManual.editable = TRUE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_2_rounded.svg]]";
    }
    else
    {
      _txtValueManual.editable = FALSE;
      _rectManual.fill = "[pattern,[fit,any,MTP_Icones/Manual_1_3_rounded.svg]]";
    }

    _rectManual.transparentForMouse = (_rectManual.fill == "[pattern,[fit,any,MTP_Icones/Manual_1_1_rounded.svg]]");
  }
};
