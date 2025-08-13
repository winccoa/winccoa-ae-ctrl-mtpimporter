// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/Services/ServParam/BinServParam.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/Services/ServParam/BinServParam.ctl
  @copyright $copyright
  @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/Services/ServParam/BinServParam" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for BinServParam.ctl
*/
class TstBinServParam : OaTest
{
  private const string _Dpt = "BinServParam";
  private const string _DptInvalidMissingApplyEn = "BinServParamInvalid1";
  private const string _DptInvalidMissingVExt = "BinServParamInvalid2";
  private const string _DptInvalidMissingVState0 = "BinServParamInvalid3";
  private const string _DptInvalidMissingVState1 = "BinServParamInvalid4";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingApplyEn = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVExt = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVState0 = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVState1 = "ExistingTestDatapointInvalid4";

  private bool _eventValueExternal;
  private bool _eventValueInternal;
  private bool _eventValueRequested;
  private bool _eventValueFeedback;
  private string _eventValueStateFalseText;
  private string _eventValueStateTrueText;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      DebugN("Data point type " + _Dpt + " does not exist");
      return -1;
    }

    // Create valid data point
    dpCreate(_DpExists, _Dpt);

    // Create invalid data point type for missing ApplyEn
    dyn_dyn_string dpes = makeDynAnytype(
                            makeDynString(_DptInvalidMissingApplyEn),
                            makeDynString("", "VExt"), makeDynString("", "VInt"), makeDynString("", "VReq"),
                            makeDynString("", "VFbk"), makeDynString("", "Name"), makeDynString("", "SrcChannel"),
                            makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
                            makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
                            makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
                            makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
                            makeDynString("", "StateAutAct"), makeDynString("", "VState0"), makeDynString("", "VState1"),
                            makeDynString("", "WQC"), makeDynString("", "OSLevel")
                          );
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
                         );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingApplyEn, _DptInvalidMissingApplyEn);
    DebugN("Created invalid data point type: " + _DptInvalidMissingApplyEn);
    DebugN("Verify ApplyEn does not exist: ", dpExists(_DpExistsInvalidMissingApplyEn + ".ApplyEn"));
    DebugN("Verify VState0 exists: ", dpExists(_DpExistsInvalidMissingApplyEn + ".VState0"));

    // Create invalid data point type for missing VExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVExt),
             makeDynString("", "ApplyEn"), makeDynString("", "VInt"), makeDynString("", "VReq"),
             makeDynString("", "VFbk"), makeDynString("", "Name"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "VState0"), makeDynString("", "VState1"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVExt, _DptInvalidMissingVExt);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVExt);
    DebugN("Verify VExt does not exist: ", dpExists(_DpExistsInvalidMissingVExt + ".VExt"));

    // Create invalid data point type for missing VState0
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVState0),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"), makeDynString("", "VState1"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVState0, _DptInvalidMissingVState0);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVState0);
    DebugN("Verify VState0 does not exist: ", dpExists(_DpExistsInvalidMissingVState0 + ".VState0"));
    DebugN("Verify ApplyEn exists: ", dpExists(_DpExistsInvalidMissingVState0 + ".ApplyEn"));

    // Create invalid data point type for missing VState1
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVState1),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"), makeDynString("", "VState0"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVState1, _DptInvalidMissingVState1);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVState1);
    DebugN("Verify VState1 does not exist: ", dpExists(_DpExistsInvalidMissingVState1 + ".VState1"));

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    DebugN("Deleted data point: " + _DpExists);

    dpDelete(_DpExistsInvalidMissingApplyEn);
    dpTypeDelete(_DptInvalidMissingApplyEn);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingApplyEn + ", " + _DptInvalidMissingApplyEn);

    dpDelete(_DpExistsInvalidMissingVExt);
    dpTypeDelete(_DptInvalidMissingVExt);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVExt + ", " + _DptInvalidMissingVExt);

    dpDelete(_DpExistsInvalidMissingVState0);
    dpTypeDelete(_DptInvalidMissingVState0);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVState0 + ", " + _DptInvalidMissingVState0);

    dpDelete(_DpExistsInvalidMissingVState1);
    dpTypeDelete(_DptInvalidMissingVState1);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVState1 + ", " + _DptInvalidMissingVState1);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<BinServParam> binServParam = new BinServParam(_DpExists);
    assertEqual(binServParam.getDp(), _DpExists);
    assertEqual(binServParam.getApplyEnabled(), false);
    assertEqual(binServParam.getApplyExternal(), false);
    assertEqual(binServParam.getApplyInternal(), false);
    assertEqual(binServParam.getSourceChannel(), false);
    assertEqual(binServParam.getSourceExternalAutomatic(), false);
    assertEqual(binServParam.getSourceInternalAutomatic(), false);
    assertEqual(binServParam.getSourceExternalActive(), false);
    assertEqual(binServParam.getSourceInternalActive(), false);
    assertTrue(binServParam.getWqc() != nullptr);
    assertTrue(binServParam.getOsLevel() != nullptr);
    langString name = binServParam.getName();
    assertTrue(name.text() == "", "Name should not be empty");
    assertEqual(binServParam.getStateChannel(), false);
    assertEqual(binServParam.getStateOffAutomatic(), false);
    assertEqual(binServParam.getStateOperatorAutomatic(), false);
    assertEqual(binServParam.getStateAutomaticAutomatic(), false);
    assertEqual(binServParam.getStateOffActive(), false);
    assertEqual(binServParam.getStateOperatorActive(), false);
    assertEqual(binServParam.getStateAutomaticActive(), false);
    assertEqual(binServParam.getValueStateFalseText(), "");
    assertEqual(binServParam.getValueStateTrueText(), "");
    assertEqual(binServParam.getValueExternal(), false);
    assertEqual(binServParam.getValueInternal(), false);
    assertEqual(binServParam.getValueRequested(), false);
    assertEqual(binServParam.getValueFeedback(), false);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    // Test missing ApplyEn
    try
    {
      shared_ptr<BinServParam> binServParam = new BinServParam(_DpExistsInvalidMissingApplyEn);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing ApplyEn");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for ApplyEn: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing ApplyEn");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingApplyEn + ".ApplyEn"), "Exception should reference ApplyEn");
    }

    // Test missing VExt
    try
    {
      shared_ptr<BinServParam> binServParam = new BinServParam(_DpExistsInvalidMissingVExt);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VExt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VExt: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VExt");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVExt + ".VExt"), "Exception should reference VExt");
    }

    // Test missing VState0
    try
    {
      shared_ptr<BinServParam> binServParam = new BinServParam(_DpExistsInvalidMissingVState0);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VState0");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VState0: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VState0");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVState0 + ".VState0"), "Exception should reference VState0");
    }

    // Test missing VState1
    try
    {
      shared_ptr<BinServParam> binServParam = new BinServParam(_DpExistsInvalidMissingVState1);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VState1");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VState1: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VState1");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVState1 + ".VState1"), "Exception should reference VState1");
    }

    return 0;
  }

  public int testSetValueExternal()
  {
    shared_ptr<BinServParam> binServParam = new BinServParam(_DpExists);
    classConnect(this, setValueExternalChangedCB, binServParam, BinServParam::valueExternalChanged);

    binServParam.setValueExternal(true);
    DebugN("Called setValueExternal with true for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    bool dpValue;
    dpGet(_DpExists + ".VExt", dpValue);
    assertEqual(binServParam.getValueExternal(), true, "getValueExternal should return true");
    assertEqual(dpValue, true, "Data point VExt should be true");
    assertEqual(_eventValueExternal, true, "Event value for VExt should be true");
    return 0;
  }

  public int testSetValueInternal()
  {
    shared_ptr<BinServParam> binServParam = new BinServParam(_DpExists);
    classConnect(this, setValueInternalChangedCB, binServParam, BinServParam::valueInternalChanged);

    binServParam.setValueInternal(true);
    DebugN("Called setValueInternal with true for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    bool dpValue;
    dpGet(_DpExists + ".VInt", dpValue);
    assertEqual(binServParam.getValueInternal(), true, "getValueInternal should return true");
    assertEqual(dpValue, true, "Data point VInt should be true");
    assertEqual(_eventValueInternal, true, "Event value for VInt should be true");
    return 0;
  }

  public int testSetValueRequested()
  {
    shared_ptr<BinServParam> binServParam = new BinServParam(_DpExists);
    classConnect(this, setValueRequestedChangedCB, binServParam, BinServParam::valueRequestedChanged);

    binServParam.setValueRequested(true);
    DebugN("Called setValueRequested with true for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    bool dpValue;
    dpGet(_DpExists + ".VReq", dpValue);
    assertEqual(binServParam.getValueRequested(), true, "getValueRequested should return true");
    assertEqual(dpValue, true, "Data point VReq should be true");
    assertEqual(_eventValueRequested, true, "Event value for VReq should be true");
    return 0;
  }

  public int testSetValueFeedback()
  {
    shared_ptr<BinServParam> binServParam = new BinServParam(_DpExists);
    classConnect(this, setValueFeedbackChangedCB, binServParam, BinServParam::valueFeedbackChanged);

    binServParam.setValueFeedback(true);
    DebugN("Called setValueFeedback with true for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    bool dpValue;
    dpGet(_DpExists + ".VFbk", dpValue);
    assertEqual(binServParam.getValueFeedback(), true, "getValueFeedback should return true");
    assertEqual(dpValue, true, "Data point VFbk should be true");
    assertEqual(_eventValueFeedback, true, "Event value for VFbk should be true");
    return 0;
  }

  private void setValueStateFalseTextChangedCB(const string &value)
  {
    _eventValueStateFalseText = value;
    DebugN("ValueStateFalseTextChanged callback triggered with value: " + value);
  }

  private void setValueStateTrueTextChangedCB(const string &value)
  {
    _eventValueStateTrueText = value;
    DebugN("ValueStateTrueTextChanged callback triggered with value: " + value);
  }

  private void setValueExternalChangedCB(const bool &value)
  {
    _eventValueExternal = value;
    DebugN("ValueExternalChanged callback triggered with value: " + value);
  }

  private void setValueInternalChangedCB(const bool &value)
  {
    _eventValueInternal = value;
    DebugN("ValueInternalChanged callback triggered with value: " + value);
  }

  private void setValueRequestedChangedCB(const bool &value)
  {
    _eventValueRequested = value;
    DebugN("ValueRequestedChanged callback triggered with value: " + value);
  }

  private void setValueFeedbackChangedCB(const bool &value)
  {
    _eventValueFeedback = value;
    DebugN("ValueFeedbackChanged callback triggered with value: " + value);
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstBinServParam test;
  test.startAll();
}
