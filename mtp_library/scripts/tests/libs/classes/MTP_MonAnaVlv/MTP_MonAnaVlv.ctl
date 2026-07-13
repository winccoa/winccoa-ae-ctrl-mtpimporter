// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_MonAnaVlv/MTP_MonAnaVlv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_MonAnaVlv/MTP_MonAnaVlv.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_MonAnaVlv/MTP_MonAnaVlv" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_MonAnaVlv.ctl
*/
class TstMTP_MonAnaVlv : OaTest
{
  private const string _Dpt = "MTP_MonAnaVlv";
  private const string _DpExists = "ExistingTestDatapoint";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _monitorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;

  private bool _evPositionReachedFeedback;
  private float _evPositionTolerance;
  private float _evMonitorPositionTime;
  private bool _evMonitorPositionError;

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
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "SrcChannel", "SrcManAut", "SrcIntAut", "SrcManOp", "SrcIntOp", "SrcManAct", "SrcIntAct",
                               "SafePos", "SafePosEn", "SafePosAct",
                               "OpenAut", "CloseAut", "OpenOp", "CloseOp", "OpenAct", "CloseAct",
                               "PosSclMin", "PosSclMax", "PosUnit", "PosMin", "PosMax", "PosInt", "PosMan", "PosRbk", "Pos",
                                "OpenFbkCalc", "OpenFbk", "CloseFbkCalc", "CloseFbk", "PosFbkCalc", "PosFbk",
                               "PosReachedFbk", "PosTolerance", "MonPosTi", "MonPosErr",
                               "PermEn", "Permit", "IntlEn", "Interlock", "ProtEn", "Protect",
                               "ResetOp", "ResetAut",
                               "MonEn", "MonSafePos", "MonStatErr", "MonDynErr", "MonStatTi", "MonDynTi");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_INT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_FLOAT,
                           DPEL_BOOL, DPEL_FLOAT, DPEL_FLOAT, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_FLOAT, DPEL_FLOAT);

    _monitorFields = makeDynString("MonEn", "MonSafePos", "MonStatErr", "MonDynErr", "MonStatTi", "MonDynTi",
                                   "PosReachedFbk", "PosTolerance", "MonPosTi", "MonPosErr");

    createTypeAndDp(_Dpt, _DpExists, "");

    for (int i = 1; i <= dynlen(_monitorFields); i++)
    {
      string dptInvalid = _Dpt + "Invalid" + i;
      string dpInvalid = "ExistingTestDatapointInvalid" + i;
      createTypeAndDp(dptInvalid, dpInvalid, _monitorFields[i]);
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
    dpSetWait(_DpExists + ".PosReachedFbk", TRUE,
              _DpExists + ".PosTolerance", 1.5,
              _DpExists + ".MonPosTi", 7.5,
              _DpExists + ".MonPosErr", TRUE);

    shared_ptr<MTP_MonAnaVlv> monAnaVlv = new MTP_MonAnaVlv(_DpExists);
    assertEqual(monAnaVlv.getDp(), _DpExists);
    assertTrue(monAnaVlv.getPositionReachedFeedback());
    assertEqual(monAnaVlv.getPositionTolerance(), 1.5);
    assertEqual(monAnaVlv.getMonitorPositionTime(), 7.5);
    assertTrue(monAnaVlv.getMonitorPositionError());
    assertTrue(monAnaVlv.getMonitor() != nullptr);
    assertTrue(monAnaVlv.getState() != nullptr);
    assertTrue(monAnaVlv.getSource() != nullptr);
    assertTrue(monAnaVlv.getSecurity() != nullptr);
    return 0;
  }

  public int testPositionMonitoringFieldsChanged()
  {
    shared_ptr<MTP_MonAnaVlv> monAnaVlv = new MTP_MonAnaVlv(_DpExists);

    classConnect(this, positionReachedFeedbackChangedCB, monAnaVlv, MTP_MonAnaVlv::positionReachedFeedbackChanged);
    classConnect(this, positionToleranceChangedCB, monAnaVlv, MTP_MonAnaVlv::positionToleranceChanged);
    classConnect(this, monitorPositionTimeChangedCB, monAnaVlv, MTP_MonAnaVlv::monitorPositionTimeChanged);
    classConnect(this, monitorPositionErrorChangedCB, monAnaVlv, MTP_MonAnaVlv::monitorPositionErrorChanged);

    _evPositionReachedFeedback = FALSE;
    _evPositionTolerance = 0.0;
    _evMonitorPositionTime = 0.0;
    _evMonitorPositionError = FALSE;

    dpSetWait(_DpExists + ".PosReachedFbk", TRUE,
              _DpExists + ".PosTolerance", 2.25,
              _DpExists + ".MonPosTi", 12.5,
              _DpExists + ".MonPosErr", TRUE);
    delay(0, 200);

    assertTrue(monAnaVlv.getPositionReachedFeedback());
    assertEqual(monAnaVlv.getPositionTolerance(), 2.25);
    assertEqual(monAnaVlv.getMonitorPositionTime(), 12.5);
    assertTrue(monAnaVlv.getMonitorPositionError());

    assertTrue(_evPositionReachedFeedback);
    assertEqual(_evPositionTolerance, 2.25);
    assertEqual(_evMonitorPositionTime, 12.5);
    assertTrue(_evMonitorPositionError);

    return 0;
  }

  public int testConstructor_MissingMonitorDpes()
  {
    for (int i = 1; i <= dynlen(_monitorFields); i++)
    {
      try
      {
        shared_ptr<MTP_MonAnaVlv> monAnaVlv = new MTP_MonAnaVlv(_invalidDps[i]);
        assertTrue(false, "shouldn't reach here");
      }
      catch
      {
        dyn_errClass err = getLastException();
        assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
        assertTrue(getErrorText(err).contains(_invalidDps[i] + "." + _monitorFields[i]));
      }
    }

    return 0;
  }

  private void positionReachedFeedbackChangedCB(const bool &v)
  {
    _evPositionReachedFeedback = v;
  }

  private void positionToleranceChangedCB(const float &v)
  {
    _evPositionTolerance = v;
  }

  private void monitorPositionTimeChangedCB(const float &v)
  {
    _evMonitorPositionTime = v;
  }

  private void monitorPositionErrorChangedCB(const bool &v)
  {
    _evMonitorPositionError = v;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_MonAnaVlv test;
  test.startAll();
}
