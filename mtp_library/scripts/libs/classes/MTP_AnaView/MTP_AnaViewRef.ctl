// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaView/MTP_AnaView"
#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_Unit/MTP_Unit"

/**
 * @class MTP_AnaViewRef
 * @brief Represents the MTP_AnaViewRef class.
 */
class MTP_AnaViewRef : MTP_ViewRef
{
  protected shape _txtValue; //!< Reference to the value text shape.
  protected shape _txtUnit; //!< Reference to the unit text shape.

  /**
   * @brief Constructor for the MTP_AnaViewRef object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_AnaViewRef object.
   */
  public MTP_AnaViewRef(shared_ptr<MTP_AnaView> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MTP_ViewRef::getViewModel(), MTP_AnaView::valueChanged);
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
   * @param value The float value to be set.
   */
  protected void setValueCB(const float &value)
  {
    if (_txtValue.enabled())
    {
      _txtValue.text = value;
    }
  }
};
