// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/Services/ServParam/StringServParam.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/Services/ServParam/StringServParam.ctl
  @copyright $copyright
  @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/Services/ServParam/StringServParam" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for StringServParam.ctl
*/
class TstStringServParam : OaTest
{
  private const string _Dpt = "StringServParam";
  private const string _DptInvalidMissingApplyEn = "StringServParamInvalid1";
  private const string _DptInvalidMissingVExt = "StringServParamInvalid2";
  private const string _DptInvalidMissingVInt = "StringServParamInvalid3";
  private const string _DptInvalidMissingVReq = "StringServParamInvalid4";
  private const string _DptInvalidMissingVFbk = "StringServParamInvalid5";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingApplyEn = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVExt = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVInt = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVReq = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingVFbk = "ExistingTestDatapointInvalid5";

  private string _eventValueExternal;
  private string _eventValueInternal;
  private string _eventValueRequested;
  private string _eventValueFeedback;

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
                            makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
                          );
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
                         );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingApplyEn, _DptInvalidMissingApplyEn);
    DebugN("Created invalid data point type: " + _DptInvalidMissingApplyEn);
    DebugN("Verify ApplyEn does not exist: ", dpExists(_DpExistsInvalidMissingApplyEn + ".ApplyEn"));
    DebugN("Verify VExt exists: ", dpExists(_DpExistsInvalidMissingApplyEn + ".VExt"));

    // Create invalid data point type for missing VExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVExt),
             makeDynString("", "ApplyEn"), makeDynString("", "VInt"), makeDynString("", "VReq"),
             makeDynString("", "VFbk"), makeDynString("", "Name"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVExt, _DptInvalidMissingVExt);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVExt);
    DebugN("Verify VExt does not exist: ", dpExists(_DpExistsInvalidMissingVExt + ".VExt"));

    // Create invalid data point type for missing VInt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVInt),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VReq"),
             makeDynString("", "VFbk"), makeDynString("", "Name"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVInt, _DptInvalidMissingVInt);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVInt);
    DebugN("Verify VInt does not exist: ", dpExists(_DpExistsInvalidMissingVInt + ".VInt"));
    DebugN("Verify ApplyEn exists: ", dpExists(_DpExistsInvalidMissingVInt + ".ApplyEn"));

    // Create invalid data point type for missing VReq
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVReq),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VFbk"), makeDynString("", "Name"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVReq, _DptInvalidMissingVReq);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVReq);
    DebugN("Verify VReq does not exist: ", dpExists(_DpExistsInvalidMissingVReq + ".VReq"));

    // Create invalid data point type for missing VFbk
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVFbk),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VReq"), makeDynString("", "Name"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVFbk, _DptInvalidMissingVFbk);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVFbk);
    DebugN("Verify VFbk does not exist: ", dpExists(_DpExistsInvalidMissingVFbk + ".VFbk"));

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

    dpDelete(_DpExistsInvalidMissingVInt);
    dpTypeDelete(_DptInvalidMissingVInt);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVInt + ", " + _DptInvalidMissingVInt);

    dpDelete(_DpExistsInvalidMissingVReq);
    dpTypeDelete(_DptInvalidMissingVReq);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVReq + ", " + _DptInvalidMissingVReq);

    dpDelete(_DpExistsInvalidMissingVFbk);
    dpTypeDelete(_DptInvalidMissingVFbk);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVFbk + ", " + _DptInvalidMissingVFbk);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExists);
    assertEqual(stringServParam.getDp(), _DpExists);
    assertEqual(stringServParam.getApplyEnabled(), false);
    assertEqual(stringServParam.getApplyExternal(), false);
    assertEqual(stringServParam.getApplyInternal(), false);
    assertEqual(stringServParam.getSourceChannel(), false);
    assertEqual(stringServParam.getSourceExternalAutomatic(), false);
    assertEqual(stringServParam.getSourceInternalAutomatic(), false);
    assertEqual(stringServParam.getSourceExternalActive(), false);
    assertEqual(stringServParam.getSourceInternalActive(), false);
    assertTrue(stringServParam.getWqc() != nullptr);
    assertTrue(stringServParam.getOsLevel() != nullptr);
    langString name = stringServParam.getName();
    assertTrue(name.text() == "", "Name should not be empty");
    assertEqual(stringServParam.getStateChannel(), false);
    assertEqual(stringServParam.getStateOffAutomatic(), false);
    assertEqual(stringServParam.getStateOperatorAutomatic(), false);
    assertEqual(stringServParam.getStateAutomaticAutomatic(), false);
    assertEqual(stringServParam.getStateOffActive(), false);
    assertEqual(stringServParam.getStateOperatorActive(), false);
    assertEqual(stringServParam.getStateAutomaticActive(), false);
    assertEqual(stringServParam.getValueExternal(), "");
    assertEqual(stringServParam.getValueInternal(), "");
    assertEqual(stringServParam.getValueRequested(), "");
    assertEqual(stringServParam.getValueFeedback(), "");
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    // Test missing ApplyEn
    try
    {
      shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExistsInvalidMissingApplyEn);
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
      shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExistsInvalidMissingVExt);
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

    // Test missing VInt
    try
    {
      shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExistsInvalidMissingVInt);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VInt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VInt: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VInt");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVInt + ".VInt"), "Exception should reference VInt");
    }

    // Test missing VReq
    try
    {
      shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExistsInvalidMissingVReq);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VReq");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VReq: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VReq");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVReq + ".VReq"), "Exception should reference VReq");
    }

    // Test missing VFbk
    try
    {
      shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExistsInvalidMissingVFbk);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VFbk");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VFbk: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VFbk");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVFbk + ".VFbk"), "Exception should reference VFbk");
    }

    return 0;
  }

  public int testSetValueExternal()
  {
    shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExists);
    classConnect(this, setValueExternalChangedCB, stringServParam, StringServParam::valueExternalChanged);

    stringServParam.setValueExternal("EXTERNAL");
    DebugN("Called setValueExternal with EXTERNAL for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    string dpValue;
    dpGet(_DpExists + ".VExt", dpValue);
    assertEqual(stringServParam.getValueExternal(), "EXTERNAL", "getValueExternal should return EXTERNAL");
    assertEqual(dpValue, "EXTERNAL", "Data point VExt should be EXTERNAL");
    assertEqual(_eventValueExternal, "EXTERNAL", "Event value for VExt should be EXTERNAL");
    return 0;
  }

  public int testSetValueInternal()
  {
    shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExists);
    classConnect(this, setValueInternalChangedCB, stringServParam, StringServParam::valueInternalChanged);

    stringServParam.setValueInternal("INTERNAL");
    DebugN("Called setValueInternal with INTERNAL for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    string dpValue;
    dpGet(_DpExists + ".VInt", dpValue);
    assertEqual(stringServParam.getValueInternal(), "INTERNAL", "getValueInternal should return INTERNAL");
    assertEqual(dpValue, "INTERNAL", "Data point VInt should be INTERNAL");
    assertEqual(_eventValueInternal, "INTERNAL", "Event value for VInt should be INTERNAL");
    return 0;
  }

  public int testSetValueRequested()
  {
    shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExists);
    classConnect(this, setValueRequestedChangedCB, stringServParam, StringServParam::valueRequestedChanged);

    stringServParam.setValueRequested("REQUESTED");
    DebugN("Called setValueRequested with REQUESTED for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    string dpValue;
    dpGet(_DpExists + ".VReq", dpValue);
    assertEqual(stringServParam.getValueRequested(), "REQUESTED", "getValueRequested should return REQUESTED");
    assertEqual(dpValue, "REQUESTED", "Data point VReq should be REQUESTED");
    assertEqual(_eventValueRequested, "REQUESTED", "Event value for VReq should be REQUESTED");
    return 0;
  }

  public int testSetValueFeedback()
  {
    shared_ptr<StringServParam> stringServParam = new StringServParam(_DpExists);
    classConnect(this, setValueFeedbackChangedCB, stringServParam, StringServParam::valueFeedbackChanged);

    stringServParam.setValueFeedback("FEEDBACK");
    DebugN("Called setValueFeedback with FEEDBACK for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    string dpValue;
    dpGet(_DpExists + ".VFbk", dpValue);
    assertEqual(stringServParam.getValueFeedback(), "FEEDBACK", "getValueFeedback should return FEEDBACK");
    assertEqual(dpValue, "FEEDBACK", "Data point VFbk should be FEEDBACK");
    assertEqual(_eventValueFeedback, "FEEDBACK", "Event value for VFbk should be FEEDBACK");
    return 0;
  }

  private void setValueExternalChangedCB(const string &value)
  {
    _eventValueExternal = value;
    DebugN("ValueExternalChanged callback triggered with value: " + value);
  }

  private void setValueInternalChangedCB(const string &value)
  {
    _eventValueInternal = value;
    DebugN("ValueInternalChanged callback triggered with value: " + value);
  }

  private void setValueRequestedChangedCB(const string &value)
  {
    _eventValueRequested = value;
    DebugN("ValueRequestedChanged callback triggered with value: " + value);
  }

  private void setValueFeedbackChangedCB(const string &value)
  {
    _eventValueFeedback = value;
    DebugN("ValueFeedbackChanged callback triggered with value: " + value);
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstStringServParam test;
  test.startAll();
}
