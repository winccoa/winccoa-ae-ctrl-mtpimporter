// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_ProcessValueIn/MTP_BinProcessValueIn.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_ProcessValueIn/MTP_BinProcessValueIn.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_ProcessValueIn/MTP_BinProcessValueIn"
#uses "classes/oaTest/OaTest"

/** Tests for MTP_BinProcessValueIn.ctl
*/
class TstMTP_BinProcessValueIn : OaTest
{
  private const string _Dpt = "MTP_BinProcessValueIn";
  private const string _DptInvalidMissingV = "MTP_BinProcessValueInInvalid1";
  private const string _DptInvalidMissingVState0 = "MTP_BinProcessValueInInvalid2";
  private const string _DptInvalidMissingVState1 = "MTP_BinProcessValueInInvalid3";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingV = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVState0 = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVState1 = "ExistingTestDatapointInvalid3";

  private bool _eventValue;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "VQC"),
                                         makeDynString("", "V"), makeDynString("", "VState0"), makeDynString("", "VState1"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingV),
                          makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "VQC"),
                          makeDynString("", "VState0"), makeDynString("", "VState1"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingV))
      dpCreate(_DpExistsInvalidMissingV, _DptInvalidMissingV);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVState0),
                          makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "VQC"),
                          makeDynString("", "V"), makeDynString("", "VState1"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVState0))
      dpCreate(_DpExistsInvalidMissingVState0, _DptInvalidMissingVState0);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVState1),
                          makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "VQC"),
                          makeDynString("", "V"), makeDynString("", "VState0"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVState1))
      dpCreate(_DpExistsInvalidMissingVState1, _DptInvalidMissingVState1);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingV);
    if (dpTypes(_DptInvalidMissingV).count() > 0)
      dpTypeDelete(_DptInvalidMissingV);
    dpDelete(_DpExistsInvalidMissingVState0);
    if (dpTypes(_DptInvalidMissingVState0).count() > 0)
      dpTypeDelete(_DptInvalidMissingVState0);
    dpDelete(_DpExistsInvalidMissingVState1);
    if (dpTypes(_DptInvalidMissingVState1).count() > 0)
      dpTypeDelete(_DptInvalidMissingVState1);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_BinProcessValueIn> processValueIn = new MTP_BinProcessValueIn(_DpExists);
    assertEqual(processValueIn.getDp(), _DpExists);
    assertEqual(processValueIn.getValue(), false);
    assertEqual(processValueIn.getValueStateFalseText(), "");
    assertEqual(processValueIn.getValueStateTrueText(), "");
    assertTrue(processValueIn.getWqc() != nullptr);
    assertTrue(processValueIn.getVqc() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    assertMissingDpe(_DpExistsInvalidMissingV, ".V");
    assertMissingDpe(_DpExistsInvalidMissingVState0, ".VState0");
    assertMissingDpe(_DpExistsInvalidMissingVState1, ".VState1");
    return 0;
  }

  public int testValueChanged()
  {
    shared_ptr<MTP_BinProcessValueIn> processValueIn = new MTP_BinProcessValueIn(_DpExists);
    classConnect(this, setValueChangedCB, processValueIn, MTP_BinProcessValueIn::valueChanged);
    _eventValue = false;

    dpSetWait(_DpExists + ".V", true);

    delay(0, 200);
    assertEqual(processValueIn.getValue(), true);
    assertEqual(_eventValue, true);
    return 0;
  }

  public int testSetValue()
  {
    shared_ptr<MTP_BinProcessValueIn> processValueIn = new MTP_BinProcessValueIn(_DpExists);

    processValueIn.setValue(true);
    delay(0, 200);

    bool dpValue;
    dpGet(_DpExists + ".V", dpValue);
    assertEqual(processValueIn.getValue(), true);
    assertEqual(dpValue, true);
    return 0;
  }

  private void assertMissingDpe(const string &dp, const string &dpe)
  {
    try
    {
      shared_ptr<MTP_BinProcessValueIn> processValueIn = new MTP_BinProcessValueIn(dp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(dp + dpe));
    }
  }

  private void setValueChangedCB(const bool &value)
  {
    _eventValue = value;
  }
};

void main()
{
  TstMTP_BinProcessValueIn test;
  test.startAll();
}
