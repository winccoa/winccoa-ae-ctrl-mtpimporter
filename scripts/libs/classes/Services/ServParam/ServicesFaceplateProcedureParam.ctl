// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/Services/Procedure"
#uses "classes/Services/ServParam/ServParamFaceplate"
#uses "classes/Services/Services"
#uses "classes/MtpView/MtpViewBase"

class ServicesFaceplateProcedureParam : MtpViewBase
{
  private shape _txtProcedure;
  private shape _rectProcedurePicker;
  private string _layout = "Layout";
  private shape _panel;

  private vector<shared_ptr<Procedure> > _procedures;
  private vector<shared_ptr<ServParamBase> > _params;
  private vector<shared_ptr<ServParamBase> > _empty;
  private vector<shape> _paramsShapes;

  public ServicesFaceplateProcedureParam(shared_ptr<Services> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    _procedures = MtpViewBase::getViewModel().getProcedures();
    _txtProcedure.text = "NOT_SELECTED";
  }

  protected void initializeShapes() override
  {
    _panel = MtpRefBase::extractShape("_panel");
    _rectProcedurePicker = MtpViewBase::extractShape("_rectProcedurePicker");
    _txtProcedure = MtpViewBase::extractShape("_txtProcedure");
  }

  public void applyAll()
  {
    for (int i = 0; i < _paramsShapes.count(); i++)
    {
      _paramsShapes.at(i).applyRow();
    }
  }

  public void proceduresPopUp()
  {
    int answer;
    dyn_string proceduresNames;

    proceduresNames.append("PUSH_BUTTON, NOT_SELECTED, 0, 1");

    for (int i = 0; i < _procedures.count(); i++)
    {
      proceduresNames.append("PUSH_BUTTON, " + _procedures.at(i).getName() + ", " + (i + 1) + ", 1");
    }

    popupMenu(proceduresNames, answer);
    deleteParams();

    if (answer == 0)
    {
      _txtProcedure.text = "NOT_SELECTED";
      _params = _empty;
      return;
    }

    _params = _procedures[answer - 1].getParameters();
    _txtProcedure.text = _procedures.at(answer - 1).getName();
    initializeTable();
  }

  private void initializeTable()
  {
    int size = _params.count();

    for (int i = 0; i < size; i++)
    {
      appendParam(i, _params.at(i));
    }
  }

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
        referencePanel = "objects/Services/ServiceParamNumber.xml";
        break;
    }

    addSymbol(_panel, referencePanel, rowNumber, rowNumber, _layout, makeDynString());
    _paramsShapes.append(getShape(_panel, rowNumber));
    invokeMethod(rowNumber, "initialize", param);
  }

  private void deleteParams()
  {
    for (int i = 0; i < _params.count(); i++)
    {
      removeSymbol(_panel, i);
    }

    _paramsShapes.clear();
  }
};
