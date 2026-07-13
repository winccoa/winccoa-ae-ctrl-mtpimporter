// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_DIntMan/MTP_DIntMan.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_DIntMan/MTP_DIntMan.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_DIntMan/MTP_DIntMan" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_DIntMan.ctl
*/
class TstMTP_DIntMan : OaTest
{
  private const string _Dpt = "MTP_DIntMan";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingVOut = "MTP_DIntManInvalid1";
  private const string _DpExistsInvalidMissingVOut = "ExistingTestDatapointInvalid1";
  private const string _DptInvalidMissingVSclMin = "MTP_DIntManInvalid2";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid2";
  private const string _DptInvalidMissingVSclMax = "MTP_DIntManInvalid3";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid3";
  private const string _DptInvalidMissingVMan = "MTP_DIntManInvalid4";
  private const string _DpExistsInvalidMissingVMan = "ExistingTestDatapointInvalid4";
  private const string _DptInvalidMissingVRbk = "MTP_DIntManInvalid5";
  private const string _DpExistsInvalidMissingVRbk = "ExistingTestDatapointInvalid5";
  private const string _DptInvalidMissingVFbk = "MTP_DIntManInvalid6";
  private const string _DpExistsInvalidMissingVFbk = "ExistingTestDatapointInvalid6";
  private const string _DptInvalidMissingVMin = "MTP_DIntManInvalid7";
  private const string _DpExistsInvalidMissingVMin = "ExistingTestDatapointInvalid7";
  private const string _DptInvalidMissingVMax = "MTP_DIntManInvalid8";
  private const string _DpExistsInvalidMissingVMax = "ExistingTestDatapointInvalid8";
  private const string _DptInvalidMissingVUnit = "MTP_DIntManInvalid9";
  private const string _DpExistsInvalidMissingVUnit = "ExistingTestDatapointInvalid9";

