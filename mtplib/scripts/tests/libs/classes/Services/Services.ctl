// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/Services/Services.ctl.

   @file $relPath
   @test Unit tests for the library: scripts/libs/classes/Services/Services.ctl
   @copyright $copyright
   @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/Services/Services" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpProcedure/MtpProcedure"

//-----------------------------------------------------------------------------
// Variables and Constants

/** Tests for Services.ctl
*/
class TstServices : OaTest
{
  private const string _Dpt = "ServiceControl";
  private const string _DptInvalidMissingCommandOp = "ServicesInvalid1";
  private const string _DptInvalidMissingStateCur = "ServicesInvalid2";
  private const string _DptInvalidMissingCommandInt = "ServicesInvalid3";
  private const string _DptInvalidMissingCommandExt = "ServicesInvalid4";
  private const string _DptInvalidMissingProcedureOp = "ServicesInvalid5";
  private const string _DptInvalidMissingProcedureInt = "ServicesInvalid6";
  private const string _DptInvalidMissingProcedureExt = "ServicesInvalid7";
  private const string _DptInvalidMissingCommandEn = "ServicesInvalid_CommandEn";
  private const string _DptInvalidMissingProcedureCur = "ServicesInvalid_ProcedureCur";
  private const string _DptInvalidMissingProcedureReq = "ServicesInvalid_ProcedureReq";
  private const string _DptInvalidMissingPosTextID = "ServicesInvalid_PosTextID";
  private const string _DptInvalidMissingInteractQuestionID = "ServicesInvalid_InteractQuestionID";
  private const string _DptInvalidMissingInteractAddInfo = "ServicesInvalid_InteractAddInfo";
  private const string _DptInvalidMissingInteractAnswerID = "ServicesInvalid_InteractAnswerID";
  private const string _DptInvalidMissingSrcChannel = "ServicesInvalid_SrcChannel";
  private const string _DptInvalidMissingSrcExtAut = "ServicesInvalid_SrcExtAut";
  private const string _DptInvalidMissingSrcIntAut = "ServicesInvalid_SrcIntAut";
  private const string _DptInvalidMissingSrcIntOp = "ServicesInvalid_SrcIntOp";
  private const string _DptInvalidMissingSrcExtOp = "ServicesInvalid_SrcExtOp";
  private const string _DptInvalidMissingSrcIntAct = "ServicesInvalid_SrcIntAct";
  private const string _DptInvalidMissingSrcExtAct = "ServicesInvalid_SrcExtAct";
  private const string _DptInvalidMissingProcParamApplyEn = "ServicesInvalid_ProcParamApplyEn";
  private const string _DptInvalidMissingProcParamApplyExt = "ServicesInvalid_ProcParamApplyExt";
  private const string _DptInvalidMissingProcParamApplyOp = "ServicesInvalid_ProcParamApplyOp";
  private const string _DptInvalidMissingProcParamApplyInt = "ServicesInvalid_ProcParamApplyInt";
  private const string _DptInvalidMissingConfigParamApplyEn = "ServicesInvalid_ConfigParamApplyEn";
  private const string _DptInvalidMissingConfigParamApplyExt = "ServicesInvalid_ConfigParamApplyExt";
  private const string _DptInvalidMissingConfigParamApplyOp = "ServicesInvalid_ConfigParamApplyOp";
  private const string _DptInvalidMissingConfigParamApplyInt = "ServicesInvalid_ConfigParamApplyInt";
  private const string _DptInvalidMissingReportValueFreeze = "ServicesInvalid_ReportValueFreeze";
  private const string _DptInvalidMissingNumberOfProcedure = "ServicesInvalid_NumberOfProcedure";
  private const string _DptInvalidMissingEnabled = "ServicesInvalid_Enabled";
  private const string _DptInvalidMissingTagName = "ServicesInvalid_TagName";
  private const string _DptInvalidMissingProcedures = "ServicesInvalid_Procedures";
  private const string _DptInvalidMissingConfigParameters = "ServicesInvalid_ConfigParameters";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingCommandOp = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingStateCur = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingCommandInt = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingCommandExt = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingProcedureOp = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingProcedureInt = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingProcedureExt = "ExistingTestDatapointInvalid7";
  private const string _DpExistsInvalidMissingCommandEn = "ExistingTestDatapointInvalid_CommandEn";
  private const string _DpExistsInvalidMissingProcedureCur = "ExistingTestDatapointInvalid_ProcedureCur";
  private const string _DpExistsInvalidMissingProcedureReq = "ExistingTestDatapointInvalid_ProcedureReq";
  private const string _DpExistsInvalidMissingPosTextID = "ExistingTestDatapointInvalid_PosTextID";
  private const string _DpExistsInvalidMissingInteractQuestionID = "ExistingTestDatapointInvalid_InteractQuestionID";
  private const string _DpExistsInvalidMissingInteractAddInfo = "ExistingTestDatapointInvalid_InteractAddInfo";
  private const string _DpExistsInvalidMissingInteractAnswerID = "ExistingTestDatapointInvalid_InteractAnswerID";
  private const string _DpExistsInvalidMissingSrcChannel = "ExistingTestDatapointInvalid_SrcChannel";
  private const string _DpExistsInvalidMissingSrcExtAut = "ExistingTestDatapointInvalid_SrcExtAut";
  private const string _DpExistsInvalidMissingSrcIntAut = "ExistingTestDatapointInvalid_SrcIntAut";
  private const string _DpExistsInvalidMissingSrcIntOp = "ExistingTestDatapointInvalid_SrcIntOp";
  private const string _DpExistsInvalidMissingSrcExtOp = "ExistingTestDatapointInvalid_SrcExtOp";
  private const string _DpExistsInvalidMissingSrcIntAct = "ExistingTestDatapointInvalid_SrcIntAct";
  private const string _DpExistsInvalidMissingSrcExtAct = "ExistingTestDatapointInvalid_SrcExtAct";
  private const string _DpExistsInvalidMissingProcParamApplyEn = "ExistingTestDatapointInvalid_ProcParamApplyEn";
  private const string _DpExistsInvalidMissingProcParamApplyExt = "ExistingTestDatapointInvalid_ProcParamApplyExt";
  private const string _DpExistsInvalidMissingProcParamApplyOp = "ExistingTestDatapointInvalid_ProcParamApplyOp";
  private const string _DpExistsInvalidMissingProcParamApplyInt = "ExistingTestDatapointInvalid_ProcParamApplyInt";
  private const string _DpExistsInvalidMissingConfigParamApplyEn = "ExistingTestDatapointInvalid_ConfigParamApplyEn";
  private const string _DpExistsInvalidMissingConfigParamApplyExt = "ExistingTestDatapointInvalid_ConfigParamApplyExt";
  private const string _DpExistsInvalidMissingConfigParamApplyOp = "ExistingTestDatapointInvalid_ConfigParamApplyOp";
  private const string _DpExistsInvalidMissingConfigParamApplyInt = "ExistingTestDatapointInvalid_ConfigParamApplyInt";
  private const string _DpExistsInvalidMissingReportValueFreeze = "ExistingTestDatapointInvalid_ReportValueFreeze";
  private const string _DpExistsInvalidMissingNumberOfProcedure = "ExistingTestDatapointInvalid_NumberOfProcedure";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid_Enabled";
  private const string _DpExistsInvalidMissingTagName = "ExistingTestDatapointInvalid_TagName";
  private const string _DpExistsInvalidMissingProcedures = "ExistingTestDatapointInvalid_Procedures";
  private const string _DpExistsInvalidMissingConfigParameters = "ExistingTestDatapointInvalid_ConfigParameters";

