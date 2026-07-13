// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_AnaMan/MTP_AnaMan.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_AnaMan/MTP_AnaMan.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_AnaMan/MTP_AnaMan" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_AnaMan.ctl
*/
class TstMTP_AnaMan : OaTest
{
  private const string _Dpt = "MTP_AnaMan";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingVOut = "MTP_AnaManInvalid1";
  private const string _DpExistsInvalidMissingVOut = "ExistingTestDatapointInvalid1";
  private const string _DptInvalidMissingVSclMin = "MTP_AnaManInvalid2";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid2";
  private const string _DptInvalidMissingVSclMax = "MTP_AnaManInvalid3";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid3";
  private const string _DptInvalidMissingVMan = "MTP_AnaManInvalid4";
  private const string _DpExistsInvalidMissingVMan = "ExistingTestDatapointInvalid4";
  private const string _DptInvalidMissingVRbk = "MTP_AnaManInvalid5";
  private const string _DpExistsInvalidMissingVRbk = "ExistingTestDatapointInvalid5";
  private const string _DptInvalidMissingVFbk = "MTP_AnaManInvalid6";
  private const string _DpExistsInvalidMissingVFbk = "ExistingTestDatapointInvalid6";
  private const string _DptInvalidMissingVMin = "MTP_AnaManInvalid7";
  private const string _DpExistsInvalidMissingVMin = "ExistingTestDatapointInvalid7";
  private const string _DptInvalidMissingVMax = "MTP_AnaManInvalid8";
  private const string _DpExistsInvalidMissingVMax = "ExistingTestDatapointInvalid8";
  private const string _DptInvalidMissingVUnit = "MTP_AnaManInvalid9";
  private const string _DpExistsInvalidMissingVUnit = "ExistingTestDatapointInvalid9";

