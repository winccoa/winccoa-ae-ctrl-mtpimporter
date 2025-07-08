// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/AnaManInt/AnaManInt.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/AnaManInt/AnaManInt.ctl
  @copyright $copyright
  @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/AnaManInt/AnaManInt" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSource/MtpSource"

class TstAnaManInt : OaTest
{
  private const string _Dpt = "AnaManInt";
  private const string _DptInvalidMissingVOut = "AnaManIntInvalid1";
  private const string _DptInvalidMissingVSclMin = "AnaManIntInvalid2";
  private const string _DptInvalidMissingVSclMax = "AnaManIntInvalid3";
  private const string _DptInvalidMissingVMan = "AnaManIntInvalid4";
  private const string _DptInvalidMissingVInt = "AnaManIntInvalid5";
  private const string _DptInvalidMissingVRbk = "AnaManIntInvalid6";
  private const string _DptInvalidMissingVFbk = "AnaManIntInvalid7";
  private const string _DptInvalidMissingVMin = "AnaManIntInvalid8";
  private const string _DptInvalidMissingVMax = "AnaManIntInvalid9";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingVOut = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVMan = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingVInt = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingVRbk = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingVFbk = "ExistingTestDatapointInvalid7";
  private const string _DpExistsInvalidMissingVMin = "ExistingTestDatapointInvalid8";
  private const string _DpExistsInvalidMissingVMax = "ExistingTestDatapointInvalid9";

