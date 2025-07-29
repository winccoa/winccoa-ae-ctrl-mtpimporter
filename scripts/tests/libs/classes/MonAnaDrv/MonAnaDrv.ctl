// $License: NOLICENSE
/**  Tests for the library: scripts/libs/classes/MonAnaDrv/MonAnaDrv.ctl.

   @file $relPath
   @test Unit tests for the library: scripts/libs/classes/MonAnaDrv/MonAnaDrv.ctl
   @copyright $copyright
   @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MonAnaDrv/MonAnaDrv" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MonAnaDrv.ctl
*/
class TstMonAnaDrv : OaTest
{
  private const string _Dpt = "MonAnaDrv";
  private const string _DptInvalidMissingSafePos = "MonAnaDrvInvalid1";
  private const string _DptInvalidMissingSafePosAct = "MonAnaDrvInvalid2";
  private const string _DptInvalidMissingFwdEn = "MonAnaDrvInvalid3";
  private const string _DptInvalidMissingRevEn = "MonAnaDrvInvalid4";
  private const string _DptInvalidMissingStopOp = "MonAnaDrvInvalid5";
  private const string _DptInvalidMissingFwdOp = "MonAnaDrvInvalid6";
  private const string _DptInvalidMissingRevOp = "MonAnaDrvInvalid7";
  private const string _DptInvalidMissingStopAut = "MonAnaDrvInvalid8";
  private const string _DptInvalidMissingFwdAut = "MonAnaDrvInvalid9";
  private const string _DptInvalidMissingRevAut = "MonAnaDrvInvalid10";
  private const string _DptInvalidMissingFwdCtrl = "MonAnaDrvInvalid11";
  private const string _DptInvalidMissingRevCtrl = "MonAnaDrvInvalid12";
  private const string _DptInvalidMissingRevFbkCalc = "MonAnaDrvInvalid13";
  private const string _DptInvalidMissingRevFbk = "MonAnaDrvInvalid14";
  private const string _DptInvalidMissingFwdFbkCalc = "MonAnaDrvInvalid15";
  private const string _DptInvalidMissingFwdFbk = "MonAnaDrvInvalid16";
  private const string _DptInvalidMissingTrip = "MonAnaDrvInvalid17";
  private const string _DptInvalidMissingResetOp = "MonAnaDrvInvalid18";
  private const string _DptInvalidMissingResetAut = "MonAnaDrvInvalid19";
  private const string _DptInvalidMissingRpmFbk = "MonAnaDrvInvalid20";
  private const string _DptInvalidMissingRpm = "MonAnaDrvInvalid21";
  private const string _DptInvalidMissingRpmErr = "MonAnaDrvInvalid22";
  private const string _DptInvalidMissingRpmAHAct = "MonAnaDrvInvalid23";
  private const string _DptInvalidMissingRpmALAct = "MonAnaDrvInvalid24";
  private const string _DptInvalidMissingRpmInt = "MonAnaDrvInvalid25";
  private const string _DptInvalidMissingRpmSclMin = "MonAnaDrvInvalid26";
  private const string _DptInvalidMissingRpmSclMax = "MonAnaDrvInvalid27";
  private const string _DptInvalidMissingRpmRbk = "MonAnaDrvInvalid28";
  private const string _DptInvalidMissingRpmMin = "MonAnaDrvInvalid29";
  private const string _DptInvalidMissingRpmMax = "MonAnaDrvInvalid30";
  private const string _DptInvalidMissingRpmMan = "MonAnaDrvInvalid31";
  private const string _DptInvalidMissingRpmFbkCalc = "MonAnaDrvInvalid32";
  private const string _DptInvalidMissingRpmAHEn = "MonAnaDrvInvalid33";
  private const string _DptInvalidMissingRpmALEn = "MonAnaDrvInvalid34";
  private const string _DptInvalidMissingRpmAHLim = "MonAnaDrvInvalid35";
  private const string _DptInvalidMissingRpmALLim = "MonAnaDrvInvalid36";

  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingSafePos = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingSafePosAct = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingFwdEn = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingRevEn = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingStopOp = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingFwdOp = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingRevOp = "ExistingTestDatapointInvalid7";
  private const string _DpExistsInvalidMissingStopAut = "ExistingTestDatapointInvalid8";
  private const string _DpExistsInvalidMissingFwdAut = "ExistingTestDatapointInvalid9";
  private const string _DpExistsInvalidMissingRevAut = "ExistingTestDatapointInvalid10";
  private const string _DpExistsInvalidMissingFwdCtrl = "ExistingTestDatapointInvalid11";
  private const string _DpExistsInvalidMissingRevCtrl = "ExistingTestDatapointInvalid12";
  private const string _DpExistsInvalidMissingRevFbkCalc = "ExistingTestDatapointInvalid13";
  private const string _DpExistsInvalidMissingRevFbk = "ExistingTestDatapointInvalid14";
  private const string _DpExistsInvalidMissingFwdFbkCalc = "ExistingTestDatapointInvalid15";
  private const string _DpExistsInvalidMissingFwdFbk = "ExistingTestDatapointInvalid16";
  private const string _DpExistsInvalidMissingTrip = "ExistingTestDatapointInvalid17";
  private const string _DpExistsInvalidMissingResetOp = "ExistingTestDatapointInvalid18";
  private const string _DpExistsInvalidMissingResetAut = "ExistingTestDatapointInvalid19";
  private const string _DpExistsInvalidMissingRpmFbk = "ExistingTestDatapointInvalid20";
  private const string _DpExistsInvalidMissingRpm = "ExistingTestDatapointInvalid21";
  private const string _DpExistsInvalidMissingRpmErr = "ExistingTestDatapointInvalid22";
  private const string _DpExistsInvalidMissingRpmAHAct = "ExistingTestDatapointInvalid23";
  private const string _DpExistsInvalidMissingRpmALAct = "ExistingTestDatapointInvalid24";
  private const string _DpExistsInvalidMissingRpmInt = "ExistingTestDatapointInvalid25";
  private const string _DpExistsInvalidMissingRpmSclMin = "ExistingTestDatapointInvalid26";
  private const string _DpExistsInvalidMissingRpmSclMax = "ExistingTestDatapointInvalid27";
  private const string _DpExistsInvalidMissingRpmRbk = "ExistingTestDatapointInvalid28";
  private const string _DpExistsInvalidMissingRpmMin = "ExistingTestDatapointInvalid29";
  private const string _DpExistsInvalidMissingRpmMax = "ExistingTestDatapointInvalid30";
  private const string _DpExistsInvalidMissingRpmMan = "ExistingTestDatapointInvalid31";
  private const string _DpExistsInvalidMissingRpmFbkCalc = "ExistingTestDatapointInvalid32";
  private const string _DpExistsInvalidMissingRpmAHEn = "ExistingTestDatapointInvalid33";
  private const string _DpExistsInvalidMissingRpmALEn = "ExistingTestDatapointInvalid34";
  private const string _DpExistsInvalidMissingRpmAHLim = "ExistingTestDatapointInvalid35";
  private const string _DpExistsInvalidMissingRpmALLim = "ExistingTestDatapointInvalid36";