  private float _eventValueOut;
  private float _eventValueFeedback;
  private float _eventValueScaleMin;
  private float _eventValueScaleMax;
  private float _eventValueMin;
  private float _eventValueMax;

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
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVOut),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVOut))
      dpCreate(_DpExistsInvalidMissingVOut, _DptInvalidMissingVOut);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVMan),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVMan))
      dpCreate(_DpExistsInvalidMissingVMan, _DptInvalidMissingVMan);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMin),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVSclMin))
      dpCreate(_DpExistsInvalidMissingVSclMin, _DptInvalidMissingVSclMin);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMax),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVSclMax))
      dpCreate(_DpExistsInvalidMissingVSclMax, _DptInvalidMissingVSclMax);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVRbk),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVRbk))
      dpCreate(_DpExistsInvalidMissingVRbk, _DptInvalidMissingVRbk);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVFbk),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVFbk))
      dpCreate(_DpExistsInvalidMissingVFbk, _DptInvalidMissingVFbk);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVMin),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVMin))
      dpCreate(_DpExistsInvalidMissingVMin, _DptInvalidMissingVMin);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVMax),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVMax))
      dpCreate(_DpExistsInvalidMissingVMax, _DptInvalidMissingVMax);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVUnit),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT),
                            makeDynInt(0, DPEL_FLOAT));
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
    shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExists);
    assertEqual(anaMan.getDp(), _DpExists);
    assertEqual(anaMan.getValueOut(), 0.0);
    assertEqual(anaMan.getValueScaleMin(), 0.0);
    assertEqual(anaMan.getValueScaleMax(), 0.0);
    assertEqual(anaMan.getValueManual(), 0.0);
    assertEqual(anaMan.getValueReadback(), 0.0);
    assertEqual(anaMan.getValueFeedback(), 0.0);
    assertEqual(anaMan.getValueMin(), 0.0);
    assertEqual(anaMan.getValueMax(), 0.0);
    assertTrue(anaMan.getValueUnit() != nullptr);
    assertTrue(anaMan.getOsLevel() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVOut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVOut + ".VOut"));
    }

    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVSclMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMin + ".VSclMin"));
    }

    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMax + ".VSclMax"));
    }

    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVMan);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMan + ".VMan"));
    }

    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVRbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVRbk + ".VRbk"));
    }

    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVFbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFbk + ".VFbk"));
    }

    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMin + ".VMin"));
    }

    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMax + ".VMax"));
    }

    try
    {
      shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExistsInvalidMissingVUnit);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVUnit + ".VUnit"));
    }

    return 0;
  }

  public int testValueOutChanged()
  {
    shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExists);
    classConnect(this, valueOutChangedCB, anaMan, MTP_AnaMan::valueOutChanged);

    dpSetWait(_DpExists + ".VOut", 42.5);
    delay(0, 200);

    assertEqual(anaMan.getValueOut(), 42.5);
    assertEqual(_eventValueOut, 42.5);
    return 0;
  }

  public int testValueFeedbackChanged()
  {
    shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExists);
    classConnect(this, valueFeedbackChangedCB, anaMan, MTP_AnaMan::valueFeedbackChanged);

    dpSetWait(_DpExists + ".VFbk", 17.2);
    delay(0, 200);

    assertEqual(anaMan.getValueFeedback(), 17.2);
    assertEqual(_eventValueFeedback, 17.2);
    return 0;
  }

  public int testValueScaleMaxChanged()
  {
    shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExists);
    classConnect(this, valueScaleMaxChangedCB, anaMan, MTP_AnaMan::valueScaleMaxChanged);

    dpSetWait(_DpExists + ".VSclMax", 100.0);
    delay(0, 200);

    assertEqual(anaMan.getValueScaleMax(), 100.0);
    assertEqual(_eventValueScaleMax, 100.0);
    return 0;
  }

  public int testValueScaleMinChanged()
  {
    shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExists);
    classConnect(this, valueScaleMinChangedCB, anaMan, MTP_AnaMan::valueScaleMinChanged);

    dpSetWait(_DpExists + ".VSclMin", -100.0);
    delay(0, 200);

    assertEqual(anaMan.getValueScaleMin(), -100.0);
    assertEqual(_eventValueScaleMin, -100.0);
    return 0;
  }

  public int testValueMinChanged()
  {
    shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExists);
    classConnect(this, valueMinChangedCB, anaMan, MTP_AnaMan::valueMinChanged);

    dpSetWait(_DpExists + ".VMin", -50.0);
    delay(0, 200);

    assertEqual(anaMan.getValueMin(), -50.0);
    assertEqual(_eventValueMin, -50.0);
    return 0;
  }

  public int testValueMaxChanged()
  {
    shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExists);
    classConnect(this, valueMaxChangedCB, anaMan, MTP_AnaMan::valueMaxChanged);

    dpSetWait(_DpExists + ".VMax", 200.0);
    delay(0, 200);

    assertEqual(anaMan.getValueMax(), 200.0);
    assertEqual(_eventValueMax, 200.0);
    return 0;
  }

  public int testSetGetValueManual()
  {
    shared_ptr<MTP_AnaMan> anaMan = new MTP_AnaMan(_DpExists);
    anaMan.setValueManual(31.4);

    float dpValue;
    dpGet(_DpExists + ".VMan", dpValue);
    assertEqual(dpValue, 31.4);
    assertEqual(anaMan.getValueManual(), 31.4);
    return 0;
  }

  private void valueOutChangedCB(const float &value)
  {
    _eventValueOut = value;
  }

  private void valueFeedbackChangedCB(const float &valueFeedback)
  {
    _eventValueFeedback = valueFeedback;
  }

  private void valueScaleMaxChangedCB(const float &valueScaleMax)
  {
    _eventValueScaleMax = valueScaleMax;
  }

  private void valueScaleMinChangedCB(const float &valueScaleMin)
  {
    _eventValueScaleMin = valueScaleMin;
  }

  private void valueMinChangedCB(const float &valueMin)
  {
    _eventValueMin = valueMin;
  }

  private void valueMaxChangedCB(const float &valueMax)
  {
    _eventValueMax = valueMax;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_AnaMan test;
  test.startAll();
}
