// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimitFloat"
#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_AnaMon/MTP_AnaMon"

/**
 * @class MTP_AnaMonFaceplateHome
 * @brief Represents the MTP_AnaMonFaceplateHome class.
 */
class MTP_AnaMonFaceplateHome : MTP_ViewBase
{
  private shape _rectLimitHigh; //!< Reference to the high limit rectangle shape.
  private shape _rectLimitLow; //!< Reference to the low limit rectangle shape.
  private shape _txtLimitHigh; //!< Reference to the high limit text shape.
  private shape _txtLimitLow; //!< Reference to the low limit text shape.

  private bool _alertHighActive; //!< Indicates if the alert high limit is active.
  private bool _warningHighActive; //!< Indicates if the warning high limit is active.
  private bool _toleranceHighActive; //!< Indicates if the tolerance high limit is active.
  private bool _toleranceLowActive; //!< Indicates if the tolerance low limit is active.
  private bool _warningLowActive; //!< Indicates if the warning low limit is active.
  private bool _alertLowActive; //!< Indicates if the alert low limit is active.

  private shared_ptr<MTP_BarIndicator> _barIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for MTP_AnaMonFaceplateHome.
   *
   * @param viewModel A shared pointer to the MTP_AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_AnaMonFaceplateHome(shared_ptr<MTP_AnaMon> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MTP_BarIndicator::setValueLimit, MTP_ViewBase::getViewModel(), MTP_AnaMon::valueChanged);
    classConnectUserData(this, setStatusHighCB, "_alertHighActive", MTP_ViewBase::getViewModel().getAlertHighLimit(), MTP_ValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusHighCB, "_warningHighActive", MTP_ViewBase::getViewModel().getWarningHighLimit(), MTP_ValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusHighCB, "_toleranceHighActive", MTP_ViewBase::getViewModel().getToleranceHighLimit(), MTP_ValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_toleranceLowActive", MTP_ViewBase::getViewModel().getToleranceLowLimit(), MTP_ValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_warningLowActive", MTP_ViewBase::getViewModel().getWarningLowLimit(), MTP_ValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_alertLowActive", MTP_ViewBase::getViewModel().getAlertLowLimit(), MTP_ValueLimitFloat::activeChanged);

    _alertHighActive = MTP_ViewBase::getViewModel().getAlertHighLimit().getActive();
    _warningHighActive = MTP_ViewBase::getViewModel().getWarningHighLimit().getActive();
    _toleranceHighActive = MTP_ViewBase::getViewModel().getToleranceHighLimit().getActive();
    _toleranceLowActive = MTP_ViewBase::getViewModel().getToleranceLowLimit().getActive();
    _warningLowActive = MTP_ViewBase::getViewModel().getWarningLowLimit().getActive();
    _alertLowActive = MTP_ViewBase::getViewModel().getAlertLowLimit().getActive();

    setStatusHighCB("_alertHighActive", MTP_ViewBase::getViewModel().getAlertHighLimit().getActive());
    setStatusLowCB("_alertLowActive", MTP_ViewBase::getViewModel().getAlertLowLimit().getActive());

    _barIndicator.showLimitIndicator();
    _barIndicator.setScale(MTP_ViewBase::getViewModel().getValueScaleMin(), MTP_ViewBase::getViewModel().getValueScaleMax());
    _barIndicator.setUnit(MTP_ViewBase::getViewModel().getUnit());

    _barIndicator.setAlertHighShape(MTP_ViewBase::getViewModel().getAlertHighLimit().getEnabled(), MTP_ViewBase::getViewModel().getAlertHighLimit().getLimit());
    _barIndicator.setWarningHighShape(MTP_ViewBase::getViewModel().getWarningHighLimit().getEnabled(), MTP_ViewBase::getViewModel().getWarningHighLimit().getLimit());
    _barIndicator.setToleranceHighShape(MTP_ViewBase::getViewModel().getToleranceHighLimit().getEnabled(), MTP_ViewBase::getViewModel().getToleranceHighLimit().getLimit());

    _barIndicator.setAlertLowShape(MTP_ViewBase::getViewModel().getAlertLowLimit().getEnabled(), MTP_ViewBase::getViewModel().getAlertLowLimit().getLimit());
    _barIndicator.setWarningLowShape(MTP_ViewBase::getViewModel().getWarningLowLimit().getEnabled(), MTP_ViewBase::getViewModel().getWarningLowLimit().getLimit());
    _barIndicator.setToleranceLowShape(MTP_ViewBase::getViewModel().getToleranceLowLimit().getEnabled(), MTP_ViewBase::getViewModel().getToleranceLowLimit().getLimit());

    _barIndicator.setValueLimit(MTP_ViewBase::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _rectLimitHigh = MTP_ViewBase::extractShape("_rectLimitHigh");
    _rectLimitLow = MTP_ViewBase::extractShape("_rectLimitLow");
    _txtLimitHigh = MTP_ViewBase::extractShape("_txtLimitHigh");
    _txtLimitLow = MTP_ViewBase::extractShape("_txtLimitLow");

    _barIndicator = MTP_ViewBase::extractShape("_barIndicator").getMtpBarIndicator();
  }

  /**
   * @brief Sets the status of the high limits based on the active state.
   *
   * @param varName The name of the variable to set.
   * @param active The active state of the limit.
   */
  private void setStatusHighCB(const string &varName, const bool &active)
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
    }

    if (_alertHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(30, 25);
      _txtLimitHigh.text =  getCatStr("MTP_AnaMon", "AlarmHigh");
      return;
    }

    if (_warningHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Mainenance_2.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text =  getCatStr("MTP_AnaMon", "WarningHigh");
      return;
    }

    if (_toleranceHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Tolerance_2.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text =  getCatStr("MTP_AnaMon", "ToleranceHigh");
      return;
    }

    _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
    _rectLimitHigh.sizeAsDyn = makeDynInt(30, 25);
    _txtLimitHigh.text =  getCatStr("MTP_AnaMon", "LimitHigh");

  }

  /**
   * @brief Sets the status of the low limit based on the active state.
   *
   * @param varName The name of the variable to set.
   * @param active The active state of the limit.
   */
  private void setStatusLowCB(const string &varName, const bool &active)
  {
    switch (varName)
    {
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

    if (_alertLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/StaticErr.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(30, 25);
      _txtLimitLow.text =  getCatStr("MTP_AnaMon", "AlarmLow");
      return;
    }

    if (_warningLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Mainenance_2.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = getCatStr("MTP_AnaMon", "WarningLow");
      return;
    }

    if (_toleranceLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Tolerance_2.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = getCatStr("MTP_AnaMon", "ToleranceLow");
      return;
    }

    _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
    _rectLimitLow.sizeAsDyn = makeDynInt(30, 25);
    _txtLimitLow.text = getCatStr("MTP_AnaMon", "LimitLow");
  }
};
