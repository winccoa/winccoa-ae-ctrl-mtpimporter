// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_TriPosVlv/MTP_TriPosVlv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_TriPosVlv/MTP_TriPosVlv.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_TriPosVlv/MTP_TriPosVlv" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_TriPosVlv.ctl
*/
class TstMTP_TriPosVlv : OaTest
{
  private const string _Dpt = "MTP_TriPosVlv";
  private const string _DpExists = "ExistingTestDatapoint";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _constructorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;

  private int _eventSafePosition;
  private bool _eventSafePositionEnabled;
  private bool _eventSafePositionActive;

  private int _eventPos1Configuration;
  private int _eventPos2Configuration;
  private int _eventPos3Configuration;

  private bool _eventPos1Automatic;
  private bool _eventPos2Automatic;
  private bool _eventPos3Automatic;

  private bool _eventPos1Control;
  private bool _eventPos2Control;
  private bool _eventPos3Control;

  private bool _eventPos1FeedbackSource;
  private bool _eventPos2FeedbackSource;
  private bool _eventPos3FeedbackSource;

  private bool _eventPos1FeedbackSignal;
  private bool _eventPos2FeedbackSignal;
  private bool _eventPos3FeedbackSignal;

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

    _eventSafePosition = 0;
    _eventSafePositionEnabled = false;
    _eventSafePositionActive = false;
    _eventPos1Configuration = 0;
    _eventPos2Configuration = 0;
    _eventPos3Configuration = 0;
    _eventPos1Automatic = false;
    _eventPos2Automatic = false;
    _eventPos3Automatic = false;
    _eventPos1Control = false;
    _eventPos2Control = false;
    _eventPos3Control = false;
    _eventPos1FeedbackSource = false;
    _eventPos2FeedbackSource = false;
    _eventPos3FeedbackSource = false;
    _eventPos1FeedbackSignal = false;
    _eventPos2FeedbackSignal = false;
    _eventPos3FeedbackSignal = false;
    _eventResetAutomatic = false;