  private const string _DptProcedure = "ProcedureHealthView";
  private const string _DptServParam = "StringServParam";
  private const string _DpProcedure1 = "Procedure_1";
  private const string _DpProcedure2 = "Procedure_1";
  private const string _DpConfigParam1 = "ConfigParam_1";
  private const string _DpConfigParam2 = "ConfigParam_1";

  private long _eventCommandInternal;
  private long _eventCommandExternal;
  private long _eventStateCurrent;
  private bool _eventSrcChannel;
  private bool _eventSrcExternalAutomatic;
  private bool _eventSrcInternalAutomatic;
  private bool _eventSrcInternalActive;
  private bool _eventSrcExternalActive;
  private bool _eventProcParamApplyEnabled;
  private bool _eventProcParamApplyExternal;
  private bool _eventProcParamApplyInternal;
  private bool _eventConfigParamApplyEnabled;
  private bool _eventConfigParamApplyExternal;
  private bool _eventConfigParamApplyInternal;
  private bool _eventReportValueFreeze;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      DebugN("Data point type", _Dpt, "does not exist");
      return -1;
    }

    if (dpTypes(_DptProcedure).count() == 0)
    {
      DebugN("Data point type", _DptProcedure, "does not exist");
      return -1;
    }

    if (dpTypes(_DptServParam).count() == 0)
    {
      DebugN("Data point type", _DptServParam, "does not exist");
      return -1;
    }

    dpCreate(_DpExists, _Dpt);
    dpCreate(_DpProcedure1, _DptProcedure);
    dpCreate(_DpProcedure2, _DptProcedure);
    dpCreate(_DpConfigParam1, _DptServParam);
    dpCreate(_DpConfigParam2, _DptServParam);
    dpSet(_DpExists + ".procedures", makeDynString(_DpProcedure1, _DpProcedure2));
    dpSet(_DpExists + ".configParameters", makeDynString(_DpConfigParam1, _DpConfigParam2));

    // Create data point types for invalid cases
    dyn_dyn_string dpes;
    dyn_dyn_int values;

    // Create invalid data point type missing CommandOp
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCommandOp),
             makeDynString("", "CommandInt"), makeDynString("", "CommandExt"),
             makeDynString("", "ProcedureOp"), makeDynString("", "ProcedureInt"),
             makeDynString("", "ProcedureExt"), makeDynString("", "StateCur"),
             makeDynString("", "CommandEn"), makeDynString("", "ProcedureCur"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCommandOp, _DptInvalidMissingCommandOp);

    // Create invalid data point type missing StateCur
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStateCur),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "CommandEn"), makeDynString("", "ProcedureCur"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );

    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateCur, _DptInvalidMissingStateCur);

    // Test missing CommandInt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCommandInt),
             makeDynString("", "CommandOp"), makeDynString("", "CommandExt"),
             makeDynString("", "ProcedureOp"), makeDynString("", "ProcedureInt"),
             makeDynString("", "ProcedureExt"), makeDynString("", "StateCur"),
             makeDynString("", "CommandEn"), makeDynString("", "ProcedureCur"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCommandInt, _DptInvalidMissingCommandInt);

    // Test missing CommandExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCommandExt),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "ProcedureOp"), makeDynString("", "ProcedureInt"),
             makeDynString("", "ProcedureExt"), makeDynString("", "StateCur"),
             makeDynString("", "CommandEn"), makeDynString("", "ProcedureCur"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCommandExt, _DptInvalidMissingCommandExt);

    // Test missing ProcedureOp
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcedureOp),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureInt"),
             makeDynString("", "ProcedureExt"), makeDynString("", "StateCur"),
             makeDynString("", "CommandEn"), makeDynString("", "ProcedureCur"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcedureOp, _DptInvalidMissingProcedureOp);

    // Test missing ProcedureInt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcedureInt),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureExt"), makeDynString("", "StateCur"),
             makeDynString("", "CommandEn"), makeDynString("", "ProcedureCur"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcedureInt, _DptInvalidMissingProcedureInt);

