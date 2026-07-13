// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinVlv/MTP_BinVlv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinVlv/MTP_BinVlv.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_BinVlv/MTP_BinVlv" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_BinVlv.ctl
*/
class TstMTP_BinVlv : OaTest
{
  private const string _Dpt = "MTP_BinVlv";
  private const string _DpExists = "ExistingTestDatapoint";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _constructorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;

  private bool _eventOpenCheckbackSignal;
  private bool _eventCloseCheckbackSignal;
  private bool _eventSafetyPosition;
  private bool _eventSafetyPositionActive;
  private bool _eventSafetyPositionEnabled;
  private bool _eventOpenAutomatic;
  private bool _eventCloseAutomatic;
  private bool _eventValveControl;
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
                               "SafePos", "SafePosEn", "SafePosAct",
                               "OpenOp", "CloseOp", "OpenAut", "CloseAut", "Ctrl",
                               "OpenFbkCalc", "OpenFbk", "CloseFbkCalc", "CloseFbk",
                               "ResetOp", "ResetAut",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "PermEn", "Permit", "IntlEn", "Interlock", "ProtEn", "Protect");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL);

    _constructorFields = makeDynString("SafePos", "SafePosEn", "SafePosAct", "OpenOp", "CloseOp", "OpenAut", "CloseAut", "Ctrl", "OpenFbkCalc", "OpenFbk", "CloseFbkCalc", "CloseFbk", "ResetOp", "ResetAut");

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
    dpSetWait(_DpExists + ".OpenOp", TRUE,
              _DpExists + ".CloseOp", FALSE,
              _DpExists + ".OpenFbkCalc", TRUE,
              _DpExists + ".CloseFbkCalc", TRUE,
              _DpExists + ".ResetOp", TRUE);

    shared_ptr<MTP_BinVlv> binVlv = new MTP_BinVlv(_DpExists);
    assertEqual(binVlv.getDp(), _DpExists);
    assertEqual(binVlv.getOpenOperator(), TRUE);
    assertEqual(binVlv.getCloseOperator(), FALSE);
    assertEqual(binVlv.getOpenFeedbackSource(), TRUE);
    assertEqual(binVlv.getCloseFeedbackSource(), TRUE);
    assertEqual(binVlv.getResetOperator(), TRUE);
    assertTrue(binVlv.getWqc() != nullptr);
    assertTrue(binVlv.getOsLevel() != nullptr);
    assertTrue(binVlv.getState() != nullptr);
    assertTrue(binVlv.getSecurity() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      try
      {
        shared_ptr<MTP_BinVlv> binVlv = new MTP_BinVlv(_invalidDps[i]);
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
    shared_ptr<MTP_BinVlv> binVlv = new MTP_BinVlv(_DpExists);

    classConnect(this, openCheckbackSignalChangedCB, binVlv, MTP_BinVlv::openCheckbackSignalChanged);
    classConnect(this, closeCheckbackSignalChangedCB, binVlv, MTP_BinVlv::closeCheckbackSignalChanged);
    classConnect(this, safetyPositionChangedCB, binVlv, MTP_BinVlv::safetyPositionChanged);
    classConnect(this, safetyPositionActiveChangedCB, binVlv, MTP_BinVlv::safetyPositionActiveChanged);
    classConnect(this, safetyPositionEnabledChangedCB, binVlv, MTP_BinVlv::safetyPositionEnabledChanged);
    classConnect(this, openAutomaticChangedCB, binVlv, MTP_BinVlv::openAutomaticChanged);
    classConnect(this, closeAutomaticChangedCB, binVlv, MTP_BinVlv::closeAutomaticChanged);
    classConnect(this, valveControlChangedCB, binVlv, MTP_BinVlv::valveControlChanged);
    classConnect(this, resetAutomaticChangedCB, binVlv, MTP_BinVlv::resetAutomaticChanged);

    dpSetWait(_DpExists + ".OpenFbk", TRUE,
              _DpExists + ".CloseFbk", TRUE,
              _DpExists + ".SafePos", TRUE,
              _DpExists + ".SafePosAct", TRUE,
              _DpExists + ".SafePosEn", TRUE,
              _DpExists + ".OpenAut", TRUE,
              _DpExists + ".CloseAut", TRUE,
              _DpExists + ".Ctrl", TRUE,
              _DpExists + ".ResetAut", TRUE);

    delay(0, 200);

    assertTrue(binVlv.getOpenCheckbackSignal());
    assertTrue(binVlv.getCloseCheckbackSignal());
    assertTrue(binVlv.getSafetyPosition());
    assertTrue(binVlv.getSafetyPositionActive());
    assertTrue(binVlv.getSafetyPositionEnabled());
    assertTrue(binVlv.getOpenAutomatic());
    assertTrue(binVlv.getCloseAutomatic());
    assertTrue(binVlv.getValveControl());
    assertTrue(binVlv.getResetAutomatic());

    assertTrue(_eventOpenCheckbackSignal);
    assertTrue(_eventCloseCheckbackSignal);
    assertTrue(_eventSafetyPosition);
    assertTrue(_eventSafetyPositionActive);
    assertTrue(_eventSafetyPositionEnabled);
    assertTrue(_eventOpenAutomatic);
    assertTrue(_eventCloseAutomatic);
    assertTrue(_eventValveControl);
    assertTrue(_eventResetAutomatic);

    return 0;
  }

  public int testSetters()
  {
    shared_ptr<MTP_BinVlv> binVlv = new MTP_BinVlv(_DpExists);
    binVlv.setOpenOperator(TRUE);
    binVlv.setCloseOperator(TRUE);
    binVlv.setResetOperator(TRUE);

    bool openOp;
    bool closeOp;
    bool resetOp;
    dpGet(_DpExists + ".OpenOp", openOp,
          _DpExists + ".CloseOp", closeOp,
          _DpExists + ".ResetOp", resetOp);

    assertTrue(openOp);
    assertTrue(closeOp);
    assertTrue(resetOp);
    assertTrue(binVlv.getOpenOperator());
    assertTrue(binVlv.getCloseOperator());
    assertTrue(binVlv.getResetOperator());
    return 0;
  }

  private void openCheckbackSignalChangedCB(const bool &value)
  {
    _eventOpenCheckbackSignal = value;
  }

  private void closeCheckbackSignalChangedCB(const bool &value)
  {
    _eventCloseCheckbackSignal = value;
  }

  private void safetyPositionChangedCB(const bool &value)
  {
    _eventSafetyPosition = value;
  }

  private void safetyPositionActiveChangedCB(const bool &value)
  {
    _eventSafetyPositionActive = value;
  }

  private void safetyPositionEnabledChangedCB(const bool &value)
  {
    _eventSafetyPositionEnabled = value;
  }

  private void openAutomaticChangedCB(const bool &value)
  {
    _eventOpenAutomatic = value;
  }

  private void closeAutomaticChangedCB(const bool &value)
  {
    _eventCloseAutomatic = value;
  }

  private void valveControlChangedCB(const bool &value)
  {
    _eventValveControl = value;
  }

  private void resetAutomaticChangedCB(const bool &value)
  {
    _eventResetAutomatic = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_BinVlv test;
  test.startAll();
}