  private bool _eventForwardControl;
  private bool _eventReverseControl;
  private bool _eventForwardFeedbackSignal;
  private bool _eventReverseFeedbackSignal;
  private float _eventRpmFeedbackSignal;
  private float _eventRpm;
  private float _eventRpmInternal;
  private bool _eventDriveSafetyIndicator;
  private bool _eventRpmAlarmHighActive;
  private bool _eventRpmAlarmLowActive;
  private bool _eventSafetyPositionActive;
  private bool _eventSafetyPosition;
  private float _eventRpmError;
  private bool _eventStopAutomatic;
  private bool _eventForwardAutomatic;
  private bool _eventReverseAutomatic;
  private bool _eventResetAutomatic;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0) { return -1; }

    dpCreate(_DpExists, _Dpt);

    dyn_dyn_string dpes = makeDynAnytype(
                            makeDynString(_DptInvalidMissingSafePos),
                            makeDynString("", "SafePosAct"), makeDynString("", "FwdEn"),
                            makeDynString("", "RevEn"), makeDynString("", "StopOp"),
                            makeDynString("", "FwdOp"), makeDynString("", "RevOp"),
                            makeDynString("", "StopAut"), makeDynString("", "FwdAut"),
                            makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
                            makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
                            makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
                            makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
                            makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
                            makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
                            makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
                            makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
                            makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
                            makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
                            makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
                            makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
                            makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
                            makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
                            makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
                            makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
                            makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
                            makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
                            makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
                            makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
                            makeDynString("", "Permit"), makeDynString("", "IntEn"),
                            makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
                            makeDynString("", "Protect"), makeDynString("", "MonEn"),
                            makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
                            makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
                            makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
                            makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
                            makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
                            makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
                            makeDynString("", "SrcIntAct"), makeDynString("", "enabled"),
                            makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSafePos, _DptInvalidMissingSafePos);

