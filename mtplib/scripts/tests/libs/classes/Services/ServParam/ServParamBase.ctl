// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/Services/ServParam/ServParamBase.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/Services/ServParam/ServParamBase.ctl
  @copyright $copyright
  @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/Services/ServParam/StringServParam" // used for testing base class
#uses "classes/oaTest/OaTest" // oaTest basic class
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for ServParamBase.ctl
*/
class TstServParamBase : OaTest
{
  private const string _Dpt = "StringServParam"; // Using StringServParam's DPT for testing
  private const string _DptInvalidMissingApplyEn = "ServParamBaseInvalid1";
  private const string _DptInvalidMissingApplyExt = "ServParamBaseInvalid2";
  private const string _DptInvalidMissingApplyInt = "ServParamBaseInvalid3";
  private const string _DptInvalidMissingSrcChannel = "ServParamBaseInvalid4";
  private const string _DptInvalidMissingSrcExtAut = "ServParamBaseInvalid5";
  private const string _DptInvalidMissingSrcIntAut = "ServParamBaseInvalid6";
  private const string _DptInvalidMissingSrcExtAct = "ServParamBaseInvalid7";
  private const string _DptInvalidMissingSrcIntAct = "ServParamBaseInvalid8";
  private const string _DptInvalidMissingVExt = "ServParamBaseInvalid9";
  private const string _DptInvalidMissingVInt = "ServParamBaseInvalid10";
  private const string _DptInvalidMissingVReq = "ServParamBaseInvalid11";
  private const string _DptInvalidMissingVFbk = "ServParamBaseInvalid12";
  private const string _DptInvalidMissingName = "ServParamBaseInvalid13";
  private const string _DptInvalidMissingStateChannel = "ServParamBaseInvalid14";
  private const string _DptInvalidMissingStateOffAut = "ServParamBaseInvalid15";
  private const string _DptInvalidMissingStateOpAut = "ServParamBaseInvalid16";
  private const string _DptInvalidMissingStateAutAut = "ServParamBaseInvalid17";
  private const string _DptInvalidMissingStateOffAct = "ServParamBaseInvalid18";
  private const string _DptInvalidMissingStateOpAct = "ServParamBaseInvalid19";
  private const string _DptInvalidMissingStateAutAct = "ServParamBaseInvalid20";
  private const string _DptInvalidMissingVOp = "ServParamBaseInvalid21";
  private const string _DptInvalidMissingVOut = "ServParamBaseInvalid22";
  private const string _DptInvalidMissingVUnit = "ServParamBaseInvalid23";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingApplyEn = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingApplyExt = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingApplyInt = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingSrcChannel = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingSrcExtAut = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingSrcIntAut = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingSrcExtAct = "ExistingTestDatapointInvalid7";
  private const string _DpExistsInvalidMissingSrcIntAct = "ExistingTestDatapointInvalid8";
  private const string _DpExistsInvalidMissingVExt = "ExistingTestDatapointInvalid9";
  private const string _DpExistsInvalidMissingVInt = "ExistingTestDatapointInvalid10";
  private const string _DpExistsInvalidMissingVReq = "ExistingTestDatapointInvalid11";
  private const string _DpExistsInvalidMissingVFbk = "ExistingTestDatapointInvalid12";
  private const string _DpExistsInvalidMissingName = "ExistingTestDatapointInvalid13";
  private const string _DpExistsInvalidMissingStateChannel = "ExistingTestDatapointInvalid14";
  private const string _DpExistsInvalidMissingStateOffAut = "ExistingTestDatapointInvalid15";
  private const string _DpExistsInvalidMissingStateOpAut = "ExistingTestDatapointInvalid16";
  private const string _DpExistsInvalidMissingStateAutAut = "ExistingTestDatapointInvalid17";
  private const string _DpExistsInvalidMissingStateOffAct = "ExistingTestDatapointInvalid18";
  private const string _DpExistsInvalidMissingStateOpAct = "ExistingTestDatapointInvalid19";
  private const string _DpExistsInvalidMissingStateAutAct = "ExistingTestDatapointInvalid20";
  private const string _DpExistsInvalidMissingVOp = "ExistingTestDatapointInvalid21";
  private const string _DpExistsInvalidMissingVOut = "ExistingTestDatapointInvalid22";
  private const string _DpExistsInvalidMissingVUnit = "ExistingTestDatapointInvalid23";

