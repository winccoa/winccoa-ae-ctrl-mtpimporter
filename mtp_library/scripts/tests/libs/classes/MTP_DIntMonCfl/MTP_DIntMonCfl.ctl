// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_DIntMonCfl/MTP_DIntMonCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_DIntMonCfl/MTP_DIntMonCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_DIntMonCfl/MTP_DIntMonCfl"
#uses "classes/oaTest/OaTest"

class TstMTP_DIntMonCfl : OaTest
{
  private const string _Dpt = "MTP_DIntMonCfl";
  private const string _DptInvalidMissingEnabled = "MTP_DIntMonCflInvalid1";
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
                                         makeDynString("", "OSLevel"),
                                         makeDynString("", "VAHLim"),
                                         makeDynString("", "VAHEn"),
                                         makeDynString("", "VAHAct"),
                                         makeDynString("", "VWHLim"),
                                         makeDynString("", "VWHEn"),
                                         makeDynString("", "VWHAct"),
                                         makeDynString("", "VTHLim"),
                                         makeDynString("", "VTHEn"),
                                         makeDynString("", "VTHAct"),
                                         makeDynString("", "VTLLim"),
                                         makeDynString("", "VTLEn"),
                                         makeDynString("", "VTLAct"),
                                         makeDynString("", "VWLLim"),
                                         makeDynString("", "VWLEn"),
                                         makeDynString("", "VWLAct"),
                                         makeDynString("", "VALLim"),
                                         makeDynString("", "VALEn"),
                                         makeDynString("", "VALAct"),
                                         makeDynString("", "enabled"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
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
                          makeDynString("", "VUnit"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VAHLim"),
                          makeDynString("", "VAHEn"),
                          makeDynString("", "VAHAct"),
                          makeDynString("", "VWHLim"),
                          makeDynString("", "VWHEn"),
                          makeDynString("", "VWHAct"),
                          makeDynString("", "VTHLim"),
                          makeDynString("", "VTHEn"),
                          makeDynString("", "VTHAct"),
                          makeDynString("", "VTLLim"),
                          makeDynString("", "VTLEn"),
                          makeDynString("", "VTLAct"),
                          makeDynString("", "VWLLim"),
                          makeDynString("", "VWLEn"),
                          makeDynString("", "VWLAct"),
                          makeDynString("", "VALLim"),
                          makeDynString("", "VALEn"),
                          makeDynString("", "VALAct"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL));
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
    shared_ptr<MTP_DIntMonCfl> dIntMonCfl = new MTP_DIntMonCfl(_DpExists);
    assertTrue(dIntMonCfl.getOsLevel() != nullptr);
    assertTrue(dIntMonCfl.getAlertHighLimit() != nullptr);
    assertTrue(dIntMonCfl.getWarningHighLimit() != nullptr);
    assertTrue(dIntMonCfl.getToleranceHighLimit() != nullptr);
    assertTrue(dIntMonCfl.getToleranceLowLimit() != nullptr);
    assertTrue(dIntMonCfl.getWarningLowLimit() != nullptr);
    assertTrue(dIntMonCfl.getAlertLowLimit() != nullptr);
    assertFalse(dIntMonCfl.getEnabled());

    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(dIntMonCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_DIntMonCfl> dIntMonCfl = new MTP_DIntMonCfl(_DpExistsInvalidMissingEnabled);
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
    shared_ptr<MTP_DIntMonCfl> dIntMonCfl = new MTP_DIntMonCfl(_DpExists);
    classConnect(this, enabledChangedCB, dIntMonCfl, MTP_DIntMonCfl::enabledChanged);
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
  TstMTP_DIntMonCfl test;
  test.startAll();
}
