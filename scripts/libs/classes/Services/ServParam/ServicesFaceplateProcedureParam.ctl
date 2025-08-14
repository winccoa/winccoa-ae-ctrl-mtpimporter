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
  private shape _tableRef;

  private vector<shared_ptr<Procedure> > _procedures;
  vector<shared_ptr<ServParamBase> > empty;

  public ServicesFaceplateProcedureParam(shared_ptr<Services> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    _procedures = MtpViewBase::getViewModel().getProcedures();

    _tableRef.Initialize(empty);
    _txtProcedure.text = "NOT_SELECTED";
  }

  protected void initializeShapes() override
  {
    _tableRef = MtpViewBase::extractShape("_tableRef");
    _rectProcedurePicker = MtpViewBase::extractShape("_rectProcedurePicker");
    _txtProcedure = MtpViewBase::extractShape("_txtProcedure");
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

    if (answer == 0)
    {
      _tableRef.Initialize(empty);
      _txtProcedure.text = "NOT_SELECTED";
      return;
    }

    _tableRef.Initialize(_procedures[answer - 1].getParameters());
    _txtProcedure.text = _procedures.at(answer - 1).getName();
  }
};
