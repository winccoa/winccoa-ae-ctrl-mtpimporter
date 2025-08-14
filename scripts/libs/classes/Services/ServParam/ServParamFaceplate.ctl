// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpRef/MtpRefBase"
#uses "classes/Services/ServParam/ServParamBase"

class ServParamFaceplate : MtpRefBase
{
  private vector<shared_ptr<ServParamBase> > _params;
  private shape _table;

  public ServParamFaceplate(vector<shared_ptr<ServParamBase> > params, const mapping &shapes) : MtpRefBase(shapes)
  {
    _params = params;

    InitializeTable();
  }

  private void initializeShapes()
  {
    _table = MtpRefBase::extractShape("_table");
  }

  private void InitializeTable()
  {
    _table.updatesEnabled = FALSE;
    _table.deleteAllLines();

    int size = _params.count();

    for (int i = 0; i < size; i++)
    {
      AppendParam(_params.at(i));
    }

    _table.updatesEnabled = TRUE;
  }

  private void AppendParam(shared_ptr<ServParamBase> param)
  {
    _table.appendLine("name", param.getName(), "requested", param.getValueRequested(), "current", param.getValueFeedback());
  }
};
