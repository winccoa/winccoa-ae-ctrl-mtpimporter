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
  private const string _DptInvalidMissingVOp = "AnaServParamInvalid7";
  private const string _DptInvalidMissingVOut = "AnaServParamInvalid8";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingApplyEn = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVExt = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVMin = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingVMax = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingVOp = "ExistingTestDatapointInvalid7";
  private const string _DpExistsInvalidMissingVOut = "ExistingTestDatapointInvalid8";

  private float _eventValueExternal;
  private float _eventValueInternal;
  private float _eventValueRequested;
  private float _eventValueFeedback;
  private float _eventValueScaleMin;
  private float _eventValueScaleMax;
  private float _eventValueMinimum;
  private float _eventValueMaximum;
  private float _eventValueOperator;
  private float _eventValueOutput;

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
                            makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
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

    // Create invalid data point type for missing VExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVExt),
             makeDynString("", "ApplyEn"), makeDynString("", "VInt"), makeDynString("", "VReq"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
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

    // Create invalid data point type for missing VSclMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVSclMin),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
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

    // Create invalid data point type for missing VMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVMin),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
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

    // Create invalid data point type for missing VSclMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVSclMax),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
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

    // Create invalid data point type for missing VMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVMax),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
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

    // Create invalid data point type for missing VOp
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVOp),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VMax"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
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
    dpCreate(_DpExistsInvalidMissingVOp, _DptInvalidMissingVOp);

    // Create invalid data point type for missing VOut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVOut),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOp"), makeDynString("", "VMax"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
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
    dpCreate(_DpExistsInvalidMissingVOut, _DptInvalidMissingVOut);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingApplyEn);
    dpTypeDelete(_DptInvalidMissingApplyEn);

    dpDelete(_DpExistsInvalidMissingVExt);
    dpTypeDelete(_DptInvalidMissingVExt);

    dpDelete(_DpExistsInvalidMissingVSclMin);
    dpTypeDelete(_DptInvalidMissingVSclMin);

    dpDelete(_DpExistsInvalidMissingVMin);
    dpTypeDelete(_DptInvalidMissingVMin);

    dpDelete(_DpExistsInvalidMissingVSclMax);
    dpTypeDelete(_DptInvalidMissingVSclMax);

    dpDelete(_DpExistsInvalidMissingVMax);
    dpTypeDelete(_DptInvalidMissingVMax);

    dpDelete(_DpExistsInvalidMissingVOp);
    dpTypeDelete(_DptInvalidMissingVOp);

    dpDelete(_DpExistsInvalidMissingVOut);
    dpTypeDelete(_DptInvalidMissingVOut);

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
    assertEqual(anaServParam.getValueOutput(), 0.0);
    assertEqual(anaServParam.getValueOperator(), 0.0);
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
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VMax");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVMax + ".VMax"), "Exception should reference VMax");
    }

    // Test missing VOut
    try
    {
      shared_ptr<AnaServParam> servParam = new AnaServParam(_DpExistsInvalidMissingVOut);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VOut");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VOut");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVOut + ".VOut"), "Exception should reference VOut");
    }

    // Test missing VOp
    try
    {
      shared_ptr<AnaServParam> servParam = new AnaServParam(_DpExistsInvalidMissingVOp);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VOp");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VOp");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVOp + ".VOp"), "Exception should reference VOp");
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

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VFbk", dpValue);
    assertEqual(anaServParam.getValueFeedback(), 70.0, "getValueFeedback should return 70.0");
    assertEqual(dpValue, 70.0, "Data point VFbk should be 70.0");
    assertEqual(_eventValueFeedback, 70.0, "Event value for VFbk should be 70.0");
    return 0;
  }

  public int testSetValueOperator()
  {
    shared_ptr<AnaServParam> anaServParam = new AnaServParam(_DpExists);
    classConnect(this, setValueOperatorChangedCB, anaServParam, AnaServParam::valueOperatorChanged);

    anaServParam.setValueOperator(69.0);

    // Give it time to execute callback
    delay(0, 200);
    float dpValue;
    dpGet(_DpExists + ".VOp", dpValue);
    assertEqual(anaServParam.getValueOperator(), 69.0, "getValueOperator should return 69.0");
    assertEqual(dpValue, 69.0, "Data point VOp should be 69.0");
    assertEqual(_eventValueOperator, 69.0, "Event value for VOp should be 69.0");
    return 0;
  }

  private void setValueScaleMinChangedCB(const float &value)
  {
    _eventValueScaleMin = value;
  }

  private void setValueScaleMaxChangedCB(const float &value)
  {
    _eventValueScaleMax = value;
  }

  private void setValueMinimumChangedCB(const float &value)
  {
    _eventValueMinimum = value;
  }

  private void setValueMaximumChangedCB(const float &value)
  {
    _eventValueMaximum = value;
  }

  private void setValueExternalChangedCB(const float &value)
  {
    _eventValueExternal = value;
  }

  private void setValueInternalChangedCB(const float &value)
  {
    _eventValueInternal = value;
  }

  private void setValueRequestedChangedCB(const float &value)
  {
    _eventValueRequested = value;
  }

  private void setValueFeedbackChangedCB(const float &value)
  {
    _eventValueFeedback = value;
  }

  private void setValueOperatorChangedCB(const float &value)
  {
    _eventValueOperator = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstAnaServParam test;
  test.startAll();
}
