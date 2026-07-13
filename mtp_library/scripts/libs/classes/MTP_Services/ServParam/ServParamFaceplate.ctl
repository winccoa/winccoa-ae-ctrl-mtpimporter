// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_Ref/MTP_RefBase"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_Services/ServParam/ServParamBase"

/**
 * @class ServParamFaceplate
 * @brief Represents the ServParamFaceplate class.
 */
class ServParamFaceplate : MTP_RefBase
{
  private vector<shared_ptr<ServParamBase> > _params; //!< List of service parameters to be displayed in the faceplate.
  private vector<shape> _paramsShapes; //!< List of shapes representing parameter rows in the panel.
  private string _layout = "Layout"; //!< The layout name used for adding parameter symbols to the panel.
  private shape _panel; //!< Reference to the main panel containing parameter shapes.

  /**
   * @brief Constructor for ServParamFaceplate.
   *
   * @param params A vector of shared pointers to ServParamBase objects representing the parameters.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServParamFaceplate(vector<shared_ptr<ServParamBase> > params, const mapping &shapes) : MTP_RefBase(shapes)
  {
    _params = params;
    initializeTable();
  }

  /**
   * @brief Applies changes to all parameter shapes in the faceplate.
   */
  public void applyAll()
  {
    for (int i = 0; i < _paramsShapes.count(); i++)
    {
      _paramsShapes.at(i).applyRow();
    }
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  private void initializeShapes()
  {
    _panel = MTP_RefBase::extractShape("_panel");
  }

  /**
   * @brief Initializes the parameter table with the provided parameters.
   */
  private void initializeTable()
  {
    int size = _params.count();

    for (int i = 0; i < size; i++)
    {
      appendParam(i, _params.at(i));
    }
  }

  /**
   * @brief Appends a parameter to the table at the specified row.
   *
   * @param rowNumber The row index where the parameter shape is added.
   * @param param The parameter object to be displayed.
   */
  private void appendParam(const int &rowNumber, shared_ptr<ServParamBase> param)
  {
    string referencePanel  = "";

    switch (getType(param.getValueFeedback()))
    {
      case BOOL_VAR:
        referencePanel = "objects/MTP_ServicesCfl/ServiceParamBoolean.xml";
        break;

      case STRING_VAR:
        referencePanel = "objects/MTP_ServicesCfl/ServiceParamString.xml";
        break;

      case INT_VAR:
        referencePanel = "objects/MTP_ServicesCfl/ServiceParamInt.xml";
        break;

      case FLOAT_VAR:
        referencePanel = "objects/MTP_ServicesCfl/ServiceParamFloat.xml";
        break;
    }

    addSymbol(_panel, referencePanel, rowNumber, rowNumber, _layout, makeDynString());
    shape paramShape = getShape(_panel, rowNumber);
    _paramsShapes.append(paramShape);
    invokeMethod(paramShape, "initialize", param);
  }
};