  private bool _eventApplyEnabled;
  private bool _eventApplyExternal;
  private bool _eventApplyInternal;
  private bool _eventSourceChannel;
  private bool _eventSourceExternalAutomatic;
  private bool _eventSourceInternalAutomatic;
  private bool _eventSourceExternalActive;
  private bool _eventSourceInternalActive;
  private bool _eventStateChannel;
  private bool _eventStateOffAutomatic;
  private bool _eventStateOperatorAutomatic;
  private bool _eventStateAutomaticAutomatic;
  private bool _eventStateOffActive;
  private bool _eventStateOperatorActive;
  private bool _eventStateAutomaticActive;
  private string _eventValueExternal;
  private string _eventValueInternal;
  private string _eventValueRequested;
  private string _eventValueFeedback;
  private string _eventValueOperator;
  private string _eventValueOutput;
  private int _eventValueUnit;
  private langString _eventName;

  public int setUp() override
  {

    if (dpTypes(_Dpt).count() == 0)
    {
      DebugN("Data point type " + _Dpt + " does not exist");
      return -1;
    }

    // Create valid data point
    dpCreate(_DpExists, _Dpt);

    // Create invalid data point types for missing elements
    dyn_dyn_string dpes;
    dyn_dyn_int values;

    // Missing ApplyEn
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingApplyEn),
             makeDynString("", "VExt"), makeDynString("", "VInt"), makeDynString("", "VReq"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VFbk"), makeDynString("", "Name"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingApplyEn, _DptInvalidMissingApplyEn);

    // Missing ApplyExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingApplyExt),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingApplyExt, _DptInvalidMissingApplyExt);

    // Missing ApplyInt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingApplyInt),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingApplyInt, _DptInvalidMissingApplyInt);

    // Missing SrcChannel
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcChannel),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcChannel, _DptInvalidMissingSrcChannel);

    // Missing SrcExtAut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcExtAut),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcExtAut, _DptInvalidMissingSrcExtAut);

    // Missing SrcIntAut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcIntAut),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcIntAut, _DptInvalidMissingSrcIntAut);

    // Missing SrcExtAct
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcExtAct),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcExtAct, _DptInvalidMissingSrcExtAct);

    // Missing SrcIntAct
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcIntAct),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcIntAct, _DptInvalidMissingSrcIntAct);

    // Missing VExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVExt),
             makeDynString("", "ApplyEn"), makeDynString("", "VInt"), makeDynString("", "VReq"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVExt, _DptInvalidMissingVExt);

    // Missing VInt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVInt),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VReq"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVInt, _DptInvalidMissingVInt);

    // Missing VReq
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVReq),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVReq, _DptInvalidMissingVReq);

    // Missing VFbk
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVFbk),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
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
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVFbk, _DptInvalidMissingVFbk);

    // Missing Name
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingName),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"), makeDynString("", "ApplyInt"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingName, _DptInvalidMissingName);

    // Missing StateChannel
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStateChannel),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateChannel, _DptInvalidMissingStateChannel);

    // Missing StateOffAut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStateOffAut),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateOffAut, _DptInvalidMissingStateOffAut);

    // Missing StateOpAut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStateOpAut),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateOpAut, _DptInvalidMissingStateOpAut);

    // Missing StateAutAut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStateAutAut),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateOffAct"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateAutAut, _DptInvalidMissingStateAutAut);

    // Missing StateOffAct
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStateOffAct),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateOffAct, _DptInvalidMissingStateOffAct);

    // Missing StateOpAct
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStateOpAct),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateOpAct, _DptInvalidMissingStateOpAct);

    // Missing StateAutAct
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStateAutAct),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VOp"), makeDynString("", "VUnit"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateAutAct, _DptInvalidMissingStateAutAct);

    // Missing VOp
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVOp),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOut"), makeDynString("", "VUnit"),  makeDynString("", "StateAutAct"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),  makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVOp, _DptInvalidMissingVOp);

    // Missing VOut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVOut),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOp"), makeDynString("", "VUnit"),  makeDynString("", "StateAutAct"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_INT),  makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVOut, _DptInvalidMissingVOut);

    // Missing VUnit
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVUnit),
             makeDynString("", "ApplyEn"), makeDynString("", "VExt"), makeDynString("", "VInt"),
             makeDynString("", "VOp"), makeDynString("", "VOut"),  makeDynString("", "StateAutAct"),
             makeDynString("", "VReq"), makeDynString("", "VFbk"), makeDynString("", "Name"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcExtAct"), makeDynString("", "SrcIntAct"), makeDynString("", "ApplyExt"),
             makeDynString("", "ApplyInt"), makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"), makeDynString("", "StateOffAct"),
             makeDynString("", "StateOpAct"), makeDynString("", "WQC"), makeDynString("", "OSLevel")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),  makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVUnit, _DptInvalidMissingVUnit);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingApplyEn);
    dpTypeDelete(_DptInvalidMissingApplyEn);

    dpDelete(_DpExistsInvalidMissingApplyExt);
    dpTypeDelete(_DptInvalidMissingApplyExt);

    dpDelete(_DpExistsInvalidMissingApplyInt);
    dpTypeDelete(_DptInvalidMissingApplyInt);

    dpDelete(_DpExistsInvalidMissingSrcChannel);
    dpTypeDelete(_DptInvalidMissingSrcChannel);

    dpDelete(_DpExistsInvalidMissingSrcExtAut);
    dpTypeDelete(_DptInvalidMissingSrcExtAut);

    dpDelete(_DpExistsInvalidMissingSrcIntAut);
    dpTypeDelete(_DptInvalidMissingSrcIntAut);

    dpDelete(_DpExistsInvalidMissingSrcExtAct);
    dpTypeDelete(_DptInvalidMissingSrcExtAct);

    dpDelete(_DpExistsInvalidMissingSrcIntAct);
    dpTypeDelete(_DptInvalidMissingSrcIntAct);

    dpDelete(_DpExistsInvalidMissingVExt);
    dpTypeDelete(_DptInvalidMissingVExt);

    dpDelete(_DpExistsInvalidMissingVInt);
    dpTypeDelete(_DptInvalidMissingVInt);

    dpDelete(_DpExistsInvalidMissingVReq);
    dpTypeDelete(_DptInvalidMissingVReq);

    dpDelete(_DpExistsInvalidMissingVFbk);
    dpTypeDelete(_DptInvalidMissingVFbk);

    dpDelete(_DpExistsInvalidMissingName);
    dpTypeDelete(_DptInvalidMissingName);

    dpDelete(_DpExistsInvalidMissingStateChannel);
    dpTypeDelete(_DptInvalidMissingStateChannel);

    dpDelete(_DpExistsInvalidMissingStateOffAut);
    dpTypeDelete(_DptInvalidMissingStateOffAut);

    dpDelete(_DpExistsInvalidMissingStateOpAut);
    dpTypeDelete(_DptInvalidMissingStateOpAut);

    dpDelete(_DpExistsInvalidMissingStateAutAut);
    dpTypeDelete(_DptInvalidMissingStateAutAut);

    dpDelete(_DpExistsInvalidMissingStateOffAct);
    dpTypeDelete(_DptInvalidMissingStateOffAct);

    dpDelete(_DpExistsInvalidMissingStateOpAct);
    dpTypeDelete(_DptInvalidMissingStateOpAct);

    dpDelete(_DpExistsInvalidMissingStateAutAct);
    dpTypeDelete(_DptInvalidMissingStateAutAct);

    dpDelete(_DpExistsInvalidMissingVOp);
    dpTypeDelete(_DptInvalidMissingVOp);

    dpDelete(_DpExistsInvalidMissingVOut);
    dpTypeDelete(_DptInvalidMissingVOut);

    dpDelete(_DpExistsInvalidMissingVUnit);
    dpTypeDelete(_DptInvalidMissingVUnit);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<StringServParam> servParam = new StringServParam(_DpExists);
    assertEqual(servParam.getDp(), _DpExists);
    assertEqual(servParam.getApplyEnabled(), false);
    assertEqual(servParam.getApplyExternal(), false);
    assertEqual(servParam.getApplyInternal(), false);
    assertEqual(servParam.getSourceChannel(), false);
    assertEqual(servParam.getSourceExternalAutomatic(), false);
    assertEqual(servParam.getSourceInternalAutomatic(), false);
    assertEqual(servParam.getSourceExternalActive(), false);
    assertEqual(servParam.getSourceInternalActive(), false);
    assertTrue(servParam.getWqc() != nullptr);
    assertTrue(servParam.getOsLevel() != nullptr);
    langString name = servParam.getName();
    assertTrue(name.text() == "", "Name should not be empty");
    assertEqual(servParam.getStateChannel(), false);
    assertEqual(servParam.getStateOffAutomatic(), false);
    assertEqual(servParam.getStateOperatorAutomatic(), false);
    assertEqual(servParam.getStateAutomaticAutomatic(), false);
    assertEqual(servParam.getStateOffActive(), false);
    assertEqual(servParam.getStateOperatorActive(), false);
    assertEqual(servParam.getStateAutomaticActive(), false);
    assertEqual(servParam.getValueExternal(), "");
    assertEqual(servParam.getValueInternal(), "");
    assertEqual(servParam.getValueRequested(), "");
    assertEqual(servParam.getValueFeedback(), "");
    assertEqual(servParam.getValueOutput(), "");
    assertEqual(servParam.getValueOperator(), "");
    assertTrue(servParam.getValueUnit() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    // Test missing ApplyEn
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingApplyEn);
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

    // Test missing ApplyExt
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingApplyExt);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing ApplyExt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing ApplyExt");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingApplyExt + ".ApplyExt"), "Exception should reference ApplyExt");
    }

    // Test missing ApplyInt
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingApplyInt);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing ApplyInt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing ApplyInt");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingApplyInt + ".ApplyInt"), "Exception should reference ApplyInt");
    }

    // Test missing SrcChannel
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingSrcChannel);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing SrcChannel");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing SrcChannel");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingSrcChannel + ".SrcChannel"), "Exception should reference SrcChannel");
    }

    // Test missing SrcExtAut
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingSrcExtAut);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing SrcExtAut");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing SrcExtAut");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingSrcExtAut + ".SrcExtAut"), "Exception should reference SrcExtAut");
    }

    // Test missing SrcIntAut
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingSrcIntAut);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing SrcIntAut");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing SrcIntAut");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingSrcIntAut + ".SrcIntAut"), "Exception should reference SrcIntAut");
    }

    // Test missing SrcExtAct
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingSrcExtAct);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing SrcExtAct");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing SrcExtAct");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingSrcExtAct + ".SrcExtAct"), "Exception should reference SrcExtAct");
    }

    // Test missing SrcIntAct
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingSrcIntAct);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing SrcIntAct");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing SrcIntAct");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingSrcIntAct + ".SrcIntAct"), "Exception should reference SrcIntAct");
    }

    // Test missing VExt
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingVExt);
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

    // Test missing VInt
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingVInt);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VInt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VInt");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVInt + ".VInt"), "Exception should reference VInt");
    }

    // Test missing VReq
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingVReq);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VReq");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VReq");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVReq + ".VReq"), "Exception should reference VReq");
    }

    // Test missing VFbk
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingVFbk);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VFbk");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VFbk");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVFbk + ".VFbk"), "Exception should reference VFbk");
    }

    // Test missing VOut
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingVOut);
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
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingVOp);
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

    // Test missing VUnit
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingVUnit);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing VUnit");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing VUnit");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingVUnit + ".VUnit"), "Exception should reference VUnit");
    }

    // Test missing Name
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingName);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing Name");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing Name");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingName + ".Name"), "Exception should reference Name");
    }

    // Test missing StateChannel
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingStateChannel);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing StateChannel");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing StateChannel");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingStateChannel + ".StateChannel"), "Exception should reference StateChannel");
    }

    // Test missing StateOffAut
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingStateOffAut);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing StateOffAut");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing StateOffAut");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingStateOffAut + ".StateOffAut"), "Exception should reference StateOffAut");
    }

