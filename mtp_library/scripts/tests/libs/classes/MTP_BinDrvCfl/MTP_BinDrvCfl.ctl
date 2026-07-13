// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinDrvCfl/MTP_BinDrvCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinDrvCfl/MTP_BinDrvCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_BinDrvCfl/MTP_BinDrvCfl"
#uses "classes/oaTest/OaTest"

class TstMTP_BinDrvCfl : OaTest
{
  private const string _Dpt = "TstMTP_BinDrvCfl";
  private const string _DptInvalidMissingEnabled = "TstMTP_BinDrvCflInvalid1";
  private const string _DpExists = "TstMTP_BinDrvCflDp";
  private const string _DpExistsInvalidMissingEnabled = "TstMTP_BinDrvCflInvalidDp1";

  private bool _eventEnabled;

  private void createType(const string &dpt, const bool &includeEnabled)
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "OSLevel"),
                                         makeDynString("", "SafePos"),
                                         makeDynString("", "SafePosAct"),
                                         makeDynString("", "FwdEn"),
                                         makeDynString("", "RevEn"),
                                         makeDynString("", "StopOp"),
                                         makeDynString("", "FwdOp"),
                                         makeDynString("", "RevOp"),
                                         makeDynString("", "StopAut"),
                                         makeDynString("", "FwdAut"),
                                         makeDynString("", "RevAut"),
                                         makeDynString("", "FwdCtrl"),
                                         makeDynString("", "RevCtrl"),
                                         makeDynString("", "RevFbkCalc"),
                                         makeDynString("", "RevFbk"),
                                         makeDynString("", "FwdFbkCalc"),
                                         makeDynString("", "FwdFbk"),
                                         makeDynString("", "Trip"),
                                         makeDynString("", "ResetOp"),
                                         makeDynString("", "ResetAut"),
                                         makeDynString("", "StateChannel"),
                                         makeDynString("", "StateOffAut"),
                                         makeDynString("", "StateOpAut"),
                                         makeDynString("", "StateAutAut"),
                                         makeDynString("", "StateOffOp"),
                                         makeDynString("", "StateOpOp"),
                                         makeDynString("", "StateAutOp"),
                                         makeDynString("", "StateOpAct"),
                                         makeDynString("", "StateAutAct"),
                                         makeDynString("", "StateOffAct"),
                                         makeDynString("", "PermEn"),
                                         makeDynString("", "Permit"),
                                         makeDynString("", "IntlEn"),
                                         makeDynString("", "Interlock"),
                                         makeDynString("", "ProtEn"),
                                         makeDynString("", "Protect"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL));

    if (includeEnabled)
    {
      dynAppend(dpes, makeDynString("", "enabled"));
      dynAppend(values, makeDynInt(0, DPEL_BOOL));
    }

    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
  }

  public int setUp() override
  {
    createType(_Dpt, TRUE);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    createType(_DptInvalidMissingEnabled, FALSE);
    if (!dpExists(_DpExistsInvalidMissingEnabled))
      dpCreate(_DpExistsInvalidMissingEnabled, _DptInvalidMissingEnabled);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    if (dpTypes(_Dpt).count() > 0)
      dpTypeDelete(_Dpt);

    dpDelete(_DpExistsInvalidMissingEnabled);

    if (dpTypes(_DptInvalidMissingEnabled).count() > 0)
      dpTypeDelete(_DptInvalidMissingEnabled);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_BinDrvCfl> binDrvCfl = new MTP_BinDrvCfl(_DpExists);

    assertEqual(binDrvCfl.getDp(), _DpExists);
    assertFalse(binDrvCfl.getEnabled());
    assertTrue(binDrvCfl.getWqc() != nullptr);
    assertTrue(binDrvCfl.getOsLevel() != nullptr);

    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(binDrvCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_BinDrvCfl> binDrvCfl = new MTP_BinDrvCfl(_DpExistsInvalidMissingEnabled);
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
    shared_ptr<MTP_BinDrvCfl> binDrvCfl = new MTP_BinDrvCfl(_DpExists);
    classConnect(this, enabledChangedCB, binDrvCfl, MTP_BinDrvCfl::enabledChanged);
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
  TstMTP_BinDrvCfl test;
  test.startAll();
}