// Test missing ProcedureExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcedureExt),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "StateCur"),
             makeDynString("", "CommandEn"), makeDynString("", "ProcedureCur"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcedureExt, _DptInvalidMissingProcedureExt);

// Test missing CommandEn
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCommandEn),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "ProcedureCur"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCommandEn, _DptInvalidMissingCommandEn);

// Test missing ProcedureCur
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcedureCur),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureReq"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcedureCur, _DptInvalidMissingProcedureCur);

// Test missing ProcedureReq
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcedureReq),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "PosTextID"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcedureReq, _DptInvalidMissingProcedureReq);

// Test missing PosTextID
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingPosTextID),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "InteractQuestionID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingPosTextID, _DptInvalidMissingPosTextID);

// Test missing InteractQuestionID
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingInteractQuestionID),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractAddInfo"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingInteractQuestionID, _DptInvalidMissingInteractQuestionID);

// Test missing InteractAddInfo
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingInteractAddInfo),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAnswerID"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingInteractAddInfo, _DptInvalidMissingInteractAddInfo);

// Test missing InteractAnswerID
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingInteractAnswerID),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "SrcChannel"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingInteractAnswerID, _DptInvalidMissingInteractAnswerID);

    // Test missing SrcChannel
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcChannel),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcExtAut"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcChannel, _DptInvalidMissingSrcChannel);

    // Test missing SrcExtAut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcExtAut),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcIntAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcExtAut, _DptInvalidMissingSrcExtAut);

    // Test missing SrcIntAut
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcIntAut),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcIntAut, _DptInvalidMissingSrcIntAut);

    // Test missing SrcIntOp
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcIntOp),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcExtOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcIntOp, _DptInvalidMissingSrcIntOp);

    // Test missing SrcExtOp
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcExtOp),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcIntAct"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcExtOp, _DptInvalidMissingSrcExtOp);

    // Test missing SrcIntAct
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcIntAct),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcExtAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcIntAct, _DptInvalidMissingSrcIntAct);

    // Test missing SrcExtAct
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSrcExtAct),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "ProcParamApplyEn"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSrcExtAct, _DptInvalidMissingSrcExtAct);

    // Test missing ProcParamApplyEn
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcParamApplyEn),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyExt"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcParamApplyEn, _DptInvalidMissingProcParamApplyEn);

    // Test missing ProcParamApplyExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcParamApplyExt),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyOp"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcParamApplyExt, _DptInvalidMissingProcParamApplyExt);

    // Test missing ProcParamApplyOp
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcParamApplyOp),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyInt"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcParamApplyOp, _DptInvalidMissingProcParamApplyOp);

    // Test missing ProcParamApplyInt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcParamApplyInt),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ConfigParamApplyEn"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcParamApplyInt, _DptInvalidMissingProcParamApplyInt);

    // Test missing ConfigParamApplyEn
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingConfigParamApplyEn),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyExt"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingConfigParamApplyEn, _DptInvalidMissingConfigParamApplyEn);

    // Test missing ConfigParamApplyExt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingConfigParamApplyExt),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyOp"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingConfigParamApplyExt, _DptInvalidMissingConfigParamApplyExt);

    // Test missing ConfigParamApplyOp
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingConfigParamApplyOp),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyExt"), makeDynString("", "ConfigParamApplyInt"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingConfigParamApplyOp, _DptInvalidMissingConfigParamApplyOp);

    // Test missing ConfigParamApplyInt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingConfigParamApplyInt),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyExt"), makeDynString("", "ConfigParamApplyOp"),
             makeDynString("", "ReportValueFreeze"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingConfigParamApplyInt, _DptInvalidMissingConfigParamApplyInt);

    // Test missing ReportValueFreeze
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingReportValueFreeze),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyExt"), makeDynString("", "ConfigParamApplyOp"),
             makeDynString("", "ConfigParamApplyInt"), makeDynString("", "numberOfProcedure"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingReportValueFreeze, _DptInvalidMissingReportValueFreeze);

    // Test missing numberOfProcedure
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingNumberOfProcedure),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyExt"), makeDynString("", "ConfigParamApplyOp"),
             makeDynString("", "ConfigParamApplyInt"), makeDynString("", "ReportValueFreeze"),
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "enabled"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingNumberOfProcedure, _DptInvalidMissingNumberOfProcedure);

