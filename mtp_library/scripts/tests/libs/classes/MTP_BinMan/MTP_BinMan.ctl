// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinMan/MTP_BinMan.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinMan/MTP_BinMan.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_BinMan/MTP_BinMan" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_BinMan.ctl
*/
class TstMTP_BinMan : OaTest
{
  private const string _Dpt = "MTP_BinMan";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingVOut = "MTP_BinManInvalid1";
  private const string _DpExistsInvalidMissingVOut = "ExistingTestDatapointInvalid1";
  private const string _DptInvalidMissingVState0 = "MTP_BinManInvalid2";
  private const string _DpExistsInvalidMissingVState0 = "ExistingTestDatapointInvalid2";
  private const string _DptInvalidMissingVState1 = "MTP_BinManInvalid3";
  private const string _DpExistsInvalidMissingVState1 = "ExistingTestDatapointInvalid3";
  private const string _DptInvalidMissingVMan = "MTP_BinManInvalid4";
  private const string _DpExistsInvalidMissingVMan = "ExistingTestDatapointInvalid4";
  private const string _DptInvalidMissingVRbk = "MTP_BinManInvalid5";
  private const string _DpExistsInvalidMissingVRbk = "ExistingTestDatapointInvalid5";
  private const string _DptInvalidMissingVFbk = "MTP_BinManInvalid6";
  private const string _DpExistsInvalidMissingVFbk = "ExistingTestDatapointInvalid6";

