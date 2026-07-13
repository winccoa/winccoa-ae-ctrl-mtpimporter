// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Ref/MTP_RefBase"
#uses "classes/MTP_PEA/MTP_PEA"
#uses "classes/MTP_PEA/MTP_PEAProcessValueRow"

/**
 * @class MTP_PEAProcessValueListFaceplate
 * @brief Dynamically renders ProcessValueIn/Out rows for one PEA tab.
 */
class MTP_PEAProcessValueListFaceplate : MTP_RefBase
{
  private shared_ptr<MTP_PEA> _viewModel; //!< PEA view model.
  private string _direction; //!< "In" or "Out".
  private string _layout = "Layout"; //!< Target layout name for row insertion.
  private shape _panel; //!< Root panel shape.
  private vector<shape> _rowShapes; //!< Inserted row symbol shapes.
  private vector<shared_ptr<MTP_PEAProcessValueRow> > _rows; //!< Row view models.
  private dyn_string _rowRefNames; //!< Inserted row reference names for cleanup.

  /**
   * @brief Constructor for MTP_PEAProcessValueListFaceplate.
   *
   * @param viewModel PEA view model.
   * @param direction Row direction ("In" or "Out").
   * @param shapes Shape mapping.
   */
  public MTP_PEAProcessValueListFaceplate(shared_ptr<MTP_PEA> viewModel, const string &direction, const mapping &shapes) : MTP_RefBase(shapes)
  {
    assignPtr(_viewModel, viewModel);
    _direction = direction;
    initializeTable();
  }

  /**
   * @brief Rebuilds all row symbols from the current process value list.
   */
  public void rebuild()
  {
    deleteRows();
    initializeTable();
  }

  /**
   * @brief Initializes required shapes.
   */
  protected void initializeShapes() override
  {
    _panel = MTP_RefBase::extractShape("_panel");
  }

  /**
   * @brief Initializes the row table.
   */
  private void initializeTable()
  {
    dyn_string processValues;

    if (_direction == "In")
    {
      processValues = _viewModel.getProcessValueIns();
    }
    else
    {
      processValues = _viewModel.getProcessValueOuts();
    }

    for (int i = 0; i < dynlen(processValues); i++)
    {
      appendRow(i, processValues[i + 1]);
    }
  }

  /**
   * @brief Deletes all currently inserted row symbols.
   */
  private void deleteRows()
  {
    for (int i = 0; i < dynlen(_rowRefNames); i++)
    {
      removeSymbol(_panel, _rowRefNames[i + 1]);
    }

    _rowRefNames.clear();
    _rowShapes.clear();
    _rows.clear();
  }

  /**
   * @brief Appends one process value row.
   *
   * @param rowNumber Target row number.
   * @param dp Process value datapoint.
   */
  private void appendRow(const int &rowNumber, const string &dp)
  {
    string referencePanel = resolveReferencePanel(dp);
    if (referencePanel == "")
    {
      return;
    }

    shared_ptr<MTP_PEAProcessValueRow> row = new MTP_PEAProcessValueRow(dp, _direction);
    _rows.append(row);

    // Keep the same insertion contract as service parameters:
    // ref name == row index and retrieval via index.
    string rowRefName = (string)rowNumber;
    addSymbol(_panel, referencePanel, rowRefName, rowNumber, _layout, makeDynString());
    shape rowShape = getShape(_panel, rowNumber);

    if (rowShape == nullptr)
    {
      return;
    }
    _rowRefNames.append(rowRefName);
    _rowShapes.append(rowShape);
    invokeMethod(rowShape, "initialize", row);
  }

  /**
   * @brief Resolves typed row panel path for a datapoint.
   *
   * @param dp Process value datapoint.
   * @return Row panel path.
   */
  private string resolveReferencePanel(const string &dp)
  {
    string typeName = dpTypeName(dp);

    if (_direction == "In")
    {
      if (strpos(typeName, "MTP_AnaProcessValueIn") >= 0)
      {
        return "objects/MTP_ProcessValueIn/MTP_AnaProcessValueIn.xml";
      }

      if (strpos(typeName, "MTP_DIntProcessValueIn") >= 0)
      {
        return "objects/MTP_ProcessValueIn/MTP_DIntProcessValueIn.xml";
      }

      if (strpos(typeName, "MTP_BinProcessValueIn") >= 0)
      {
        return "objects/MTP_ProcessValueIn/MTP_BinProcessValueIn.xml";
      }

      if (strpos(typeName, "MTP_StringProcessValueIn") >= 0)
      {
        return "objects/MTP_ProcessValueIn/MTP_StringProcessValueIn.xml";
      }
    }
    else
    {
      if (typeName == "MTP_AnaView" || typeName == "MTP_AnaViewCfl")
      {
        return "objects/MTP_ProcessValueOut/MTP_AnaProcessValueOut.xml";
      }

      if (typeName == "MTP_DIntView" || typeName == "MTP_DIntViewCfl")
      {
        return "objects/MTP_ProcessValueOut/MTP_DIntProcessValueOut.xml";
      }

      if (typeName == "MTP_BinView" || typeName == "MTP_BinViewCfl")
      {
        return "objects/MTP_ProcessValueOut/MTP_BinProcessValueOut.xml";
      }

      if (typeName == "MTP_StringView" || typeName == "MTP_StringViewCfl")
      {
        return "objects/MTP_ProcessValueOut/MTP_StringProcessValueOut.xml";
      }
    }

    DebugN("Unsupported process value type in PEA list:", typeName, dp);
    return "";
  }
};
