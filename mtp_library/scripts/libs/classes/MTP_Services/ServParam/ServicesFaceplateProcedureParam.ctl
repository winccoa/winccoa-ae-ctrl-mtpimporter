// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_Procedure/MTP_Procedure"
#uses "classes/ContextMenu/ContextMenuConfig"
#uses "classes/ContextMenu/ContextMenuCustom"
#uses "classes/MTP_Services/Procedure"
#uses "classes/MTP_Services/ServParam/ServParamFaceplate"
#uses "classes/MTP_Services/MTP_Services"

/**
 * @class ServicesFaceplateProcedureParam
 * @brief Represents the ServicesFaceplateProcedureParam class.
 */
class ServicesFaceplateProcedureParam : MTP_ViewBase
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

  private uint _currentProcedure; //!< Index of the currently active procedure.
  private uint _requestedProcedure; //!< Index of the requested procedure.

  /**
   * @brief Constructor for ServicesFaceplateProcedureParam.
   *
   * @param viewModel A shared pointer to the Services view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public ServicesFaceplateProcedureParam(shared_ptr<MTP_Services> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    _procedures = MTP_ViewBase::getViewModel().getProcedures();
    _txtProcedure.text = "NOT_SELECTED";

    classConnect(this, setCurrentProcedureCB, MTP_ViewBase::getViewModel().getProcedure(), MTP_Procedure::currentChanged);
    classConnect(this, setRequestedProcedureCB, MTP_ViewBase::getViewModel().getProcedure(), MTP_Procedure::requestedChanged);

    _contextConfig = new ContextMenuConfig();
    setCurrentProcedureCB(MTP_ViewBase::getViewModel().getProcedure().getCurrent());
    setRequestedProcedureCB(MTP_ViewBase::getViewModel().getProcedure().getRequested());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _panel = MTP_RefBase::extractShape("_panel");
    _rectProcedurePicker = MTP_ViewBase::extractShape("_rectProcedurePicker");
    _txtProcedure = MTP_ViewBase::extractShape("_txtProcedure");
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
   * @brief Opens a context menu for procedure selection with icons.
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

  /**
   * @brief Deletes all parameters and their associated shapes from the table.
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
   *
   * @param currentProcedure The new current procedure index.
   */
  private void setCurrentProcedureCB(const uint &currentProcedure)
  {
    _currentProcedure = currentProcedure;
  }

  /**
   * @brief Callback function to update the requested procedure index.
   *
   * @param requestedProcedure The new requested procedure index.
   */
  private void setRequestedProcedureCB(const uint &requestedProcedure)
  {
    _requestedProcedure = requestedProcedure;
  }
};
