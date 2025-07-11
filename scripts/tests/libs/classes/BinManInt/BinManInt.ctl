// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/BinManInt/BinManInt.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/BinManInt/BinManInt.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/BinManInt/BinManInt" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class


class TstBinManInt : OaTest
{
  private const string _Dpt = "BinManInt";
  private const string _DptInvalidMissingVOut = "BinManIntInvalid1";
  private const string _DptInvalidMissingVState0 = "BinManIntInvalid2";
  private const string _DptInvalidMissingVState1 = "BinManIntInvalid3";
  private const string _DptInvalidMissingVMan = "BinManIntInvalid4";
  private const string _DptInvalidMissingVInt = "BinManIntInvalid5";
  private const string _DptInvalidMissingVRbk = "BinManIntInvalid6";
  private const string _DptInvalidMissingVFbk = "BinManIntInvalid7";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingVOut = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVState0 = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVState1 = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVMan = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingVInt = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingVRbk = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingVFbk = "ExistingTestDatapointInvalid7";

  private bool _eventValueOut;
  private bool _eventValueManual;
  private bool _eventValueInternal;
  private bool _eventValueFeedback;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      return -1;
    }

    dpCreate(_DpExists, _Dpt);

    dyn_dyn_string dpes = makeDynAnytype(
                            makeDynString(_DptInvalidMissingVOut),
                            makeDynString("", "VState0"), makeDynString("", "VState1"),
                            makeDynString("", "VMan"), makeDynString("", "VInt"),
                            makeDynString("", "VRbk"), makeDynString("", "VFbk"),
                            makeDynString("", "WQC"), makeDynString("", "OSLevel"),
                            makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
                            makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
                            makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
                            makeDynString("", "SrcIntAct"));
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVOut, _DptInvalidMissingVOut);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVState0),
             makeDynString("", "VOut"), makeDynString("", "VState1"),
             makeDynString("", "VMan"), makeDynString("", "VInt"),
             makeDynString("", "VRbk"), makeDynString("", "VFbk"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVState0, _DptInvalidMissingVState0);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVState1),
             makeDynString("", "VOut"), makeDynString("", "VState0"),
             makeDynString("", "VMan"), makeDynString("", "VInt"),
             makeDynString("", "VRbk"), makeDynString("", "VFbk"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVState1, _DptInvalidMissingVState1);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVMan),
             makeDynString("", "VOut"), makeDynString("", "VState0"),
             makeDynString("", "VState1"), makeDynString("", "VInt"),
             makeDynString("", "VRbk"), makeDynString("", "VFbk"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVMan, _DptInvalidMissingVMan);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVInt),
             makeDynString("", "VOut"), makeDynString("", "VState0"),
             makeDynString("", "VState1"), makeDynString("", "VMan"),
             makeDynString("", "VRbk"), makeDynString("", "VFbk"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVInt, _DptInvalidMissingVInt);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVRbk),
             makeDynString("", "VOut"), makeDynString("", "VState0"),
             makeDynString("", "VState1"), makeDynString("", "VMan"),
             makeDynString("", "VInt"), makeDynString("", "VFbk"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVRbk, _DptInvalidMissingVRbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVFbk),
             makeDynString("", "VOut"), makeDynString("", "VState0"),
             makeDynString("", "VState1"), makeDynString("", "VMan"),
             makeDynString("", "VInt"), makeDynString("", "VRbk"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVFbk, _DptInvalidMissingVFbk);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingVOut);
    dpTypeDelete(_DptInvalidMissingVOut);

    dpDelete(_DpExistsInvalidMissingVState0);
    dpTypeDelete(_DptInvalidMissingVState0);

    dpDelete(_DpExistsInvalidMissingVState1);
    dpTypeDelete(_DptInvalidMissingVState1);

    dpDelete(_DpExistsInvalidMissingVMan);
    dpTypeDelete(_DptInvalidMissingVMan);

    dpDelete(_DpExistsInvalidMissingVInt);
    dpTypeDelete(_DptInvalidMissingVInt);

    dpDelete(_DpExistsInvalidMissingVRbk);
    dpTypeDelete(_DptInvalidMissingVRbk);

    dpDelete(_DpExistsInvalidMissingVFbk);
    dpTypeDelete(_DptInvalidMissingVFbk);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<BinManInt> binManInt = new BinManInt(_DpExists);
    assertEqual(binManInt.getDp(), _DpExists);
    assertEqual(binManInt.getValueOut(), false);
    assertEqual(binManInt.getValueStateFalseText(), "");
    assertEqual(binManInt.getValueStateTrueText(), "");
    assertEqual(binManInt.getValueManual(), false);
    assertEqual(binManInt.getValueInternal(), false);
    assertEqual(binManInt.getValueReadback(), false);
    assertEqual(binManInt.getValueFeedback(), false);
    assertTrue(binManInt.getWqc() != nullptr);
    assertTrue(binManInt.getOsLevel() != nullptr);
    assertTrue(binManInt.getSource() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<BinManInt> binManInt = new BinManInt(_DpExistsInvalidMissingVOut);
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
      shared_ptr<BinManInt> binManInt = new BinManInt(_DpExistsInvalidMissingVState0);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVState0 + ".VState0"));
    }

    try
    {
      shared_ptr<BinManInt> binManInt = new BinManInt(_DpExistsInvalidMissingVState1);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVState1 + ".VState1"));
    }

    try
    {
      shared_ptr<BinManInt> binManInt = new BinManInt(_DpExistsInvalidMissingVMan);
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
      shared_ptr<BinManInt> binManInt = new BinManInt(_DpExistsInvalidMissingVInt);
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
      shared_ptr<BinManInt> binManInt = new BinManInt(_DpExistsInvalidMissingVRbk);
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
      shared_ptr<BinManInt> binManInt = new BinManInt(_DpExistsInvalidMissingVFbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFbk + ".VFbk"));
    }

    return 0;
  }

  public int testValueOutChanged()
  {
    shared_ptr<BinManInt> binManInt = new BinManInt(_DpExists);
    classConnect(this, setValueOutChangedCB, binManInt, BinManInt::valueOutChanged);

    dpSetWait(_DpExists + ".VOut", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(binManInt.getValueOut(), true);
    assertEqual(_eventValueOut, true);
    return 0;
  }

  public int testValueManualChanged()
  {
    shared_ptr<BinManInt> binManInt = new BinManInt(_DpExists);
    classConnect(this, setValueManualChangedCB, binManInt, BinManInt::valueManualChanged);

    dpSetWait(_DpExists + ".VMan", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(binManInt.getValueManual(), true);
    assertEqual(_eventValueManual, true);
    return 0;
  }

  public int testValueInternalChanged()
  {
    shared_ptr<BinManInt> binManInt = new BinManInt(_DpExists);
    classConnect(this, setValueInternalChangedCB, binManInt, BinManInt::valueInternalChanged);

    dpSetWait(_DpExists + ".VInt", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(binManInt.getValueInternal(), true);
    assertEqual(_eventValueInternal, true);
    return 0;
  }

  public int testValueFeedbackChanged()
  {
    shared_ptr<BinManInt> binManInt = new BinManInt(_DpExists);
    classConnect(this, setValueFeedbackChangedCB, binManInt, BinManInt::valueFeedbackChanged);

    dpSetWait(_DpExists + ".VFbk", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(binManInt.getValueFeedback(), true);
    assertEqual(_eventValueFeedback, true);
    return 0;
  }

  public int testSetValueManual()
  {
    shared_ptr<BinManInt> binManInt = new BinManInt(_DpExists);

    binManInt.setValueManual(true);

    bool dpValue;
    dpGet(_DpExists + ".VMan", dpValue);
    assertEqual(dpValue, true, "Data point VMan should be set to true");
    assertEqual(binManInt.getValueOut(), true, "ValueOut should be set to true");

    binManInt.setValueManual(false);

    dpGet(_DpExists + ".VMan", dpValue);
    assertEqual(dpValue, false, "Data point VMan should be set to false");
    assertEqual(binManInt.getValueOut(), false, "ValueOut should be set to false");

    return 0;
  }

  private void setValueOutChangedCB(const bool &value)
  {
    _eventValueOut = value;
  }

  private void setValueManualChangedCB(const bool &value)
  {
    _eventValueManual = value;
  }

  private void setValueInternalChangedCB(const bool &value)
  {
    _eventValueInternal = value;
  }

  private void setValueFeedbackChangedCB(const bool &value)
  {
    _eventValueFeedback = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstBinManInt test;
  test.startAll();
}
