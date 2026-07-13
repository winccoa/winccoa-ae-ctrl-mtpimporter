// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_DIntMon/MTP_DIntMon"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_ValueLimit/MTP_ValueLimitDInt"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_DIntMonRef
 * @brief Represents the MTP_DIntMonRef class.
 */
class MTP_DIntMonRef : MTP_ViewRef
{
  protected shape _txtValue; //!< Reference to the value text shape.
  protected shape _txtUnit; //!< Reference to the unit text shape.
  protected shape _rectStatus; //!< Reference to the status rectangle shape.
  private bool _alertHighActive; //!< Indicates if the alert high limit is active.
  private bool _warningHighActive; //!< Indicates if the warning high limit is active.
  private bool _toleranceHighActive; //!< Indicates if the tolerance high limit is active.
  private bool _toleranceLowActive; //!< Indicates if the tolerance low limit is active.
  private bool _warningLowActive; //!< Indicates if the warning low limit is active.
  private bool _alertLowActive; //!< Indicates if the alert low limit is active.

  /**
   * @brief Constructor for the MTP_DIntMonRef object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_DIntMonRef object.
   */
  public MTP_DIntMonRef(shared_ptr<MTP_DIntMon> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnectUserData(this, setStatusCB, "_alertHighActive", MTP_ViewRef::getViewModel().getAlertHighLimit(), MTP_ValueLimitDInt::activeChanged);
    classConnectUserData(this, setStatusCB, "_warningHighActive", MTP_ViewRef::getViewModel().getWarningHighLimit(), MTP_ValueLimitDInt::activeChanged);
    classConnectUserData(this, setStatusCB, "_toleranceHighActive", MTP_ViewRef::getViewModel().getToleranceHighLimit(), MTP_ValueLimitDInt::activeChanged);
    classConnectUserData(this, setStatusCB, "_toleranceLowActive", MTP_ViewRef::getViewModel().getToleranceLowLimit(), MTP_ValueLimitDInt::activeChanged);
    classConnectUserData(this, setStatusCB, "_warningLowActive", MTP_ViewRef::getViewModel().getWarningLowLimit(), MTP_ValueLimitDInt::activeChanged);
    classConnectUserData(this, setStatusCB, "_alertLowActive", MTP_ViewRef::getViewModel().getAlertLowLimit(), MTP_ValueLimitDInt::activeChanged);
    classConnect(this, setValueCB, MTP_ViewRef::getViewModel(), MTP_DIntMon::valueChanged);

    _alertHighActive = MTP_ViewRef::getViewModel().getAlertHighLimit().getActive();
    _warningHighActive = MTP_ViewRef::getViewModel().getWarningHighLimit().getActive();
    _toleranceHighActive = MTP_ViewRef::getViewModel().getToleranceHighLimit().getActive();
    _toleranceLowActive = MTP_ViewRef::getViewModel().getToleranceLowLimit().getActive();
    _warningLowActive = MTP_ViewRef::getViewModel().getWarningLowLimit().getActive();

    setStatusCB("_alertLowActive", MTP_ViewRef::getViewModel().getAlertLowLimit().getActive());
    setUnit(MTP_ViewRef::getViewModel().getUnit());
    setValueCB(MTP_ViewRef::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _txtValue = MTP_ViewRef::extractShape("_txtValue");
    _txtUnit = MTP_ViewRef::extractShape("_txtUnit");
    _rectStatus = MTP_ViewRef::extractShape("_rectStatus");
  }

  /**
   * @brief Sets the unit for the reference.
   *
   * @param unit A shared pointer to the MTP_Unit object representing the unit.
   */
  protected void setUnit(shared_ptr<MTP_Unit> unit)
  {
    if (_txtUnit.enabled())
    {
      _txtUnit.text = unit.toString();
    }
  }

  /**
   * @brief Sets the value for the reference.
   *
   * @param value The integer value to be set.
   */
  protected void setValueCB(const int &value)
  {
    if (_txtValue.enabled())
    {
      _txtValue.text = value;
    }
  }

  /**
   * @brief Sets the status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param active The active state to be set.
   */
  protected void setStatusCB(const string &varName, const bool &active)
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

    if (_rectStatus.enabled())
    {
      if (_alertHighActive || _alertLowActive)
      {
        _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/Error.svg]]";
        _rectStatus.visible = TRUE;
        return;
      }

      if (_warningHighActive || _warningLowActive)
      {
        _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/Mainenance.svg]]";
        _rectStatus.visible = TRUE;
        return;
      }

      if (_toleranceHighActive || _toleranceLowActive)
      {
        _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/Tolerance.svg]]";
        _rectStatus.visible = TRUE;
        return;
      }
    }

    _rectStatus.visible = FALSE;
  }
};
