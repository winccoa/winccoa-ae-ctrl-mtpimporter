// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_LockView8Cfl/MTP_LockView8Cfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_LockView8Cfl/MTP_LockView8Cfl.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_LockView8Cfl/MTP_LockView8Cfl"
#uses "classes/oaTest/OaTest"

class TstMTP_LockView8Cfl : OaTest
{
  private const string _Dpt = "MTP_LockView8Cfl";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingEnabled = "MTP_LockView8CflInvalid1";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid1";

  private bool _eventEnabled;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "Logic"), makeDynString("", "Out"), makeDynString("", "OutQC"),
                                         makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"), makeDynString("", "In1QC"),
                                         makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"), makeDynString("", "In2QC"),
                                         makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"), makeDynString("", "In3QC"),
                                         makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "In4QC"),
                                         makeDynString("", "In5En"), makeDynString("", "In5"), makeDynString("", "In5Inv"), makeDynString("", "In5Txt"), makeDynString("", "In5QC"),
                                         makeDynString("", "In6En"), makeDynString("", "In6"), makeDynString("", "In6Inv"), makeDynString("", "In6Txt"), makeDynString("", "In6QC"),
                                         makeDynString("", "In7En"), makeDynString("", "In7"), makeDynString("", "In7Inv"), makeDynString("", "In7Txt"), makeDynString("", "In7QC"),
                                         makeDynString("", "In8En"), makeDynString("", "In8"), makeDynString("", "In8Inv"), makeDynString("", "In8Txt"), makeDynString("", "In8QC"),
                                         makeDynString("", "enabled"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingEnabled),
                          makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "Logic"), makeDynString("", "Out"), makeDynString("", "OutQC"),
                          makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"), makeDynString("", "In1QC"),
                          makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"), makeDynString("", "In2QC"),
                          makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"), makeDynString("", "In3QC"),
                          makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "In4QC"),
                          makeDynString("", "In5En"), makeDynString("", "In5"), makeDynString("", "In5Inv"), makeDynString("", "In5Txt"), makeDynString("", "In5QC"),
                          makeDynString("", "In6En"), makeDynString("", "In6"), makeDynString("", "In6Inv"), makeDynString("", "In6Txt"), makeDynString("", "In6QC"),
                          makeDynString("", "In7En"), makeDynString("", "In7"), makeDynString("", "In7Inv"), makeDynString("", "In7Txt"), makeDynString("", "In7QC"),
                          makeDynString("", "In8En"), makeDynString("", "In8"), makeDynString("", "In8Inv"), makeDynString("", "In8Txt"), makeDynString("", "In8QC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32));
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
    shared_ptr<MTP_LockView8Cfl> lockView8Cfl = new MTP_LockView8Cfl(_DpExists);
    assertFalse(lockView8Cfl.getEnabled());
    assertTrue(lockView8Cfl.getInput8() != nullptr);
    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(lockView8Cfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_LockView8Cfl> lockView8Cfl = new MTP_LockView8Cfl(_DpExistsInvalidMissingEnabled);
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
    shared_ptr<MTP_LockView8Cfl> lockView8Cfl = new MTP_LockView8Cfl(_DpExists);
    classConnect(this, enabledChangedCB, lockView8Cfl, MTP_LockView8Cfl::enabledChanged);
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
  TstMTP_LockView8Cfl test;
  test.startAll();
}
