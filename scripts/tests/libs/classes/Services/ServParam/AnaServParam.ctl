// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/Services/ServParam/AnaServParam.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/Services/ServParam/AnaServParam.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/Services/ServParam/AnaServParam" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for AnaServParam.ctl
*/
class TstAnaServParam : OaTest
{
  private const string _Dpt = "AnaServParam";
  private const string _DptInvalidMissingApplyEn = "AnaServParamInvalid1";
  private const string _DptInvalidMissingVExt = "AnaServParamInvalid2";
  private const string _DptInvalidMissingVSclMin = "AnaServParamInvalid3";
  private const string _DptInvalidMissingVMin = "AnaServParamInvalid4";
  private const string _DptInvalidMissingVSclMax = "AnaServParamInvalid5";
  private const string _DptInvalidMissingVMax = "AnaServParamInvalid6";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingApplyEn = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVExt = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVMin = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingVMax = "ExistingTestDatapointInvalid6";

  private float _eventValueExternal;
  private float _eventValueInternal;
  private float _eventValueRequested;
  private float _eventValueFeedback;
  private float _eventValueScaleMin;
  private float _eventValueScaleMax;
  private float _eventValueMinimum;
  private float _eventValueMaximum;

  public int setUp() override
  {
    // Clean up existing data points and types
    dyn_string existingDps = dpNames("*", _Dpt);

    for (int i = 1; i <= dynlen(existingDps); i++) dpDelete(existingDps[i]);

    dyn_string existingTypes = dpTypes(_Dpt + "Invalid*");

    for (int i = 1; i <= dynlen(existingTypes); i++) dpTypeDelete(existingTypes[i]);

    DebugN("Cleaned up existing data points: ", existingDps, "Types: ", existingTypes);

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
                            makeDynString("", "StateAutAct"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"),
                            makeDynString("", "VMin"), makeDynString("", "VMax")
                          );
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT)
                         );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingApplyEn, _DptInvalidMissingApplyEn);
    DebugN("Created invalid data point type: " + _DptInvalidMissingApplyEn);
    DebugN("Verify ApplyEn does not exist: ", dpExists(_DpExistsInvalidMissingApplyEn + ".ApplyEn"));
    DebugN("Verify VSclMin exists: ", dpExists(_DpExistsInvalidMissingApplyEn + ".VSclMin"));

    // Create invalid data point type for missing VExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVExt),
             makeDynString("", "ApplyEn"), makeDynString("", "VInt"), makeDynString("", "VReq"),
             makeDynString("", "VFbk"), makeDynString("", "Name"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"),
             makeDynString("", "VMin"), makeDynString("", "VMax")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVExt, _DptInvalidMissingVExt);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVExt);
    DebugN("Verify VExt does not exist: ", dpExists(_DpExistsInvalidMissingVExt + ".VExt"));

    // Create invalid data point type for missing VSclMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVSclMin),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"), makeDynString("", "VSclMax"),
             makeDynString("", "VMin"), makeDynString("", "VMax"),  makeDynString("", "WQC"),
             makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT),  makeDynInt(0, DPEL_FLOAT),  makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVSclMin, _DptInvalidMissingVSclMin);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVSclMin);
    DebugN("Verify VSclMin does not exist: ", dpExists(_DpExistsInvalidMissingVSclMin + ".VSclMin"));
    DebugN("Verify ApplyEn exists: ", dpExists(_DpExistsInvalidMissingVSclMin + ".ApplyEn"));

    // Create invalid data point type for missing VMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVMin),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"), makeDynString("", "VSclMin"),
             makeDynString("", "VSclMax"), makeDynString("", "VMax"),  makeDynString("", "WQC"),
             makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),  makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVMin, _DptInvalidMissingVMin);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVMin);
    DebugN("Verify VMin does not exist: ", dpExists(_DpExistsInvalidMissingVMin + ".VMin"));

    // Create invalid data point type for missing VSclMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVSclMax),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"), makeDynString("", "VSclMin"),
             makeDynString("", "VMin"), makeDynString("", "VMax"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVSclMax, _DptInvalidMissingVSclMax);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVSclMax);
    DebugN("Verify VSclMax does not exist: ", dpExists(_DpExistsInvalidMissingVSclMax + ".VSclMax"));
    DebugN("Verify ApplyEn exists: ", dpExists(_DpExistsInvalidMissingVSclMax + ".ApplyEn"));

    // Create invalid data point type for missing VMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVMax),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"), makeDynString("", "VSclMin"),
             makeDynString("", "VSclMax"), makeDynString("", "VMin"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVMax, _DptInvalidMissingVMax);
    DebugN("Created invalid data point type: " + _DptInvalidMissingVMax);
    DebugN("Verify VMax does not exist: ", dpExists(_DpExistsInvalidMissingVMax + ".VMax"));

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

    dpDelete(_DpExistsInvalidMissingVSclMin);
    dpTypeDelete(_DptInvalidMissingVSclMin);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVSclMin + ", " + _DptInvalidMissingVSclMin);

    dpDelete(_DpExistsInvalidMissingVMin);
    dpTypeDelete(_DptInvalidMissingVMin);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVMin + ", " + _DptInvalidMissingVMin);

    dpDelete(_DpExistsInvalidMissingVSclMax);
    dpTypeDelete(_DptInvalidMissingVSclMax);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVSclMax + ", " + _DptInvalidMissingVSclMax);

    dpDelete(_DpExistsInvalidMissingVMax);
    dpTypeDelete(_DptInvalidMissingVMax);
    DebugN("Deleted data point and type: " + _DpExistsInvalidMissingVMax + ", " + _DptInvalidMissingVMax);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    assertEqual(anaServParam.getDp(), _DpExists);
    assertEqual(anaServParam.getApplyEnabled(), false);
    assertEqual(anaServParam.getApplyExternal(), false);
    assertEqual(anaServParam.getApplyInternal(), false);
    assertEqual(anaServParam.getSourceChannel(), false);
    assertEqual(anaServParam.getSourceExternalAutomatic(), false);
    assertEqual(anaServParam.getSourceInternalAutomatic(), false);
    assertEqual(anaServParam.getSourceExternalActive(), false);
    assertEqual(anaServParam.getSourceInternalActive(), false);
    assertTrue(anaServParam.getWqc() != nullptr);
    assertTrue(anaServParam.getOsLevel() != nullptr);
    langString name = anaServParam.getName();
    assertTrue(name.text() == "", "Name should not be empty");
    assertEqual(anaServParam.getStateChannel(), false);
    assertEqual(anaServParam.getStateOffAutomatic(), false);
    assertEqual(anaServParam.getStateOperatorAutomatic(), false);
    assertEqual(anaServParam.getStateAutomaticAutomatic(), false);
    assertEqual(anaServParam.getStateOffActive(), false);
    assertEqual(anaServParam.getStateOperatorActive(), false);
    assertEqual(anaServParam.getStateAutomaticActive(), false);
    assertEqual(anaServParam.getValueScaleMin(), 0.0);
    assertEqual(anaServParam.getValueScaleMax(), 0.0);
    assertEqual(anaServParam.getValueMinimum(), 0.0);
    assertEqual(anaServParam.getValueMaximum(), 0.0);
    assertEqual(anaServParam.getValueExternal(), 0.0);
    assertEqual(anaServParam.getValueInternal(), 0.0);
    assertEqual(anaServParam.getValueRequested(), 0.0);
    assertEqual(anaServParam.getValueFeedback(), 0.0);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    // Test missing ApplyEn
    try
    {
      shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExistsInvalidMissingApplyEn);
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
      shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExistsInvalidMissingVExt);
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

    // Test missing VSclMin
    try
    {
      shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExistsInvalidMissingVSclMin);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VSclMin");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VSclMin: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VSclMin");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVSclMin + ".VSclMin"), "Exception should reference VSclMin");
    }

    // Test missing VMin
    try
    {
      shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExistsInvalidMissingVMin);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VMin");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VMin: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VMin");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVMin + ".VMin"), "Exception should reference VMin");
    }

    // Test missing VSclMax
    try
    {
      shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExistsInvalidMissingVSclMax);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VSclMax");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VSclMax: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VSclMax");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVSclMax + ".VSclMax"), "Exception should reference VSclMax");
    }

    // Test missing VMax
    try
    {
      shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExistsInvalidMissingVMax);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VMax");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      DebugN("Caught exception for VMax: " + errText);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VMax");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVMax + ".VMax"), "Exception should reference VMax");
    }

    return 0;
  }

  public int testValueScaleMinChanged()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueScaleMinChangedCB, anaServParam, AnaServParam::valueScaleMinChanged);

    dpSetWait(_DpExists + ".VSclMin", 10.0);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaServParam.getValueScaleMin(), 10.0);
    assertEqual(_eventValueScaleMin, 10.0);
    return 0;
  }

  public int testSetValueScaleMin()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueScaleMinChangedCB, anaServParam, AnaServParam::valueScaleMinChanged);

    anaServParam.setValueScaleMin(10.0);
    DebugN("Called setValueScaleMin with 10.0 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VSclMin", dpValue);
    assertEqual(anaServParam.getValueScaleMin(), 10.0, "getValueScaleMin should return 10.0");
    assertEqual(dpValue, 10.0, "Data point VSclMin should be 10.0");
    assertEqual(_eventValueScaleMin, 10.0, "Event value for VSclMin should be 10.0");
    return 0;
  }

  public int testSetValueScaleMax()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueScaleMaxChangedCB, anaServParam, AnaServParam::valueScaleMaxChanged);

    anaServParam.setValueScaleMax(20.0);
    DebugN("Called setValueScaleMax with 20.0 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VSclMax", dpValue);
    assertEqual(anaServParam.getValueScaleMax(), 20.0, "getValueScaleMax should return 20.0");
    assertEqual(dpValue, 20.0, "Data point VSclMax should be 20.0");
    assertEqual(_eventValueScaleMax, 20.0, "Event value for VSclMax should be 20.0");
    return 0;
  }

  public int testSetValueMinimum()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueMinimumChangedCB, anaServParam, AnaServParam::valueMinimumChanged);

    anaServParam.setValueMinimum(5.0);
    DebugN("Called setValueMinimum with 5.0 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VMin", dpValue);
    assertEqual(anaServParam.getValueMinimum(), 5.0, "getValueMinimum should return 5.0");
    assertEqual(dpValue, 5.0, "Data point VMin should be 5.0");
    assertEqual(_eventValueMinimum, 5.0, "Event value for VMin should be 5.0");
    return 0;
  }

  public int testSetValueMaximum()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueMaximumChangedCB, anaServParam, AnaServParam::valueMaximumChanged);

    anaServParam.setValueMaximum(30.0);
    DebugN("Called setValueMaximum with 30.0 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VMax", dpValue);
    assertEqual(anaServParam.getValueMaximum(), 30.0, "getValueMaximum should return 30.0");
    assertEqual(dpValue, 30.0, "Data point VMax should be 30.0");
    assertEqual(_eventValueMaximum, 30.0, "Event value for VMax should be 30.0");
    return 0;
  }

  public int testSetValueExternal()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueExternalChangedCB, anaServParam, AnaServParam::valueExternalChanged);

    anaServParam.setValueExternal(42.0);
    DebugN("Called setValueExternal with 42.0 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VExt", dpValue);
    assertEqual(anaServParam.getValueExternal(), 42.0, "getValueExternal should return 42.0");
    assertEqual(dpValue, 42.0, "Data point VExt should be 42.0");
    assertEqual(_eventValueExternal, 42.0, "Event value for VExt should be 42.0");
    return 0;
  }

  public int testSetValueInternal()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueInternalChangedCB, anaServParam, AnaServParam::valueInternalChanged);

    anaServParam.setValueInternal(50.0);
    DebugN("Called setValueInternal with 50.0 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VInt", dpValue);
    assertEqual(anaServParam.getValueInternal(), 50.0, "getValueInternal should return 50.0");
    assertEqual(dpValue, 50.0, "Data point VInt should be 50.0");
    assertEqual(_eventValueInternal, 50.0, "Event value for VInt should be 50.0");
    return 0;
  }

  public int testSetValueRequested()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueRequestedChangedCB, anaServParam, AnaServParam::valueRequestedChanged);

    anaServParam.setValueRequested(60.0);
    DebugN("Called setValueRequested with 60.0 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VReq", dpValue);
    assertEqual(anaServParam.getValueRequested(), 60.0, "getValueRequested should return 60.0");
    assertEqual(dpValue, 60.0, "Data point VReq should be 60.0");
    assertEqual(_eventValueRequested, 60.0, "Event value for VReq should be 60.0");
    return 0;
  }

  public int testSetValueFeedback()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueFeedbackChangedCB, anaServParam, AnaServParam::valueFeedbackChanged);

    anaServParam.setValueFeedback(70.0);
    DebugN("Called setValueFeedback with 70.0 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VFbk", dpValue);
    assertEqual(anaServParam.getValueFeedback(), 70.0, "getValueFeedback should return 70.0");
    assertEqual(dpValue, 70.0, "Data point VFbk should be 70.0");
    assertEqual(_eventValueFeedback, 70.0, "Event value for VFbk should be 70.0");
    return 0;
  }

  private void setValueScaleMinChangedCB(const float &value)
  {
    _eventValueScaleMin = value;
    DebugN("ValueScaleMinChanged callback triggered with value: " + value);
  }

  private void setValueScaleMaxChangedCB(const float &value)
  {
    _eventValueScaleMax = value;
    DebugN("ValueScaleMaxChanged callback triggered with value: " + value);
  }

  private void setValueMinimumChangedCB(const float &value)
  {
    _eventValueMinimum = value;
    DebugN("ValueMinimumChanged callback triggered with value: " + value);
  }

  private void setValueMaximumChangedCB(const float &value)
  {
    _eventValueMaximum = value;
    DebugN("ValueMaximumChanged callback triggered with value: " + value);
  }

  private void setValueExternalChangedCB(const float &value)
  {
    _eventValueExternal = value;
    DebugN("ValueExternalChanged callback triggered with value: " + value);
  }

  private void setValueInternalChangedCB(const float &value)
  {
    _eventValueInternal = value;
    DebugN("ValueInternalChanged callback triggered with value: " + value);
  }

  private void setValueRequestedChangedCB(const float &value)
  {
    _eventValueRequested = value;
    DebugN("ValueRequestedChanged callback triggered with value: " + value);
  }

  private void setValueFeedbackChangedCB(const float &value)
  {
    _eventValueFeedback = value;
    DebugN("ValueFeedbackChanged callback triggered with value: " + value);
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstAnaServParam test;
  test.startAll();
}
