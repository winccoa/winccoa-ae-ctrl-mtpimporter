// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_AnaVlv/MTP_AnaVlv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_AnaVlv/MTP_AnaVlv.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_AnaVlv/MTP_AnaVlv" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_AnaVlv.ctl
*/
class TstMTP_AnaVlv : OaTest
{
  private const string _Dpt = "MTP_AnaVlvUT";
  private const string _DpExists = "ExistingTestDatapointUT";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _constructorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;
  private dyn_string _invalidFields;

  private bool _eventSafetyPosition;
  private bool _eventSafetyPositionEnabled;
  private bool _eventSafetyPositionActive;
  private bool _eventOpenAutomatic;
  private bool _eventCloseAutomatic;
  private bool _eventOpenActive;
  private bool _eventCloseActive;
  private bool _eventOpenFeedback;
  private bool _eventCloseFeedback;
  private bool _eventResetAutomatic;
  private float _eventPosition;
  private float _eventPositionInternal;
  private float _eventPositionFeedback;

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
    delay(0, 50);

    if (dpExists(dp))
    {
      dpDelete(dp);
      delay(0, 50);
    }

    if (!dpExists(dp))
      dpCreate(dp, dpt);
    delay(0, 50);

    if (!dpExists(dp))
    {
      if (!dpExists(dp))
        dpCreate(dp, dpt);
      delay(0, 50);
    }

