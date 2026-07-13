// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaMan/MTP_AnaMan"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_AnaManRef
 * @brief Represents the MTP_AnaManRef class.
 */
class MTP_AnaManRef : MTP_ViewRef
{
  protected shape _rectLimit; //!< Reference to the limit rectangle shape.
  protected shape _txtUnit; //!< Reference to the unit text shape.
  protected shape _txtValue; //!< Reference to the value text shape.

  protected float _valueMin; //!< Minimum value for the reference.
  private float _valueMax; //!< Maximum value for the reference.

  /**
   * @brief Constructor for MTP_AnaManRef.
   *
   * @param viewModel A shared pointer to the MTP_AnaMan view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_AnaManRef(shared_ptr<MTP_AnaMan> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setValueOutCB, MTP_ViewRef::getViewModel(), MTP_AnaMan::valueOutChanged);

    classConnectUserData(this, setValueMinMaxCB, "_valueMin", MTP_ViewRef::getViewModel(), MTP_AnaMan::valueMinChanged);
    classConnectUserData(this, setValueMinMaxCB, "_valueMax", MTP_ViewRef::getViewModel(), MTP_AnaMan::valueMaxChanged);

    _valueMin = MTP_ViewRef::getViewModel().getValueMin();
    _valueMax = MTP_ViewRef::getViewModel().getValueMax();

    setUnit(MTP_ViewRef::getViewModel().getValueUnit());
    setValueOutCB(MTP_ViewRef::getViewModel().getValueOut());
    setValueMinMaxCB("_valueMin", _valueMin);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _rectLimit = MTP_ViewRef::extractShape("_rectLimit");
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
