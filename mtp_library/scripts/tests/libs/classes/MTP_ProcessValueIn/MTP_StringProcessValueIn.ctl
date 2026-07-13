// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_ProcessValueIn/MTP_StringProcessValueIn.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_ProcessValueIn/MTP_StringProcessValueIn.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_ProcessValueIn/MTP_StringProcessValueIn"
#uses "classes/oaTest/OaTest"

/** Tests for MTP_StringProcessValueIn.ctl
*/
class TstMTP_StringProcessValueIn : OaTest
{
  private const string _Dpt = "MTP_StringProcessValueIn";
  private const string _DptInvalidMissingV = "MTP_StringProcessValueInInvalid1";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingV = "ExistingTestDatapointInvalid1";

  private string _eventValue;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "VQC"),
                                         makeDynString("", "V"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingV),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "VQC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingV))
      dpCreate(_DpExistsInvalidMissingV, _DptInvalidMissingV);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingV);

    if (dpTypes(_DptInvalidMissingV).count() > 0)
      dpTypeDelete(_DptInvalidMissingV);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_StringProcessValueIn> processValueIn = new MTP_StringProcessValueIn(_DpExists);
    assertEqual(processValueIn.getDp(), _DpExists);
    assertTrue(processValueIn.getWqc() != nullptr);
    assertTrue(processValueIn.getVqc() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_StringProcessValueIn> processValueIn = new MTP_StringProcessValueIn(_DpExistsInvalidMissingV);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingV + ".V"));
    }

    return 0;
  }

  public int testValueChanged()
  {
    shared_ptr<MTP_StringProcessValueIn> processValueIn = new MTP_StringProcessValueIn(_DpExists);
    classConnect(this, setValueChangedCB, processValueIn, MTP_StringProcessValueIn::valueChanged);
    _eventValue = "";

    dpSetWait(_DpExists + ".V", "Hello World");

    delay(0, 200);
    assertEqual(processValueIn.getValue(), "Hello World");
    assertEqual(_eventValue, "Hello World");
    return 0;
  }

  public int testSetValue()
  {
    shared_ptr<MTP_StringProcessValueIn> processValueIn = new MTP_StringProcessValueIn(_DpExists);
    string expectedValue = "Value set by setValue";

    processValueIn.setValue(expectedValue);
    delay(0, 200);

    string dpValue;
    dpGet(_DpExists + ".V", dpValue);
    assertEqual(processValueIn.getValue(), expectedValue);
    assertEqual(dpValue, expectedValue);
    return 0;
  }

  private void setValueChangedCB(const string &value)
  {
    _eventValue = value;
  }
};

void main()
{
  TstMTP_StringProcessValueIn test;
  test.startAll();
}
