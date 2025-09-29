// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpRef/MtpRefBase"
#uses "classes/Services/ServParam/ServParamBase"

/**
 * @class ServParamFaceplate
 * @brief Manages the faceplate for displaying and interacting with service parameters.
 */
class ServParamFaceplate : MtpRefBase
{
  private vector<shared_ptr<ServParamBase> > _params; //!< List of service parameters to be displayed in the faceplate.
  private vector<shape> _paramsShapes; //!< List of shapes representing parameter rows in the panel.
  private string _layout = "Layout"; //!< The layout name used for adding parameter symbols to the panel.
  private shape _panel; //!< Reference to the main panel containing parameter shapes.

  /**
   * @brief Constructor for ServParamFaceplate.
   * @details Initializes the faceplate by storing the provided parameters and setting up the parameter table.
   *
   * @param params A vector of shared pointers to ServParamBase objects representing the parameters.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServParamFaceplate(vector<shared_ptr<ServParamBase> > params, const mapping &shapes) : MtpRefBase(shapes)
  {
    _params = params;
    initializeTable();
  }

  /**
   * @brief Applies changes to all parameter shapes in the faceplate.
   * @details Iterates through all parameter shapes and calls their applyRow method to update their display or apply requested values.
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
   * @details Overrides the base class method to extract the main panel shape for displaying parameter rows.
   */
  private void initializeShapes()
  {
    _panel = MtpRefBase::extractShape("_panel");
  }

  /**
   * @brief Initializes the parameter table with the provided parameters.
   * @details Creates a table by appending shapes for each parameter based on its type and initializes them.
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
   * @details Adds a parameter shape to the panel based on the parameter's type (boolean, string, or integer) and initializes it with the provided parameter data.
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
        referencePanel = "objects/Services/ServiceParamBoolean.xml";
        break;

      case STRING_VAR:
        referencePanel = "objects/Services/ServiceParamString.xml";
        break;

      case INT_VAR:
        referencePanel = "objects/Services/ServiceParamInt.xml";
        break;

      case FLOAT_VAR:
        referencePanel = "objects/Services/ServiceParamFloat.xml";
        break;
    }

    addSymbol(_panel, referencePanel, rowNumber, rowNumber, _layout, makeDynString());
    _paramsShapes.append(getShape(_panel, rowNumber));
    invokeMethod(rowNumber, "initialize", param);
  }
};
