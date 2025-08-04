// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpUnit/MtpUnit"
#uses "classes/MtpRef/MtpRefBase"

/**
 * @class MtpBarIndicator
 * @brief Represents a bar indicator for displaying values with alert, warning, and tolerance limits.
 */
class MtpBarIndicator : MtpRefBase
{
  private shape _txtValue; //!< Reference to the value text shape.
  private shape _txtUnit; //!< Reference to the unit text shape.

  private shape _body1; //!< Reference to the body shape.
  private shape _circleAH1; //!< Reference to the alert high circle shape.
  private shape _circleAL1; //!< Reference to the alert low circle shape.
  private shape _circlePV1; //!< Reference to the process value circle shape.
  private shape _circleTH1; //!< Reference to the tolerance high circle shape.
  private shape _circleTL1; //!< Reference to the tolerance low circle shape.
  private shape _circleWH1; //!< Reference to the warning high circle shape.
  private shape _circleWL1; //!< Reference to the warning low circle shape.

  private shape _body; //!< Reference to the body shape.
  private shape _circlePV; //!< Reference to the process value circle shape.
  private shape _circleValue; //!< Reference to the value circle shape.
  private shape _pvPointer; //!< Reference to the process value pointer shape.

  private shape _txtHalfMax; //!< Reference to the half max text shape.
  private shape _txtMax; //!< Reference to the max text shape.

  private float _value; //!< The current value to be displayed.
  private float _ahLimit; //!< The alert high limit value.
  private float _alLimit; //!< The alert low limit value.
  private float _whLimit; //!< The warning high limit value.
  private float _wlLimit; //!< The warning low limit value.
  private float _thLimit; //!< The tolerance high limit value.
  private float _tlLimit; //!< The tolerance low limit value.
  private bool _ahEnabled; //!< Indicates if the alert high limit is enabled.
  private bool _alEnabled; //!< Indicates if the alert low limit is enabled.
  private bool _whEnabled; //!< Indicates if the warning high limit is enabled.
  private bool _wlEnabled; //!< Indicates if the warning low limit is enabled.
  private bool _thEnabled; //!< Indicates if the tolerance high limit is enabled.
  private bool _tlEnabled; //!< Indicates if the tolerance low limit is enabled.
  private float _minV; //!< The minimum value for the scale.
  private float _maxV; //!< The maximum value for the scale.

  /**
   * @brief Constructor for MtpBarIndicator.
   *
   * @param shapes A mapping of shapes used in the bar indicator.
   */
  public MtpBarIndicator(const mapping &shapes) : MtpRefBase(shapes)
  {
  }

  /**
    * @brief Shows the limit indicator shapes.
    * @details Sets the visibility of all limit indicator shapes to true.
    */
  public void showLimitIndicator()
  {
    _body1.visible = TRUE;
    _circleAH1.visible = TRUE;
    _circleAL1.visible = TRUE;
    _circlePV1.visible = TRUE;
    _circleTH1.visible = TRUE;
    _circleTL1.visible = TRUE;
    _circleWH1.visible = TRUE;
    _circleWL1.visible = TRUE;
  }

  /**
  * @brief Shows the alarm limit indicator shapes.
  * @details Sets the visibility of alarm limit indicator shapes to true.
  */
  public void showAlarmLimitIndicator()
  {
    _body1.visible = TRUE;
    _circleAH1.visible = TRUE;
    _circleAL1.visible = TRUE;
    _circlePV1.visible = TRUE;
  }

  /**
     * @brief Sets the scale range for the bar indicator.
     * @details Updates the minimum and maximum scale values and sets the corresponding text shapes for half-maximum and maximum values.
     *
     * @param min The minimum value of the scale.
     * @param max The maximum value of the scale.
     */
  public void setScale(const float &min, const float &max)
  {
    _minV = min;
    _maxV = max;

    _txtHalfMax.text = (_minV + _maxV) / 2;
    _txtMax.text = max;
  }

