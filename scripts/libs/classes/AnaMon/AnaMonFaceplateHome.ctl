// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpBarIndicator/MtpBarIndicator"
#uses "classes/MtpValueLimit/MtpValueLimitFloat"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpUnit/MtpUnit"
#uses "classes/AnaMon/AnaMon"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class AnaMonFaceplateHome
 * @brief Represents the home faceplate for AnaMon objects.
 */
class AnaMonFaceplateHome : MtpViewBase
{
  private shape _refWqc; //!< Reference to the quality code shape.
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

  private shared_ptr<MtpBarIndicator> _barIndicator; //!< Reference to the bar indicator for displaying values.

  /**
   * @brief Constructor for AnaMonFaceplateHome.
   *
   * @param viewModel A shared pointer to the AnaMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public AnaMonFaceplateHome(shared_ptr<AnaMon> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(_barIndicator, MtpBarIndicator::setValueLimit, MtpViewBase::getViewModel(), AnaMon::valueChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);
    classConnectUserData(this, setStatusHighCB, "_alertHighActive", MtpViewBase::getViewModel().getAlertHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusHighCB, "_warningHighActive", MtpViewBase::getViewModel().getWarningHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusHighCB, "_toleranceHighActive", MtpViewBase::getViewModel().getToleranceHighLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_toleranceLowActive", MtpViewBase::getViewModel().getToleranceLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_warningLowActive", MtpViewBase::getViewModel().getWarningLowLimit(), MtpValueLimitFloat::activeChanged);
    classConnectUserData(this, setStatusLowCB, "_alertLowActive", MtpViewBase::getViewModel().getAlertLowLimit(), MtpValueLimitFloat::activeChanged);

    _alertHighActive = MtpViewBase::getViewModel().getAlertHighLimit().getActive();
    _warningHighActive = MtpViewBase::getViewModel().getWarningHighLimit().getActive();
    _toleranceHighActive = MtpViewBase::getViewModel().getToleranceHighLimit().getActive();
    _toleranceLowActive = MtpViewBase::getViewModel().getToleranceLowLimit().getActive();
    _warningLowActive = MtpViewBase::getViewModel().getWarningLowLimit().getActive();
    _alertLowActive = MtpViewBase::getViewModel().getAlertLowLimit().getActive();

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setStatusHighCB("_alertHighActive", MtpViewBase::getViewModel().getAlertHighLimit().getActive());
    setStatusLowCB("_alertLowActive", MtpViewBase::getViewModel().getAlertLowLimit().getActive());

    _barIndicator.showLimitIndicator();
    _barIndicator.setScale(MtpViewBase::getViewModel().getValueScaleMin(), MtpViewBase::getViewModel().getValueScaleMax());
    _barIndicator.setUnit(MtpViewBase::getViewModel().getUnit());

    _barIndicator.setAlertHighShape(MtpViewBase::getViewModel().getAlertHighLimit().getEnabled(), MtpViewBase::getViewModel().getAlertHighLimit().getLimit());
    _barIndicator.setWarningHighShape(MtpViewBase::getViewModel().getWarningHighLimit().getEnabled(), MtpViewBase::getViewModel().getWarningHighLimit().getLimit());
    _barIndicator.setToleranceHighShape(MtpViewBase::getViewModel().getToleranceHighLimit().getEnabled(), MtpViewBase::getViewModel().getToleranceHighLimit().getLimit());

    _barIndicator.setAlertLowShape(MtpViewBase::getViewModel().getAlertLowLimit().getEnabled(), MtpViewBase::getViewModel().getAlertLowLimit().getLimit());
    _barIndicator.setWarningLowShape(MtpViewBase::getViewModel().getWarningLowLimit().getEnabled(), MtpViewBase::getViewModel().getWarningLowLimit().getLimit());
    _barIndicator.setToleranceLowShape(MtpViewBase::getViewModel().getToleranceLowLimit().getEnabled(), MtpViewBase::getViewModel().getToleranceLowLimit().getLimit());

    _barIndicator.setValueLimit(MtpViewBase::getViewModel().getValue());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the table shape.
   */
  protected void initializeShapes() override
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectLimitHigh = MtpViewBase::extractShape("_rectLimitHigh");
    _rectLimitLow = MtpViewBase::extractShape("_rectLimitLow");
    _txtLimitHigh = MtpViewBase::extractShape("_txtLimitHigh");
    _txtLimitLow = MtpViewBase::extractShape("_txtLimitLow");

    _barIndicator = MtpViewBase::extractShape("_barIndicator").getMtpBarIndicator();
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
   * @brief Sets the status of the high and low limits based on the active state.
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
      _txtLimitHigh.text = "Alarm hoch";
      return;
    }

    if (_warningHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Mainenance_2.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text = "Warnung hoch";
      return;
    }

    if (_toleranceHighActive)
    {
      _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Tolerance_2.svg]]";
      _rectLimitHigh.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitHigh.text = "Toleranz hoch";
      return;
    }

    _rectLimitHigh.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
    _rectLimitHigh.sizeAsDyn = makeDynInt(30, 25);
    _txtLimitHigh.text = "Grenze hoch";

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
      _txtLimitLow.text = "Alarm niedrig";
      return;
    }

    if (_warningLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Mainenance_2.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = "Warnung niedrig";
      return;
    }

    if (_toleranceLowActive)
    {
      _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Tolerance_2.svg]]";
      _rectLimitLow.sizeAsDyn = makeDynInt(25, 25);
      _txtLimitLow.text = "Toleranz niedrig";
      return;
    }

    _rectLimitLow.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
    _rectLimitLow.sizeAsDyn = makeDynInt(30, 25);
    _txtLimitLow.text = "Grenze niedrig";
  }
};
