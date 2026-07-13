// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_AnaMon/MTP_AnaMon.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_AnaMon/MTP_AnaMon.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/MTP_AnaMon/MTP_AnaMon" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_AnaMon.ctl
*/
class TstMTP_AnaMon : OaTest
{
  private const string _Dpt = "MTP_AnaMon";
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
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_FLOAT),
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
    shared_ptr<MTP_AnaMon> anaMon = new MTP_AnaMon(_DpExists);
    assertTrue(anaMon.getOsLevel() != nullptr);
    assertTrue(anaMon.getAlertHighLimit() != nullptr);
    assertTrue(anaMon.getWarningHighLimit() != nullptr);
    assertTrue(anaMon.getToleranceHighLimit() != nullptr);
    assertTrue(anaMon.getToleranceLowLimit() != nullptr);
    assertTrue(anaMon.getWarningLowLimit() != nullptr);
    assertTrue(anaMon.getAlertLowLimit() != nullptr);
    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_AnaMon test;
  test.startAll();
}
