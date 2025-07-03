// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/AnaMon/AnaMon"
#uses "classes/MtpView/MtpViewRef"
#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpUnit/MtpUnit"

/**
 * @class AnaMonRef
 * @brief Represents the reference implementation for the AnaMon objects.
 */
class AnaMonRef : MtpViewRef
{
  private shape _txtValue; //!< Reference to the value text shape.
  private shape _txtUnit; //!< Reference to the unit text shape.
  private shape _rectStatus; //!< Reference to the status rectangle shape.
  private bool _alertHighActive; //!< Indicates if the alert high limit is active.
  private bool _warningHighActive; //!< Indicates if the warning high limit is active.
  private bool _toleranceHighActive; //!< Indicates if the tolerance high limit is active.
  private bool _toleranceLowActive; //!< Indicates if the tolerance low limit is active.
  private bool _warningLowActive; //!< Indicates if the warning low limit is active.
  private bool _alertLowActive; //!< Indicates if the alert low limit is active.

  /**
   * @brief Constructor for AnaMonRef.
   *
   * @param viewModel A shared pointer to the AnaMon view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public AnaMonRef(shared_ptr<AnaMon> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnectUserData(this, setStatusCB, "_alertHighActive", MtpViewRef::getViewModel().getAlertHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_warningHighActive", MtpViewRef::getViewModel().getWarningHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_toleranceHighActive", MtpViewRef::getViewModel().getToleranceHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_toleranceLowActive", MtpViewRef::getViewModel().getToleranceLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_warningLowActive", MtpViewRef::getViewModel().getWarningLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusCB, "_alertLowActive", MtpViewRef::getViewModel().getAlertLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnect(this, setValueCB, MtpViewRef::getViewModel(), AnaMon::valueChanged);

    _alertHighActive = MtpViewRef::getViewModel().getAlertHighLimit().getActive();
    _warningHighActive = MtpViewRef::getViewModel().getWarningHighLimit().getActive();
    _toleranceHighActive = MtpViewRef::getViewModel().getToleranceHighLimit().getActive();
    _toleranceLowActive = MtpViewRef::getViewModel().getToleranceLowLimit().getActive();
    _warningLowActive = MtpViewRef::getViewModel().getWarningLowLimit().getActive();

    setStatusCB("_alertLowActive", MtpViewRef::getViewModel().getAlertLowLimit().getActive());
    setUnit(MtpViewRef::getViewModel().getUnit());
    setValueCB(MtpViewRef::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the table shape.
   */
  protected void initializeShapes() override
  {
    _txtValue = MtpViewRef::extractShape("_txtValue");
    _txtUnit = MtpViewRef::extractShape("_txtUnit");
    _rectStatus = MtpViewRef::extractShape("_rectStatus");
  }

  /**
   * @brief Sets the unit for the reference.
   *
   * @param unit A shared pointer to the MtpUnit object representing the unit.
   */
  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtUnit.text = unit.toString();
  }

  /**
   * @brief Sets the value for the reference.
   *
   * @param value The float value to be set.
   */
  private void setValueCB(const float &value)
  {
    _txtValue.text = value;
  }

  /**
   * @brief Sets the status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param active The active state to be set.
   */
  private void setStatusCB(const string &varName, const bool &active)
  {
    switch (varName)
    {
      case "_alertHighActive":
        _alertHighActive = active;
        break;

      case "_warningHighActive":
        _warningHighActive = active;
        break;

      case "_toleranceHighActive":
        _toleranceHighActive = active;
        break;

      case "_toleranceLowActive":
        _toleranceLowActive = active;
        break;

      case "_warningLowActive":
        _warningLowActive = active;
        break;

      case "_alertLowActive":
        _alertLowActive = active;
        break;
    }

    if (_alertHighActive || _alertLowActive)
    {
      _rectStatus.fill = "[pattern,[tile,any,MTP_Icones/Error.svg]]";
      _rectStatus.visible = TRUE;
      return;
    }

    if (_warningHighActive || _warningLowActive)
    {
      _rectStatus.fill = "[pattern,[tile,any,MTP_Icones/Mainenance.svg]]";
      _rectStatus.visible = TRUE;
      return;
    }

    if (_toleranceHighActive || _toleranceLowActive)
    {
      _rectStatus.fill = "[pattern,[tile,any,MTP_Icones/Tolerance.svg]]";
      _rectStatus.visible = TRUE;
      return;
    }

    _rectStatus.visible = FALSE;
  }
};
