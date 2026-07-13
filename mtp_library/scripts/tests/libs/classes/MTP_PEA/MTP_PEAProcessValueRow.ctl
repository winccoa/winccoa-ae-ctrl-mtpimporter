// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_PEA/MTP_PEAProcessValueRow.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_PEA/MTP_PEAProcessValueRow.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_PEA/MTP_PEAProcessValueRow"
#uses "classes/oaTest/OaTest"

class TstMTP_PEAProcessValueRow : OaTest
{
  private const string _DptAna = "TstMTP_PEAProcessValueRowAna";
  private const string _DptDInt = "TstMTP_PEAProcessValueRowDInt";
  private const string _DptBin = "TstMTP_PEAProcessValueRowBin";
  private const string _DptStringText = "TstMTP_PEAProcessValueRowStringText";
  private const string _DptStringValue = "TstMTP_PEAProcessValueRowStringValue";
  private const string _DptStringNoTagName = "TstMTP_PEAProcessValueRowStringNoTagName";
  private const string _DptAnaNoUnit = "TstMTP_PEAProcessValueRowAnaNoUnit";
  private const string _DptStringNoQuality = "TstMTP_PEAProcessValueRowStringNoQuality";

  private const string _DpAna = "TstMTP_PEAProcessValueRowAnaDp";
  private const string _DpDInt = "TstMTP_PEAProcessValueRowDIntDp";
  private const string _DpBin = "TstMTP_PEAProcessValueRowBinDp";
  private const string _DpStringText = "TstMTP_PEAProcessValueRowStringTextDp";
  private const string _DpStringValue = "TstMTP_PEAProcessValueRowStringValueDp";
  private const string _DpStringNoTagName = "TstMTP_PEAProcessValueRowStringNoTagNameDp";
  private const string _DpAnaNoUnit = "TstMTP_PEAProcessValueRowAnaNoUnitDp";
  private const string _DpStringNoQuality = "TstMTP_PEAProcessValueRowStringNoQualityDp";
  private const string _DpMissing = "TstMTP_PEAProcessValueRowMissingDp";

  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private int _rowChangedCount;

