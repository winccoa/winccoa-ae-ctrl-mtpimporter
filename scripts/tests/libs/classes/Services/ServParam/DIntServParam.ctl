// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/Services/ServParam/DIntServParam.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/Services/ServParam/DIntServParam.ctl
  @copyright $copyright
  @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/Services/ServParam/DIntServParam" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for DIntServParam.ctl
*/
class TstDIntServParam : OaTest
{
  private const string _Dpt = "DIntServParam";
  private const string _DptInvalidMissingApplyEn = "DIntServParamInvalid1";
  private const string _DptInvalidMissingVExt = "DIntServParamInvalid2";
  private const string _DptInvalidMissingVSclMin = "DIntServParamInvalid3";
  private const string _DptInvalidMissingVMin = "DIntServParamInvalid4";
  private const string _DptInvalidMissingVSclMax = "DIntServParamInvalid5";
  private const string _DptInvalidMissingVMax = "DIntServParamInvalid6";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingApplyEn = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVExt = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVMin = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingVMax = "ExistingTestDatapointInvalid6";

  private int _eventValueExternal;
  private int _eventValueInternal;
  private int _eventValueRequested;
  private int _eventValueFeedback;
  private int _eventValueScaleMin;
  private int _eventValueScaleMax;
  private int _eventValueMinimum;
  private int _eventValueMaximum;

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
                            makeDynString("", "StateAutAct"), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"),
                            makeDynString("", "VMin"), makeDynString("", "VMax")
                          );
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
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
             makeDynString("", "VMin"), makeDynString("", "VMax"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
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
             makeDynString("", "VSclMax"), makeDynString("", "VMax"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
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
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    assertEqual(dintServParam.getDp(), _DpExists);
    assertEqual(dintServParam.getApplyEnabled(), false);
    assertEqual(dintServParam.getApplyExternal(), false);
    assertEqual(dintServParam.getApplyInternal(), false);
    assertEqual(dintServParam.getSourceChannel(), false);
    assertEqual(dintServParam.getSourceExternalAutomatic(), false);
    assertEqual(dintServParam.getSourceInternalAutomatic(), false);
    assertEqual(dintServParam.getSourceExternalActive(), false);
    assertEqual(dintServParam.getSourceInternalActive(), false);
    assertTrue(dintServParam.getWqc() != nullptr);
    assertTrue(dintServParam.getOsLevel() != nullptr);
    langString name = dintServParam.getName();
    assertTrue(name.text() == "", "Name should not be empty");
    assertEqual(dintServParam.getStateChannel(), false);
    assertEqual(dintServParam.getStateOffAutomatic(), false);
    assertEqual(dintServParam.getStateOperatorAutomatic(), false);
    assertEqual(dintServParam.getStateAutomaticAutomatic(), false);
    assertEqual(dintServParam.getStateOffActive(), false);
    assertEqual(dintServParam.getStateOperatorActive(), false);
    assertEqual(dintServParam.getStateAutomaticActive(), false);
    assertEqual(dintServParam.getValueScaleMin(), 0);
    assertEqual(dintServParam.getValueScaleMax(), 0);
    assertEqual(dintServParam.getValueMinimum(), 0);
    assertEqual(dintServParam.getValueMaximum(), 0);
    assertEqual(dintServParam.getValueExternal(), 0);
    assertEqual(dintServParam.getValueInternal(), 0);
    assertEqual(dintServParam.getValueRequested(), 0);
    assertEqual(dintServParam.getValueFeedback(), 0);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    // Test missing ApplyEn
    try
    {
      shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExistsInvalidMissingApplyEn);
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
      shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExistsInvalidMissingVExt);
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
      shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExistsInvalidMissingVSclMin);
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
      shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExistsInvalidMissingVMin);
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
      shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExistsInvalidMissingVSclMax);
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
      shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExistsInvalidMissingVMax);
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
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueScaleMinChangedCB, dintServParam, DIntServParam::valueScaleMinChanged);

    dpSetWait(_DpExists + ".VSclMin", 10);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(dintServParam.getValueScaleMin(), 10);
    assertEqual(_eventValueScaleMin, 10);
    return 0;
  }

  public int testSetValueScaleMin()
  {
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueScaleMinChangedCB, dintServParam, DIntServParam::valueScaleMinChanged);

    dintServParam.setValueScaleMin(10);
    DebugN("Called setValueScaleMin with 10 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    int dpValue;
    dpGet(_DpExists + ".VSclMin", dpValue);
    assertEqual(dintServParam.getValueScaleMin(), 10, "getValueScaleMin should return 10");
    assertEqual(dpValue, 10, "Data point VSclMin should be 10");
    assertEqual(_eventValueScaleMin, 10, "Event value for VSclMin should be 10");
    return 0;
  }

  public int testSetValueScaleMax()
  {
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueScaleMaxChangedCB, dintServParam, DIntServParam::valueScaleMaxChanged);

    dintServParam.setValueScaleMax(20);
    DebugN("Called setValueScaleMax with 20 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    int dpValue;
    dpGet(_DpExists + ".VSclMax", dpValue);
    assertEqual(dintServParam.getValueScaleMax(), 20, "getValueScaleMax should return 20");
    assertEqual(dpValue, 20, "Data point VSclMax should be 20");
    assertEqual(_eventValueScaleMax, 20, "Event value for VSclMax should be 20");
    return 0;
  }

  public int testSetValueMinimum()
  {
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueMinimumChangedCB, dintServParam, DIntServParam::valueMinimumChanged);

    dintServParam.setValueMinimum(5);
    DebugN("Called setValueMinimum with 5 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    int dpValue;
    dpGet(_DpExists + ".VMin", dpValue);
    assertEqual(dintServParam.getValueMinimum(), 5, "getValueMinimum should return 5");
    assertEqual(dpValue, 5, "Data point VMin should be 5");
    assertEqual(_eventValueMinimum, 5, "Event value for VMin should be 5");
    return 0;
  }

  public int testSetValueMaximum()
  {
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueMaximumChangedCB, dintServParam, DIntServParam::valueMaximumChanged);

    dintServParam.setValueMaximum(30);
    DebugN("Called setValueMaximum with 30 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    int dpValue;
    dpGet(_DpExists + ".VMax", dpValue);
    assertEqual(dintServParam.getValueMaximum(), 30, "getValueMaximum should return 30");
    assertEqual(dpValue, 30, "Data point VMax should be 30");
    assertEqual(_eventValueMaximum, 30, "Event value for VMax should be 30");
    return 0;
  }

  public int testSetValueExternal()
  {
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueExternalChangedCB, dintServParam, DIntServParam::valueExternalChanged);

    dintServParam.setValueExternal(42);
    DebugN("Called setValueExternal with 42 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    int dpValue;
    dpGet(_DpExists + ".VExt", dpValue);
    assertEqual(dintServParam.getValueExternal(), 42, "getValueExternal should return 42");
    assertEqual(dpValue, 42, "Data point VExt should be 42");
    assertEqual(_eventValueExternal, 42, "Event value for VExt should be 42");
    return 0;
  }

  public int testSetValueInternal()
  {
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueInternalChangedCB, dintServParam, DIntServParam::valueInternalChanged);

    dintServParam.setValueInternal(50);
    DebugN("Called setValueInternal with 50 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    int dpValue;
    dpGet(_DpExists + ".VInt", dpValue);
    assertEqual(dintServParam.getValueInternal(), 50, "getValueInternal should return 50");
    assertEqual(dpValue, 50, "Data point VInt should be 50");
    assertEqual(_eventValueInternal, 50, "Event value for VInt should be 50");
    return 0;
  }

  public int testSetValueRequested()
  {
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueRequestedChangedCB, dintServParam, DIntServParam::valueRequestedChanged);

    dintServParam.setValueRequested(60);
    DebugN("Called setValueRequested with 60 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    int dpValue;
    dpGet(_DpExists + ".VReq", dpValue);
    assertEqual(dintServParam.getValueRequested(), 60, "getValueRequested should return 60");
    assertEqual(dpValue, 60, "Data point VReq should be 60");
    assertEqual(_eventValueRequested, 60, "Event value for VReq should be 60");
    return 0;
  }

  public int testSetValueFeedback()
  {
    shared_ptr<DIntServParam> dintServParam = new DIntServParam(_DpExists);
    classConnect(this, setValueFeedbackChangedCB, dintServParam, DIntServParam::valueFeedbackChanged);

    dintServParam.setValueFeedback(70);
    DebugN("Called setValueFeedback with 70 for " + _DpExists);

    // Give it time to execute callback
    delay(0, 200);
    int dpValue;
    dpGet(_DpExists + ".VFbk", dpValue);
    assertEqual(dintServParam.getValueFeedback(), 70, "getValueFeedback should return 70");
    assertEqual(dpValue, 70, "Data point VFbk should be 70");
    assertEqual(_eventValueFeedback, 70, "Event value for VFbk should be 70");
    return 0;
  }

  private void setValueScaleMinChangedCB(const int &value)
  {
    _eventValueScaleMin = value;
    DebugN("ValueScaleMinChanged callback triggered with value: " + value);
  }

  private void setValueScaleMaxChangedCB(const int &value)
  {
    _eventValueScaleMax = value;
    DebugN("ValueScaleMaxChanged callback triggered with value: " + value);
  }

  private void setValueMinimumChangedCB(const int &value)
  {
    _eventValueMinimum = value;
    DebugN("ValueMinimumChanged callback triggered with value: " + value);
  }

  private void setValueMaximumChangedCB(const int &value)
  {
    _eventValueMaximum = value;
    DebugN("ValueMaximumChanged callback triggered with value: " + value);
  }

  private void setValueExternalChangedCB(const int &value)
  {
    _eventValueExternal = value;
    DebugN("ValueExternalChanged callback triggered with value: " + value);
  }

  private void setValueInternalChangedCB(const int &value)
  {
    _eventValueInternal = value;
    DebugN("ValueInternalChanged callback triggered with value: " + value);
  }

  private void setValueRequestedChangedCB(const int &value)
  {
    _eventValueRequested = value;
    DebugN("ValueRequestedChanged callback triggered with value: " + value);
  }

  private void setValueFeedbackChangedCB(const int &value)
  {
    _eventValueFeedback = value;
    DebugN("ValueFeedbackChanged callback triggered with value: " + value);
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstDIntServParam test;
  test.startAll();
}
