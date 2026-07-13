// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_DIntViewCfl/MTP_DIntViewCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_DIntViewCfl/MTP_DIntViewCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_DIntViewCfl/MTP_DIntViewCfl"
#uses "classes/oaTest/OaTest"

class TstMTP_DIntViewCfl : OaTest
{
  private const string _Dpt = "MTP_DIntViewCfl";
  private const string _DptInvalidMissingEnabled = "MTP_DIntViewCflInvalid1";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid1";

  private bool _eventEnabled;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "V"),
                                         makeDynString("", "VSclMin"),
                                         makeDynString("", "VSclMax"),
                                         makeDynString("", "VUnit"),
                                         makeDynString("", "enabled"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingEnabled),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingEnabled))
      dpCreate(_DpExistsInvalidMissingEnabled, _DptInvalidMissingEnabled);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingEnabled);

    if (dpTypes(_DptInvalidMissingEnabled).count() > 0)
      dpTypeDelete(_DptInvalidMissingEnabled);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DIntViewCfl> dIntViewCfl = new MTP_DIntViewCfl(_DpExists);
    int expectedInitialValue = 0;

    assertEqual(dIntViewCfl.getDp(), _DpExists);
    assertEqual(dIntViewCfl.getValue(), expectedInitialValue);
    assertEqual(dIntViewCfl.getValueScaleMin(), expectedInitialValue);
    assertEqual(dIntViewCfl.getValueScaleMax(), expectedInitialValue);
    assertFalse(dIntViewCfl.getEnabled());
    assertTrue(dIntViewCfl.getUnit() != nullptr);
    assertTrue(dIntViewCfl.getWqc() != nullptr);

    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(dIntViewCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_DIntViewCfl> dIntViewCfl = new MTP_DIntViewCfl(_DpExistsInvalidMissingEnabled);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingEnabled + ".enabled"));
    }

    return 0;
  }

  public int testEnabledChanged()
  {
    shared_ptr<MTP_DIntViewCfl> dIntViewCfl = new MTP_DIntViewCfl(_DpExists);
    classConnect(this, enabledChangedCB, dIntViewCfl, MTP_DIntViewCfl::enabledChanged);
    _eventEnabled = false;

    dpSetWait(_DpExists + ".enabled", TRUE);

    delay(0, 200);
    assertTrue(_eventEnabled);
    return 0;
  }

  private void enabledChangedCB(const bool &enabled)
  {
    _eventEnabled = enabled;
  }
};

void main()
{
  TstMTP_DIntViewCfl test;
  test.startAll();
}
