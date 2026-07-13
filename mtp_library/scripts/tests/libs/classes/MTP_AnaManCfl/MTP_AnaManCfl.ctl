// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_AnaManCfl/MTP_AnaManCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_AnaManCfl/MTP_AnaManCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_AnaManCfl/MTP_AnaManCfl"
#uses "classes/oaTest/OaTest"

class TstMTP_AnaManCfl : OaTest
{
  private const string _Dpt = "MTP_AnaManCfl";
  private const string _DptInvalidMissingEnabled = "MTP_AnaManCflInvalid1";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid1";

  private bool _eventEnabled;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "OSLevel"),
                                         makeDynString("", "VOut"),
                                         makeDynString("", "VSclMin"),
                                         makeDynString("", "VSclMax"),
                                         makeDynString("", "VUnit"),
                                         makeDynString("", "VMan"),
                                         makeDynString("", "VRbk"),
                                         makeDynString("", "VFbk"),
                                         makeDynString("", "VMin"),
                                         makeDynString("", "VMax"),
                                         makeDynString("", "enabled"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingEnabled),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
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
    shared_ptr<MTP_AnaManCfl> anaManCfl = new MTP_AnaManCfl(_DpExists);

    assertEqual(anaManCfl.getDp(), _DpExists);
    assertEqual(anaManCfl.getValueOut(), 0.0);
    assertEqual(anaManCfl.getValueScaleMin(), 0.0);
    assertEqual(anaManCfl.getValueScaleMax(), 0.0);
    assertEqual(anaManCfl.getValueManual(), 0.0);
    assertEqual(anaManCfl.getValueReadback(), 0.0);
    assertEqual(anaManCfl.getValueFeedback(), 0.0);
    assertEqual(anaManCfl.getValueMin(), 0.0);
    assertEqual(anaManCfl.getValueMax(), 0.0);
    assertFalse(anaManCfl.getEnabled());
    assertTrue(anaManCfl.getValueUnit() != nullptr);
    assertTrue(anaManCfl.getOsLevel() != nullptr);

    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(anaManCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_AnaManCfl> anaManCfl = new MTP_AnaManCfl(_DpExistsInvalidMissingEnabled);
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
    shared_ptr<MTP_AnaManCfl> anaManCfl = new MTP_AnaManCfl(_DpExists);
    classConnect(this, enabledChangedCB, anaManCfl, MTP_AnaManCfl::enabledChanged);
    _eventEnabled = FALSE;

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
  TstMTP_AnaManCfl test;
  test.startAll();
}