// Repeat similar dpTypeCreate and dpCreate for other invalid datapoints
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSafePosAct),
             makeDynString("", "SafePos"), makeDynString("", "FwdEn"),
             makeDynString("", "RevEn"), makeDynString("", "StopOp"),
             makeDynString("", "FwdOp"), makeDynString("", "RevOp"),
             makeDynString("", "StopAut"), makeDynString("", "FwdAut"),
             makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"),
             makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"),
             makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"),
             makeDynString("", "SrcIntAct"), makeDynString("", "enabled"),
             makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSafePosAct, _DptInvalidMissingSafePosAct);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingFwdEn),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "RevEn"), makeDynString("", "StopOp"),
             makeDynString("", "FwdOp"), makeDynString("", "RevOp"),
             makeDynString("", "StopAut"), makeDynString("", "FwdAut"),
             makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingFwdEn, _DptInvalidMissingFwdEn);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRevEn),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "StopOp"),
             makeDynString("", "FwdOp"), makeDynString("", "RevOp"),
             makeDynString("", "StopAut"), makeDynString("", "FwdAut"),
             makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRevEn, _DptInvalidMissingRevEn);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStopOp),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "FwdOp"), makeDynString("", "RevOp"),
             makeDynString("", "StopAut"), makeDynString("", "FwdAut"),
             makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStopOp, _DptInvalidMissingStopOp);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingFwdOp),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "RevOp"),
             makeDynString("", "StopAut"), makeDynString("", "FwdAut"),
             makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingFwdOp, _DptInvalidMissingFwdOp);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRevOp),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "StopAut"), makeDynString("", "FwdAut"),
             makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRevOp, _DptInvalidMissingRevOp);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingStopAut),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "FwdAut"),
             makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStopAut, _DptInvalidMissingStopAut);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingFwdAut),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingFwdAut, _DptInvalidMissingFwdAut);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRevAut),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "FwdCtrl"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRevAut, _DptInvalidMissingRevAut);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingFwdCtrl),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingFwdCtrl, _DptInvalidMissingFwdCtrl);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRevCtrl),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevFbkCalc"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRevCtrl, _DptInvalidMissingRevCtrl);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRevFbkCalc),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRevFbkCalc, _DptInvalidMissingRevFbkCalc);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRevFbk),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "FwdFbkCalc"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRevFbk, _DptInvalidMissingRevFbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingFwdFbkCalc),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingFwdFbkCalc, _DptInvalidMissingFwdFbkCalc);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingFwdFbk),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "Trip"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingFwdFbk, _DptInvalidMissingFwdFbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingTrip),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingTrip, _DptInvalidMissingTrip);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingResetOp),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetAut"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingResetOp, _DptInvalidMissingResetOp);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingResetAut),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "RpmFbk"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingResetAut, _DptInvalidMissingResetAut);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmFbk),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "Rpm"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmFbk, _DptInvalidMissingRpmFbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpm),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "RpmErr"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpm, _DptInvalidMissingRpm);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmErr),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmAHAct"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmErr, _DptInvalidMissingRpmErr);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmAHAct),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmALAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmAHAct, _DptInvalidMissingRpmAHAct);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmALAct),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmInt"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmALAct, _DptInvalidMissingRpmALAct);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmInt),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmSclMin"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmInt, _DptInvalidMissingRpmInt);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmSclMin),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMax"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmSclMin, _DptInvalidMissingRpmSclMin);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmSclMax),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmRbk"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmSclMax, _DptInvalidMissingRpmSclMax);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmRbk),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmMin"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmRbk, _DptInvalidMissingRpmRbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmMin),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmRbk"),
             makeDynString("", "RpmMax"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmMin, _DptInvalidMissingRpmMin);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmMax),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmRbk"),
             makeDynString("", "RpmMin"), makeDynString("", "RpmMan"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmMax, _DptInvalidMissingRpmMax);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmMan),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmRbk"),
             makeDynString("", "RpmMin"), makeDynString("", "RpmMax"),
             makeDynString("", "RpmFbkCalc"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmMan, _DptInvalidMissingRpmMan);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmFbkCalc),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmRbk"),
             makeDynString("", "RpmMin"), makeDynString("", "RpmMax"),
             makeDynString("", "RpmMan"), makeDynString("", "RpmAHEn"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmFbkCalc, _DptInvalidMissingRpmFbkCalc);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmAHEn),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmRbk"),
             makeDynString("", "RpmMin"), makeDynString("", "RpmMax"),
             makeDynString("", "RpmMan"), makeDynString("", "RpmFbkCalc"),
             makeDynString("", "RpmALEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmAHEn, _DptInvalidMissingRpmAHEn);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmALEn),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmRbk"),
             makeDynString("", "RpmMin"), makeDynString("", "RpmMax"),
             makeDynString("", "RpmMan"), makeDynString("", "RpmFbkCalc"),
             makeDynString("", "RpmAHEn"), makeDynString("", "RpmAHLim"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmALEn, _DptInvalidMissingRpmALEn);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmAHLim),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmRbk"),
             makeDynString("", "RpmMin"), makeDynString("", "RpmMax"),
             makeDynString("", "RpmMan"), makeDynString("", "RpmFbkCalc"),
             makeDynString("", "RpmAHEn"), makeDynString("", "RpmALEn"),
             makeDynString("", "RpmALLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmAHLim, _DptInvalidMissingRpmAHLim);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingRpmALLim),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "FwdEn"), makeDynString("", "RevEn"),
             makeDynString("", "StopOp"), makeDynString("", "FwdOp"),
             makeDynString("", "RevOp"), makeDynString("", "StopAut"),
             makeDynString("", "FwdAut"), makeDynString("", "RevAut"),
             makeDynString("", "FwdCtrl"), makeDynString("", "RevCtrl"),
             makeDynString("", "RevFbkCalc"), makeDynString("", "RevFbk"),
             makeDynString("", "FwdFbkCalc"), makeDynString("", "FwdFbk"),
             makeDynString("", "Trip"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "RpmFbk"),
             makeDynString("", "Rpm"), makeDynString("", "RpmErr"),
             makeDynString("", "RpmAHAct"), makeDynString("", "RpmALAct"),
             makeDynString("", "RpmInt"), makeDynString("", "RpmSclMin"),
             makeDynString("", "RpmSclMax"), makeDynString("", "RpmRbk"),
             makeDynString("", "RpmMin"), makeDynString("", "RpmMax"),
             makeDynString("", "RpmMan"), makeDynString("", "RpmFbkCalc"),
             makeDynString("", "RpmAHEn"), makeDynString("", "RpmALEn"),
             makeDynString("", "RpmAHLim"), makeDynString("", "WQC"),
             makeDynString("", "OSLevel"), makeDynString("", "StateChannel"),
             makeDynString("", "StateOffAut"), makeDynString("", "StateOpAut"),
             makeDynString("", "StateAutAut"), makeDynString("", "StateOffOp"),
             makeDynString("", "StateOpOp"), makeDynString("", "StateAutOp"),
             makeDynString("", "StateOpAct"), makeDynString("", "StateAutAct"),
             makeDynString("", "StateOffAct"), makeDynString("", "PermEn"),
             makeDynString("", "Permit"), makeDynString("", "IntEn"),
             makeDynString("", "Interlock"), makeDynString("", "ProtEn"),
             makeDynString("", "Protect"), makeDynString("", "MonEn"),
             makeDynString("", "MonSafePos"), makeDynString("", "MonStatErr"),
             makeDynString("", "MonDynErr"), makeDynString("", "MonStatTi"),
             makeDynString("", "MonDynTi"), makeDynString("", "RpmUnit"),
             makeDynString("", "enabled"), makeDynString("", "tagName"));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingRpmALLim, _DptInvalidMissingRpmALLim);

    return 0;
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingSafePos);
    dpDelete(_DpExistsInvalidMissingSafePosAct);
    dpDelete(_DpExistsInvalidMissingFwdEn);
    dpDelete(_DpExistsInvalidMissingRevEn);
    dpDelete(_DpExistsInvalidMissingStopOp);
    dpDelete(_DpExistsInvalidMissingFwdOp);
    dpDelete(_DpExistsInvalidMissingRevOp);
    dpDelete(_DpExistsInvalidMissingStopAut);
    dpDelete(_DpExistsInvalidMissingFwdAut);
    dpDelete(_DpExistsInvalidMissingRevAut);
    dpDelete(_DpExistsInvalidMissingFwdCtrl);
    dpDelete(_DpExistsInvalidMissingRevCtrl);
    dpDelete(_DpExistsInvalidMissingRevFbkCalc);
    dpDelete(_DpExistsInvalidMissingRevFbk);
    dpDelete(_DpExistsInvalidMissingFwdFbkCalc);
    dpDelete(_DpExistsInvalidMissingFwdFbk);
    dpDelete(_DpExistsInvalidMissingTrip);
    dpDelete(_DpExistsInvalidMissingResetOp);
    dpDelete(_DpExistsInvalidMissingResetAut);
    dpDelete(_DpExistsInvalidMissingRpmFbk);
    dpDelete(_DpExistsInvalidMissingRpm);
    dpDelete(_DpExistsInvalidMissingRpmErr);
    dpDelete(_DpExistsInvalidMissingRpmAHAct);
    dpDelete(_DpExistsInvalidMissingRpmALAct);
    dpDelete(_DpExistsInvalidMissingRpmInt);
    dpDelete(_DpExistsInvalidMissingRpmSclMin);
    dpDelete(_DpExistsInvalidMissingRpmSclMax);
    dpDelete(_DpExistsInvalidMissingRpmRbk);
    dpDelete(_DpExistsInvalidMissingRpmMin);
    dpDelete(_DpExistsInvalidMissingRpmMax);
    dpDelete(_DpExistsInvalidMissingRpmMan);
    dpDelete(_DpExistsInvalidMissingRpmFbkCalc);
    dpDelete(_DpExistsInvalidMissingRpmAHEn);
    dpDelete(_DpExistsInvalidMissingRpmALEn);
    dpDelete(_DpExistsInvalidMissingRpmAHLim);
    dpDelete(_DpExistsInvalidMissingRpmALLim);

    dpTypeDelete(_DptInvalidMissingSafePos);
    dpTypeDelete(_DptInvalidMissingSafePosAct);
    dpTypeDelete(_DptInvalidMissingFwdEn);
    dpTypeDelete(_DptInvalidMissingRevEn);
    dpTypeDelete(_DptInvalidMissingStopOp);
    dpTypeDelete(_DptInvalidMissingFwdOp);
    dpTypeDelete(_DptInvalidMissingRevOp);
    dpTypeDelete(_DptInvalidMissingStopAut);
    dpTypeDelete(_DptInvalidMissingFwdAut);
    dpTypeDelete(_DptInvalidMissingRevAut);
    dpTypeDelete(_DptInvalidMissingFwdCtrl);
    dpTypeDelete(_DptInvalidMissingRevCtrl);
    dpTypeDelete(_DptInvalidMissingRevFbkCalc);
    dpTypeDelete(_DptInvalidMissingRevFbk);
    dpTypeDelete(_DptInvalidMissingFwdFbkCalc);
    dpTypeDelete(_DptInvalidMissingFwdFbk);
    dpTypeDelete(_DptInvalidMissingTrip);
    dpTypeDelete(_DptInvalidMissingResetOp);
    dpTypeDelete(_DptInvalidMissingResetAut);
    dpTypeDelete(_DptInvalidMissingRpmFbk);
    dpTypeDelete(_DptInvalidMissingRpm);
    dpTypeDelete(_DptInvalidMissingRpmErr);
    dpTypeDelete(_DptInvalidMissingRpmAHAct);
    dpTypeDelete(_DptInvalidMissingRpmALAct);
    dpTypeDelete(_DptInvalidMissingRpmInt);
    dpTypeDelete(_DptInvalidMissingRpmSclMin);
    dpTypeDelete(_DptInvalidMissingRpmSclMax);
    dpTypeDelete(_DptInvalidMissingRpmRbk);
    dpTypeDelete(_DptInvalidMissingRpmMin);
    dpTypeDelete(_DptInvalidMissingRpmMax);
    dpTypeDelete(_DptInvalidMissingRpmMan);
    dpTypeDelete(_DptInvalidMissingRpmFbkCalc);
    dpTypeDelete(_DptInvalidMissingRpmAHEn);
    dpTypeDelete(_DptInvalidMissingRpmALEn);
    dpTypeDelete(_DptInvalidMissingRpmAHLim);
    dpTypeDelete(_DptInvalidMissingRpmALLim);

    return 0;
  }

  public int testConstructor()
  {
    shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExists);
    assertEqual(drv.getDp(), _DpExists);
    assertEqual(drv.getSafetyPosition(), false);
    assertEqual(drv.getSafetyPositionActive(), false);
    assertEqual(drv.getForwardEnabled(), false);
    assertEqual(drv.getReverseEnabled(), false);
    assertEqual(drv.getStopOperator(), false);
    assertEqual(drv.getForwardOperator(), false);
    assertEqual(drv.getReverseOperator(), false);
    assertEqual(drv.getStopAutomatic(), false);
    assertEqual(drv.getForwardAutomatic(), false);
    assertEqual(drv.getReverseAutomatic(), false);
    assertEqual(drv.getForwardControl(), false);
    assertEqual(drv.getReverseControl(), false);
    assertEqual(drv.getReverseFeedbackSource(), false);
    assertEqual(drv.getForwardFeedbackSource(), false);
    assertEqual(drv.getForwardFeedbackSignal(), false);
    assertEqual(drv.getReverseFeedbackSignal(), false);
    assertEqual(drv.getRpmFeedbackSource(), false);
    assertEqual(drv.getRpmFeedbackSignal(), 0.0);
    assertEqual(drv.getDriveSafetyIndicator(), false);
    assertEqual(drv.getResetOperator(), false);
    assertEqual(drv.getResetAutomatic(), false);
    assertEqual(drv.getRpm(), 0.0);
    assertEqual(drv.getRpmError(), 0.0);
    assertEqual(drv.getRpmAlarmHighActive(), false);
    assertEqual(drv.getRpmAlarmLowActive(), false);
    assertEqual(drv.getRpmInternal(), 0.0);
    assertEqual(drv.getRpmScaleMin(), 0.0);
    assertEqual(drv.getRpmScaleMax(), 0.0);
    assertEqual(drv.getRpmReadback(), 0.0);
    assertEqual(drv.getRpmMin(), 0.0);
    assertEqual(drv.getRpmMax(), 0.0);
    assertEqual(drv.getRpmManual(), 0.0);
    assertEqual(drv.getRpmAlarmHighEnabled(), false);
    assertEqual(drv.getRpmAlarmLowEnabled(), false);
    assertEqual(drv.getRpmAlarmHighLimit(), 0.0);
    assertEqual(drv.getRpmAlarmLowLimit(), 0.0);
    assertTrue(drv.getWqc() != nullptr);
    assertTrue(drv.getOsLevel() != nullptr);
    assertTrue(drv.getState() != nullptr);
    assertTrue(drv.getMonitor() != nullptr);
    assertTrue(drv.getSecurity() != nullptr);
    assertTrue(drv.getRpmUnit() != nullptr);
    assertTrue(drv.getSource() != nullptr);
    return 0;
  }

  public int testSetters()
  {
    shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExists);

    // Test setRpmAlarmHighLimit
    drv.setRpmAlarmHighLimit(1000.0);
    float rpmHighLimit;
    dpGet(_DpExists + ".RpmAHLim", rpmHighLimit);
    assertEqual(drv.getRpmAlarmHighLimit(), 1000.0, "RpmAlarmHighLimit should be 1000.0");
    assertEqual(rpmHighLimit, 1000.0, "Datapoint RpmAHLim should be 1000.0");

    // Test setRpmAlarmLowLimit
    drv.setRpmAlarmLowLimit(100.0);
    float rpmLowLimit;
    dpGet(_DpExists + ".RpmALLim", rpmLowLimit);
    assertEqual(drv.getRpmAlarmLowLimit(), 100.0, "RpmAlarmLowLimit should be 100.0");
    assertEqual(rpmLowLimit, 100.0, "Datapoint RpmALLim should be 100.0");

    // Test setRpmManual
    drv.setRpmManual(500.0);
    float rpmManual;
    dpGet(_DpExists + ".RpmMan", rpmManual);
    assertEqual(drv.getRpmManual(), 500.0, "RpmManual should be 500.0");
    assertEqual(rpmManual, 500.0, "Datapoint RpmMan should be 500.0");

    // Test setStopOperator
    drv.setStopOperator(true);
    bool stopOperator;
    dpGet(_DpExists + ".StopOp", stopOperator);
    assertEqual(drv.getStopOperator(), true, "StopOperator should be true");
    assertEqual(stopOperator, true, "Datapoint StopOp should be true");

    // Test setForwardOperator
    drv.setForwardOperator(true);
    bool forwardOperator;
    dpGet(_DpExists + ".FwdOp", forwardOperator);
    assertEqual(drv.getForwardOperator(), true, "ForwardOperator should be true");
    assertEqual(forwardOperator, true, "Datapoint FwdOp should be true");

    // Test setReverseOperator
    drv.setReverseOperator(true);
    bool reverseOperator;
    dpGet(_DpExists + ".RevOp", reverseOperator);
    assertEqual(drv.getReverseOperator(), true, "ReverseOperator should be true");
    assertEqual(reverseOperator, true, "Datapoint RevOp should be true");

    // Test setResetOperator
    drv.setResetOperator(true);
    bool resetOperator;
    dpGet(_DpExists + ".ResetOp", resetOperator);
    assertEqual(drv.getResetOperator(), true, "ResetOperator should be true");
    assertEqual(resetOperator, true, "Datapoint ResetOp should be true");

    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingSafePos);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSafePos + ".SafePos"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingSafePosAct);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSafePosAct + ".SafePosAct"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingFwdEn);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingFwdEn + ".FwdEn"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRevEn);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRevEn + ".RevEn"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingStopOp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingStopOp + ".StopOp"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingFwdOp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingFwdOp + ".FwdOp"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRevOp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRevOp + ".RevOp"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingStopAut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingStopAut + ".StopAut"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingFwdAut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingFwdAut + ".FwdAut"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRevAut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRevAut + ".RevAut"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingFwdCtrl);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingFwdCtrl + ".FwdCtrl"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRevCtrl);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRevCtrl + ".RevCtrl"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRevFbkCalc);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRevFbkCalc + ".RevFbkCalc"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRevFbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRevFbk + ".RevFbk"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingFwdFbkCalc);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingFwdFbkCalc + ".FwdFbkCalc"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingFwdFbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingFwdFbk + ".FwdFbk"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingTrip);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingTrip + ".Trip"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingResetOp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingResetOp + ".ResetOp"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingResetAut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingResetAut + ".ResetAut"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmFbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmFbk + ".RpmFbk"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpm);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpm + ".Rpm"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmErr);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmErr + ".RpmErr"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmAHAct);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmAHAct + ".RpmAHAct"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmALAct);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmALAct + ".RpmALAct"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmInt);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmInt + ".RpmInt"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmSclMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmSclMin + ".RpmSclMin"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmSclMax + ".RpmSclMax"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmRbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmRbk + ".RpmRbk"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmMin + ".RpmMin"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmMax + ".RpmMax"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmMan);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmMan + ".RpmMan"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmFbkCalc);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmFbkCalc + ".RpmFbkCalc"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmAHEn);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmAHEn + ".RpmAHEn"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmALEn);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmALEn + ".RpmALEn"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmAHLim);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmAHLim + ".RpmAHLim"));
    }

    try
    {
      shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExistsInvalidMissingRpmALLim);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingRpmALLim + ".RpmALLim"));
    }

    return 0;
  }

  public int testControlSignals()
  {
    shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExists);
    classConnect(this, setForwardControlChangedCB, drv, MonAnaDrv::forwardControlChanged);
    classConnect(this, setReverseControlChangedCB, drv, MonAnaDrv::reverseControlChanged);

    // Enable forward and reverse to allow control signals
    dpSetWait(_DpExists + ".FwdEn", true, _DpExists + ".RevEn", true);

    // Test forward control
    dpSetWait(_DpExists + ".FwdCtrl", true);
    delay(0, 200);

    assertTrue(_eventForwardControl, "Forward control signal should be active");
    assertEqual(drv.getForwardControl(), true, "Forward control should be true");

    // Test reverse control
    dpSetWait(_DpExists + ".RevCtrl", true);
    delay(0, 200);
    assertTrue(_eventReverseControl, "Reverse control signal should be active");
    assertEqual(drv.getReverseControl(), true, "Reverse control should be true");

    return 0;
  }

  public int testFeedbackSignals()
  {
    shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExists);
    classConnect(this, setForwardFeedbackSignalChangedCB, drv, MonAnaDrv::forwardFeedbackSignalChanged);
    classConnect(this, setReverseFeedbackSignalChangedCB, drv, MonAnaDrv::reverseFeedbackSignalChanged);
    classConnect(this, setRpmFeedbackSignalChangedCB, drv, MonAnaDrv::rpmFeedbackSignalChanged);

    dpSetWait(_DpExists + ".FwdFbk", true);
    delay(0, 200);
    assertTrue(_eventForwardFeedbackSignal, "Forward feedback should be active");
    assertEqual(drv.getForwardFeedbackSignal(), true);

    dpSetWait(_DpExists + ".RevFbk", true);
    delay(0, 200);
    assertTrue(_eventReverseFeedbackSignal, "Reverse feedback should be active");
    assertEqual(drv.getReverseFeedbackSignal(), true);

    dpSetWait(_DpExists + ".RpmFbk", 100.0);
    delay(0, 200);
    assertEqual(_eventRpmFeedbackSignal, 100.0, "RPM feedback should match set value");
    assertEqual(drv.getRpmFeedbackSignal(), 100.0);

    return 0;
  }

  public int testSafetyAndAlarms()
  {
    shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExists);
    classConnect(this, setSafetyPositionChangedCB, drv, MonAnaDrv::safetyPositionChanged);
    classConnect(this, setRpmAlarmHighActiveChangedCB, drv, MonAnaDrv::rpmAlarmHighActiveChanged);
    classConnect(this, setRpmAlarmLowActiveChangedCB, drv, MonAnaDrv::rpmAlarmLowActiveChanged);

    dpSetWait(_DpExists + ".SafePos", true);
    delay(0, 200);
    assertTrue(_eventSafetyPosition, "Safety position should be active");
    assertEqual(drv.getSafetyPosition(), true);

    return 0;
  }

  public int testRpmCalculations()
  {
    shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExists);
    classConnect(this, setRpmChangedCB, drv, MonAnaDrv::rpmChanged);
    classConnect(this, setRpmErrorChangedCB, drv, MonAnaDrv::rpmErrorChanged);

    dpSetWait(_DpExists + ".RpmSclMin", 0.0);
    dpSetWait(_DpExists + ".RpmSclMax", 1000.0);
    dpSetWait(_DpExists + ".RpmFbk", 500.0);
    delay(0, 200);
    assertEqual(drv.getRpmFeedbackSignal(), 500.0);

    return 0;
  }

  public int testAutomaticMode()
  {
    shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExists);
    classConnect(this, setForwardAutomaticChangedCB, drv, MonAnaDrv::forwardAutomaticChanged);
    classConnect(this, setReverseAutomaticChangedCB, drv, MonAnaDrv::reverseAutomaticChanged);
    classConnect(this, setStopAutomaticChangedCB, drv, MonAnaDrv::stopAutomaticChanged);

    dpSetWait(_DpExists + ".FwdAut", true);
    delay(0, 200);
    assertTrue(_eventForwardAutomatic, "Forward control should be active in auto mode");
    assertEqual(drv.getForwardAutomatic(), true);

    dpSetWait(_DpExists + ".RevAut", true);
    delay(0, 200);
    assertTrue(_eventReverseAutomatic, "Reverse control should be active in auto mode");
    assertEqual(drv.getReverseAutomatic(), true);

    dpSetWait(_DpExists + ".StopAut", true);
    delay(0, 200);
    assertTrue(_eventStopAutomatic, "Stop automatic should be active");
    assertEqual(drv.getStopAutomatic(), true);

    return 0;
  }

  public int testResetFunctionality()
  {
    shared_ptr<MonAnaDrv> drv = new MonAnaDrv(_DpExists);
    classConnect(this, setDriveSafetyIndicatorChangedCB, drv, MonAnaDrv::driveSafetyIndicatorChanged);
    classConnect(this, setResetAutomaticChangedCB, drv, MonAnaDrv::resetAutomaticChanged);

    dpSetWait(_DpExists + ".Trip", true);
    delay(0, 200);
    assertTrue(_eventDriveSafetyIndicator, "Trip should be active");
    assertEqual(drv.getDriveSafetyIndicator(), true);

    dpSetWait(_DpExists + ".Trip", false);
    dpSetWait(_DpExists + ".ResetAut", true);
    delay(0, 200);
    assertEqual(drv.getDriveSafetyIndicator(), false);
    assertTrue(_eventResetAutomatic, "Reset automatic should be active");
    assertEqual(drv.getResetAutomatic(), true);

    return 0;
  }

  private void setForwardControlChangedCB(const bool &value)
  {
    _eventForwardControl = value;
  }

  private void setReverseControlChangedCB(const bool &value)
  {
    _eventReverseControl = value;
  }

  private void setForwardFeedbackSignalChangedCB(const bool &value)
  {
    _eventForwardFeedbackSignal = value;
  }

  private void setReverseFeedbackSignalChangedCB(const bool &value)
  {
    _eventReverseFeedbackSignal = value;
  }

  private void setRpmFeedbackSignalChangedCB(const float &value)
  {
    _eventRpmFeedbackSignal = value;
  }

  private void setRpmChangedCB(const float &value)
  {
    _eventRpm = value;
  }

  private void setDriveSafetyIndicatorChangedCB(const bool &value)
  {
    _eventDriveSafetyIndicator = value;
  }

  private void setRpmAlarmHighActiveChangedCB(const bool &value)
  {
    _eventRpmAlarmHighActive = value;
  }

  private void setRpmAlarmLowActiveChangedCB(const bool &value)
  {
    _eventRpmAlarmLowActive = value;
  }

  private void setSafetyPositionChangedCB(const bool &value)
  {
    _eventSafetyPosition = value;
  }

  private void setRpmErrorChangedCB(const float &value)
  {
    _eventRpmError = value;
  }

  private void setStopAutomaticChangedCB(const bool &value)
  {
    _eventStopAutomatic = value;
  }

  private void setForwardAutomaticChangedCB(const bool &value)
  {
    _eventForwardAutomatic = value;
  }

  private void setReverseAutomaticChangedCB(const bool &value)
  {
    _eventReverseAutomatic = value;
  }

  private void setResetAutomaticChangedCB(const bool &value)
  {
    _eventResetAutomatic = value;
  }

  private void setResetOperatorChangedCB(const bool &value)
  {
    _eventResetOperator = value;
  }

  private void setStateOffActChangedCB(const bool &value)
  {
    _eventStateOffAct = value;
  }

  private void setStateOpActChangedCB(const bool &value)
  {
    _eventStateOpAct = value;
  }

  private void setStateAutActChangedCB(const bool &value)
  {
    _eventStateAutAct = value;
  }

  private void setPermitChangedCB(const bool &value)
  {
    _eventPermit = value;
  }

  private void setInterlockChangedCB(const bool &value)
  {
    _eventInterlock = value;
  }

  private void setProtectChangedCB(const bool &value)
  {
    _eventProtect = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMonAnaDrv test;
  test.startAll();
}