  private bool _eventValueOut;
  private bool _eventValueManual;
  private bool _eventValueFeedback;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "OSLevel"),
                                         makeDynString("", "VOut"),
                                         makeDynString("", "VState0"),
                                         makeDynString("", "VState1"),
                                         makeDynString("", "VMan"),
                                         makeDynString("", "VRbk"),
                                         makeDynString("", "VFbk"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_STRING),
                                        makeDynInt(0, DPEL_STRING),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVOut), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VState0"), makeDynString("", "VState1"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVOut))
      dpCreate(_DpExistsInvalidMissingVOut, _DptInvalidMissingVOut);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVState0), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VState1"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVState0))
      dpCreate(_DpExistsInvalidMissingVState0, _DptInvalidMissingVState0);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVState1), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VState0"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVState1))
      dpCreate(_DpExistsInvalidMissingVState1, _DptInvalidMissingVState1);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVMan), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VState0"), makeDynString("", "VState1"), makeDynString("", "VRbk"), makeDynString("", "VFbk"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVMan))
      dpCreate(_DpExistsInvalidMissingVMan, _DptInvalidMissingVMan);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVRbk), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VState0"), makeDynString("", "VState1"), makeDynString("", "VMan"), makeDynString("", "VFbk"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVRbk))
      dpCreate(_DpExistsInvalidMissingVRbk, _DptInvalidMissingVRbk);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVFbk), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VState0"), makeDynString("", "VState1"), makeDynString("", "VMan"), makeDynString("", "VRbk"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVFbk))
      dpCreate(_DpExistsInvalidMissingVFbk, _DptInvalidMissingVFbk);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingVOut);
    if (dpTypes(_DptInvalidMissingVOut).count() > 0)
      dpTypeDelete(_DptInvalidMissingVOut);
    dpDelete(_DpExistsInvalidMissingVState0);
    if (dpTypes(_DptInvalidMissingVState0).count() > 0)
      dpTypeDelete(_DptInvalidMissingVState0);
    dpDelete(_DpExistsInvalidMissingVState1);
    if (dpTypes(_DptInvalidMissingVState1).count() > 0)
      dpTypeDelete(_DptInvalidMissingVState1);
    dpDelete(_DpExistsInvalidMissingVMan);
    if (dpTypes(_DptInvalidMissingVMan).count() > 0)
      dpTypeDelete(_DptInvalidMissingVMan);
    dpDelete(_DpExistsInvalidMissingVRbk);
    if (dpTypes(_DptInvalidMissingVRbk).count() > 0)
      dpTypeDelete(_DptInvalidMissingVRbk);
    dpDelete(_DpExistsInvalidMissingVFbk);
    if (dpTypes(_DptInvalidMissingVFbk).count() > 0)
      dpTypeDelete(_DptInvalidMissingVFbk);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_BinMan> binMan = new MTP_BinMan(_DpExists);
    assertEqual(binMan.getDp(), _DpExists);
    assertEqual(binMan.getValueOut(), false);
    assertEqual(binMan.getValueStateFalseText(), "");
    assertEqual(binMan.getValueStateTrueText(), "");
    assertEqual(binMan.getValueManual(), false);
    assertEqual(binMan.getValueReadback(), false);
    assertEqual(binMan.getValueFeedback(), false);
    assertTrue(binMan.getOsLevel() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try { shared_ptr<MTP_BinMan> o = new MTP_BinMan(_DpExistsInvalidMissingVOut); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVOut + ".VOut")); }
    try { shared_ptr<MTP_BinMan> o = new MTP_BinMan(_DpExistsInvalidMissingVState0); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVState0 + ".VState0")); }
    try { shared_ptr<MTP_BinMan> o = new MTP_BinMan(_DpExistsInvalidMissingVState1); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVState1 + ".VState1")); }
    try { shared_ptr<MTP_BinMan> o = new MTP_BinMan(_DpExistsInvalidMissingVMan); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMan + ".VMan")); }
    try { shared_ptr<MTP_BinMan> o = new MTP_BinMan(_DpExistsInvalidMissingVRbk); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVRbk + ".VRbk")); }
    try { shared_ptr<MTP_BinMan> o = new MTP_BinMan(_DpExistsInvalidMissingVFbk); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFbk + ".VFbk")); }
    return 0;
  }

  public int testValueOutChanged()
  {
    shared_ptr<MTP_BinMan> binMan = new MTP_BinMan(_DpExists);
    classConnect(this, valueOutChangedCB, binMan, MTP_BinMan::valueOutChanged);
    dpSetWait(_DpExists + ".VOut", true);
    delay(0, 200);
    assertEqual(binMan.getValueOut(), true);
    assertEqual(_eventValueOut, true);
    return 0;
  }

  public int testValueManualChanged()
  {
    shared_ptr<MTP_BinMan> binMan = new MTP_BinMan(_DpExists);
    classConnect(this, valueManualChangedCB, binMan, MTP_BinMan::valueManualChanged);
    dpSetWait(_DpExists + ".VMan", true);
    delay(0, 200);
    assertEqual(binMan.getValueManual(), true);
    assertEqual(_eventValueManual, true);
    return 0;
  }

  public int testValueFeedbackChanged()
  {
    shared_ptr<MTP_BinMan> binMan = new MTP_BinMan(_DpExists);
    classConnect(this, valueFeedbackChangedCB, binMan, MTP_BinMan::valueFeedbackChanged);
    dpSetWait(_DpExists + ".VFbk", true);
    delay(0, 200);
    assertEqual(binMan.getValueFeedback(), true);
    assertEqual(_eventValueFeedback, true);
    return 0;
  }

  public int testSetValueManual()
  {
    shared_ptr<MTP_BinMan> binMan = new MTP_BinMan(_DpExists);
    binMan.setValueManual(true);
    bool dpValue;
    dpGet(_DpExists + ".VMan", dpValue);
    assertEqual(dpValue, true);
    assertEqual(binMan.getValueOut(), true);
    return 0;
  }

  private void valueOutChangedCB(const bool &value)
  {
    _eventValueOut = value;
  }

  private void valueManualChangedCB(const bool &value)
  {
    _eventValueManual = value;
  }

  private void valueFeedbackChangedCB(const bool &value)
  {
    _eventValueFeedback = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_BinMan test;
  test.startAll();
}
