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

class ServParamFaceplate : MtpRefBase
{
  private vector<shared_ptr<ServParamBase> > _params;
  private shape _table;

  public ServParamFaceplate(vector<shared_ptr<ServParamBase> > params, const mapping &shapes) : MtpRefBase(shapes)
  {
    _params = params;

    InitializeTable();
  }

  public void apply(const int &rowNumber)
  {
    anytype required = _table.cellValueRC(rowNumber, "required");
    shared_ptr<ServParamBase> param = _params.at(rowNumber);
    param.setValueRequested(required);
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
      AppendParam(i, _params.at(i));
    }

    _table.updatesEnabled = TRUE;
  }

  private void AppendParam(const int &rowNumber, shared_ptr<ServParamBase> param)
  {
    _table.appendLine("name", param.getName(), "required", param.getValueRequested(), "current", param.getValueFeedback(), "wqc", param.getWqc());
    _table.cellWidgetRC(rowNumber, "apply", "PushButton", "Apply");
    classConnectUserData(this, setCurrentCB, rowNumber, param, ServParamBase::valueFeedbackChanged);
    classConnectUserData(this, setWqcCB, rowNumber, param.getWqc(), MtpQualityCode::qualityGoodChanged);
    setWqcCB(rowNumber, param.getWqc().getQualityGood());
  }

  private void setCurrentCB(const int &rowNumber, const anytype &value)
  {
    _table.cellValueRC(rowNumber, "current", value);
  }

  private void setWqcCB(const int &rowNumber, const anytype &value)
  {
    if (value)
    {
      _table.cellFillRC(rowNumber, "wqc", "[pattern,[fit,any,MTP_Icones/GreyOk.svg]]");
    }
    else
    {
      _table.cellFillRC(rowNumber, "wqc", "[pattern,[fit,any,MTP_Icones/MTP_Icones/Close.svg]]");
    }
  }
};
