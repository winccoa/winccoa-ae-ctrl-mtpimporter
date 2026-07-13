// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_AnaManInt/MTP_AnaManInt"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_AnaManIntRef
 * @brief Represents the MTP_AnaManIntRef class.
 */
class MTP_AnaManIntRef : MTP_ViewRef
{
  protected shape _rectLimit; //!< Reference to the limit rectangle shape.
  protected shape _rectSource; //!< Reference to the source rectangle shape.
  protected shape _txtUnit; //!< Reference to the unit text shape.
  protected shape _txtValue; //!< Reference to the value text shape.

  protected bool _sourceManualActive; //!< Indicates if the manual source is active.
  private bool _sourceInternalActive; //!< Indicates if the internal source is active.
  private bool _sourceChannel; //!< Indicates if the channel source is active.

  protected float _valueMin; //!< Minimum value for the reference.
  private float _valueMax; //!< Maximum value for the reference.

  /**
   * @brief Constructor for MTP_MTP_AnaManIntRef.
   *
   * @param viewModel A shared pointer to the MTP_AnaManInt view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_AnaManIntRef(shared_ptr<MTP_AnaManInt> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setValueOutCB, MTP_ViewRef::getViewModel(), MTP_AnaManInt::valueOutChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::internalActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceChannel", MTP_ViewRef::getViewModel().getSource(), MTP_Source::channelChanged);

    classConnectUserData(this, setValueMinMaxCB, "_valueMin", MTP_ViewRef::getViewModel(),  MTP_AnaManInt::valueMinChanged);
    classConnectUserData(this, setValueMinMaxCB, "_valueMax", MTP_ViewRef::getViewModel(),  MTP_AnaManInt::valueMaxChanged);

    _sourceManualActive = MTP_ViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MTP_ViewRef::getViewModel().getSource().getInternalActive();
    _sourceChannel = MTP_ViewRef::getViewModel().getSource().getChannel();

    _valueMin = MTP_ViewRef::getViewModel().getValueMin();
    _valueMax = MTP_ViewRef::getViewModel().getValueMax();

      setUnit(MTP_ViewRef::getViewModel().getValueUnit());
      setValueOutCB(MTP_ViewRef::getViewModel().getValueOut());
      setSourceCB("_sourceManualActive", _sourceManualActive);
      setValueMinMaxCB("_valueMin", _valueMin);
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  */
  protected void initializeShapes() override
  {
    _rectLimit = MTP_ViewRef::extractShape("_rectLimit");
    _rectSource = MTP_ViewRef::extractShape("_rectSource");
    _txtUnit = MTP_ViewRef::extractShape("_txtUnit");
    _txtValue = MTP_ViewRef::extractShape("_txtValue");
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
   * @brief Sets the output value for the reference.
   *
   * @param valueOut The float value to be set.
   */
  protected void setValueOutCB(const float &valueOut)
  {
    if (_txtValue.enabled())
    {
      _txtValue.text = valueOut;
    }
  }

  /**
   * @brief Sets the source status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param source The source state to be set.
   */
  protected void setSourceCB(const string &varName, const bool &source)
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

    if (_rectSource.enabled())
    {
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
  }

  /**
   * @brief Sets the minimum or maximum value for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param minMax The minimum or maximum value to be set.
   */
  protected void setValueMinMaxCB(const string &varName, const float &minMax)
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

    if (_rectLimit.enabled())
    {
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
  }
};
