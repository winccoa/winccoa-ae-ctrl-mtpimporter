// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_DIntMon/MTP_DIntMon.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_DIntMon/MTP_DIntMon.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/MTP_DIntMon/MTP_DIntMon" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_DIntMon.ctl
*/
class TstMTP_DIntMon : OaTest
{
  private const string _Dpt = "MTP_DIntMon";
  private const string _DpExists = "ExistingTestDatapoint";

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
                                         makeDynString("", "VALAct"));

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
                                        makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DIntMon> dIntMon = new MTP_DIntMon(_DpExists);

    assertTrue(dIntMon.getOsLevel() != nullptr);
    assertTrue(dIntMon.getAlertHighLimit() != nullptr);
    assertTrue(dIntMon.getWarningHighLimit() != nullptr);
    assertTrue(dIntMon.getToleranceHighLimit() != nullptr);
    assertTrue(dIntMon.getToleranceLowLimit() != nullptr);
    assertTrue(dIntMon.getWarningLowLimit() != nullptr);
    assertTrue(dIntMon.getAlertLowLimit() != nullptr);

    return 0;
  }

  public int testConfiguredLimitMapping()
  {
    int alertHighLimit = 1001;
    int warningHighLimit = 1002;
    int toleranceHighLimit = 1003;
    int toleranceLowLimit = -1003;
    int warningLowLimit = -1002;
    int alertLowLimit = -1001;

    dpSetWait(_DpExists + ".OSLevel", 1,
              _DpExists + ".VAHLim", alertHighLimit,
              _DpExists + ".VAHEn", TRUE,
              _DpExists + ".VAHAct", TRUE,
              _DpExists + ".VWHLim", warningHighLimit,
              _DpExists + ".VWHEn", TRUE,
              _DpExists + ".VWHAct", FALSE,
              _DpExists + ".VTHLim", toleranceHighLimit,
              _DpExists + ".VTHEn", FALSE,
              _DpExists + ".VTHAct", FALSE,
              _DpExists + ".VTLLim", toleranceLowLimit,
              _DpExists + ".VTLEn", TRUE,
              _DpExists + ".VTLAct", TRUE,
              _DpExists + ".VWLLim", warningLowLimit,
              _DpExists + ".VWLEn", TRUE,
              _DpExists + ".VWLAct", FALSE,
              _DpExists + ".VALLim", alertLowLimit,
              _DpExists + ".VALEn", FALSE,
              _DpExists + ".VALAct", FALSE);

    shared_ptr<MTP_DIntMon> dIntMon = new MTP_DIntMon(_DpExists);

    delay(0, 200);

    assertEqual(dIntMon.getOsLevel().getLevel(), 1);

    assertEqual(dIntMon.getAlertHighLimit().getLimit(), alertHighLimit);
    assertEqual(dIntMon.getAlertHighLimit().getEnabled(), TRUE);
    assertEqual(dIntMon.getAlertHighLimit().getActive(), TRUE);

    assertEqual(dIntMon.getWarningHighLimit().getLimit(), warningHighLimit);
    assertEqual(dIntMon.getWarningHighLimit().getEnabled(), TRUE);
    assertEqual(dIntMon.getWarningHighLimit().getActive(), FALSE);

    assertEqual(dIntMon.getToleranceHighLimit().getLimit(), toleranceHighLimit);
    assertEqual(dIntMon.getToleranceHighLimit().getEnabled(), FALSE);
    assertEqual(dIntMon.getToleranceHighLimit().getActive(), FALSE);

    assertEqual(dIntMon.getToleranceLowLimit().getLimit(), toleranceLowLimit);
    assertEqual(dIntMon.getToleranceLowLimit().getEnabled(), TRUE);
    assertEqual(dIntMon.getToleranceLowLimit().getActive(), TRUE);

    assertEqual(dIntMon.getWarningLowLimit().getLimit(), warningLowLimit);
    assertEqual(dIntMon.getWarningLowLimit().getEnabled(), TRUE);
    assertEqual(dIntMon.getWarningLowLimit().getActive(), FALSE);

    assertEqual(dIntMon.getAlertLowLimit().getLimit(), alertLowLimit);
    assertEqual(dIntMon.getAlertLowLimit().getEnabled(), FALSE);
    assertEqual(dIntMon.getAlertLowLimit().getActive(), FALSE);

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_DIntMon test;
  test.startAll();
}
