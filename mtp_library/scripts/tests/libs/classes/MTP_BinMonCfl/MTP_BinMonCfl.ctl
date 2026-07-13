// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinMonCfl/MTP_BinMonCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinMonCfl/MTP_BinMonCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_BinMonCfl/MTP_BinMonCfl" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_BinMonCfl.ctl
*/
class TstMTP_BinMonCfl : OaTest
{
  private const string _Dpt = "MTP_BinMonCfl";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingEnabled = "MTP_BinMonCflInvalid1";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid1";

  private bool _eventEnabled;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "V"),
                                         makeDynString("", "VState0"),
                                         makeDynString("", "VState1"),
                                         makeDynString("", "VFlutEn"),
                                         makeDynString("", "VFlutTi"),
                                         makeDynString("", "VFlutCnt"),
                                         makeDynString("", "VFlutAct"),
                                         makeDynString("", "OSLevel"),
                                         makeDynString("", "enabled"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_STRING),
                                        makeDynInt(0, DPEL_STRING),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
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
                          makeDynString("", "VState0"),
                          makeDynString("", "VState1"),
                          makeDynString("", "VFlutEn"),
                          makeDynString("", "VFlutTi"),
                          makeDynString("", "VFlutCnt"),
                          makeDynString("", "VFlutAct"),
                          makeDynString("", "OSLevel"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_STRING),
                            makeDynInt(0, DPEL_STRING),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
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
    shared_ptr<MTP_BinMonCfl> binMonCfl = new MTP_BinMonCfl(_DpExists);
    assertFalse(binMonCfl.getEnabled());
    dpSetWait(_DpExists + ".enabled", TRUE);
    assertTrue(binMonCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_BinMonCfl> binMonCfl = new MTP_BinMonCfl(_DpExistsInvalidMissingEnabled);
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
    shared_ptr<MTP_BinMonCfl> binMonCfl = new MTP_BinMonCfl(_DpExists);
    classConnect(this, enabledChangedCB, binMonCfl, MTP_BinMonCfl::enabledChanged);
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
  TstMTP_BinMonCfl test;
  test.startAll();
}