// Test missing enabled
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingEnabled),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyExt"), makeDynString("", "ConfigParamApplyOp"),
             makeDynString("", "ConfigParamApplyInt"), makeDynString("", "ReportValueFreeze"),
             makeDynString("", "numberOfProcedure"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "tagName"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_LANGSTRING),  makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_DPID), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingEnabled, _DptInvalidMissingEnabled);

// Test missing tagName
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingTagName),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyExt"), makeDynString("", "ConfigParamApplyOp"),
             makeDynString("", "ConfigParamApplyInt"), makeDynString("", "ReportValueFreeze"),
             makeDynString("", "numberOfProcedure"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "enabled"),
             makeDynString("", "procedures"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_DPID),  makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingTagName, _DptInvalidMissingTagName);

// Test missing procedures
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingProcedures),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyExt"), makeDynString("", "ConfigParamApplyOp"),
             makeDynString("", "ConfigParamApplyInt"), makeDynString("", "ReportValueFreeze"),
             makeDynString("", "numberOfProcedure"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "enabled"),
             makeDynString("", "tagName"), makeDynString("", "configParameters")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL),  makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingProcedures, _DptInvalidMissingProcedures);

// Test missing configParameters
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingConfigParameters),
             makeDynString("", "CommandOp"), makeDynString("", "CommandInt"),
             makeDynString("", "CommandExt"), makeDynString("", "ProcedureOp"),
             makeDynString("", "ProcedureInt"), makeDynString("", "ProcedureExt"),
             makeDynString("", "StateCur"), makeDynString("", "CommandEn"),
             makeDynString("", "ProcedureCur"), makeDynString("", "ProcedureReq"),
             makeDynString("", "PosTextID"), makeDynString("", "InteractQuestionID"),
             makeDynString("", "InteractAddInfo"), makeDynString("", "InteractAnswerID"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcExtAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcIntOp"),
             makeDynString("", "SrcExtOp"), makeDynString("", "SrcIntAct"),
             makeDynString("", "SrcExtAct"), makeDynString("", "ProcParamApplyEn"),
             makeDynString("", "ProcParamApplyExt"), makeDynString("", "ProcParamApplyOp"),
             makeDynString("", "ProcParamApplyInt"), makeDynString("", "ConfigParamApplyEn"),
             makeDynString("", "ConfigParamApplyExt"), makeDynString("", "ConfigParamApplyOp"),
             makeDynString("", "ConfigParamApplyInt"), makeDynString("", "ReportValueFreeze"),
             makeDynString("", "numberOfProcedure"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "enabled"),
             makeDynString("", "tagName"), makeDynString("", "procedures")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_LONG), makeDynString(0, DPEL_LONG),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_LONG),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_DPID)
             );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingConfigParameters, _DptInvalidMissingConfigParameters);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingCommandOp);
    dpTypeDelete(_DptInvalidMissingCommandOp);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingStateCur);
    dpTypeDelete(_DptInvalidMissingStateCur);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingCommandInt);
    dpTypeDelete(_DptInvalidMissingCommandInt);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingCommandExt);
    dpTypeDelete(_DptInvalidMissingCommandExt);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcedureOp);
    dpTypeDelete(_DptInvalidMissingProcedureOp);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcedureInt);
    dpTypeDelete(_DptInvalidMissingProcedureInt);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcedureExt);
    dpTypeDelete(_DptInvalidMissingProcedureExt);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingCommandEn);
    dpTypeDelete(_DptInvalidMissingCommandEn);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcedureCur);
    dpTypeDelete(_DptInvalidMissingProcedureCur);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcedureReq);
    dpTypeDelete(_DptInvalidMissingProcedureReq);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingPosTextID);
    dpTypeDelete(_DptInvalidMissingPosTextID);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingInteractQuestionID);
    dpTypeDelete(_DptInvalidMissingInteractQuestionID);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingInteractAddInfo);
    dpTypeDelete(_DptInvalidMissingInteractAddInfo);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingInteractAnswerID);
    dpTypeDelete(_DptInvalidMissingInteractAnswerID);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingSrcChannel);
    dpTypeDelete(_DptInvalidMissingSrcChannel);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingSrcExtAut);
    dpTypeDelete(_DptInvalidMissingSrcExtAut);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingSrcIntAut);
    dpTypeDelete(_DptInvalidMissingSrcIntAut);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingSrcIntOp);
    dpTypeDelete(_DptInvalidMissingSrcIntOp);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingSrcExtOp);
    dpTypeDelete(_DptInvalidMissingSrcExtOp);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingSrcIntAct);
    dpTypeDelete(_DptInvalidMissingSrcIntAct);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingSrcExtAct);
    dpTypeDelete(_DptInvalidMissingSrcExtAct);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcParamApplyEn);
    dpTypeDelete(_DptInvalidMissingProcParamApplyEn);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcParamApplyExt);
    dpTypeDelete(_DptInvalidMissingProcParamApplyExt);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcParamApplyOp);
    dpTypeDelete(_DptInvalidMissingProcParamApplyOp);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcParamApplyInt);
    dpTypeDelete(_DptInvalidMissingProcParamApplyInt);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingConfigParamApplyEn);
    dpTypeDelete(_DptInvalidMissingConfigParamApplyEn);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingConfigParamApplyExt);
    dpTypeDelete(_DptInvalidMissingConfigParamApplyExt);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingConfigParamApplyOp);
    dpTypeDelete(_DptInvalidMissingConfigParamApplyOp);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingConfigParamApplyInt);
    dpTypeDelete(_DptInvalidMissingConfigParamApplyInt);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingReportValueFreeze);
    dpTypeDelete(_DptInvalidMissingReportValueFreeze);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingNumberOfProcedure);
    dpTypeDelete(_DptInvalidMissingNumberOfProcedure);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingEnabled);
    dpTypeDelete(_DptInvalidMissingEnabled);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingTagName);
    dpTypeDelete(_DptInvalidMissingTagName);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingProcedures);
    dpTypeDelete(_DptInvalidMissingProcedures);
    delay(0, 200);
    dpDelete(_DpExistsInvalidMissingConfigParameters);
    dpTypeDelete(_DptInvalidMissingConfigParameters);
    delay(0, 200);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    assertEqual(services.getDp(), _DpExists);
    assertEqual(services.getCommandOperator(), 0L);
    assertEqual(services.getCommandInternal(), 0L);
    assertEqual(services.getCommandExternal(), 0L);
    assertEqual(services.getCurrentState(), 0L);
    assertEqual(services.getCommandEnabled(), 0L);
    assertEqual(services.getPositionTextId(), 0L);
    assertEqual(services.getInteractionQuestionId(), 0L);
    assertEqual(services.getInteractionAdditionalInfo(), "");
    assertEqual(services.getInteractionAnswerId(), 0L);
    assertEqual(services.getSrcChannel(), false);
    assertEqual(services.getSrcExternalAutomatic(), false);
    assertEqual(services.getSrcInternalAutomatic(), false);
    assertEqual(services.getSrcInternalOperator(), false);
    assertEqual(services.getSrcExternalOperator(), false);
    assertEqual(services.getSrcInternalActive(), false);
    assertEqual(services.getSrcExternalActive(), false);
    assertEqual(services.getProcParamApplyEnabled(), false);
    assertEqual(services.getProcParamApplyExternal(), false);
    assertEqual(services.getProcParamApplyOperator(), false);
    assertEqual(services.getProcParamApplyInternal(), false);
    assertEqual(services.getConfigParamApplyEnabled(), false);
    assertEqual(services.getConfigParamApplyExternal(), false);
    assertEqual(services.getConfigParamApplyOperator(), false);
    assertEqual(services.getConfigParamApplyInternal(), false);
    assertEqual(services.getReportValueFreeze(), false);
    assertEqual(services.getNumberOfProcedure(), 0);
    assertTrue(services.getWqc() != nullptr);
    assertTrue(services.getOsLevel() != nullptr);
    assertTrue(services.getState() != nullptr);
    assertTrue(services.getProcedure() != nullptr);
    assertEqual(services.getProcedures().count(), 2);
    assertEqual(services.getConfigParameters().count(), 2);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    // Test missing CommandOp
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingCommandOp);
      assertTrue(false, "shouldn't reach here for missing CommandOp");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCommandOp + ".CommandOp"));
    }

    // Test missing CommandInt
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingCommandInt);
      assertTrue(false, "shouldn't reach here for missing CommandInt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCommandInt + ".CommandInt"));
    }

    // Test missing CommandExt
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingCommandExt);
      assertTrue(false, "shouldn't reach here for missing CommandExt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCommandExt + ".CommandExt"));
    }

    // Test missing StateCur
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingStateCur);
      assertTrue(false, "shouldn't reach here for missing StateCur");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingStateCur + ".StateCur"));
    }

    // Test missing ProcedureOp
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcedureOp);
      assertTrue(false, "shouldn't reach here for missing ProcedureOp");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcedureOp + ".ProcedureOp"));
    }

    // Test missing ProcedureInt
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcedureInt);
      assertTrue(false, "shouldn't reach here for missing ProcedureInt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcedureInt + ".ProcedureInt"));
    }

    // Test missing ProcedureExt
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcedureExt);
      assertTrue(false, "shouldn't reach here for missing ProcedureExt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcedureExt + ".ProcedureExt"));
    }

    // Test missing CommandEn
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingCommandEn);
      assertTrue(false, "shouldn't reach here for missing CommandEn");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCommandEn + ".CommandEn"));
    }

    // Test missing ProcedureCur
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcedureCur);
      assertTrue(false, "shouldn't reach here for missing ProcedureCur");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcedureCur + ".ProcedureCur"));
    }

    // Test missing ProcedureReq
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcedureReq);
      assertTrue(false, "shouldn't reach here for missing ProcedureReq");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcedureReq + ".ProcedureReq"));
    }

    // Test missing PosTextID
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingPosTextID);
      assertTrue(false, "shouldn't reach here for missing PosTextID");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingPosTextID + ".PosTextID"));
    }

    // Test missing InteractQuestionID
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingInteractQuestionID);
      assertTrue(false, "shouldn't reach here for missing InteractQuestionID");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingInteractQuestionID + ".InteractQuestionID"));
    }

    // Test missing InteractAddInfo
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingInteractAddInfo);
      assertTrue(false, "shouldn't reach here for missing InteractAddInfo");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingInteractAddInfo + ".InteractAddInfo"));
    }

    // Test missing InteractAnswerID
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingInteractAnswerID);
      assertTrue(false, "shouldn't reach here for missing InteractAnswerID");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingInteractAnswerID + ".InteractAnswerID"));
    }

    // Test missing SrcChannel
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingSrcChannel);
      assertTrue(false, "shouldn't reach here for missing SrcChannel");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcChannel + ".SrcChannel"));
    }

    // Test missing SrcExtAut
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingSrcExtAut);
      assertTrue(false, "shouldn't reach here for missing SrcExtAut");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcExtAut + ".SrcExtAut"));
    }

    // Test missing SrcIntAut
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingSrcIntAut);
      assertTrue(false, "shouldn't reach here for missing SrcIntAut");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcIntAut + ".SrcIntAut"));
    }

    // Test missing SrcIntOp
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingSrcIntOp);
      assertTrue(false, "shouldn't reach here for missing SrcIntOp");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcIntOp + ".SrcIntOp"));
    }

    // Test missing SrcExtOp
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingSrcExtOp);
      assertTrue(false, "shouldn't reach here for missing SrcExtOp");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcExtOp + ".SrcExtOp"));
    }

    // Test missing SrcIntAct
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingSrcIntAct);
      assertTrue(false, "shouldn't reach here for missing SrcIntAct");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcIntAct + ".SrcIntAct"));
    }

    // Test missing SrcExtAct
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingSrcExtAct);
      assertTrue(false, "shouldn't reach here for missing SrcExtAct");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcExtAct + ".SrcExtAct"));
    }

    // Test missing ProcParamApplyEn
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcParamApplyEn);
      assertTrue(false, "shouldn't reach here for missing ProcParamApplyEn");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcParamApplyEn + ".ProcParamApplyEn"));
    }

    // Test missing ProcParamApplyExt
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcParamApplyExt);
      assertTrue(false, "shouldn't reach here for missing ProcParamApplyExt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcParamApplyExt + ".ProcParamApplyExt"));
    }

    // Test missing ProcParamApplyOp
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcParamApplyOp);
      assertTrue(false, "shouldn't reach here for missing ProcParamApplyOp");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcParamApplyOp + ".ProcParamApplyOp"));
    }

    // Test missing ProcParamApplyInt
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcParamApplyInt);
      assertTrue(false, "shouldn't reach here for missing ProcParamApplyInt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcParamApplyInt + ".ProcParamApplyInt"));
    }

    // Test missing ConfigParamApplyEn
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingConfigParamApplyEn);
      assertTrue(false, "shouldn't reach here for missing ConfigParamApplyEn");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingConfigParamApplyEn + ".ConfigParamApplyEn"));
    }

    // Test missing ConfigParamApplyExt
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingConfigParamApplyExt);
      assertTrue(false, "shouldn't reach here for missing ConfigParamApplyExt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingConfigParamApplyExt + ".ConfigParamApplyExt"));
    }

    // Test missing ConfigParamApplyOp
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingConfigParamApplyOp);
      assertTrue(false, "shouldn't reach here for missing ConfigParamApplyOp");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingConfigParamApplyOp + ".ConfigParamApplyOp"));
    }

    // Test missing ConfigParamApplyInt
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingConfigParamApplyInt);
      assertTrue(false, "shouldn't reach here for missing ConfigParamApplyInt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingConfigParamApplyInt + ".ConfigParamApplyInt"));
    }

    // Test missing ReportValueFreeze
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingReportValueFreeze);
      assertTrue(false, "shouldn't reach here for missing ReportValueFreeze");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingReportValueFreeze + ".ReportValueFreeze"));
    }

    // Test missing numberOfProcedure
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingNumberOfProcedure);
      assertTrue(false, "shouldn't reach here for missing numberOfProcedure");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingNumberOfProcedure + ".numberOfProcedure"));
    }

    // Test missing enabled
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingEnabled);
      assertTrue(false, "shouldn't reach here for missing enabled");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingEnabled + ".enabled"));
    }

    // Test missing tagName
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingTagName);
      assertTrue(false, "shouldn't reach here for missing tagName");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingTagName + ".tagName"));
    }

    // Test missing procedures
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingProcedures);
      assertTrue(false, "shouldn't reach here for missing procedures");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingProcedures + ".procedures"));
    }

    // Test missing configParameters
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingConfigParameters);
      assertTrue(false, "shouldn't reach here for missing configParameters");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingConfigParameters + ".configParameters"));
    }

    return 0;
  }

  public int testCommandInternalChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setCommandInternalChangedCB, services, Services::commandInternalChanged);

    dpSetWait(_DpExists + ".CommandInt", 100L);

    // Give it time to execute callback
    delay(0, 200);
    assertEqual(services.getCommandInternal(), 100L);
    assertEqual(_eventCommandInternal, 100L);
    return 0;
  }

  public int testCommandExternalChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setCommandExternalChangedCB, services, Services::commandExternalChanged);

    dpSetWait(_DpExists + ".CommandExt", 150L);

    // Give it time to execute callback
    delay(0, 200);
    assertEqual(services.getCommandExternal(), 150L);
    assertEqual(_eventCommandExternal, 150L);
    return 0;
  }

  public int testCurrentStateChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setCurrentStateChangedCB, services, Services::currentStateChanged);

    dpSetWait(_DpExists + ".StateCur", 200L);

    // Give it time to execute callback
    delay(0, 200);
    assertEqual(services.getCurrentState(), 200L);
    assertEqual(_eventStateCurrent, 200L);
    return 0;
  }

  public int testSourceChannelChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setSourceChannelChangedCB, services, Services::sourceChannelChanged);

    dpSetWait(_DpExists + ".SrcChannel", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getSrcChannel());
    assertTrue(_eventSrcChannel);
    return 0;
  }

  public int testSourceExternalAutomaticChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setSourceExternalAutomaticChangedCB, services, Services::sourceExternalAutomaticChanged);

    dpSetWait(_DpExists + ".SrcExtAut", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getSrcExternalAutomatic());
    assertTrue(_eventSrcExternalAutomatic);
    return 0;
  }

  public int testSourceInternalAutomaticChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setSourceInternalAutomaticChangedCB, services, Services::sourceInternalAutomaticChanged);

    dpSetWait(_DpExists + ".SrcIntAut", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getSrcInternalAutomatic());
    assertTrue(_eventSrcInternalAutomatic);
    return 0;
  }

  public int testSourceInternalActiveChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setSourceInternalActiveChangedCB, services, Services::sourceInternalActiveChanged);

    dpSetWait(_DpExists + ".SrcIntAct", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getSrcInternalActive());
    assertTrue(_eventSrcInternalActive);
    return 0;
  }

  public int testSourceExternalActiveChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setSourceExternalActiveChangedCB, services, Services::sourceExternalActiveChanged);

    dpSetWait(_DpExists + ".SrcExtAct", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getSrcExternalActive());
    assertTrue(_eventSrcExternalActive);
    return 0;
  }

  public int testProcParamApplyEnabledChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setProcParamApplyEnabledChangedCB, services, Services::procParamApplyEnabledChanged);

    dpSetWait(_DpExists + ".ProcParamApplyEn", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getProcParamApplyEnabled());
    assertTrue(_eventProcParamApplyEnabled);
    return 0;
  }

  public int testProcParamApplyExternalChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setProcParamApplyExternalChangedCB, services, Services::procParamApplyExternalChanged);

    dpSetWait(_DpExists + ".ProcParamApplyExt", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getProcParamApplyExternal());
    assertTrue(_eventProcParamApplyExternal);
    return 0;
  }

  public int testProcParamApplyInternalChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setProcParamApplyInternalChangedCB, services, Services::procParamApplyInternalChanged);

    dpSetWait(_DpExists + ".ProcParamApplyInt", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getProcParamApplyInternal());
    assertTrue(_eventProcParamApplyInternal);
    return 0;
  }

  public int testConfigParamApplyEnabledChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setConfigParamApplyEnabledChangedCB, services, Services::configParamApplyEnabledChanged);

    dpSetWait(_DpExists + ".ConfigParamApplyEn", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getConfigParamApplyEnabled());
    assertTrue(_eventConfigParamApplyEnabled);
    return 0;
  }

  public int testConfigParamApplyExternalChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setConfigParamApplyExternalChangedCB, services, Services::configParamApplyExternalChanged);

    dpSetWait(_DpExists + ".ConfigParamApplyExt", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getConfigParamApplyExternal());
    assertTrue(_eventConfigParamApplyExternal);
    return 0;
  }

  public int testConfigParamApplyInternalChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setConfigParamApplyInternalChangedCB, services, Services::configParamApplyInternalChanged);

    dpSetWait(_DpExists + ".ConfigParamApplyInt", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getConfigParamApplyInternal());
    assertTrue(_eventConfigParamApplyInternal);
    return 0;
  }

  public int testReportValueFreezeChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setReportValueFreezeChangedCB, services, Services::reportValueFreezeChanged);

    dpSetWait(_DpExists + ".ReportValueFreeze", true);

    // Give it time to execute callback
    delay(0, 200);
    assertTrue(services.getReportValueFreeze());
    assertTrue(_eventReportValueFreeze);
    return 0;
  }

  public int testSetConfigParamApplyOperator()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    services.setConfigParamApplyOperator(true);

    // Give it time to write to the data point
    delay(0, 200);

    bool value;
    dpGet(_DpExists + ".ConfigParamApplyOp", value);
    assertTrue(services.getConfigParamApplyOperator());
    assertTrue(value);

    services.setConfigParamApplyOperator(false);
    delay(0, 200);
    dpGet(_DpExists + ".ConfigParamApplyOp", value);
    assertFalse(services.getConfigParamApplyOperator());
    assertFalse(value);
    return 0;
  }

  public int testSetProcParamApplyOperator()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    services.setProcParamApplyOperator(true);

    // Give it time to write to the data point
    delay(0, 200);

    bool value;
    dpGet(_DpExists + ".ProcParamApplyOp", value);
    assertTrue(services.getProcParamApplyOperator());
    assertTrue(value);

    services.setProcParamApplyOperator(false);
    delay(0, 200);
    dpGet(_DpExists + ".ProcParamApplyOp", value);
    assertFalse(services.getProcParamApplyOperator());
    assertFalse(value);
    return 0;
  }

  public int testSetSrcExternalOperator()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    services.setSrcExternalOperator(true);

    // Give it time to write to the data point
    delay(0, 200);

    bool value;
    dpGet(_DpExists + ".SrcExtOp", value);
    assertTrue(services.getSrcExternalOperator());
    assertTrue(value);

    services.setSrcExternalOperator(false);
    delay(0, 200);
    dpGet(_DpExists + ".SrcExtOp", value);
    assertFalse(services.getSrcExternalOperator());
    assertFalse(value);
    return 0;
  }

  public int testSetSrcInternalOperator()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    services.setSrcInternalOperator(true);

    // Give it time to write to the data point
    delay(0, 200);

    bool value;
    dpGet(_DpExists + ".SrcIntOp", value);
    assertTrue(services.getSrcInternalOperator());
    assertTrue(value);

    services.setSrcInternalOperator(false);
    delay(0, 200);
    dpGet(_DpExists + ".SrcIntOp", value);
    assertFalse(services.getSrcInternalOperator());
    assertFalse(value);
    return 0;
  }

  public int testSetCommandOperator()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    services.setCommandOperator(500L);

    // Give it time to write to the data point
    delay(0, 200);

    long value;
    dpGet(_DpExists + ".CommandOp", value);
    assertEqual(services.getCommandOperator(), 500L);
    assertEqual(value, 500L);

    services.setCommandOperator(0L);
    delay(0, 200);
    dpGet(_DpExists + ".CommandOp", value);
    assertEqual(services.getCommandOperator(), 0L);
    assertEqual(value, 0L);
    return 0;
  }

  private void setCommandInternalChangedCB(const long &commandInternal)
  {
    _eventCommandInternal = commandInternal;
  }

  private void setCommandExternalChangedCB(const long &commandExternal)
  {
    _eventCommandExternal = commandExternal;
  }

  private void setCurrentStateChangedCB(const long &stateCurrent)
  {
    _eventStateCurrent = stateCurrent;
  }

  private void setSourceChannelChangedCB(const bool &srcChannel)
  {
    _eventSrcChannel = srcChannel;
  }

  private void setSourceExternalAutomaticChangedCB(const bool &srcExternalAutomatic)
  {
    _eventSrcExternalAutomatic = srcExternalAutomatic;
  }

  private void setSourceInternalAutomaticChangedCB(const bool &srcInternalAutomatic)
  {
    _eventSrcInternalAutomatic = srcInternalAutomatic;
  }

  private void setSourceInternalActiveChangedCB(const bool &srcInternalActive)
  {
    _eventSrcInternalActive = srcInternalActive;
  }

  private void setSourceExternalActiveChangedCB(const bool &srcExternalActive)
  {
    _eventSrcExternalActive = srcExternalActive;
  }

  private void setProcParamApplyEnabledChangedCB(const bool &procParamApplyEnabled)
  {
    _eventProcParamApplyEnabled = procParamApplyEnabled;
  }

  private void setProcParamApplyExternalChangedCB(const bool &procParamApplyExternal)
  {
    _eventProcParamApplyExternal = procParamApplyExternal;
  }

  private void setProcParamApplyInternalChangedCB(const bool &procParamApplyInternal)
  {
    _eventProcParamApplyInternal = procParamApplyInternal;
  }

  private void setConfigParamApplyEnabledChangedCB(const bool &configParamApplyEnabled)
  {
    _eventConfigParamApplyEnabled = configParamApplyEnabled;
  }

  private void setConfigParamApplyExternalChangedCB(const bool &configParamApplyExternal)
  {
    _eventConfigParamApplyExternal = configParamApplyExternal;
  }

  private void setConfigParamApplyInternalChangedCB(const bool &configParamApplyInternal)
  {
    _eventConfigParamApplyInternal = configParamApplyInternal;
  }

  private void setReportValueFreezeChangedCB(const bool &reportValueFreeze)
  {
    _eventReportValueFreeze = reportValueFreeze;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstServices test;
  test.startAll();
}