  private int _eventValueOut;
  private int _eventValueFeedback;
  private int _eventValueScaleMin;
  private int _eventValueScaleMax;
  private int _eventValueMin;
  private int _eventValueMax;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "OSLevel"),
                                         makeDynString("", "VOut"),
                                         makeDynString("", "VSclMin"),
                                         makeDynString("", "VSclMax"),
                                         makeDynString("", "VUnit"),
                                         makeDynString("", "VMan"),
                                         makeDynString("", "VRbk"),
                                         makeDynString("", "VFbk"),
                                         makeDynString("", "VMin"),
                                         makeDynString("", "VMax"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVOut), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"), makeDynString("", "VUnit"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "VMin"), makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVOut))
      dpCreate(_DpExistsInvalidMissingVOut, _DptInvalidMissingVOut);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVMan), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"), makeDynString("", "VUnit"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "VMin"), makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVMan))
      dpCreate(_DpExistsInvalidMissingVMan, _DptInvalidMissingVMan);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMin), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VSclMax"), makeDynString("", "VUnit"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "VMin"), makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVSclMin))
      dpCreate(_DpExistsInvalidMissingVSclMin, _DptInvalidMissingVSclMin);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMax), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VSclMin"), makeDynString("", "VUnit"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "VMin"), makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVSclMax))
      dpCreate(_DpExistsInvalidMissingVSclMax, _DptInvalidMissingVSclMax);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVRbk), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"), makeDynString("", "VUnit"), makeDynString("", "VMan"), makeDynString("", "VFbk"), makeDynString("", "VMin"), makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVRbk))
      dpCreate(_DpExistsInvalidMissingVRbk, _DptInvalidMissingVRbk);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVFbk), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"), makeDynString("", "VUnit"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VMin"), makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVFbk))
      dpCreate(_DpExistsInvalidMissingVFbk, _DptInvalidMissingVFbk);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVMin), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"), makeDynString("", "VUnit"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVMin))
      dpCreate(_DpExistsInvalidMissingVMin, _DptInvalidMissingVMin);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVMax), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"), makeDynString("", "VUnit"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "VMin"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVMax))
      dpCreate(_DpExistsInvalidMissingVMax, _DptInvalidMissingVMax);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVUnit), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "VMin"), makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVUnit))
      dpCreate(_DpExistsInvalidMissingVUnit, _DptInvalidMissingVUnit);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingVOut);

    if (dpTypes(_DptInvalidMissingVOut).count() > 0)
      dpTypeDelete(_DptInvalidMissingVOut);

    dpDelete(_DpExistsInvalidMissingVMan);

    if (dpTypes(_DptInvalidMissingVMan).count() > 0)
      dpTypeDelete(_DptInvalidMissingVMan);

    dpDelete(_DpExistsInvalidMissingVSclMin);

    if (dpTypes(_DptInvalidMissingVSclMin).count() > 0)
      dpTypeDelete(_DptInvalidMissingVSclMin);

    dpDelete(_DpExistsInvalidMissingVSclMax);

    if (dpTypes(_DptInvalidMissingVSclMax).count() > 0)
      dpTypeDelete(_DptInvalidMissingVSclMax);

    dpDelete(_DpExistsInvalidMissingVRbk);

    if (dpTypes(_DptInvalidMissingVRbk).count() > 0)
      dpTypeDelete(_DptInvalidMissingVRbk);

    dpDelete(_DpExistsInvalidMissingVFbk);

    if (dpTypes(_DptInvalidMissingVFbk).count() > 0)
      dpTypeDelete(_DptInvalidMissingVFbk);

    dpDelete(_DpExistsInvalidMissingVMin);

    if (dpTypes(_DptInvalidMissingVMin).count() > 0)
      dpTypeDelete(_DptInvalidMissingVMin);

    dpDelete(_DpExistsInvalidMissingVMax);

    if (dpTypes(_DptInvalidMissingVMax).count() > 0)
      dpTypeDelete(_DptInvalidMissingVMax);

    dpDelete(_DpExistsInvalidMissingVUnit);

    if (dpTypes(_DptInvalidMissingVUnit).count() > 0)
      dpTypeDelete(_DptInvalidMissingVUnit);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DIntMan> dIntMan = new MTP_DIntMan(_DpExists);
    int expectedInitialValue = 0;
    assertEqual(dIntMan.getDp(), _DpExists);
    assertEqual(dIntMan.getValueOut(), expectedInitialValue);
    assertEqual(dIntMan.getValueScaleMin(), expectedInitialValue);
    assertEqual(dIntMan.getValueScaleMax(), expectedInitialValue);
    assertEqual(dIntMan.getValueManual(), expectedInitialValue);
    assertEqual(dIntMan.getValueReadback(), expectedInitialValue);
    assertEqual(dIntMan.getValueFeedback(), expectedInitialValue);
    assertEqual(dIntMan.getValueMin(), expectedInitialValue);
    assertEqual(dIntMan.getValueMax(), expectedInitialValue);
    assertTrue(dIntMan.getValueUnit() != nullptr);
    assertTrue(dIntMan.getOsLevel() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVOut); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVOut + ".VOut")); }
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVSclMin); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMin + ".VSclMin")); }
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVSclMax); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMax + ".VSclMax")); }
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVMan); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMan + ".VMan")); }
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVRbk); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVRbk + ".VRbk")); }
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVFbk); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFbk + ".VFbk")); }
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVMin); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMin + ".VMin")); }
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVMax); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMax + ".VMax")); }
    try { shared_ptr<MTP_DIntMan> o = new MTP_DIntMan(_DpExistsInvalidMissingVUnit); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVUnit + ".VUnit")); }
    return 0;
  }

  public int testValueOutChanged()
  {
    shared_ptr<MTP_DIntMan> dIntMan = new MTP_DIntMan(_DpExists);
    classConnect(this, valueOutChangedCB, dIntMan, MTP_DIntMan::valueOutChanged);
    int expectedValue = 425;
    dpSetWait(_DpExists + ".VOut", expectedValue);
    delay(0, 200);
    assertEqual(dIntMan.getValueOut(), expectedValue);
    assertEqual(_eventValueOut, expectedValue);
    return 0;
  }

  public int testValueFeedbackChanged()
  {
    shared_ptr<MTP_DIntMan> dIntMan = new MTP_DIntMan(_DpExists);
    classConnect(this, valueFeedbackChangedCB, dIntMan, MTP_DIntMan::valueFeedbackChanged);
    int expectedValue = 172;
    dpSetWait(_DpExists + ".VFbk", expectedValue);
    delay(0, 200);
    assertEqual(dIntMan.getValueFeedback(), expectedValue);
    assertEqual(_eventValueFeedback, expectedValue);
    return 0;
  }

  public int testValueScaleMaxChanged()
  {
    shared_ptr<MTP_DIntMan> dIntMan = new MTP_DIntMan(_DpExists);
    classConnect(this, valueScaleMaxChangedCB, dIntMan, MTP_DIntMan::valueScaleMaxChanged);
    int expectedValue = 1000;
    dpSetWait(_DpExists + ".VSclMax", expectedValue);
    delay(0, 200);
    assertEqual(dIntMan.getValueScaleMax(), expectedValue);
    assertEqual(_eventValueScaleMax, expectedValue);
    return 0;
  }

  public int testValueScaleMinChanged()
  {
    shared_ptr<MTP_DIntMan> dIntMan = new MTP_DIntMan(_DpExists);
    classConnect(this, valueScaleMinChangedCB, dIntMan, MTP_DIntMan::valueScaleMinChanged);
    int expectedValue = -1000;
    dpSetWait(_DpExists + ".VSclMin", expectedValue);
    delay(0, 200);
    assertEqual(dIntMan.getValueScaleMin(), expectedValue);
    assertEqual(_eventValueScaleMin, expectedValue);
    return 0;
  }

  public int testValueMinChanged()
  {
    shared_ptr<MTP_DIntMan> dIntMan = new MTP_DIntMan(_DpExists);
    classConnect(this, valueMinChangedCB, dIntMan, MTP_DIntMan::valueMinChanged);
    int expectedValue = -500;
    dpSetWait(_DpExists + ".VMin", expectedValue);
    delay(0, 200);
    assertEqual(dIntMan.getValueMin(), expectedValue);
    assertEqual(_eventValueMin, expectedValue);
    return 0;
  }

  public int testValueMaxChanged()
  {
    shared_ptr<MTP_DIntMan> dIntMan = new MTP_DIntMan(_DpExists);
    classConnect(this, valueMaxChangedCB, dIntMan, MTP_DIntMan::valueMaxChanged);
    int expectedValue = 2000;
    dpSetWait(_DpExists + ".VMax", expectedValue);
    delay(0, 200);
    assertEqual(dIntMan.getValueMax(), expectedValue);
    assertEqual(_eventValueMax, expectedValue);
    return 0;
  }

  public int testSetGetValueManual()
  {
    shared_ptr<MTP_DIntMan> dIntMan = new MTP_DIntMan(_DpExists);
    int expectedValue = 314;
    dIntMan.setValueManual(expectedValue);

    int dpValue;
    dpGet(_DpExists + ".VMan", dpValue);
    assertEqual(dpValue, expectedValue);
    assertEqual(dIntMan.getValueManual(), expectedValue);
    return 0;
  }

  private void valueOutChangedCB(const int &value)
  {
    _eventValueOut = value;
  }

  private void valueFeedbackChangedCB(const int &valueFeedback)
  {
    _eventValueFeedback = valueFeedback;
  }

  private void valueScaleMaxChangedCB(const int &valueScaleMax)
  {
    _eventValueScaleMax = valueScaleMax;
  }

  private void valueScaleMinChangedCB(const int &valueScaleMin)
  {
    _eventValueScaleMin = valueScaleMin;
  }

  private void valueMinChangedCB(const int &valueMin)
  {
    _eventValueMin = valueMin;
  }

  private void valueMaxChangedCB(const int &valueMax)
  {
    _eventValueMax = valueMax;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_DIntMan test;
  test.startAll();
}
