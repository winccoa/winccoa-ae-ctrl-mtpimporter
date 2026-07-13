// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_AnaDrv/MTP_AnaDrv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_AnaDrv/MTP_AnaDrv.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_AnaDrv/MTP_AnaDrv"
#uses "classes/oaTest/OaTest"

class TstMTP_AnaDrv : OaTest
{
  private const string _Dpt = "MTP_AnaDrv";
  private const string _DpExists = "ExistingTestDatapoint";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _constructorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;

  private bool _evForwardControl;
  private bool _evReverseControl;
  private bool _evForwardFeedbackSignal;
  private bool _evReverseFeedbackSignal;
  private float _evRpmFeedbackSignal;
  private float _evRpm;
  private bool _evDriveSafetyIndicator;
  private bool _evSafetyPositionActive;
  private float _evRpmError;
  private bool _evStopAutomatic;
  private bool _evForwardAutomatic;
  private bool _evReverseAutomatic;
  private bool _evSafetyPosition;
  private bool _evResetAutomatic;
  private float _evRpmInternal;
  private float _evRpmManual;

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
                               "RpmUnit");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_INT);

    _constructorFields = makeDynString("SafePos", "SafePosAct", "FwdEn", "RevEn", "StopOp", "FwdOp", "RevOp", "StopAut", "FwdAut", "RevAut", "FwdCtrl", "RevCtrl", "RevFbkCalc", "RevFbk", "FwdFbkCalc", "FwdFbk", "Trip", "ResetOp", "ResetAut", "RpmFbk", "Rpm", "RpmErr", "RpmInt", "RpmSclMin", "RpmSclMax", "RpmRbk", "RpmMin", "RpmMax", "RpmMan", "RpmFbkCalc");

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
    dpSetWait(_DpExists + ".FwdEn", TRUE,
              _DpExists + ".RevEn", TRUE,
              _DpExists + ".StopOp", TRUE,
              _DpExists + ".FwdOp", TRUE,
              _DpExists + ".RevOp", FALSE,
              _DpExists + ".RevFbkCalc", TRUE,
              _DpExists + ".FwdFbkCalc", TRUE,
              _DpExists + ".ResetOp", TRUE,
              _DpExists + ".RpmSclMin", -100.0,
              _DpExists + ".RpmSclMax", 100.0,
              _DpExists + ".RpmMin", 10.0,
              _DpExists + ".RpmMax", 90.0,
              _DpExists + ".RpmFbkCalc", TRUE,
              _DpExists + ".RpmRbk", 55.0);

    shared_ptr<MTP_AnaDrv> anaDrv = new MTP_AnaDrv(_DpExists);
    assertEqual(anaDrv.getDp(), _DpExists);
    assertTrue(anaDrv.getForwardEnabled());
    assertTrue(anaDrv.getReverseEnabled());
    assertTrue(anaDrv.getStopOperator());
    assertTrue(anaDrv.getForwardOperator());
    assertFalse(anaDrv.getReverseOperator());
    assertTrue(anaDrv.getReverseFeedbackSource());
    assertTrue(anaDrv.getForwardFeedbackSource());
    assertTrue(anaDrv.getResetOperator());
    assertEqual(anaDrv.getRpmScaleMin(), -100.0);
    assertEqual(anaDrv.getRpmScaleMax(), 100.0);
    assertEqual(anaDrv.getRpmMin(), 10.0);
    assertEqual(anaDrv.getRpmMax(), 90.0);
    assertTrue(anaDrv.getRpmFeedbackSource());
    assertEqual(anaDrv.getRpmReadback(), 55.0);
    assertTrue(anaDrv.getWqc() != nullptr);
    assertTrue(anaDrv.getOsLevel() != nullptr);
    assertTrue(anaDrv.getState() != nullptr);
    assertTrue(anaDrv.getSecurity() != nullptr);
    assertTrue(anaDrv.getSource() != nullptr);
    assertTrue(anaDrv.getRpmUnit() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      try
      {
        shared_ptr<MTP_AnaDrv> anaDrv = new MTP_AnaDrv(_invalidDps[i]);
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

  public int testChangedEventsAndGetters()
  {
    shared_ptr<MTP_AnaDrv> anaDrv = new MTP_AnaDrv(_DpExists);
    classConnect(this, forwardControlChangedCB, anaDrv, MTP_AnaDrv::forwardControlChanged);
    classConnect(this, reverseControlChangedCB, anaDrv, MTP_AnaDrv::reverseControlChanged);
    classConnect(this, forwardFeedbackSignalChangedCB, anaDrv, MTP_AnaDrv::forwardFeedbackSignalChanged);
    classConnect(this, reverseFeedbackSignalChangedCB, anaDrv, MTP_AnaDrv::reverseFeedbackSignalChanged);
    classConnect(this, rpmFeedbackSignalChangedCB, anaDrv, MTP_AnaDrv::rpmFeedbackSignalChanged);
    classConnect(this, rpmChangedCB, anaDrv, MTP_AnaDrv::rpmChanged);
    classConnect(this, driveSafetyIndicatorChangedCB, anaDrv, MTP_AnaDrv::driveSafetyIndicatorChanged);
    classConnect(this, safetyPositionActiveChangedCB, anaDrv, MTP_AnaDrv::safetyPositionActiveChanged);
    classConnect(this, rpmErrorChangedCB, anaDrv, MTP_AnaDrv::rpmErrorChanged);
    classConnect(this, stopAutomaticChangedCB, anaDrv, MTP_AnaDrv::stopAutomaticChanged);
    classConnect(this, forwardAutomaticChangedCB, anaDrv, MTP_AnaDrv::forwardAutomaticChanged);
    classConnect(this, reverseAutomaticChangedCB, anaDrv, MTP_AnaDrv::reverseAutomaticChanged);
    classConnect(this, safetyPositionChangedCB, anaDrv, MTP_AnaDrv::safetyPositionChanged);
    classConnect(this, resetAutomaticChangedCB, anaDrv, MTP_AnaDrv::resetAutomaticChanged);
    classConnect(this, rpmInternalChangedCB, anaDrv, MTP_AnaDrv::rpmInternalChanged);
    classConnect(this, rpmManualChangedCB, anaDrv, MTP_AnaDrv::rpmManualChanged);

    dpSetWait(_DpExists + ".FwdCtrl", TRUE,
              _DpExists + ".RevCtrl", TRUE,
              _DpExists + ".FwdFbk", TRUE,
              _DpExists + ".RevFbk", TRUE,
              _DpExists + ".RpmFbk", 50.0,
              _DpExists + ".Rpm", 45.0,
              _DpExists + ".Trip", TRUE,
              _DpExists + ".SafePosAct", TRUE,
              _DpExists + ".RpmErr", 3.0,
              _DpExists + ".StopAut", TRUE,
              _DpExists + ".FwdAut", TRUE,
              _DpExists + ".RevAut", TRUE,
              _DpExists + ".SafePos", TRUE,
              _DpExists + ".ResetAut", TRUE,
              _DpExists + ".RpmInt", 40.0,
              _DpExists + ".RpmMan", 35.0);

    delay(0, 200);

    assertTrue(anaDrv.getForwardControl());
    assertTrue(anaDrv.getReverseControl());
    assertTrue(anaDrv.getForwardFeedbackSignal());
    assertTrue(anaDrv.getReverseFeedbackSignal());
    assertEqual(anaDrv.getRpmFeedbackSignal(), 50.0);
    assertEqual(anaDrv.getRpm(), 45.0);
    assertTrue(anaDrv.getDriveSafetyIndicator());
    assertTrue(anaDrv.getSafetyPositionActive());
    assertEqual(anaDrv.getRpmError(), 3.0);
    assertTrue(anaDrv.getStopAutomatic());
    assertTrue(anaDrv.getForwardAutomatic());
    assertTrue(anaDrv.getReverseAutomatic());
    assertTrue(anaDrv.getSafetyPosition());
    assertTrue(anaDrv.getResetAutomatic());
    assertEqual(anaDrv.getRpmInternal(), 40.0);
    assertEqual(anaDrv.getRpmManual(), 35.0);

    assertTrue(_evForwardControl);
    assertTrue(_evReverseControl);
    assertTrue(_evForwardFeedbackSignal);
    assertTrue(_evReverseFeedbackSignal);
    assertEqual(_evRpmFeedbackSignal, 50.0);
    assertEqual(_evRpm, 45.0);
    assertTrue(_evDriveSafetyIndicator);
    assertTrue(_evSafetyPositionActive);
    assertEqual(_evRpmError, 3.0);
    assertTrue(_evStopAutomatic);
    assertTrue(_evForwardAutomatic);
    assertTrue(_evReverseAutomatic);
    assertTrue(_evSafetyPosition);
    assertTrue(_evResetAutomatic);
    assertEqual(_evRpmInternal, 40.0);
    assertEqual(_evRpmManual, 35.0);

    return 0;
  }

  public int testSetters()
  {
    shared_ptr<MTP_AnaDrv> anaDrv = new MTP_AnaDrv(_DpExists);
    anaDrv.setStopOperator(TRUE);
    anaDrv.setForwardOperator(TRUE);
    anaDrv.setReverseOperator(TRUE);
    anaDrv.setResetOperator(TRUE);
    anaDrv.setRpmManual(77.7);

    bool stopOp;
    bool fwdOp;
    bool revOp;
    bool resetOp;
    float rpmMan;
    dpGet(_DpExists + ".StopOp", stopOp,
          _DpExists + ".FwdOp", fwdOp,
          _DpExists + ".RevOp", revOp,
          _DpExists + ".ResetOp", resetOp,
          _DpExists + ".RpmMan", rpmMan);

    assertTrue(stopOp);
    assertTrue(fwdOp);
    assertTrue(revOp);
    assertTrue(resetOp);
    assertEqual(rpmMan, 77.7);
    assertEqual(anaDrv.getRpmManual(), 77.7);
    return 0;
  }

  private void forwardControlChangedCB(const bool &v) { _evForwardControl = v; }
  private void reverseControlChangedCB(const bool &v) { _evReverseControl = v; }
  private void forwardFeedbackSignalChangedCB(const bool &v) { _evForwardFeedbackSignal = v; }
  private void reverseFeedbackSignalChangedCB(const bool &v) { _evReverseFeedbackSignal = v; }
  private void rpmFeedbackSignalChangedCB(const float &v) { _evRpmFeedbackSignal = v; }
  private void rpmChangedCB(const float &v) { _evRpm = v; }
  private void driveSafetyIndicatorChangedCB(const bool &v) { _evDriveSafetyIndicator = v; }
  private void safetyPositionActiveChangedCB(const bool &v) { _evSafetyPositionActive = v; }
  private void rpmErrorChangedCB(const float &v) { _evRpmError = v; }
  private void stopAutomaticChangedCB(const bool &v) { _evStopAutomatic = v; }
  private void forwardAutomaticChangedCB(const bool &v) { _evForwardAutomatic = v; }
  private void reverseAutomaticChangedCB(const bool &v) { _evReverseAutomatic = v; }
  private void safetyPositionChangedCB(const bool &v) { _evSafetyPosition = v; }
  private void resetAutomaticChangedCB(const bool &v) { _evResetAutomatic = v; }
  private void rpmInternalChangedCB(const float &v) { _evRpmInternal = v; }
  private void rpmManualChangedCB(const float &v) { _evRpmManual = v; }
};

void main()
{
  TstMTP_AnaDrv test;
  test.startAll();
}
