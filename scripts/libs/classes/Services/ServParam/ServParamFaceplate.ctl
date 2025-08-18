// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/Services/ServParam/ServParamNumberRef"
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpRef/MtpRefBase"
#uses "classes/Services/ServParam/ServParamBase"

class ServParamFaceplate : MtpRefBase
{
  private vector<shared_ptr<ServParamBase> > _params;
  private string _layout = "Layout";
  private shape _panel;

  public ServParamFaceplate(vector<shared_ptr<ServParamBase> > params, const mapping &shapes) : MtpRefBase(shapes)
  {
    _params = params;
    InitializeTable();
  }

  private void initializeShapes()
  {
    _panel = MtpRefBase::extractShape("_panel");
  }

  private void InitializeTable()
  {
    int size = _params.count();

    for (int i = 0; i < size; i++)
    {
      AppendParam(i, _params.at(i));
    }
  }

  private void AppendParam(const int &rowNumber, shared_ptr<ServParamBase> param)
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
    invokeMethod(rowNumber, "initialize", param);
  }
};