    _allFields = makeDynString("tagName", "WQC", "OSLevel",
                               "SafePos", "SafePosEn", "SafePosAct",
                               "Pos1Conf", "Pos2Conf", "Pos3Conf",
                               "Pos1Op", "Pos2Op", "Pos3Op",
                               "Pos1Aut", "Pos2Aut", "Pos3Aut",
                               "Pos1Ctrl", "Pos2Ctrl", "Pos3Ctrl",
                               "Pos1FbkCalc", "Pos2FbkCalc", "Pos3FbkCalc",
                               "Pos1Fbk", "Pos2Fbk", "Pos3Fbk",
                               "ResetOp", "ResetAut",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "PermEn", "Permit", "IntlEn", "Interlock", "ProtEn", "Protect");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_INT, DPEL_BOOL, DPEL_BOOL,
                           DPEL_INT, DPEL_INT, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL);

    _constructorFields = makeDynString("SafePos", "SafePosEn", "SafePosAct",
                                       "Pos1Conf", "Pos2Conf", "Pos3Conf",
                                       "Pos1Op", "Pos2Op", "Pos3Op",
                                       "Pos1Aut", "Pos2Aut", "Pos3Aut",
                                       "Pos1Ctrl", "Pos2Ctrl", "Pos3Ctrl",
                                       "Pos1FbkCalc", "Pos2FbkCalc", "Pos3FbkCalc",
                                       "Pos1Fbk", "Pos2Fbk", "Pos3Fbk",
                                       "ResetOp", "ResetAut");

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
    dpSetWait(_DpExists + ".Pos1Op", TRUE,
              _DpExists + ".Pos2Op", FALSE,
              _DpExists + ".Pos3Op", TRUE,
              _DpExists + ".ResetOp", TRUE);

    shared_ptr<MTP_TriPosVlv> triPosVlv = new MTP_TriPosVlv(_DpExists);
    assertEqual(triPosVlv.getDp(), _DpExists);
    assertEqual(triPosVlv.getPos1Operator(), TRUE);
    assertEqual(triPosVlv.getPos2Operator(), FALSE);
    assertEqual(triPosVlv.getPos3Operator(), TRUE);
    assertEqual(triPosVlv.getResetOperator(), TRUE);
    assertTrue(triPosVlv.getWqc() != nullptr);
    assertTrue(triPosVlv.getOsLevel() != nullptr);
    assertTrue(triPosVlv.getState() != nullptr);
    assertTrue(triPosVlv.getSecurity() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      try
      {
        shared_ptr<MTP_TriPosVlv> triPosVlv = new MTP_TriPosVlv(_invalidDps[i]);
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
    shared_ptr<MTP_TriPosVlv> triPosVlv = new MTP_TriPosVlv(_DpExists);

    classConnect(this, safePositionChangedCB, triPosVlv, MTP_TriPosVlv::safePositionChanged);
    classConnect(this, safePositionEnabledChangedCB, triPosVlv, MTP_TriPosVlv::safePositionEnabledChanged);
    classConnect(this, safePositionActiveChangedCB, triPosVlv, MTP_TriPosVlv::safePositionActiveChanged);

    classConnect(this, pos1ConfigurationChangedCB, triPosVlv, MTP_TriPosVlv::pos1ConfigurationChanged);
    classConnect(this, pos2ConfigurationChangedCB, triPosVlv, MTP_TriPosVlv::pos2ConfigurationChanged);
    classConnect(this, pos3ConfigurationChangedCB, triPosVlv, MTP_TriPosVlv::pos3ConfigurationChanged);

    classConnect(this, pos1AutomaticChangedCB, triPosVlv, MTP_TriPosVlv::pos1AutomaticChanged);
    classConnect(this, pos2AutomaticChangedCB, triPosVlv, MTP_TriPosVlv::pos2AutomaticChanged);
    classConnect(this, pos3AutomaticChangedCB, triPosVlv, MTP_TriPosVlv::pos3AutomaticChanged);

    classConnect(this, pos1ControlChangedCB, triPosVlv, MTP_TriPosVlv::pos1ControlChanged);
    classConnect(this, pos2ControlChangedCB, triPosVlv, MTP_TriPosVlv::pos2ControlChanged);
    classConnect(this, pos3ControlChangedCB, triPosVlv, MTP_TriPosVlv::pos3ControlChanged);

    classConnect(this, pos1FeedbackSourceChangedCB, triPosVlv, MTP_TriPosVlv::pos1FeedbackSourceChanged);
    classConnect(this, pos2FeedbackSourceChangedCB, triPosVlv, MTP_TriPosVlv::pos2FeedbackSourceChanged);
    classConnect(this, pos3FeedbackSourceChangedCB, triPosVlv, MTP_TriPosVlv::pos3FeedbackSourceChanged);

    classConnect(this, pos1FeedbackSignalChangedCB, triPosVlv, MTP_TriPosVlv::pos1FeedbackSignalChanged);
    classConnect(this, pos2FeedbackSignalChangedCB, triPosVlv, MTP_TriPosVlv::pos2FeedbackSignalChanged);
    classConnect(this, pos3FeedbackSignalChangedCB, triPosVlv, MTP_TriPosVlv::pos3FeedbackSignalChanged);

    classConnect(this, resetAutomaticChangedCB, triPosVlv, MTP_TriPosVlv::resetAutomaticChanged);

    dpSetWait(_DpExists + ".SafePos", 3,
              _DpExists + ".SafePosEn", TRUE,
              _DpExists + ".SafePosAct", TRUE,
              _DpExists + ".Pos1Conf", 11,
              _DpExists + ".Pos2Conf", 12,
              _DpExists + ".Pos3Conf", 13,
              _DpExists + ".Pos1Aut", TRUE,
              _DpExists + ".Pos2Aut", TRUE,
              _DpExists + ".Pos3Aut", TRUE,
              _DpExists + ".Pos1Ctrl", TRUE,
              _DpExists + ".Pos2Ctrl", TRUE,
              _DpExists + ".Pos3Ctrl", TRUE,
              _DpExists + ".Pos1FbkCalc", TRUE,
              _DpExists + ".Pos2FbkCalc", TRUE,
              _DpExists + ".Pos3FbkCalc", TRUE,
              _DpExists + ".Pos1Fbk", TRUE,
              _DpExists + ".Pos2Fbk", TRUE,
              _DpExists + ".Pos3Fbk", TRUE,
              _DpExists + ".ResetAut", TRUE);

    delay(0, 200);

    assertEqual(triPosVlv.getSafePosition(), 3);
    assertTrue(triPosVlv.getSafePositionEnabled());
    assertTrue(triPosVlv.getSafePositionActive());
    assertEqual(triPosVlv.getPos1Configuration(), 11);
    assertEqual(triPosVlv.getPos2Configuration(), 12);
    assertEqual(triPosVlv.getPos3Configuration(), 13);
    assertTrue(triPosVlv.getPos1Automatic());
    assertTrue(triPosVlv.getPos2Automatic());
    assertTrue(triPosVlv.getPos3Automatic());
    assertTrue(triPosVlv.getPos1Control());
    assertTrue(triPosVlv.getPos2Control());
    assertTrue(triPosVlv.getPos3Control());
    assertTrue(triPosVlv.getPos1FeedbackSource());
    assertTrue(triPosVlv.getPos2FeedbackSource());
    assertTrue(triPosVlv.getPos3FeedbackSource());
    assertTrue(triPosVlv.getPos1FeedbackSignal());
    assertTrue(triPosVlv.getPos2FeedbackSignal());
    assertTrue(triPosVlv.getPos3FeedbackSignal());
    assertTrue(triPosVlv.getResetAutomatic());

    assertEqual(_eventSafePosition, 3);
    assertTrue(_eventSafePositionEnabled);
    assertTrue(_eventSafePositionActive);
    assertEqual(_eventPos1Configuration, 11);
    assertEqual(_eventPos2Configuration, 12);
    assertEqual(_eventPos3Configuration, 13);
    assertTrue(_eventPos1Automatic);
    assertTrue(_eventPos2Automatic);
    assertTrue(_eventPos3Automatic);
    assertTrue(_eventPos1Control);
    assertTrue(_eventPos2Control);
    assertTrue(_eventPos3Control);
    assertTrue(_eventPos1FeedbackSource);
    assertTrue(_eventPos2FeedbackSource);
    assertTrue(_eventPos3FeedbackSource);
    assertTrue(_eventPos1FeedbackSignal);
    assertTrue(_eventPos2FeedbackSignal);
    assertTrue(_eventPos3FeedbackSignal);
    assertTrue(_eventResetAutomatic);

    return 0;
  }

  public int testSetters()
  {
    shared_ptr<MTP_TriPosVlv> triPosVlv = new MTP_TriPosVlv(_DpExists);
    triPosVlv.setPos1Operator(TRUE);
    triPosVlv.setPos2Operator(TRUE);
    triPosVlv.setPos3Operator(TRUE);
    triPosVlv.setResetOperator(TRUE);

    bool pos1Op;
    bool pos2Op;
    bool pos3Op;
    bool resetOp;
    dpGet(_DpExists + ".Pos1Op", pos1Op,
          _DpExists + ".Pos2Op", pos2Op,
          _DpExists + ".Pos3Op", pos3Op,
          _DpExists + ".ResetOp", resetOp);

    assertTrue(pos1Op);
    assertTrue(pos2Op);
    assertTrue(pos3Op);
    assertTrue(resetOp);
    assertTrue(triPosVlv.getPos1Operator());
    assertTrue(triPosVlv.getPos2Operator());
    assertTrue(triPosVlv.getPos3Operator());
    assertTrue(triPosVlv.getResetOperator());
    return 0;
  }

  private void safePositionChangedCB(const int &value)
  {
    _eventSafePosition = value;
  }

  private void safePositionEnabledChangedCB(const bool &value)
  {
    _eventSafePositionEnabled = value;
  }

  private void safePositionActiveChangedCB(const bool &value)
  {
    _eventSafePositionActive = value;
  }

  private void pos1ConfigurationChangedCB(const int &value)
  {
    _eventPos1Configuration = value;
  }

  private void pos2ConfigurationChangedCB(const int &value)
  {
    _eventPos2Configuration = value;
  }

  private void pos3ConfigurationChangedCB(const int &value)
  {
    _eventPos3Configuration = value;
  }

  private void pos1AutomaticChangedCB(const bool &value)
  {
    _eventPos1Automatic = value;
  }

  private void pos2AutomaticChangedCB(const bool &value)
  {
    _eventPos2Automatic = value;
  }

  private void pos3AutomaticChangedCB(const bool &value)
  {
    _eventPos3Automatic = value;
  }

  private void pos1ControlChangedCB(const bool &value)
  {
    _eventPos1Control = value;
  }

  private void pos2ControlChangedCB(const bool &value)
  {
    _eventPos2Control = value;
  }

  private void pos3ControlChangedCB(const bool &value)
  {
    _eventPos3Control = value;
  }

  private void pos1FeedbackSourceChangedCB(const bool &value)
  {
    _eventPos1FeedbackSource = value;
  }

  private void pos2FeedbackSourceChangedCB(const bool &value)
  {
    _eventPos2FeedbackSource = value;
  }

  private void pos3FeedbackSourceChangedCB(const bool &value)
  {
    _eventPos3FeedbackSource = value;
  }

  private void pos1FeedbackSignalChangedCB(const bool &value)
  {
    _eventPos1FeedbackSignal = value;
  }

  private void pos2FeedbackSignalChangedCB(const bool &value)
  {
    _eventPos2FeedbackSignal = value;
  }

  private void pos3FeedbackSignalChangedCB(const bool &value)
  {
    _eventPos3FeedbackSignal = value;
  }

  private void resetAutomaticChangedCB(const bool &value)
  {
    _eventResetAutomatic = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_TriPosVlv test;
  test.startAll();
}