  private float _eventValueOut;
  private float _eventValueManual;
  private float _eventValueInternal;
  private float _eventValueFeedback;
  private float _eventValueMin;
  private float _eventValueMax;
  private float _eventValueScaleMin;
  private float _eventValueScaleMax;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      return -1;
    }

    dpCreate(_DpExists, _Dpt);

    dyn_dyn_string dpes = makeDynAnytype(
                            makeDynString(_DptInvalidMissingVOut),
                            makeDynString("", "VSclMin"), makeDynString("", "VSclMax"),
                            makeDynString("", "VMan"), makeDynString("", "VInt"),
                            makeDynString("", "VRbk"), makeDynString("", "VFbk"),
                            makeDynString("", "VMin"), makeDynString("", "VMax"),
                            makeDynString("", "WQC"), makeDynString("", "OSLevel"),
                            makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
                            makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
                            makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
                            makeDynString("", "SrcIntAct"));
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVOut, _DptInvalidMissingVOut);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVSclMin),
             makeDynString("", "VOut"), makeDynString("", "VSclMax"),
             makeDynString("", "VMan"), makeDynString("", "VInt"),
             makeDynString("", "VRbk"), makeDynString("", "VFbk"),
             makeDynString("", "VMin"), makeDynString("", "VMax"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVSclMin, _DptInvalidMissingVSclMin);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVSclMax),
             makeDynString("", "VOut"), makeDynString("", "VSclMin"),
             makeDynString("", "VMan"), makeDynString("", "VInt"),
             makeDynString("", "VRbk"), makeDynString("", "VFbk"),
             makeDynString("", "VMin"), makeDynString("", "VMax"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVSclMax, _DptInvalidMissingVSclMax);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVMan),
             makeDynString("", "VOut"), makeDynString("", "VSclMin"),
             makeDynString("", "VSclMax"), makeDynString("", "VInt"),
             makeDynString("", "VRbk"), makeDynString("", "VFbk"),
             makeDynString("", "VMin"), makeDynString("", "VMax"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVMan, _DptInvalidMissingVMan);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVInt),
             makeDynString("", "VOut"), makeDynString("", "VSclMin"),
             makeDynString("", "VSclMax"), makeDynString("", "VMan"),
             makeDynString("", "VRbk"), makeDynString("", "VFbk"),
             makeDynString("", "VMin"), makeDynString("", "VMax"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVInt, _DptInvalidMissingVInt);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVRbk),
             makeDynString("", "VOut"), makeDynString("", "VSclMin"),
             makeDynString("", "VSclMax"), makeDynString("", "VMan"),
             makeDynString("", "VInt"), makeDynString("", "VFbk"),
             makeDynString("", "VMin"), makeDynString("", "VMax"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVRbk, _DptInvalidMissingVRbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVFbk),
             makeDynString("", "VOut"), makeDynString("", "VSclMin"),
             makeDynString("", "VSclMax"), makeDynString("", "VMan"),
             makeDynString("", "VInt"), makeDynString("", "VRbk"),
             makeDynString("", "VMin"), makeDynString("", "VMax"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVFbk, _DptInvalidMissingVFbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVMin),
             makeDynString("", "VOut"), makeDynString("", "VSclMin"),
             makeDynString("", "VSclMax"), makeDynString("", "VMan"),
             makeDynString("", "VInt"), makeDynString("", "VRbk"),
             makeDynString("", "VFbk"), makeDynString("", "VMax"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVMin, _DptInvalidMissingVMin);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVMax),
             makeDynString("", "VOut"), makeDynString("", "VSclMin"),
             makeDynString("", "VSclMax"), makeDynString("", "VMan"),
             makeDynString("", "VInt"), makeDynString("", "VRbk"),
             makeDynString("", "VFbk"), makeDynString("", "VMin"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVMax, _DptInvalidMissingVMax);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingVOut);
    dpTypeDelete(_DptInvalidMissingVOut);

    dpDelete(_DpExistsInvalidMissingVSclMin);
    dpTypeDelete(_DptInvalidMissingVSclMin);

    dpDelete(_DpExistsInvalidMissingVSclMax);
    dpTypeDelete(_DptInvalidMissingVSclMax);

    dpDelete(_DpExistsInvalidMissingVMan);
    dpTypeDelete(_DptInvalidMissingVMan);

    dpDelete(_DpExistsInvalidMissingVInt);
    dpTypeDelete(_DptInvalidMissingVInt);

    dpDelete(_DpExistsInvalidMissingVRbk);
    dpTypeDelete(_DptInvalidMissingVRbk);

    dpDelete(_DpExistsInvalidMissingVFbk);
    dpTypeDelete(_DptInvalidMissingVFbk);

    dpDelete(_DpExistsInvalidMissingVMin);
    dpTypeDelete(_DptInvalidMissingVMin);

    dpDelete(_DpExistsInvalidMissingVMax);
    dpTypeDelete(_DptInvalidMissingVMax);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    assertEqual(anaManInt.getDp(), _DpExists);
    assertEqual(anaManInt.getValueOut(), 0.0);
    assertEqual(anaManInt.getValueScaleMin(), 0.0);
    assertEqual(anaManInt.getValueScaleMax(), 0.0);
    assertEqual(anaManInt.getValueManual(), 0.0);
    assertEqual(anaManInt.getValueInternal(), 0.0);
    assertEqual(anaManInt.getValueReadback(), 0.0);
    assertEqual(anaManInt.getValueFeedback(), 0.0);
    assertEqual(anaManInt.getValueMin(), 0.0);
    assertEqual(anaManInt.getValueMax(), 0.0);
    assertTrue(anaManInt.getWqc() != nullptr);
    assertTrue(anaManInt.getOsLevel() != nullptr);
    assertTrue(anaManInt.getSource() != nullptr);
    assertTrue(anaManInt.getValueUnit != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVOut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVOut + ".VOut"));
    }

    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVSclMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMin + ".VSclMin"));
    }

    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMax + ".VSclMax"));
    }

    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVMan);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMan + ".VMan"));
    }

    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVInt);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVInt + ".VInt"));
    }

    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVRbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVRbk + ".VRbk"));
    }

    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVFbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFbk + ".VFbk"));
    }

    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMin + ".VMin"));
    }

    try
    {
      shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExistsInvalidMissingVMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVMax + ".VMax"));
    }

    return 0;
  }

  public int testValueOutChanged()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    classConnect(this, setValueOutChangedCB, anaManInt, AnaManInt::valueOutChanged);

    dpSetWait(_DpExists + ".VOut", 42.5);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaManInt.getValueOut(), 42.5);
    assertEqual(_eventValueOut, 42.5);
    return 0;
  }

  public int testValueManualChanged()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    // Note: AnaManInt does not have a valueManualChanged event, testing setter instead
    anaManInt.setValueManual(25.3);

    // Give it time to execute dpSet.
    delay(0, 200);
    assertEqual(anaManInt.getValueManual(), 25.3);
    float dpValue;
    dpGet(_DpExists + ".VMan", dpValue);
    assertEqual(dpValue, 25.3);
    return 0;
  }

  public int testValueInternalChanged()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    classConnect(this, setValueInternalChangedCB, anaManInt, AnaManInt::valueInternalChanged);

    dpSetWait(_DpExists + ".VInt", 33.7);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaManInt.getValueInternal(), 33.7);
    assertEqual(_eventValueInternal, 33.7);
    return 0;
  }

  public int testValueFeedbackChanged()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    classConnect(this, setValueFeedbackChangedCB, anaManInt, AnaManInt::valueFeedbackChanged);

    dpSetWait(_DpExists + ".VFbk", 19.8);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaManInt.getValueFeedback(), 19.8);
    assertEqual(_eventValueFeedback, 19.8);
    return 0;
  }

  public int testValueMinChanged()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    classConnect(this, setValueMinValueChangedCB, anaManInt, AnaManInt::valueMinChanged);

    dpSetWait(_DpExists + ".VMin", -50.0);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaManInt.getValueMin(), -50.0);
    assertEqual(_eventValueMin, -50.0);
    return 0;
  }

  public int testValueMaxChanged()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    classConnect(this, setValueMaxValueChangedCB, anaManInt, AnaManInt::valueMaxChanged);

    dpSetWait(_DpExists + ".VMax", 200.0);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaManInt.getValueMax(), 200.0);
    assertEqual(_eventValueMax, 200.0);
    return 0;
  }

  public int testValueScaleMinChanged()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    classConnect(this, setValueScaleMinChangedCB, anaManInt, AnaManInt::valueScaleMinChanged);

    dpSetWait(_DpExists + ".VSclMin", -100.0);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaManInt.getValueScaleMin(), -100.0);
    assertEqual(_eventValueScaleMin, -100.0);
    return 0;
  }

  public int testValueScaleMaxChanged()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);
    classConnect(this, setValueScaleMaxChangedCB, anaManInt, AnaManInt::valueScaleMaxChanged);

    dpSetWait(_DpExists + ".VSclMax", 100.0);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaManInt.getValueScaleMax(), 100.0);
    assertEqual(_eventValueScaleMax, 100.0);
    return 0;
  }

  public int testSetValueManual()
  {
    shared_ptr<AnaManInt> anaManInt = new AnaManInt(_DpExists);

    anaManInt.setValueManual(75.2);

    float dpValue;
    dpGet(_DpExists + ".VMan", dpValue);
    assertEqual(dpValue, 75.2, "Data point VMan should be set to 75.2");
    assertEqual(anaManInt.getValueManual(), 75.2, "ValueManual should be set to 75.2");

    return 0;
  }

  private void setValueOutChangedCB(const float &value)
  {
    _eventValueOut = value;
  }

  private void setValueInternalChangedCB(const float &value)
  {
    _eventValueInternal = value;
  }

  private void setValueFeedbackChangedCB(const float &value)
  {
    _eventValueFeedback = value;
  }

  private void setValueMinValueChangedCB(const float &value)
  {
    _eventValueMin = value;
  }

  private void setValueMaxValueChangedCB(const float &value)
  {
    _eventValueMax = value;
  }

  private void setValueScaleMinChangedCB(const float &value)
  {
    _eventValueScaleMin = value;
  }

  private void setValueScaleMaxChangedCB(const float &value)
  {
    _eventValueScaleMax = value;
  }
};

//-----------------------------------------------------------------------------
// Main function to run all tests
void main()
{
  TstAnaManInt test;
  test.startAll();
}