// Test missing StateOpAut
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingStateOpAut);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing StateOpAut");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing StateOpAut");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingStateOpAut + ".StateOpAut"), "Exception should reference StateOpAut");
    }

    // Test missing StateAutAut
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingStateAutAut);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing StateAutAut");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing StateAutAut");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingStateAutAut + ".StateAutAut"), "Exception should reference StateAutAut");
    }

    // Test missing StateOffAct
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingStateOffAct);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing StateOffAct");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing StateOffAct");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingStateOffAct + ".StateOffAct"), "Exception should reference StateOffAct");
    }

    // Test missing StateOpAct
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingStateOpAct);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing StateOpAct");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing StateOpAct");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingStateOpAct + ".StateOpAct"), "Exception should reference StateOpAct");
    }

    // Test missing StateAutAct
    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(_DpExistsInvalidMissingStateAutAct);
      assertTrue(false, "Expected DPNOTEXISTENT exception for missing StateAutAct");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for missing StateAutAct");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(_DpExistsInvalidMissingStateAutAct + ".StateAutAct"), "Exception should reference StateAutAct");
    }

    return 0;
  }

  public int testConstructor_NonExistentDp()
  {
    string nonExistentDp = "NonExistentTestDatapoint";

    try
    {
      shared_ptr<StringServParam> servParam = new StringServParam(nonExistentDp);
      assertTrue(false, "Expected DPNOTEXISTENT exception for non-existent datapoint");
    }
    catch
    {
      dyn_errClass err = getLastException();
      string errText = getErrorText(err);
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Expected DPNOTEXISTENT for non-existent datapoint");
      assertTrue(errText.contains("Datapoint does not exist"), "Exception should indicate datapoint does not exist");
      assertTrue(errText.contains(nonExistentDp), "Exception should reference the non-existent datapoint");
    }

    return 0;
  }

  public int testValueGettersAndSetters()
  {
    shared_ptr<StringServParam> servParam = new StringServParam(_DpExists);

    // Test ValueExternal
    assertEqual(servParam.getValueExternal(), "");
    servParam.setValueExternal("ExternalValue");
    assertEqual(servParam.getValueExternal(), "ExternalValue");
    string valueExternal;
    dpGet(_DpExists + ".VExt", valueExternal);
    assertEqual(valueExternal, "ExternalValue");

    // Test ValueInternal
    assertEqual(servParam.getValueInternal(), "");
    servParam.setValueInternal("InternalValue");
    assertEqual(servParam.getValueInternal(), "InternalValue");
    string valueInternal;
    dpGet(_DpExists + ".VInt", valueInternal);
    assertEqual(valueInternal, "InternalValue");

    // Test ValueRequested
    assertEqual(servParam.getValueRequested(), "");
    servParam.setValueRequested("RequestedValue");
    assertEqual(servParam.getValueRequested(), "RequestedValue");
    string valueRequested;
    dpGet(_DpExists + ".VReq", valueRequested);
    assertEqual(valueRequested, "RequestedValue");

    // Test ValueFeedback
    assertEqual(servParam.getValueFeedback(), "");
    servParam.setValueFeedback("FeedbackValue");
    assertEqual(servParam.getValueFeedback(), "FeedbackValue");
    string valueFeedback;
    dpGet(_DpExists + ".VFbk", valueFeedback);
    assertEqual(valueFeedback, "FeedbackValue");

        // Test ValueOperator
    assertEqual(servParam.getValueOperator(), "");
    servParam.setValueOperator("Value");
    assertEqual(servParam.getValueOperator(), "Value");
    string valueOperator;
    dpGet(_DpExists + ".VOp", valueOperator);
    assertEqual(valueOperator, "Value");

    // Test ValueOutput
    assertEqual(servParam.getValueOutput(), "");
    string valueOutput;
    dpGet(_DpExists + ".VOut", valueOutput);
    assertEqual(valueOutput, "");

    return 0;
  }

  public void onApplyEnabled(shared_ptr<StringServParam> sender, bool value)
  {
    _eventApplyEnabled = value;
  }

  public void onApplyExternal(shared_ptr<StringServParam> sender, bool value)
  {
    _eventApplyExternal = value;
  }

  public void onApplyInternal(shared_ptr<StringServParam> sender, bool value)
  {
    _eventApplyInternal = value;
  }

  public void onSourceChannel(shared_ptr<StringServParam> sender, bool value)
  {
    _eventSourceChannel = value;
  }

  public void onSourceExternalAutomatic(shared_ptr<StringServParam> sender, bool value)
  {
    _eventSourceExternalAutomatic = value;
  }

  public void onSourceInternalAutomatic(shared_ptr<StringServParam> sender, bool value)
  {
    _eventSourceInternalAutomatic = value;
  }

  public void onSourceExternalActive(shared_ptr<StringServParam> sender, bool value)
  {
    _eventSourceExternalActive = value;
  }

  public void onSourceInternalActive(shared_ptr<StringServParam> sender, bool value)
  {
    _eventSourceInternalActive = value;
  }

  public void onStateChannel(shared_ptr<StringServParam> sender, bool value)
  {
    _eventStateChannel = value;
  }

  public void onStateOffAutomatic(shared_ptr<StringServParam> sender, bool value)
  {
    _eventStateOffAutomatic = value;
  }

  public void onStateOperatorAutomatic(shared_ptr<StringServParam> sender, bool value)
  {
    _eventStateOperatorAutomatic = value;
  }

  public void onStateAutomaticAutomatic(shared_ptr<StringServParam> sender, bool value)
  {
    _eventStateAutomaticAutomatic = value;
  }

  public void onStateOffActive(shared_ptr<StringServParam> sender, bool value)
  {
    _eventStateOffActive = value;
  }

  public void onStateOperatorActive(shared_ptr<StringServParam> sender, bool value)
  {
    _eventStateOperatorActive = value;
  }

  public void onStateAutomaticActive(shared_ptr<StringServParam> sender, bool value)
  {
    _eventStateAutomaticActive = value;
  }

  public void onValueExternal(shared_ptr<StringServParam> sender, string value)
  {
    _eventValueExternal = value;
  }

  public void onValueInternal(shared_ptr<StringServParam> sender, string value)
  {
    _eventValueInternal = value;
  }

  public void onValueRequested(shared_ptr<StringServParam> sender, string value)
  {
    _eventValueRequested = value;
  }

  public void onValueFeedback(shared_ptr<StringServParam> sender, string value)
  {
    _eventValueFeedback = value;
  }

  public void onValueOperator(shared_ptr<StringServParam> sender, string value)
  {
    _eventValueOperator = value;
  }

  public void onValueOutput(shared_ptr<StringServParam> sender, string value)
  {
    _eventValueOutput = value;
  }

  public void onName(shared_ptr<StringServParam> sender, langString value)
  {
    _eventName = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstServParamBase test;
  test.startAll();
}