    if (dpExists(dp))
    {
      dynAppend(_createdDpts, dpt);
      dynAppend(_createdDps, dp);
    }
  }

  public int setUp() override
  {
    _createdDpts = makeDynString();
    _createdDps = makeDynString();
    _invalidDps = makeDynString();
    _invalidFields = makeDynString();

    _allFields = makeDynString("tagName", "WQC", "OSLevel",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "SrcChannel", "SrcManAut", "SrcIntAut", "SrcManOp", "SrcIntOp", "SrcManAct", "SrcIntAct",
                               "SafePos", "SafePosEn", "SafePosAct",
                               "OpenAut", "CloseAut", "OpenOp", "CloseOp", "OpenAct", "CloseAct",
                               "PosSclMin", "PosSclMax", "PosUnit", "PosMin", "PosMax", "PosInt", "PosMan", "PosRbk", "Pos",
                               "OpenFbkCalc", "OpenFbk", "CloseFbkCalc", "CloseFbk", "PosFbkCalc", "PosFbk",
                               "PermEn", "Permit", "IntlEn", "Interlock", "ProtEn", "Protect",
                               "ResetOp", "ResetAut");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_INT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_FLOAT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL);

    _constructorFields = makeDynString("SafePos", "SafePosEn", "SafePosAct", "OpenAut", "CloseAut", "OpenOp", "CloseOp", "OpenAct", "CloseAct", "PosSclMin", "PosSclMax", "PosMin", "PosMax", "PosInt", "PosMan", "PosRbk", "Pos", "OpenFbkCalc", "OpenFbk", "CloseFbkCalc", "CloseFbk", "PosFbkCalc", "PosFbk", "ResetOp", "ResetAut", "PosUnit", "IntlEn", "StateChannel", "SrcChannel");

    if (dpExists(_DpExists))
    {
      dpDelete(_DpExists);
      if (dpTypes(_Dpt).count() > 0)
        dpTypeDelete(_Dpt);
    }

    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      string dpInvalid = "ExistingTestDatapointUTInvalid" + i;
      if (dpExists(dpInvalid))
      {
        dpDelete(dpInvalid);
      }
    }

    createTypeAndDp(_Dpt, _DpExists, "");

    if (!dpExists(_DpExists))
    {
      createTypeAndDp(_Dpt, _DpExists, "");

      if (!dpExists(_DpExists))
      {
        if (!dpExists(_DpExists))
          dpCreate(_DpExists, "MTP_AnaVlv");
        delay(0, 50);
      }
    }

    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      string dptInvalid = _Dpt + "Invalid" + i;
      string dpInvalid = "ExistingTestDatapointUTInvalid" + i;
      createTypeAndDp(dptInvalid, dpInvalid, _constructorFields[i]);

      if (dpExists(dpInvalid))
      {
        dynAppend(_invalidDps, dpInvalid);
        dynAppend(_invalidFields, _constructorFields[i]);
      }
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
    if (!dpExists(_DpExists))
    {
      if (!dpExists(_DpExists))
        dpCreate(_DpExists, _Dpt);
      delay(0, 50);

      if (!dpExists(_DpExists))
      {
        if (!dpExists(_DpExists))
          dpCreate(_DpExists, "MTP_AnaVlv");
        delay(0, 50);
      }
    }

    float expectedSclMin = 0.1;
    float expectedSclMax = 99.9;
    float expectedPosMin = 1.2;
    float expectedPosMax = 98.8;
    float expectedPosMan = 42.4;
    float expectedPosRbk = 41.4;

    dpSetWait(_DpExists + ".OpenOp", TRUE,
              _DpExists + ".CloseOp", FALSE,
              _DpExists + ".PosSclMin", expectedSclMin,
              _DpExists + ".PosSclMax", expectedSclMax,
              _DpExists + ".PosMin", expectedPosMin,
              _DpExists + ".PosMax", expectedPosMax,
              _DpExists + ".PosMan", expectedPosMan,
              _DpExists + ".PosRbk", expectedPosRbk,
              _DpExists + ".OpenFbkCalc", TRUE,
              _DpExists + ".CloseFbkCalc", FALSE,
              _DpExists + ".PosFbkCalc", TRUE,
              _DpExists + ".ResetOp", TRUE);

    shared_ptr<MTP_AnaVlv> anaVlv = new MTP_AnaVlv(_DpExists);

    assertEqual(anaVlv.getDp(), _DpExists);
    assertEqual(anaVlv.getOpenOperator(), TRUE);
    assertEqual(anaVlv.getCloseOperator(), FALSE);
    assertEqual(anaVlv.getPositionScaleMin(), expectedSclMin);
    assertEqual(anaVlv.getPositionScaleMax(), expectedSclMax);
    assertEqual(anaVlv.getPositionMin(), expectedPosMin);
    assertEqual(anaVlv.getPositionMax(), expectedPosMax);
    assertEqual(anaVlv.getPositionManual(), expectedPosMan);
    assertEqual(anaVlv.getPositionReadback(), expectedPosRbk);
    assertEqual(anaVlv.getOpenFeedbackCalculated(), TRUE);
    assertEqual(anaVlv.getCloseFeedbackCalculated(), FALSE);
    assertEqual(anaVlv.getPositionFeedbackCalculated(), TRUE);
    assertEqual(anaVlv.getResetOperator(), TRUE);
    assertTrue(anaVlv.getWqc() != nullptr);
    assertTrue(anaVlv.getOsLevel() != nullptr);
    assertTrue(anaVlv.getState() != nullptr);
    assertTrue(anaVlv.getSource() != nullptr);
    assertTrue(anaVlv.getSecurity() != nullptr);
    assertTrue(anaVlv.getPositionUnit() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_invalidDps); i++)
    {
      try
      {
        shared_ptr<MTP_AnaVlv> anaVlv = new MTP_AnaVlv(_invalidDps[i]);
        assertTrue(false, "shouldn't reach here");
      }
      catch
      {
        dyn_errClass err = getLastException();
        assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
        string errText = getErrorText(err);
        assertTrue(errText.contains(_invalidDps[i] + "." + _invalidFields[i]) || errText.contains(_invalidDps[i]));
      }
    }

    return 0;
  }

  public int testChangedEventsAndGetters()
  {
    if (!dpExists(_DpExists))
    {
      if (!dpExists(_DpExists))
        dpCreate(_DpExists, _Dpt);
      delay(0, 50);

      if (!dpExists(_DpExists))
      {
        if (!dpExists(_DpExists))
          dpCreate(_DpExists, "MTP_AnaVlv");
        delay(0, 50);
      }
    }

    shared_ptr<MTP_AnaVlv> anaVlv = new MTP_AnaVlv(_DpExists);

    classConnect(this, safetyPositionChangedCB, anaVlv, MTP_AnaVlv::safetyPositionChanged);
    classConnect(this, safetyPositionEnabledChangedCB, anaVlv, MTP_AnaVlv::safetyPositionEnabledChanged);
    classConnect(this, safetyPositionActiveChangedCB, anaVlv, MTP_AnaVlv::safetyPositionActiveChanged);
    classConnect(this, openAutomaticChangedCB, anaVlv, MTP_AnaVlv::openAutomaticChanged);
    classConnect(this, closeAutomaticChangedCB, anaVlv, MTP_AnaVlv::closeAutomaticChanged);
    classConnect(this, openActiveChangedCB, anaVlv, MTP_AnaVlv::openActiveChanged);
    classConnect(this, closeActiveChangedCB, anaVlv, MTP_AnaVlv::closeActiveChanged);
    classConnect(this, openFeedbackChangedCB, anaVlv, MTP_AnaVlv::openFeedbackChanged);
    classConnect(this, closeFeedbackChangedCB, anaVlv, MTP_AnaVlv::closeFeedbackChanged);
    classConnect(this, positionChangedCB, anaVlv, MTP_AnaVlv::positionChanged);
    classConnect(this, positionInternalChangedCB, anaVlv, MTP_AnaVlv::positionInternalChanged);
    classConnect(this, positionFeedbackChangedCB, anaVlv, MTP_AnaVlv::positionFeedbackChanged);
    classConnect(this, resetAutomaticChangedCB, anaVlv, MTP_AnaVlv::resetAutomaticChanged);

    float expectedPos = 12.34;
    float expectedPosInt = 12.32;
    float expectedPosFbk = 12.30;

    dpSetWait(_DpExists + ".SafePos", TRUE,
              _DpExists + ".SafePosEn", TRUE,
              _DpExists + ".SafePosAct", TRUE,
              _DpExists + ".OpenAut", TRUE,
              _DpExists + ".CloseAut", FALSE,
              _DpExists + ".OpenAct", TRUE,
              _DpExists + ".CloseAct", FALSE,
              _DpExists + ".OpenFbk", TRUE,
              _DpExists + ".CloseFbk", FALSE,
              _DpExists + ".PosInt", expectedPosInt,
              _DpExists + ".Pos", expectedPos,
              _DpExists + ".PosFbk", expectedPosFbk,
              _DpExists + ".ResetAut", TRUE);

    delay(0, 200);

    assertTrue(anaVlv.getSafetyPosition());
    assertTrue(anaVlv.getSafetyPositionEnabled());
    assertTrue(anaVlv.getSafetyPositionActive());
    assertTrue(anaVlv.getOpenAutomatic());
    assertFalse(anaVlv.getCloseAutomatic());
    assertTrue(anaVlv.getOpenActive());
    assertFalse(anaVlv.getCloseActive());
    assertTrue(anaVlv.getOpenFeedback());
    assertFalse(anaVlv.getCloseFeedback());
    assertEqual(anaVlv.getPositionInternal(), expectedPosInt);
    assertEqual(anaVlv.getPosition(), expectedPos);
    assertEqual(anaVlv.getPositionFeedback(), expectedPosFbk);
    assertTrue(anaVlv.getResetAutomatic());

    assertTrue(_eventSafetyPosition);
    assertTrue(_eventSafetyPositionEnabled);
    assertTrue(_eventSafetyPositionActive);
    assertTrue(_eventOpenAutomatic);
    assertFalse(_eventCloseAutomatic);
    assertTrue(_eventOpenActive);
    assertFalse(_eventCloseActive);
    assertTrue(_eventOpenFeedback);
    assertFalse(_eventCloseFeedback);
    assertEqual(_eventPositionInternal, expectedPosInt);
    assertEqual(_eventPosition, expectedPos);
    assertEqual(_eventPositionFeedback, expectedPosFbk);
    assertTrue(_eventResetAutomatic);

    return 0;
  }

  public int testSetters()
  {
    if (!dpExists(_DpExists))
    {
      if (!dpExists(_DpExists))
        dpCreate(_DpExists, _Dpt);
      delay(0, 50);

      if (!dpExists(_DpExists))
      {
        if (!dpExists(_DpExists))
          dpCreate(_DpExists, "MTP_AnaVlv");
        delay(0, 50);
      }
    }

    shared_ptr<MTP_AnaVlv> anaVlv = new MTP_AnaVlv(_DpExists);

    float expectedPosMan = 56.78;
    anaVlv.setOpenOperator(TRUE);
    anaVlv.setCloseOperator(TRUE);
    anaVlv.setPositionManual(expectedPosMan);
    anaVlv.setResetOperator(TRUE);

    bool openOp;
    bool closeOp;
    bool resetOp;
    float posMan;
    dpGet(_DpExists + ".OpenOp", openOp,
          _DpExists + ".CloseOp", closeOp,
          _DpExists + ".PosMan", posMan,
          _DpExists + ".ResetOp", resetOp);

    assertTrue(openOp);
    assertTrue(closeOp);
    assertTrue(resetOp);
    assertEqual(posMan, expectedPosMan);
    assertTrue(anaVlv.getOpenOperator());
    assertTrue(anaVlv.getCloseOperator());
    assertTrue(anaVlv.getResetOperator());
    assertEqual(anaVlv.getPositionManual(), expectedPosMan);
    return 0;
  }

  private void safetyPositionChangedCB(const bool &value)
  {
    _eventSafetyPosition = value;
  }

  private void safetyPositionEnabledChangedCB(const bool &value)
  {
    _eventSafetyPositionEnabled = value;
  }

  private void safetyPositionActiveChangedCB(const bool &value)
  {
    _eventSafetyPositionActive = value;
  }

  private void openAutomaticChangedCB(const bool &value)
  {
    _eventOpenAutomatic = value;
  }

  private void closeAutomaticChangedCB(const bool &value)
  {
    _eventCloseAutomatic = value;
  }

  private void openActiveChangedCB(const bool &value)
  {
    _eventOpenActive = value;
  }

  private void closeActiveChangedCB(const bool &value)
  {
    _eventCloseActive = value;
  }

  private void openFeedbackChangedCB(const bool &value)
  {
    _eventOpenFeedback = value;
  }

  private void closeFeedbackChangedCB(const bool &value)
  {
    _eventCloseFeedback = value;
  }

  private void positionChangedCB(const float &value)
  {
    _eventPosition = value;
  }

  private void positionInternalChangedCB(const float &value)
  {
    _eventPositionInternal = value;
  }

  private void positionFeedbackChangedCB(const float &value)
  {
    _eventPositionFeedback = value;
  }

  private void resetAutomaticChangedCB(const bool &value)
  {
    _eventResetAutomatic = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_AnaVlv test;
  test.startAll();
}
