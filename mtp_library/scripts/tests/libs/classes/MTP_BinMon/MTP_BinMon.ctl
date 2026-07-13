// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinMon/MTP_BinMon.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinMon/MTP_BinMon.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_BinMon/MTP_BinMon" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_BinMon.ctl
*/
class TstMTP_BinMon : OaTest
{
  private const string _Dpt = "MTP_BinMon";
  private const string _DptInvalidMissingVFlutEn = "MTP_BinMonInvalid1";
  private const string _DptInvalidMissingVFlutTi = "MTP_BinMonInvalid2";
  private const string _DptInvalidMissingVFlutCnt = "MTP_BinMonInvalid3";
  private const string _DptInvalidMissingVFlutAct = "MTP_BinMonInvalid4";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingVFlutEn = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVFlutTi = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVFlutCnt = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVFlutAct = "ExistingTestDatapointInvalid4";

  private bool _eventFlutterActive;

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
                                         makeDynString("", "OSLevel"));
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
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVFlutEn),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VState0"),
                          makeDynString("", "VState1"),
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
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVFlutEn))
      dpCreate(_DpExistsInvalidMissingVFlutEn, _DptInvalidMissingVFlutEn);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVFlutTi),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VState0"),
                          makeDynString("", "VState1"),
                          makeDynString("", "VFlutEn"),
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
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVFlutTi))
      dpCreate(_DpExistsInvalidMissingVFlutTi, _DptInvalidMissingVFlutTi);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVFlutCnt),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VState0"),
                          makeDynString("", "VState1"),
                          makeDynString("", "VFlutEn"),
                          makeDynString("", "VFlutTi"),
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
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVFlutCnt))
      dpCreate(_DpExistsInvalidMissingVFlutCnt, _DptInvalidMissingVFlutCnt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVFlutAct),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VState0"),
                          makeDynString("", "VState1"),
                          makeDynString("", "VFlutEn"),
                          makeDynString("", "VFlutTi"),
                          makeDynString("", "VFlutCnt"),
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
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVFlutAct))
      dpCreate(_DpExistsInvalidMissingVFlutAct, _DptInvalidMissingVFlutAct);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingVFlutEn);

    if (dpTypes(_DptInvalidMissingVFlutEn).count() > 0)
      dpTypeDelete(_DptInvalidMissingVFlutEn);

    dpDelete(_DpExistsInvalidMissingVFlutTi);

    if (dpTypes(_DptInvalidMissingVFlutTi).count() > 0)
      dpTypeDelete(_DptInvalidMissingVFlutTi);

    dpDelete(_DpExistsInvalidMissingVFlutCnt);

    if (dpTypes(_DptInvalidMissingVFlutCnt).count() > 0)
      dpTypeDelete(_DptInvalidMissingVFlutCnt);

    dpDelete(_DpExistsInvalidMissingVFlutAct);

    if (dpTypes(_DptInvalidMissingVFlutAct).count() > 0)
      dpTypeDelete(_DptInvalidMissingVFlutAct);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_BinMon> binMon = new MTP_BinMon(_DpExists);
    assertEqual(binMon.getDp(), _DpExists);
    assertEqual(binMon.getValue(), false);
    assertEqual(binMon.getValueStateFalseText(), "");
    assertEqual(binMon.getValueStateTrueText(), "");
    assertEqual(binMon.getFlutterEnabled(), false);
    assertEqual(binMon.getFlutterTime(), 0.0);
    assertEqual(binMon.getFlutterCount(), 0);
    assertEqual(binMon.getFlutterActive(), false);
    assertTrue(binMon.getWqc() != nullptr);
    assertTrue(binMon.getOsLevel() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_BinMon> binMon = new MTP_BinMon(_DpExistsInvalidMissingVFlutEn);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFlutEn + ".VFlutEn"));
    }

    try
    {
      shared_ptr<MTP_BinMon> binMon = new MTP_BinMon(_DpExistsInvalidMissingVFlutTi);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFlutTi + ".VFlutTi"));
    }

    try
    {
      shared_ptr<MTP_BinMon> binMon = new MTP_BinMon(_DpExistsInvalidMissingVFlutCnt);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFlutCnt + ".VFlutCnt"));
    }

    try
    {
      shared_ptr<MTP_BinMon> binMon = new MTP_BinMon(_DpExistsInvalidMissingVFlutAct);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFlutAct + ".VFlutAct"));
    }

    return 0;
  }

  public int testFlutterActiveChanged()
  {
    shared_ptr<MTP_BinMon> binMon = new MTP_BinMon(_DpExists);
    classConnect(this, setFlutterActiveChangedCB, binMon, MTP_BinMon::flutterActiveChanged);
    _eventFlutterActive = false;

    dpSetWait(_DpExists + ".VFlutAct", true);

    delay(0, 200);
    assertEqual(binMon.getFlutterActive(), true);
    assertEqual(_eventFlutterActive, true);
    return 0;
  }

  public int testSetGetFlutterCount()
  {
    shared_ptr<MTP_BinMon> binMon = new MTP_BinMon(_DpExists);

    binMon.setFlutterCount(42);

    int dpValue;
    dpGet(_DpExists + ".VFlutCnt", dpValue);
    assertEqual(dpValue, 42);
    assertEqual(binMon.getFlutterCount(), 42);
    return 0;
  }

  public int testSetGetFlutterTime()
  {
    shared_ptr<MTP_BinMon> binMon = new MTP_BinMon(_DpExists);

    binMon.setFlutterTime(3.14);

    float dpValue;
    dpGet(_DpExists + ".VFlutTi", dpValue);
    assertEqual(dpValue, 3.14);
    assertEqual(binMon.getFlutterTime(), 3.14);
    return 0;
  }

  private void setFlutterActiveChangedCB(const bool &flutterActive)
  {
    _eventFlutterActive = flutterActive;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_BinMon test;
  test.startAll();
}
