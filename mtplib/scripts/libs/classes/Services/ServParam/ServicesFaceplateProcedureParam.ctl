// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpProcedure/MtpProcedure"
#uses "classes/ContextMenu/ContextMenuConfig"
#uses "classes/ContextMenu/ContextMenuCustom"
#uses "classes/Services/Procedure"
#uses "classes/Services/ServParam/ServParamFaceplate"
#uses "classes/Services/Services"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class ServicesFaceplateProcedureParam
 * @brief Manages the faceplate for procedure parameters in a Services view.
 */
class ServicesFaceplateProcedureParam : MtpViewBase
{
  private shape _txtProcedure; //!< Reference to the text shape displaying the selected procedure name.
  private shape _rectProcedurePicker; //!< Reference to the rectangle shape used to trigger the procedure selection context menu.
  private string _layout = "Layout"; //!< The layout name used for adding parameter symbols to the panel.
  private shape _panel; //!< Reference to the main panel containing parameter symbols.

  private vector<shared_ptr<Procedure> > _procedures; //!< List of available procedures from the view model.
  private vector<shared_ptr<ServParamBase> > _params; //!< List of parameters for the currently selected procedure.
  private vector<shared_ptr<ServParamBase> > _empty; //!< Empty parameter vector used for clearing parameters.
  private vector<shape> _paramsShapes; //!< List of shapes representing parameter rows in the panel.
  private shared_ptr<ContextMenuCustom> _contextMenu; //!< Reference to the custom context menu for procedure selection.
  private shared_ptr<ContextMenuConfig> _contextConfig; //!< Configuration for the context menu.

  private long _currentProcedure; //!< Index of the currently active procedure.
  private long _requestedProcedure; //!< Index of the requested procedure.

  /**
   * @brief Constructor for ServicesFaceplateProcedureParam.
   * @details Initializes the faceplate by setting up procedure data, connecting callbacks for procedure changes, and configuring the context menu.
   *
   * @param viewModel A shared pointer to the Services view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServicesFaceplateProcedureParam(shared_ptr<Services> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    _procedures = MtpViewBase::getViewModel().getProcedures();
    _txtProcedure.text = "NOT_SELECTED";

    classConnect(this, setCurrentProcedureCB, MtpViewBase::getViewModel().getProcedure(), MtpProcedure::currentChanged);
    classConnect(this, setRequestedProcedureCB, MtpViewBase::getViewModel().getProcedure(), MtpProcedure::requestedChanged);

    _contextConfig = new ContextMenuConfig();
    setCurrentProcedureCB(MtpViewBase::getViewModel().getProcedure().getCurrent());
    setRequestedProcedureCB(MtpViewBase::getViewModel().getProcedure().getRequested());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details Overrides the base class method to extract required shapes from the panel for procedure display and interaction.
   */
  protected void initializeShapes() override
  {
    _panel = MtpRefBase::extractShape("_panel");
    _rectProcedurePicker = MtpViewBase::extractShape("_rectProcedurePicker");
    _txtProcedure = MtpViewBase::extractShape("_txtProcedure");
  }

  /**
   * @brief Applies changes to all parameter shapes in the faceplate.
   * @details Iterates through all parameter shapes and calls their applyRow method to update their display.
   */
  public void applyAll()
  {
    for (int i = 0; i < _paramsShapes.count(); i++)
    {
      _paramsShapes.at(i).applyRow();
    }
  }

  /**
   * @brief Opens a context menu for procedure selection with icons.
   * @details Configures and displays a custom context menu with procedure names and icons indicating current or requested procedures. Updates the parameter table based on the selected procedure.
   */
  public void proceduresPopUp()
  {
    int answer;

    _contextConfig.Clear();
    _contextConfig.AddPushButton("NOT_SELECTED", 0, 1);

    for (int i = 0; i < _procedures.count(); i++)
    {
      if (i + 1 == _currentProcedure)
      {
        _contextConfig.AddPushButtonWithImage(_procedures.at(i).getName(), i + 1, 1, "", "MTP_Icones/CurrentProcedureOn.svg");
      }
      else if (i + 1 == _requestedProcedure)
      {
        _contextConfig.AddPushButtonWithImage(_procedures.at(i).getName(), i + 1, 1, "", "MTP_Icones/RequestedProcedureOn.svg");
      }
      else
      {
        _contextConfig.AddPushButton(_procedures.at(i).getName(), i + 1, 1);
      }
    }

    _contextMenu = new ContextMenuCustom(_contextConfig, _rectProcedurePicker.name());

    answer = _contextMenu.Open();

    if (answer == 0)
    {
      _txtProcedure.text = "NOT_SELECTED";
      deleteParams();
      return;
    }

    if (answer == -1)
    {
      return;
    }

    deleteParams();
    _params = _procedures[answer - 1].getParameters();
    _txtProcedure.text = _procedures.at(answer - 1).getName();

    initializeTable();
  }

  /**
   * @brief Initializes the parameter table with the current procedure's parameters.
   * @details Clears existing parameters and populates the table with new parameter shapes based on the selected procedure.
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
   * @details Adds a parameter shape to the panel based on the parameter's type (boolean, string, or integer) and initializes it.
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

  /**
   * @brief Deletes all parameters and their associated shapes from the table.
   * @details Removes all parameter shapes from the panel and clears the parameter and shape vectors.
   */
  private void deleteParams()
  {
    for (int i = 0; i < _params.count(); i++)
    {
      removeSymbol(_panel, i);
    }

    _params.clear();
    _paramsShapes.clear();
  }

  /**
   * @brief Callback function to update the current procedure index.
   * @details Updates the internal current procedure index when the view model's current procedure changes.
   *
   * @param currentProcedure The new current procedure index.
   */
  private void setCurrentProcedureCB(const long &currentProcedure)
  {
    _currentProcedure = currentProcedure;
  }

  /**
   * @brief Callback function to update the requested procedure index.
   * @details Updates the internal requested procedure index when the view model's requested procedure changes.
   *
   * @param requestedProcedure The new requested procedure index.
   */
  private void setRequestedProcedureCB(const long &requestedProcedure)
  {
    _requestedProcedure = requestedProcedure;
  }
};
