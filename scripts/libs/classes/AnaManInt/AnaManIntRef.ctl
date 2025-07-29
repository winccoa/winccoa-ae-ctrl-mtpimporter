// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/AnaManInt/AnaManInt"
#uses "classes/MtpView/MtpViewRef"

/**
 * @class AnaManIntRef
 * @brief Represents the reference implementation for the AnaManInt objects.
 */
class AnaManIntRef : MtpViewRef
{
  private shape _rectLimit; //!< Reference to the limit rectangle shape.
  private shape _rectSource; //!< Reference to the source rectangle shape.
  private shape _txtUnit; //!< Reference to the unit text shape.
  private shape _txtValue; //!< Reference to the value text shape.

  private bool _sourceManualActive; //!< Indicates if the manual source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal source is active.
  private bool _sourceChannel; //!< Indicates if the channel source is active.

  private float _valueMin; //!< Minimum value for the reference.
  private float _valueMax; //!< Maximum value for the reference.

  /**
   * @brief Constructor for AnaManIntRef.
   *
   * @param viewModel A shared pointer to the AnaManInt view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public AnaManIntRef(shared_ptr<AnaManInt> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setValueOutCB, MtpViewRef::getViewModel(), AnaManInt::valueOutChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MtpViewRef::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MtpViewRef::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceChannel", MtpViewRef::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setValueMinMaxCB, "_valueMin", MtpViewRef::getViewModel(),  AnaManInt::valueMinChanged);
    classConnectUserData(this, setValueMinMaxCB, "_valueMax", MtpViewRef::getViewModel(),  AnaManInt::valueMaxChanged);

    _sourceManualActive = MtpViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MtpViewRef::getViewModel().getSource().getInternalActive();
    _sourceChannel = MtpViewRef::getViewModel().getSource().getChannel();

    _valueMin = MtpViewRef::getViewModel().getValueMin();
    _valueMax = MtpViewRef::getViewModel().getValueMax();

    setUnit(MtpViewRef::getViewModel().getValueUnit());
    setValueOutCB(MtpViewRef::getViewModel().getValueOut());
    setSourceCB("_sourceManualActive", _sourceManualActive);
    setValueMinMaxCB("_valueMin", _valueMin);
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  * @details This method overrides the base class method to extract the shapes.
  */
  protected void initializeShapes() override
  {
    _rectLimit = MtpViewRef::extractShape("_rectLimit");
    _rectSource = MtpViewRef::extractShape("_rectSource");
    _txtUnit = MtpViewRef::extractShape("_txtUnit");
    _txtValue = MtpViewRef::extractShape("_txtValue");
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
   * @brief Sets the output value for the reference.
   *
   * @param valueOut The float value to be set.
   */
  private void setValueOutCB(const float &valueOut)
  {
    _txtValue.text = valueOut;
  }

  /**
   * @brief Sets the source status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param source The source state to be set.
   */
  private void setSourceCB(const string &varName, const bool &source)
  {
    switch (varName)
    {
      case "_sourceManualActive":
        _sourceManualActive = source;
        break;

      case "_sourceInternalActive":
        _sourceInternalActive = source;
        break;

      case "_sourceChannel":
        _sourceChannel = source;
        break;
    }

    if (_sourceManualActive && !_sourceChannel)
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/Manual__2.svg]]";
      _rectSource.visible = TRUE;
      return;
    }
    else if (_sourceInternalActive && !_sourceChannel)
    {
      _rectSource.fill = "[pattern,[fit,any,MTP_Icones/internal.svg]]";
      _rectSource.visible = TRUE;
    }
    else
    {
      _rectSource.visible = FALSE;
    }
  }

  /**
   * @brief Sets the minimum or maximum value for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param minMax The minimum or maximum value to be set.
   */
  private void setValueMinMaxCB(const string &varName, const float &minMax)
  {
    switch (varName)
    {
      case "_valueMin":
        _valueMin = minMax;
        break;

      case "_valueMax":
        _valueMax = minMax;
        break;
    }

    if (_valueMin == 1 || _valueMax == 1)
    {
      _rectLimit.fill = "[pattern,[fit,any,MTP_Icones/Tolerance.svg]]";
      _rectLimit.visible = TRUE;
      return;
    }
    else
    {
      _rectLimit.visible = FALSE;
    }
  }
};
