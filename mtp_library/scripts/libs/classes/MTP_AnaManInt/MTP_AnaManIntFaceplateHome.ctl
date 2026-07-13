// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_AnaManInt/MTP_AnaManInt"
#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_AnaManIntFaceplateHome
 * @brief Represents the MTP_AnaManIntFaceplateHome class.
 */
class MTP_AnaManIntFaceplateHome : MTP_ViewBase
{
  private shape _txtValueManual; //!< Reference to the manual value text shape.
  private shape _txtValueInternal; //!< Reference to the internal value text shape.
  private shape _txtFeedbackValue; //!< Reference to the feedback value text shape.
  private shape _rectManual; //!< Reference to the manual mode rectangle shape.
  private shape _rectInternal; //!< Reference to the internal mode rectangle shape.

  private bool _manualActive; //!< Indicates if the manual mode is active.
  private bool _internalActive; //!< Indicates if the internal mode is active.
  private bool _channel; //!< Indicates the channel state.
  private bool _osLevelStation; //!< Indicates the station-level operational state.

  private shared_ptr<MTP_BarIndicator> _refBarIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MTP_AnaManIntFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_AnaManInt view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_AnaManIntFaceplateHome(shared_ptr<MTP_AnaManInt> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_refBarIndicator, MTP_BarIndicator::setValueCustomLimit, MTP_ViewBase::getViewModel(), MTP_AnaManInt::valueOutChanged);
    classConnect(this, setValueFeedbackCB, MTP_ViewBase::getViewModel(), MTP_AnaManInt::valueFeedbackChanged);
    classConnect(this, setValueInternalCB, MTP_ViewBase::getViewModel(), MTP_AnaManInt::valueInternalChanged);
    classConnect(this, setOsLevelCB, MTP_ViewBase::getViewModel().getOsLevel(), MTP_OsLevel::osStationLevelChanged);

    classConnectUserData(this, setManualActiveCB, "_manualActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setManualActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    classConnectUserData(this, setInternalActiveCB, "_internalActive", MTP_ViewBase::getViewModel().getSource(), MTP_Source::internalActiveChanged);
    classConnectUserData(this, setInternalActiveCB, "_channel", MTP_ViewBase::getViewModel().getSource(), MTP_Source::channelChanged);

    _manualActive =  MTP_ViewBase::getViewModel().getSource().getManualActive();
    _internalActive =  MTP_ViewBase::getViewModel().getSource().getInternalActive();
    _channel =  MTP_ViewBase::getViewModel().getSource().getChannel();
    _osLevelStation = MTP_ViewBase::getViewModel().getOsLevel().getStationLevel();

    _refBarIndicator.setAlertHighShape(FALSE, MTP_ViewBase::getViewModel().getValueMax());
    _refBarIndicator.setAlertLowShape(FALSE, MTP_ViewBase::getViewModel().getValueMin());
    _refBarIndicator.setScale(MTP_ViewBase::getViewModel().getValueScaleMin(), MTP_ViewBase::getViewModel().getValueScaleMax());
    _refBarIndicator.setUnit(MTP_ViewBase::getViewModel().getValueUnit());

    setValueManualText(MTP_ViewBase::getViewModel().getValueManual());
    _refBarIndicator.setValueCustomLimit(MTP_ViewBase::getViewModel().getValueOut());
    setUnit(MTP_ViewBase::getViewModel().getValueUnit());
    setValueFeedbackCB(MTP_ViewBase::getViewModel().getValueFeedback());
    setValueInternalCB(MTP_ViewBase::getViewModel().getValueInternal());

    setManualActiveCB("_manualActive", _manualActive);
    setInternalActiveCB("_internalActive", _internalActive);
    setOsLevelCB(MTP_ViewBase::getViewModel().getOsLevel().getStationLevel());
  }

  /**
   * @brief Activates the manual mode.
   */
  public void activateManual()
  {
    MTP_ViewBase::getViewModel().getSource().setManualOperator(TRUE);
  }

  /**
   * @brief Activates the internal mode.
   */
  public void activateInternal()
  {
    MTP_ViewBase::getViewModel().getSource().setInternalOperator(TRUE);
  }

  /**
   * @brief Sets the manual value for the view model.
   *
   * @param valueManual The new manual value to set.
   */
  public void setValueManual(const float &valueManual)
  {
    MTP_ViewBase::getViewModel().setValueManual(valueManual);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _rectManual = MTP_ViewBase::extractShape("_rectManual");
    _rectInternal = MTP_ViewBase::extractShape("_rectInternal");
    _txtValueManual = MTP_ViewBase::extractShape("_txtValueManual");
    _txtValueInternal = MTP_ViewBase::extractShape("_txtValueInternal");
    _txtFeedbackValue = MTP_ViewBase::extractShape("_txtFeedbackValue");

    _refBarIndicator = MTP_ViewBase::extractShape("_refBarIndicator").getMtpBarIndicator();
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
   * @param unit A shared pointer to the MTP_Unit instance.
   */
  private void setUnit(shared_ptr<MTP_Unit> unit)
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