  /**
     * @brief Sets the alert high limit shape properties.
     * @details Updates the alert high limit value and enables/disables the corresponding shape, adjusting its angle based on the scale.
     *
     * @param ahEnabled Indicates if the alert high limit is enabled.
     * @param ahLimit The alert high limit value.
     */
  public void setAlertHighShape(const bool &ahEnabled, const float &ahLimit)
  {
    _ahEnabled = ahEnabled;
    _ahLimit = ahLimit;
    _circleAH1.angle2 = (ahEnabled) ? ((calculateCircleDeg(ahLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(ahLimit, _minV, _maxV)) : 0;
  }

  /**
     * @brief Sets the warning high limit shape properties.
     * @details Updates the warning high limit value and enables/disables the corresponding shape, adjusting its angle based on the scale.
     *
     * @param whEnabled Indicates if the warning high limit is enabled.
     * @param whLimit The warning high limit value.
     */
  public void setWarningHighShape(const bool &whEnabled, const float &whLimit)
  {
    _whEnabled = whEnabled;
    _whLimit = whLimit;
    _circleWH1.angle2 = (whEnabled) ? ((calculateCircleDeg(whLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(whLimit, _minV, _maxV)) : 0;
  }

  /**
     * @brief Sets the tolerance high limit shape properties.
     * @details Updates the tolerance high limit value and enables/disables the corresponding shape, adjusting its angle based on the scale.
     *
     * @param thEnabled Indicates if the tolerance high limit is enabled.
     * @param thLimit The tolerance high limit value.
     */
  public void setToleranceHighShape(const bool &thEnabled, const float &thLimit)
  {
    _thEnabled = thEnabled;
    _thLimit = thLimit;
    _circleTH1.angle2 = (thEnabled) ? ((calculateCircleDeg(thLimit, _minV, _maxV) > 180) ? 180 : calculateCircleDeg(thLimit, _minV, _maxV)) : 0;
  }

  /**
     * @brief Sets the alert low limit shape properties.
     * @details Updates the alert low limit value and enables/disables the corresponding shape, adjusting its angle based on the scale.
     *
     * @param alEnabled Indicates if the alert low limit is enabled.
     * @param alLimit The alert low limit value.
     */
  public void setAlertLowShape(const bool &alEnabled, const float &alLimit)
  {
    _alEnabled = alEnabled;
    _alLimit = alLimit;
    _circleAL1.angle2 = 180;
    _circleAL1.angle1 = (alEnabled) ? ((calculateCircleDeg(alLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(alLimit, _minV, _maxV)) : 180;
  }

  /**
     * @brief Sets the warning low limit shape properties.
     * @details Updates the warning low limit value and enables/disables the corresponding shape, adjusting its angle based on the scale.
     *
     * @param wlEnabled Indicates if the warning low limit is enabled.
     * @param wlLimit The warning low limit value.
     */
  public void setWarningLowShape(const bool &wlEnabled, const float &wlLimit)
  {
    _wlEnabled = wlEnabled;
    _wlLimit = wlLimit;
    _circleWL1.angle2 = 180;
    _circleWL1.angle1 = (wlEnabled) ? ((calculateCircleDeg(wlLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(wlLimit, _minV, _maxV)) : 180;
  }

  /**
     * @brief Sets the tolerance low limit shape properties.
     * @details Updates the tolerance low limit value and enables/disables the corresponding shape, adjusting its angle based on the scale.
     *
     * @param tlEnabled Indicates if the tolerance low limit is enabled.
     * @param tlLimit The tolerance low limit value.
     */
  public void setToleranceLowShape(const bool &tlEnabled, const float &tlLimit)
  {
    _tlEnabled = tlEnabled;
    _tlLimit = tlLimit;
    _circleTL1.angle2 = 180;
    _circleTL1.angle1 = (tlEnabled) ? ((calculateCircleDeg(tlLimit, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(tlLimit, _minV, _maxV)) : 180;
  }

  /**
     * @brief Sets the current value for the bar indicator.
     * @details Updates the displayed value and adjusts the process value pointer and circle shapes based on the scale.
     *
     * @param value The current value to display.
     */
  public void setValue(const float &value)
  {
    _value = value;
    _txtValue.text = value;

    float clampedValue = value;

    if (clampedValue < _minV)
      clampedValue = _minV;

    if (clampedValue > _maxV)
      clampedValue = _maxV;

    _circlePV.angle2 = 180;
    _circleValue.angle2 = 180;
    _circleValue.angle1 = (_maxV != _minV) ? ((calculateCircleDeg(clampedValue, _minV, _maxV) < 0) ? 0 : calculateCircleDeg(clampedValue, _minV, _maxV)) : 180;

    _pvPointer.rotation = (calculatePvDeg(value, _minV, _maxV) < 180) ? 180 : calculatePvDeg(value, _minV, _maxV);
  }

  /**
   * @brief Sets the value with limit-based coloring.
   * @details Updates the value and sets the circle value background color based on alert, warning, or tolerance limits.
   *
   * @param value The current value to display.
   */
  public void setValueLimit(const float &value)
  {
    setValue(value);

    if ((_ahEnabled && value >= _ahLimit) || (_alEnabled && value <= _alLimit))
    {
      _circleValue.backCol = "mtpRed";
    }
    else if ((_whEnabled && value >= _whLimit) || (_wlEnabled && value <= _wlLimit))
    {
      _circleValue.backCol = "mtpYellow";
    }
    else if ((_thEnabled && value >= _thLimit) || (_tlEnabled && value <= _tlLimit))
    {
      _circleValue.backCol = "mtpGrey";
    }
    else
    {
      _circleValue.backCol = "mtpGreen";
    }
  }

  /**
   * @brief Sets the value with custom limit-based coloring.
   * @details Updates the value and sets the circle value background color based on custom alert limits.
   *
   * @param value The current value to display.
   */
  public void setValueCustomLimit(const float &value)
  {
    setValue(value);

    if (value > _ahLimit || value < _alLimit)
    {
      _circleValue.backCol = "mtpRed";
    }
    else
    {
      _circleValue.backCol = "mtpGreen";
    }
  }

  /**
     * @brief Sets the unit text for the bar indicator.
     * @details Updates the unit text shape with the string representation of the provided unit.
     *
     * @param unit A shared pointer to the MtpUnit object.
     */
  public void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtUnit.text = unit.toString();
  }

  /**
   * @brief Hides the unit text shape.
   * @details Sets the visibility of the unit text shape to false.
   */
  public void hideUnit()
  {
    _txtUnit.visible = FALSE;
  }

  /**
   * @brief Hides the value text shape.
   * @details Sets the visibility of the value text shape to false.
   */
  public void hideValue()
  {
    _txtValue.visible = FALSE;
  }


  /**
     * @brief Initializes the shapes for the bar indicator.
     * @details Overrides the base class method to extract the required shapes for the bar indicator.
     */
  protected void initializeShapes()
  {
    _body1 = MtpRefBase::extractShape("_body1");
    _circleAH1 = MtpRefBase::extractShape("_circleAH1");
    _circleAL1 = MtpRefBase::extractShape("_circleAL1");
    _circlePV1 = MtpRefBase::extractShape("_circlePV1");
    _circleTH1 = MtpRefBase::extractShape("_circleTH1");
    _circleTL1 = MtpRefBase::extractShape("_circleTL1");
    _circleWH1 = MtpRefBase::extractShape("_circleWH1");
    _circleWL1 = MtpRefBase::extractShape("_circleWL1");

    _body = MtpRefBase::extractShape("_body");
    _circlePV = MtpRefBase::extractShape("_circlePV");
    _circleValue = MtpRefBase::extractShape("_circleValue");
    _pvPointer = MtpRefBase::extractShape("_pvPointer");

    _txtHalfMax = MtpRefBase::extractShape("_txtHalfMax");
    _txtMax = MtpRefBase::extractShape("_txtMax");

    _txtValue = MtpRefBase::extractShape("_txtValue");
    _txtUnit = MtpRefBase::extractShape("_txtUnit");
  }

  /**
     * @brief Calculates the degree for the process value pointer.
     * @details Computes the rotation angle for the process value pointer based on the provided value and scale.
     *
     * @param value The current value.
     * @param minV The minimum scale value.
     * @param maxV The maximum scale value.
     * @return The calculated rotation angle in degrees.
     */
  private float calculatePvDeg(float value, float minV, float maxV)
  {
    if (minV - maxV != 0)
    {
      float pvk = (180.0 / (minV - maxV));
      float pvd = (360.0 - minV * pvk);
      return value * pvk + pvd;
    }
    else
    {
      return 0;
    }
  }

  /**
     * @brief Calculates the degree for the circle shapes.
     * @details Computes the angle for the limit circle shapes based on the provided value and scale.
     *
     * @param value The limit value.
     * @param minV The minimum scale value.
     * @param maxV The maximum scale value.
     * @return The calculated angle in degrees.
     */
  private float calculateCircleDeg(float value, float minV, float maxV)
  {
    if (minV - maxV != 0)
    {
      float ck = (180.0 / (minV - maxV));
      float cd = (180.0 - minV * ck);
      return value * ck + cd;
    }
    else
    {
      return 0;
    }
  }
};
