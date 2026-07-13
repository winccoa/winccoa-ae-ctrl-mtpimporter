// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinDrv/MTP_BinDrv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinDrv/MTP_BinDrv.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_BinDrv/MTP_BinDrv" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_BinDrv.ctl
*/
class TstMTP_BinDrv : OaTest
{
  private const string _Dpt = "MTP_BinDrv";
  private const string _DpExists = "ExistingTestDatapoint";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _constructorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;

  private bool _eventForwardControl;
  private bool _eventReverseControl;
  private bool _eventForwardFeedbackSignal;
  private bool _eventReverseFeedbackSignal;
  private bool _eventDriveSafetyIndicator;
  private bool _eventSafetyPositionActive;
  private bool _eventSafetyPosition;
  private bool _eventForwardAutomatic;
  private bool _eventReverseAutomatic;
  private bool _eventStopAutomatic;
  private bool _eventResetAutomatic;

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
                               "SafePos", "SafePosAct", "FwdEn", "RevEn",
                               "StopOp", "FwdOp", "RevOp",
                               "StopAut", "FwdAut", "RevAut",
                               "FwdCtrl", "RevCtrl",
                               "RevFbkCalc", "RevFbk", "FwdFbkCalc", "FwdFbk",
                               "Trip", "ResetOp", "ResetAut",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "PermEn", "Permit", "IntlEn", "Interlock", "ProtEn", "Protect");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL);

    _constructorFields = makeDynString("SafePos", "SafePosAct", "FwdEn", "RevEn", "StopOp", "FwdOp", "RevOp", "StopAut", "FwdAut", "RevAut", "FwdCtrl", "RevCtrl", "RevFbkCalc", "RevFbk", "FwdFbkCalc", "FwdFbk", "Trip", "ResetOp", "ResetAut");

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
              _DpExists + ".ResetOp", TRUE);

    shared_ptr<MTP_BinDrv> binDrv = new MTP_BinDrv(_DpExists);
    assertEqual(binDrv.getDp(), _DpExists);
    assertTrue(binDrv.getForwardEnabled());
    assertTrue(binDrv.getReverseEnabled());
    assertTrue(binDrv.getStopOperator());
    assertTrue(binDrv.getForwardOperator());
    assertFalse(binDrv.getReverseOperator());
    assertTrue(binDrv.getReverseFeedbackSource());
    assertTrue(binDrv.getForwardFeedbackSource());
    assertTrue(binDrv.getResetOperator());
    assertTrue(binDrv.getWqc() != nullptr);
    assertTrue(binDrv.getOsLevel() != nullptr);
    assertTrue(binDrv.getState() != nullptr);
    assertTrue(binDrv.getSecurity() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      try
      {
        shared_ptr<MTP_BinDrv> binDrv = new MTP_BinDrv(_invalidDps[i]);
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
    shared_ptr<MTP_BinDrv> binDrv = new MTP_BinDrv(_DpExists);

    classConnect(this, forwardControlChangedCB, binDrv, MTP_BinDrv::forwardControlChanged);
    classConnect(this, reverseControlChangedCB, binDrv, MTP_BinDrv::reverseControlChanged);
    classConnect(this, forwardFeedbackSignalChangedCB, binDrv, MTP_BinDrv::forwardFeedbackSignalChanged);
    classConnect(this, reverseFeedbackSignalChangedCB, binDrv, MTP_BinDrv::reverseFeedbackSignalChanged);
    classConnect(this, driveSafetyIndicatorChangedCB, binDrv, MTP_BinDrv::driveSafetyIndicatorChanged);
    classConnect(this, safetyPositionActiveChangedCB, binDrv, MTP_BinDrv::safetyPositionActiveChanged);
    classConnect(this, safetyPositionChangedCB, binDrv, MTP_BinDrv::safetyPositionChanged);
    classConnect(this, forwardAutomaticChangedCB, binDrv, MTP_BinDrv::forwardAutomaticChanged);
    classConnect(this, reverseAutomaticChangedCB, binDrv, MTP_BinDrv::reverseAutomaticChanged);
    classConnect(this, stopAutomaticChangedCB, binDrv, MTP_BinDrv::stopAutomaticChanged);
    classConnect(this, resetAutomaticChangedCB, binDrv, MTP_BinDrv::resetAutomaticChanged);

    dpSetWait(_DpExists + ".FwdCtrl", TRUE,
              _DpExists + ".RevCtrl", TRUE,
              _DpExists + ".FwdFbk", TRUE,
              _DpExists + ".RevFbk", TRUE,
              _DpExists + ".Trip", TRUE,
              _DpExists + ".SafePosAct", TRUE,
              _DpExists + ".SafePos", TRUE,
              _DpExists + ".FwdAut", TRUE,
              _DpExists + ".RevAut", TRUE,
              _DpExists + ".StopAut", TRUE,
              _DpExists + ".ResetAut", TRUE);

    delay(0, 200);

    assertTrue(binDrv.getForwardControl());
    assertTrue(binDrv.getReverseControl());
    assertTrue(binDrv.getForwardFeedbackSignal());
    assertTrue(binDrv.getReverseFeedbackSignal());
    assertTrue(binDrv.getDriveSafetyIndicator());
    assertTrue(binDrv.getSafetyPositionActive());
    assertTrue(binDrv.getSafetyPosition());
    assertTrue(binDrv.getForwardAutomatic());
    assertTrue(binDrv.getReverseAutomatic());
    assertTrue(binDrv.getStopAutomatic());
    assertTrue(binDrv.getResetAutomatic());

    assertTrue(_eventForwardControl);
    assertTrue(_eventReverseControl);
    assertTrue(_eventForwardFeedbackSignal);
    assertTrue(_eventReverseFeedbackSignal);
    assertTrue(_eventDriveSafetyIndicator);
    assertTrue(_eventSafetyPositionActive);
    assertTrue(_eventSafetyPosition);
    assertTrue(_eventForwardAutomatic);
    assertTrue(_eventReverseAutomatic);
    assertTrue(_eventStopAutomatic);
    assertTrue(_eventResetAutomatic);

    return 0;
  }

  public int testSetters()
  {
    shared_ptr<MTP_BinDrv> binDrv = new MTP_BinDrv(_DpExists);
    binDrv.setStopOperator(TRUE);
    binDrv.setForwardOperator(TRUE);
    binDrv.setReverseOperator(TRUE);
    binDrv.setResetOperator(TRUE);

    bool stopOp;
    bool fwdOp;
    bool revOp;
    bool resetOp;
    dpGet(_DpExists + ".StopOp", stopOp,
          _DpExists + ".FwdOp", fwdOp,
          _DpExists + ".RevOp", revOp,
          _DpExists + ".ResetOp", resetOp);

    assertTrue(stopOp);
    assertTrue(fwdOp);
    assertTrue(revOp);
    assertTrue(resetOp);
    assertTrue(binDrv.getStopOperator());
    assertTrue(binDrv.getForwardOperator());
    assertTrue(binDrv.getReverseOperator());
    assertTrue(binDrv.getResetOperator());
    return 0;
  }

  private void forwardControlChangedCB(const bool &value)
  {
    _eventForwardControl = value;
  }

  private void reverseControlChangedCB(const bool &value)
  {
    _eventReverseControl = value;
  }

  private void forwardFeedbackSignalChangedCB(const bool &value)
  {
    _eventForwardFeedbackSignal = value;
  }

  private void reverseFeedbackSignalChangedCB(const bool &value)
  {
    _eventReverseFeedbackSignal = value;
  }

  private void driveSafetyIndicatorChangedCB(const bool &value)
  {
    _eventDriveSafetyIndicator = value;
  }

  private void safetyPositionActiveChangedCB(const bool &value)
  {
    _eventSafetyPositionActive = value;
  }

  private void safetyPositionChangedCB(const bool &value)
  {
    _eventSafetyPosition = value;
  }

  private void forwardAutomaticChangedCB(const bool &value)
  {
    _eventForwardAutomatic = value;
  }

  private void reverseAutomaticChangedCB(const bool &value)
  {
    _eventReverseAutomatic = value;
  }

  private void stopAutomaticChangedCB(const bool &value)
  {
    _eventStopAutomatic = value;
  }

  private void resetAutomaticChangedCB(const bool &value)
  {
    _eventResetAutomatic = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_BinDrv test;
  test.startAll();
}
