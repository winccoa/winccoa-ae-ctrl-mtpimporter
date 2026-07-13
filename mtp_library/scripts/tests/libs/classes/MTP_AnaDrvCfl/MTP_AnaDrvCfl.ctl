// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_AnaDrvCfl/MTP_AnaDrvCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_AnaDrvCfl/MTP_AnaDrvCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_AnaDrvCfl/MTP_AnaDrvCfl"
#uses "classes/oaTest/OaTest"

/** Tests for MTP_AnaDrvCfl.ctl */
class TstMTP_AnaDrvCfl : OaTest
{
  private const string _Dpt = "MTP_AnaDrvCfl";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingEnabled = "MTP_AnaDrvCflInvalid1";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid1";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private bool _eventEnabled;

  private void createTypeAndDp(const string &dpt, const string &dp, const string &missingField)
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(dpt));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT));

    for (int i = 1; i <= dynlen(_allFields); i++)
    {
      if (_allFields[i] == missingField)
      {
        continue;
      }

      dynAppend(dpes, makeDynString("", _allFields[i]));
      dynAppend(values, makeDynInt(0, _allTypes[i]));
    }

    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(dp))
      dpCreate(dp, dpt);
    dynAppend(_createdDpts, dpt);
    dynAppend(_createdDps, dp);
  }

  public int setUp() override
  {
    _createdDpts = makeDynString();
    _createdDps = makeDynString();

    _allFields = makeDynString("tagName", "WQC", "OSLevel",
                               "SafePos", "SafePosAct", "FwdEn", "RevEn", "StopOp", "FwdOp", "RevOp", "StopAut", "FwdAut", "RevAut", "FwdCtrl", "RevCtrl",
                               "RevFbkCalc", "RevFbk", "FwdFbkCalc", "FwdFbk", "Trip", "ResetOp", "ResetAut",
                               "RpmFbk", "Rpm", "RpmErr", "RpmInt", "RpmSclMin", "RpmSclMax", "RpmRbk", "RpmMin", "RpmMax", "RpmMan", "RpmFbkCalc",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "PermEn", "Permit", "IntlEn", "Interlock", "ProtEn", "Protect",
                               "SrcChannel", "SrcManAut", "SrcIntAut", "SrcManOp", "SrcIntOp", "SrcManAct", "SrcIntAct",
                               "RpmUnit", "enabled");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_INT, DPEL_BOOL);

    createTypeAndDp(_Dpt, _DpExists, "");
    createTypeAndDp(_DptInvalidMissingEnabled, _DpExistsInvalidMissingEnabled, "enabled");

    return OaTest::setUp();
  }


  private bool isTestOnlyDpt(const string &dpt)
  {
    return dpt.contains("Invalid") || dpt.contains("Unsupported") || dpt.contains("UT") || dpt.contains("Tst") || dpt == "TestDpt";
  }
  public int tearDown() override
  {
    for (int i = 1; i <= dynlen(_createdDps); i++)
    {
      dpDelete(_createdDps[i]);
    }


    for (int i = 1; i <= dynlen(_createdDpts); i++)
    {
      if (isTestOnlyDpt(_createdDpts[i]) && dpTypes(_createdDpts[i]).count() > 0)
        dpTypeDelete(_createdDpts[i]);
    }
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_AnaDrvCfl> anaDrvCfl = new MTP_AnaDrvCfl(_DpExists);

    assertEqual(anaDrvCfl.getDp(), _DpExists);
    assertTrue(anaDrvCfl.getWqc() != nullptr);
    assertTrue(anaDrvCfl.getOsLevel() != nullptr);
    assertTrue(anaDrvCfl.getState() != nullptr);
    assertTrue(anaDrvCfl.getSecurity() != nullptr);
    assertTrue(anaDrvCfl.getSource() != nullptr);
    assertTrue(anaDrvCfl.getRpmUnit() != nullptr);
    assertFalse(anaDrvCfl.getEnabled());

    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(anaDrvCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_AnaDrvCfl> anaDrvCfl = new MTP_AnaDrvCfl(_DpExistsInvalidMissingEnabled);
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
    shared_ptr<MTP_AnaDrvCfl> anaDrvCfl = new MTP_AnaDrvCfl(_DpExists);
    classConnect(this, enabledChangedCB, anaDrvCfl, MTP_AnaDrvCfl::enabledChanged);
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

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_AnaDrvCfl test;
  test.startAll();
}
