// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_MonAnaDrv/MTP_MonAnaDrv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_MonAnaDrv/MTP_MonAnaDrv.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_MonAnaDrv/MTP_MonAnaDrv"
#uses "classes/oaTest/OaTest"

class TstMTP_MonAnaDrv : OaTest
{
  private const string _Dpt = "MTP_MonAnaDrv";
  private const string _DpExists = "ExistingTestDatapoint";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _constructorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;

  private bool _evRpmAlarmHighActive;
  private bool _evRpmAlarmLowActive;

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
    _invalidDps = makeDynString();

    _allFields = makeDynString("tagName", "WQC", "OSLevel",
                               "SafePos", "SafePosAct", "FwdEn", "RevEn", "StopOp", "FwdOp", "RevOp", "StopAut", "FwdAut", "RevAut", "FwdCtrl", "RevCtrl",
                               "RevFbkCalc", "RevFbk", "FwdFbkCalc", "FwdFbk", "Trip", "ResetOp", "ResetAut",
                               "RpmFbk", "Rpm", "RpmErr", "RpmInt", "RpmSclMin", "RpmSclMax", "RpmRbk", "RpmMin", "RpmMax", "RpmMan", "RpmFbkCalc",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "PermEn", "Permit", "IntlEn", "Interlock", "ProtEn", "Protect",
                               "SrcChannel", "SrcManAut", "SrcIntAut", "SrcManOp", "SrcIntOp", "SrcManAct", "SrcIntAct",
                               "RpmUnit",
                               "RpmAHAct", "RpmALAct", "RpmAHEn", "RpmALEn", "RpmAHLim", "RpmALLim",
                               "MonEn", "MonSafePos", "MonStatErr", "MonDynErr", "MonStatTi", "MonDynTi");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_FLOAT, DPEL_FLOAT);

    _constructorFields = makeDynString("RpmAHAct", "RpmALAct", "RpmAHEn", "RpmALEn", "RpmAHLim", "RpmALLim", "MonEn", "MonSafePos", "MonStatErr", "MonDynErr", "MonStatTi", "MonDynTi");

    createTypeAndDp(_Dpt, _DpExists, "");

    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      string dptInvalid = _Dpt + "Invalid" + i;
      string dpInvalid = "ExistingTestDatapointInvalid" + i;
      createTypeAndDp(dptInvalid, dpInvalid, _constructorFields[i]);
      dynAppend(_invalidDps, dpInvalid);
    }

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
    dpSetWait(_DpExists + ".RpmAHEn", TRUE,
              _DpExists + ".RpmALEn", TRUE,
              _DpExists + ".RpmAHLim", 88.8,
              _DpExists + ".RpmALLim", 11.1);

    shared_ptr<MTP_MonAnaDrv> monAnaDrv = new MTP_MonAnaDrv(_DpExists);
    assertEqual(monAnaDrv.getDp(), _DpExists);
    assertTrue(monAnaDrv.getRpmAlarmHighEnabled());
    assertTrue(monAnaDrv.getRpmAlarmLowEnabled());
    assertEqual(monAnaDrv.getRpmAlarmHighLimit(), 88.8);
    assertEqual(monAnaDrv.getRpmAlarmLowLimit(), 11.1);
    assertTrue(monAnaDrv.getMonitor() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      try
      {
        shared_ptr<MTP_MonAnaDrv> monAnaDrv = new MTP_MonAnaDrv(_invalidDps[i]);
        assertTrue(false, "shouldn't reach here");
      }
      catch
      {
        dyn_errClass err = getLastException();
        assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
        assertTrue(getErrorText(err).contains(_invalidDps[i] + "." + _constructorFields[i]));
      }
    }
    return 0;
  }

  public int testAlarmActiveChangedAndSetters()
  {
    shared_ptr<MTP_MonAnaDrv> monAnaDrv = new MTP_MonAnaDrv(_DpExists);
    classConnect(this, rpmAlarmHighActiveChangedCB, monAnaDrv, MTP_MonAnaDrv::rpmAlarmHighActiveChanged);
    classConnect(this, rpmAlarmLowActiveChangedCB, monAnaDrv, MTP_MonAnaDrv::rpmAlarmLowActiveChanged);

    dpSetWait(_DpExists + ".RpmAHAct", TRUE,
              _DpExists + ".RpmALAct", TRUE);
    delay(0, 200);

    assertTrue(monAnaDrv.getRpmAlarmHighActive());
    assertTrue(monAnaDrv.getRpmAlarmLowActive());
    assertTrue(_evRpmAlarmHighActive);
    assertTrue(_evRpmAlarmLowActive);

    monAnaDrv.setRpmAlarmHighLimit(99.1);
    monAnaDrv.setRpmAlarmLowLimit(22.2);

    float ahLim;
    float alLim;
    dpGet(_DpExists + ".RpmAHLim", ahLim,
          _DpExists + ".RpmALLim", alLim);

    assertEqual(ahLim, 99.1);
    assertEqual(alLim, 22.2);
    assertEqual(monAnaDrv.getRpmAlarmHighLimit(), 99.1);
    assertEqual(monAnaDrv.getRpmAlarmLowLimit(), 22.2);
    return 0;
  }

  private void rpmAlarmHighActiveChangedCB(const bool &v) { _evRpmAlarmHighActive = v; }
  private void rpmAlarmLowActiveChangedCB(const bool &v) { _evRpmAlarmLowActive = v; }
};

void main()
{
  TstMTP_MonAnaDrv test;
  test.startAll();
}
