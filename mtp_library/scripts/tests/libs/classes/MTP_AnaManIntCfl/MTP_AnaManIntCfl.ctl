// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_AnaManIntCfl/MTP_AnaManIntCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_AnaManIntCfl/MTP_AnaManIntCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_AnaManIntCfl/MTP_AnaManIntCfl" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_AnaManIntCfl.ctl
*/
class TstMTP_AnaManIntCfl : OaTest
{
  private const string _Dpt = "MTP_AnaManIntCfl";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingEnabled = "MTP_AnaManIntCflInvalid1";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid1";

  private bool _eventEnabled;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "OSLevel"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "VOut"),
                                         makeDynString("", "VSclMin"),
                                         makeDynString("", "VSclMax"),
                                         makeDynString("", "VUnit"),
                                         makeDynString("", "VMan"),
                                         makeDynString("", "VInt"),
                                         makeDynString("", "VRbk"),
                                         makeDynString("", "VFbk"),
                                         makeDynString("", "VMin"),
                                         makeDynString("", "VMax"),
                                         makeDynString("", "SrcChannel"),
                                         makeDynString("", "SrcManAut"),
                                         makeDynString("", "SrcIntAut"),
                                         makeDynString("", "SrcManOp"),
                                         makeDynString("", "SrcIntOp"),
                                         makeDynString("", "SrcManAct"),
                                         makeDynString("", "SrcIntAct"),
                                         makeDynString("", "enabled"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingEnabled),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "WQC"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VInt"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"),
                          makeDynString("", "SrcChannel"),
                          makeDynString("", "SrcManAut"),
                          makeDynString("", "SrcIntAut"),
                          makeDynString("", "SrcManOp"),
                          makeDynString("", "SrcIntOp"),
                          makeDynString("", "SrcManAct"),
                          makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
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
    shared_ptr<MTP_AnaManIntCfl> anaManIntCfl = new MTP_AnaManIntCfl(_DpExists);
    assertFalse(anaManIntCfl.getEnabled());
    dpSetWait(_DpExists + ".enabled", TRUE);
    assertTrue(anaManIntCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_AnaManIntCfl> anaManIntCfl = new MTP_AnaManIntCfl(_DpExistsInvalidMissingEnabled);
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
    shared_ptr<MTP_AnaManIntCfl> anaManIntCfl = new MTP_AnaManIntCfl(_DpExists);
    classConnect(this, enabledChangedCB, anaManIntCfl, MTP_AnaManIntCfl::enabledChanged);
    _eventEnabled = false;
    dpSetWait(_DpExists + ".enabled", TRUE);
    assertTrue(_eventEnabled);
    return 0;
  }

  private void enabledChangedCB(const bool &enabled)
  {
    _eventEnabled = enabled;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_AnaManIntCfl test;
  test.startAll();
}
