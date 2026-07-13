// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_ProcessValueIn/MTP_DIntProcessValueIn.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_ProcessValueIn/MTP_DIntProcessValueIn.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_ProcessValueIn/MTP_DIntProcessValueIn"
#uses "classes/oaTest/OaTest"

/** Tests for MTP_DIntProcessValueIn.ctl
*/
class TstMTP_DIntProcessValueIn : OaTest
{
  private const string _Dpt = "MTP_DIntProcessValueIn";
  private const string _DptInvalidMissingV = "MTP_DIntProcessValueInInvalid1";
  private const string _DptInvalidMissingSclMinCur = "MTP_DIntProcessValueInInvalid2";
  private const string _DptInvalidMissingSclMaxCur = "MTP_DIntProcessValueInInvalid3";
  private const string _DptInvalidMissingOSLevel = "MTP_DIntProcessValueInInvalid4";
  private const string _DptInvalidMissingUnitCur = "MTP_DIntProcessValueInInvalid5";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingV = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingSclMinCur = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingSclMaxCur = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingOSLevel = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingUnitCur = "ExistingTestDatapointInvalid5";

  private int _eventValue;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "VQC"),
                                         makeDynString("", "OSLevel"), makeDynString("", "V"), makeDynString("", "UnitCur"),
                                         makeDynString("", "SclMinCur"), makeDynString("", "SclMaxCur"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingV), makeDynString("", "tagName"), makeDynString("", "WQC"),
                          makeDynString("", "VQC"), makeDynString("", "OSLevel"), makeDynString("", "UnitCur"),
                          makeDynString("", "SclMinCur"), makeDynString("", "SclMaxCur"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingV))
      dpCreate(_DpExistsInvalidMissingV, _DptInvalidMissingV);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingSclMinCur), makeDynString("", "tagName"), makeDynString("", "WQC"),
                          makeDynString("", "VQC"), makeDynString("", "OSLevel"), makeDynString("", "V"),
                          makeDynString("", "UnitCur"), makeDynString("", "SclMaxCur"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingSclMinCur))
      dpCreate(_DpExistsInvalidMissingSclMinCur, _DptInvalidMissingSclMinCur);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingSclMaxCur), makeDynString("", "tagName"), makeDynString("", "WQC"),
                          makeDynString("", "VQC"), makeDynString("", "OSLevel"), makeDynString("", "V"),
                          makeDynString("", "UnitCur"), makeDynString("", "SclMinCur"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingSclMaxCur))
      dpCreate(_DpExistsInvalidMissingSclMaxCur, _DptInvalidMissingSclMaxCur);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingOSLevel), makeDynString("", "tagName"), makeDynString("", "WQC"),
                          makeDynString("", "VQC"), makeDynString("", "V"), makeDynString("", "UnitCur"),
                          makeDynString("", "SclMinCur"), makeDynString("", "SclMaxCur"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingOSLevel))
      dpCreate(_DpExistsInvalidMissingOSLevel, _DptInvalidMissingOSLevel);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingUnitCur), makeDynString("", "tagName"), makeDynString("", "WQC"),
                          makeDynString("", "VQC"), makeDynString("", "OSLevel"), makeDynString("", "V"),
                          makeDynString("", "SclMinCur"), makeDynString("", "SclMaxCur"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingUnitCur))
      dpCreate(_DpExistsInvalidMissingUnitCur, _DptInvalidMissingUnitCur);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingV);
    if (dpTypes(_DptInvalidMissingV).count() > 0)
      dpTypeDelete(_DptInvalidMissingV);
    dpDelete(_DpExistsInvalidMissingSclMinCur);
    if (dpTypes(_DptInvalidMissingSclMinCur).count() > 0)
      dpTypeDelete(_DptInvalidMissingSclMinCur);
    dpDelete(_DpExistsInvalidMissingSclMaxCur);
    if (dpTypes(_DptInvalidMissingSclMaxCur).count() > 0)
      dpTypeDelete(_DptInvalidMissingSclMaxCur);
    dpDelete(_DpExistsInvalidMissingOSLevel);
    if (dpTypes(_DptInvalidMissingOSLevel).count() > 0)
      dpTypeDelete(_DptInvalidMissingOSLevel);
    dpDelete(_DpExistsInvalidMissingUnitCur);
    if (dpTypes(_DptInvalidMissingUnitCur).count() > 0)
      dpTypeDelete(_DptInvalidMissingUnitCur);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DIntProcessValueIn> processValueIn = new MTP_DIntProcessValueIn(_DpExists);
    int expectedInitialValue = 0;
    assertEqual(processValueIn.getDp(), _DpExists);
    assertEqual(processValueIn.getValue(), expectedInitialValue);
    assertEqual(processValueIn.getScaleMinCur(), expectedInitialValue);
    assertEqual(processValueIn.getScaleMaxCur(), expectedInitialValue);
    assertTrue(processValueIn.getWqc() != nullptr);
    assertTrue(processValueIn.getVqc() != nullptr);
    assertTrue(processValueIn.getOsLevel() != nullptr);
    assertTrue(processValueIn.getUnitCur() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    assertMissingDpe(_DpExistsInvalidMissingV, ".V");
    assertMissingDpe(_DpExistsInvalidMissingSclMinCur, ".SclMinCur");
    assertMissingDpe(_DpExistsInvalidMissingSclMaxCur, ".SclMaxCur");
    assertMissingDpe(_DpExistsInvalidMissingOSLevel, ".OSLevel");
    assertMissingDpe(_DpExistsInvalidMissingUnitCur, ".UnitCur");
    return 0;
  }

  public int testValueChanged()
  {
    shared_ptr<MTP_DIntProcessValueIn> processValueIn = new MTP_DIntProcessValueIn(_DpExists);
    classConnect(this, setValueChangedCB, processValueIn, MTP_DIntProcessValueIn::valueChanged);
    int expectedValue = 123;

    dpSetWait(_DpExists + ".V", expectedValue);

    delay(0, 200);
    assertEqual(processValueIn.getValue(), expectedValue);
    assertEqual(_eventValue, expectedValue);
    return 0;
  }

  public int testSetValue()
  {
    shared_ptr<MTP_DIntProcessValueIn> processValueIn = new MTP_DIntProcessValueIn(_DpExists);
    int expectedValue = 234;

    processValueIn.setValue(expectedValue);
    delay(0, 200);

    int dpValue;
    dpGet(_DpExists + ".V", dpValue);
    assertEqual(processValueIn.getValue(), expectedValue);
    assertEqual(dpValue, expectedValue);
    return 0;
  }

  private void assertMissingDpe(const string &dp, const string &dpe)
  {
    try
    {
      shared_ptr<MTP_DIntProcessValueIn> processValueIn = new MTP_DIntProcessValueIn(dp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(dp + dpe));
    }
  }

  private void setValueChangedCB(const int &value)
  {
    _eventValue = value;
  }
};

void main()
{
  TstMTP_DIntProcessValueIn test;
  test.startAll();
}