  public int setUp() override
  {
    _createdDpts = makeDynString();
    _createdDps = makeDynString();
    _rowChangedCount = 0;

    cleanupTestData();

    createTypeAndDp(_DptAna, _DpAna,
                    makeDynString("tagName", "WQC", "V", "UnitCur", "VUnit"),
                    makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_FLOAT, DPEL_INT, DPEL_INT));
    createTypeAndDp(_DptDInt, _DpDInt,
                    makeDynString("tagName", "WQC", "V", "UnitCur", "VUnit"),
                    makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT, DPEL_INT, DPEL_INT));
    createTypeAndDp(_DptBin, _DpBin,
                    makeDynString("tagName", "WQC", "V", "VState0", "VState1"),
                    makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_BOOL, DPEL_STRING, DPEL_STRING));
    createTypeAndDp(_DptStringText, _DpStringText,
                    makeDynString("tagName", "WQC", "Text", "V", "UnitCur", "VUnit"),
                    makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_STRING, DPEL_STRING, DPEL_INT, DPEL_INT));
    createTypeAndDp(_DptStringValue, _DpStringValue,
                    makeDynString("tagName", "WQC", "V"),
                    makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_STRING));
    createTypeAndDp(_DptStringNoTagName, _DpStringNoTagName,
                    makeDynString("WQC", "V"),
                    makeDynInt(DPEL_BIT32, DPEL_STRING));
    createTypeAndDp(_DptAnaNoUnit, _DpAnaNoUnit,
                    makeDynString("tagName", "WQC", "V"),
                    makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_FLOAT));
    createTypeAndDp(_DptStringNoQuality, _DpStringNoQuality,
                    makeDynString("tagName", "V"),
                    makeDynInt(DPEL_LANGSTRING, DPEL_STRING));

    dpSetWait(_DpAna + ".tagName", "System1:Analog Row",
              _DpAna + ".WQC", (bit32)0x80,
              _DpAna + ".V", 12.34,
              _DpAna + ".UnitCur", 1,
              _DpAna + ".VUnit", 2,
              _DpDInt + ".tagName", "Integer Row",
              _DpDInt + ".WQC", (bit32)0x00,
              _DpDInt + ".V", (int)42,
              _DpDInt + ".UnitCur", 3,
              _DpDInt + ".VUnit", 4,
              _DpBin + ".tagName", "Binary Row",
              _DpBin + ".WQC", (bit32)0xFF,
              _DpBin + ".V", false,
              _DpBin + ".VState0", "Closed",
              _DpBin + ".VState1", "Open",
              _DpStringText + ".tagName", "String Text Row",
              _DpStringText + ".WQC", (bit32)0x80,
              _DpStringText + ".Text", "text value",
              _DpStringText + ".V", "value dpe",
              _DpStringText + ".UnitCur", 5,
              _DpStringText + ".VUnit", 6,
              _DpStringValue + ".tagName", "String Value Row",
              _DpStringValue + ".WQC", (bit32)0x00,
              _DpStringValue + ".V", "plain value",
              _DpStringNoTagName + ".WQC", (bit32)0x80,
              _DpStringNoTagName + ".V", "fallback",
              _DpAnaNoUnit + ".tagName", "Analog No Unit",
              _DpAnaNoUnit + ".WQC", (bit32)0x80,
              _DpAnaNoUnit + ".V", 1.0,
              _DpStringNoQuality + ".tagName", "String No Quality",
              _DpStringNoQuality + ".V", "no quality");

    return OaTest::setUp();
  }


  private bool isTestOnlyDpt(const string &dpt)
  {
    return dpt.contains("Invalid") || dpt.contains("Unsupported") || dpt.contains("UT") || dpt.contains("Tst") || dpt == "TestDpt";
  }
  public int tearDown() override
  {
    cleanupTestData();
    for (int i = 1; i <= dynlen(_createdDpts); i++)
    {
      if (isTestOnlyDpt(_createdDpts[i]) && dpTypes(_createdDpts[i]).count() > 0)
        dpTypeDelete(_createdDpts[i]);
    }
    return OaTest::tearDown();
  }

  private void createTypeAndDp(const string &dpt, const string &dp, const dyn_string &fields, const dyn_int &types)
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(dpt));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT));

    for (int i = 1; i <= dynlen(fields); i++)
    {
      dynAppend(dpes, makeDynString("", fields[i]));
      dynAppend(values, makeDynInt(0, types[i]));
    }

    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(dp))
      dpCreate(dp, dpt);

    dynAppend(_createdDpts, dpt);
    dynAppend(_createdDps, dp);
  }

  private void cleanupTestData()
  {
    dyn_string dps = makeDynString(_DpAna, _DpDInt, _DpBin, _DpStringText, _DpStringValue,
                                   _DpStringNoTagName, _DpAnaNoUnit, _DpStringNoQuality);
    dyn_string dpts = makeDynString(_DptAna, _DptDInt, _DptBin, _DptStringText, _DptStringValue,
                                    _DptStringNoTagName, _DptAnaNoUnit, _DptStringNoQuality);

    for (int i = 1; i <= dynlen(dps); i++)
    {
      if (dpExists(dps[i]))
      {
        dpDelete(dps[i]);
      }
    }

    for (int j = 1; j <= dynlen(dpts); j++)
    {
    }
  }

  public int testConstructorAndClassification()
  {
    shared_ptr<MTP_PEAProcessValueRow> anaRow = new MTP_PEAProcessValueRow(_DpAna, "In");
    shared_ptr<MTP_PEAProcessValueRow> dintRow = new MTP_PEAProcessValueRow(_DpDInt, "Out");
    shared_ptr<MTP_PEAProcessValueRow> binRow = new MTP_PEAProcessValueRow(_DpBin, "In");
    shared_ptr<MTP_PEAProcessValueRow> stringRow = new MTP_PEAProcessValueRow(_DpStringText, "Out");

    assertEqual(anaRow.getDp(), _DpAna);
    assertEqual(anaRow.getKind(), "Ana");
    assertTrue(anaRow.isInput());
    assertTrue(!anaRow.isBinary());

    assertEqual(dintRow.getKind(), "DInt");
    assertTrue(!dintRow.isInput());
    assertTrue(!dintRow.isBinary());

    assertEqual(binRow.getKind(), "Bin");
    assertTrue(binRow.isInput());
    assertTrue(binRow.isBinary());

    assertEqual(stringRow.getKind(), "String");
    assertTrue(!stringRow.isInput());
    assertTrue(!stringRow.isBinary());
    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MTP_PEAProcessValueRow> row = new MTP_PEAProcessValueRow(_DpMissing, "In");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpMissing));
    }

    return 0;
  }

  public int testNameValueAndDpeGetters()
  {
    shared_ptr<MTP_PEAProcessValueRow> anaRow = new MTP_PEAProcessValueRow(_DpAna, "In");
    shared_ptr<MTP_PEAProcessValueRow> dintRow = new MTP_PEAProcessValueRow(_DpDInt, "In");
    shared_ptr<MTP_PEAProcessValueRow> binRow = new MTP_PEAProcessValueRow(_DpBin, "In");
    shared_ptr<MTP_PEAProcessValueRow> stringTextRow = new MTP_PEAProcessValueRow(_DpStringText, "In");
    shared_ptr<MTP_PEAProcessValueRow> stringValueRow = new MTP_PEAProcessValueRow(_DpStringValue, "In");
    shared_ptr<MTP_PEAProcessValueRow> noTagNameRow = new MTP_PEAProcessValueRow(_DpStringNoTagName, "In");

    assertEqual(anaRow.getName(), "Analog Row");
    assertEqual(dintRow.getName(), "Integer Row");
    assertEqual(binRow.getName(), "Binary Row");
    assertEqual(noTagNameRow.getName(), _DpStringNoTagName);

    assertEqual(anaRow.getCurrentValue(), "12.34");
    assertEqual(dintRow.getCurrentValue(), "42");
    assertEqual(binRow.getCurrentValue(), "Closed");
    assertEqual(stringTextRow.getCurrentValue(), "text value");
    assertEqual(stringValueRow.getCurrentValue(), "plain value");

    assertEqual(stringTextRow.getValueDpe(), _DpStringText + ".Text");
    assertEqual(stringValueRow.getValueDpe(), _DpStringValue + ".V");
    assertEqual(anaRow.getValueDpe(), _DpAna + ".V");
    assertEqual(anaRow.getQualityDpe(), _DpAna + ".WQC");
    return 0;
  }

  public int testBinaryValueFallbackAndToggle()
  {
    shared_ptr<MTP_PEAProcessValueRow> inputRow = new MTP_PEAProcessValueRow(_DpBin, "In");
    shared_ptr<MTP_PEAProcessValueRow> outputRow = new MTP_PEAProcessValueRow(_DpBin, "Out");

    assertEqual(inputRow.getCurrentBool(), false);
    assertEqual(inputRow.getCurrentValue(), "Closed");

    assertTrue(inputRow.toggleBinaryValue());
    delay(0, 200);
    assertEqual(inputRow.getCurrentBool(), true);
    assertEqual(inputRow.getCurrentValue(), "Open");

    dpSetWait(_DpBin + ".VState0", "",
              _DpBin + ".VState1", "");
    assertEqual(inputRow.getCurrentValue(), "TRUE");

    assertTrue(!outputRow.toggleBinaryValue());
    return 0;
  }

  public int testUnitAndQuality()
  {
    shared_ptr<MTP_PEAProcessValueRow> anaInputRow = new MTP_PEAProcessValueRow(_DpAna, "In");
    shared_ptr<MTP_PEAProcessValueRow> anaOutputRow = new MTP_PEAProcessValueRow(_DpAna, "Out");
    shared_ptr<MTP_PEAProcessValueRow> noUnitRow = new MTP_PEAProcessValueRow(_DpAnaNoUnit, "In");
    shared_ptr<MTP_PEAProcessValueRow> goodQualityRow = new MTP_PEAProcessValueRow(_DpAna, "In");
    shared_ptr<MTP_PEAProcessValueRow> badQualityRow = new MTP_PEAProcessValueRow(_DpDInt, "In");
    string inputUnit = anaInputRow.getUnit();
    string outputUnit = anaOutputRow.getUnit();

    assertEqual(inputUnit, getCatStr("LCFL_Unit", 1));
    assertEqual(outputUnit, getCatStr("LCFL_Unit", 2));
    assertEqual(noUnitRow.getUnit(), "");
    assertTrue(goodQualityRow.getQualityGood());
    assertTrue(!badQualityRow.getQualityGood());
    return 0;
  }

  public int testSetRequestedValue()
  {
    shared_ptr<MTP_PEAProcessValueRow> anaInputRow = new MTP_PEAProcessValueRow(_DpAna, "In");
    shared_ptr<MTP_PEAProcessValueRow> anaOutputRow = new MTP_PEAProcessValueRow(_DpAna, "Out");
    shared_ptr<MTP_PEAProcessValueRow> dintInputRow = new MTP_PEAProcessValueRow(_DpDInt, "In");
    shared_ptr<MTP_PEAProcessValueRow> binInputRow = new MTP_PEAProcessValueRow(_DpBin, "In");
    shared_ptr<MTP_PEAProcessValueRow> stringTextRow = new MTP_PEAProcessValueRow(_DpStringText, "In");
    shared_ptr<MTP_PEAProcessValueRow> stringValueRow = new MTP_PEAProcessValueRow(_DpStringValue, "In");

    assertTrue(anaInputRow.setRequestedValue("23.5"));
    assertTrue(!anaInputRow.setRequestedValue("not a float"));
    assertTrue(!anaOutputRow.setRequestedValue("24.5"));
    assertTrue(dintInputRow.setRequestedValue("77"));
    assertTrue(!dintInputRow.setRequestedValue("not an int"));
    assertTrue(!binInputRow.setRequestedValue("true"));
    assertTrue(stringTextRow.setRequestedValue("new text"));
    assertTrue(stringValueRow.setRequestedValue("new value"));

    delay(0, 200);

    assertEqual(anaInputRow.getCurrentValue(), "23.50");
    assertEqual(dintInputRow.getCurrentValue(), "77");
    assertEqual(stringTextRow.getCurrentValue(), "new text");
    assertEqual(stringValueRow.getCurrentValue(), "new value");
    return 0;
  }

  public int testRowChangedEventsForStringRows()
  {
    shared_ptr<MTP_PEAProcessValueRow> row = new MTP_PEAProcessValueRow(_DpStringText, "In");
    classConnect(this, rowChangedCB, row, MTP_PEAProcessValueRow::rowChanged);

    dpSetWait(_DpStringText + ".Text", "changed by test");
    delay(0, 200);
    assertTrue(_rowChangedCount > 0);

    int countAfterValueChange = _rowChangedCount;
    dpSetWait(_DpStringText + ".WQC", (bit32)0x00);
    delay(0, 200);
    assertTrue(_rowChangedCount > countAfterValueChange);
    return 0;
  }

  public int testMissingOptionalConnectDpes()
  {
    shared_ptr<MTP_PEAProcessValueRow> row = new MTP_PEAProcessValueRow(_DpStringNoQuality, "In");

    assertEqual(row.getKind(), "String");
    assertEqual(row.getValueDpe(), _DpStringNoQuality + ".V");
    assertEqual(row.getQualityDpe(), _DpStringNoQuality + ".WQC");
    assertEqual(row.getCurrentValue(), "no quality");
    return 0;
  }

  private void rowChangedCB()
  {
    _rowChangedCount++;
  }
};

void main()
{
  TstMTP_PEAProcessValueRow test;
  test.startAll();
}
