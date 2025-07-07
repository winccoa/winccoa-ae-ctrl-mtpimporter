// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MonBinDrv/MonBinDrv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MonBinDrv/MonBinDrv.ctl
  @copyright $copyright
  @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MonBinDrv/MonBinDrv" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MonBinDrv.ctl
*/
class TstMonBinDrv : OaTest
{
  private const string _Dpt = "MonBinDrv";
  private const string _DptInvalidMissingSafePos = "MonBinDrvInvalid1";
  private const string _DptInvalidMissingSafePosAct = "MonBinDrvInvalid2";
  private const string _DptInvalidMissingFwdEn = "MonBinDrvInvalid3";
  private const string _DptInvalidMissingRevEn = "MonBinDrvInvalid4";
  private const string _DptInvalidMissingStopOp = "MonBinDrvInvalid5";
  private const string _DptInvalidMissingFwdOp = "MonBinDrvInvalid6";
  private const string _DptInvalidMissingRevOp = "MonBinDrvInvalid7";
  private const string _DptInvalidMissingStopAut = "MonBinDrvInvalid8";
  private const string _DptInvalidMissingFwdAut = "MonBinDrvInvalid9";
  private const string _DptInvalidMissingRevAut = "MonBinDrvInvalid10";
  private const string _DptInvalidMissingFwdCtrl = "MonBinDrvInvalid11";
  private const string _DptInvalidMissingRevCtrl = "MonBinDrvInvalid12";
  private const string _DptInvalidMissingRevFbkCalc = "MonBinDrvInvalid13";
  private const string _DptInvalidMissingRevFbk = "MonBinDrvInvalid14";
  private const string _DptInvalidMissingFwdFbkCalc = "MonBinDrvInvalid15";
  private const string _DptInvalidMissingFwdFbk = "MonBinDrvInvalid16";
  private const string _DptInvalidMissingTrip = "MonBinDrvInvalid17";
  private const string _DptInvalidMissingResetOp = "MonBinDrvInvalid18";
  private const string _DptInvalidMissingResetAut = "MonBinDrvInvalid19";
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

  private bool _eventForwardCheckbackSignal;
  private bool _eventReverseCheckbackSignal;
  private bool _eventSafetyPosition;
  private bool _eventSafetyPositionActive;
  private bool _eventForwardControl;
  private bool _eventReverseControl;
  private bool _eventDriveSafetyIndicator;
  private bool _eventForwardAutomatic;
  private bool _eventReverseAutomatic;
  private bool _eventStopAutomatic;
  private bool _eventResetAutomatic;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      return -1;
    }

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
                            makeDynString("", "WQC"), makeDynString("", "OSLevel"),
                            makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
                            makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
                            makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
                            makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
                            makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
                            makeDynString("", "PermEn"), makeDynString("", "Permit"),
                            makeDynString("", "IntEn"), makeDynString("", "Interlock"),
                            makeDynString("", "ProtEn"), makeDynString("", "Protect"),
                            makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
                            makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
                            makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
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
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
                           makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSafePos, _DptInvalidMissingSafePos);

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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynString("", "RevOp"),
               makeDynString("", "StopAut"), makeDynString("", "FwdAut"),
               makeDynString("", "RevAut"), makeDynString("", "FwdCtrl"),
               makeDynString("", "RevCtrl"), makeDynString("", "RevFbkCalc"),
               makeDynString("", "RevFbk"), makeDynString("", "FwdFbkCalc"),
               makeDynString("", "FwdFbk"), makeDynString("", "Trip"),
               makeDynString("", "ResetOp"), makeDynString("", "ResetAut"),
               makeDynString("", "WQC"), makeDynString("", "OSLevel"),
               makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
               makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
               makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
               makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
               makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
               makeDynString("", "PermEn"), makeDynString("", "Permit"),
               makeDynString("", "IntEn"), makeDynString("", "Interlock"),
               makeDynString("", "ProtEn"), makeDynString("", "Protect"),
               makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
               makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
               makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
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
             makeDynString("", "WQC"), makeDynString("", "OSLevel"),
             makeDynString("", "StateChannel"), makeDynString("", "StateOffAut"),
             makeDynString("", "StateOpAut"), makeDynString("", "StateAutAut"),
             makeDynString("", "StateOffOp"), makeDynString("", "StateOpOp"),
             makeDynString("", "StateAutOp"), makeDynString("", "StateOpAct"),
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"),
             makeDynString("", "PermEn"), makeDynString("", "Permit"),
             makeDynString("", "IntEn"), makeDynString("", "Interlock"),
             makeDynString("", "ProtEn"), makeDynString("", "Protect"),
             makeDynString("", "MonEn"), makeDynString("", "MonSafePos"),
             makeDynString("", "MonStatErr"), makeDynString("", "MonDynErr"),
             makeDynString("", "MonStatTi"), makeDynString("", "MonDynTi"));
    values = makeDynAnytype(
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
               makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingResetAut, _DptInvalidMissingResetAut);

    return OaTest::setUp();
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

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    assertEqual(monBinDrv.getDp(), _DpExists);
    assertEqual(monBinDrv.getSafetyPosition(), false);
    assertEqual(monBinDrv.getSafetyPositionActive(), false);
    assertEqual(monBinDrv.getForwardEnabled(), false);
    assertEqual(monBinDrv.getReverseEnabled(), false);
    assertEqual(monBinDrv.getStopOperator(), false);
    assertEqual(monBinDrv.getForwardOperator(), false);
    assertEqual(monBinDrv.getReverseOperator(), false);
    assertEqual(monBinDrv.getStopAutomatic(), false);
    assertEqual(monBinDrv.getForwardAutomatic(), false);
    assertEqual(monBinDrv.getReverseAutomatic(), false);
    assertEqual(monBinDrv.getForwardControl(), false);
    assertEqual(monBinDrv.getReverseControl(), false);
    assertEqual(monBinDrv.getForwardFeedbackSource(), false);
    assertEqual(monBinDrv.getReverseFeedbackSource(), false);
    assertEqual(monBinDrv.getForwardFeedbackSignal(), false);
    assertEqual(monBinDrv.getReverseFeedbackSignal(), false);
    assertEqual(monBinDrv.getDriveSafetyIndicator(), false);
    assertEqual(monBinDrv.getResetOperator(), false);
    assertEqual(monBinDrv.getResetAutomatic(), false);
    assertTrue(monBinDrv.getWqc() != nullptr);
    assertTrue(monBinDrv.getOsLevel() != nullptr);
    assertTrue(monBinDrv.getState() != nullptr);
    assertTrue(monBinDrv.getMonitor() != nullptr);
    assertTrue(monBinDrv.getSecurity() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingSafePos);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingSafePosAct);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingFwdEn);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingRevEn);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingStopOp);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingFwdOp);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingRevOp);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingStopAut);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingFwdAut);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingRevAut);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingFwdCtrl);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingRevCtrl);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingFwdFbkCalc);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingFwdFbk);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingRevFbkCalc);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingRevFbk);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingTrip);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingResetOp);
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
      shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExistsInvalidMissingResetAut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingResetAut + ".ResetAut"));
    }

    return 0;
  }


  public int testSafetyPositionChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setSafetyPositionChangedCB, monBinDrv, MonBinDrv::safetyPositionChanged);

    dpSetWait(_DpExists + ".SafePos", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getSafetyPosition(), true);
    assertEqual(_eventSafetyPosition, true);
    return 0;
  }

  public int testSafetyPositionActiveChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setSafetyPositionActiveChangedCB, monBinDrv, MonBinDrv::safetyPositionActiveChanged);

    dpSetWait(_DpExists + ".SafePosAct", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getSafetyPositionActive(), true);
    assertEqual(_eventSafetyPositionActive, true);
    return 0;
  }

  public int testForwardAutomaticChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setForwardAutomaticChangedCB, monBinDrv, MonBinDrv::forwardAutomaticChanged);

    dpSetWait(_DpExists + ".FwdAut", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getForwardAutomatic(), true);
    assertEqual(_eventForwardAutomatic, true);
    return 0;
  }

  public int testReverseAutomaticChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setReverseAutomaticChangedCB, monBinDrv, MonBinDrv::reverseAutomaticChanged);

    dpSetWait(_DpExists + ".RevAut", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getReverseAutomatic(), true);
    assertEqual(_eventReverseAutomatic, true);
    return 0;
  }

  public int testStopAutomaticChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setStopAutomaticChangedCB, monBinDrv, MonBinDrv::stopAutomaticChanged);

    dpSetWait(_DpExists + ".StopAut", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getStopAutomatic(), true);
    assertEqual(_eventStopAutomatic, true);
    return 0;
  }

  public int testForwardControlChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setForwardControlChangedCB, monBinDrv, MonBinDrv::forwardControlChanged);

    dpSetWait(_DpExists + ".FwdCtrl", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getForwardControl(), true);
    assertEqual(_eventForwardControl, true);
    return 0;
  }

  public int testReverseControlChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setReverseControlChangedCB, monBinDrv, MonBinDrv::reverseControlChanged);

    dpSetWait(_DpExists + ".RevCtrl", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getReverseControl(), true);
    assertEqual(_eventReverseControl, true);
    return 0;
  }

  public int testDriveSafetyIndicatorChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setDriveSafetyIndicatorChangedCB, monBinDrv, MonBinDrv::driveSafetyIndicatorChanged);

    dpSetWait(_DpExists + ".Trip", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getDriveSafetyIndicator(), true);
    assertEqual(_eventDriveSafetyIndicator, true);
    return 0;
  }

  public int testResetAutomaticChanged()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);
    classConnect(this, setResetAutomaticChangedCB, monBinDrv, MonBinDrv::resetAutomaticChanged);

    dpSetWait(_DpExists + ".ResetAut", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinDrv.getResetAutomatic(), true);
    assertEqual(_eventResetAutomatic, true);
    return 0;
  }

  public int testSetForwardOperator()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);

    monBinDrv.setForwardOperator(true);

    bool dpValue;
    dpGet(_DpExists + ".FwdOp", dpValue);
    assertEqual(dpValue, true, "Data point FwdOp should be set to true");
    assertEqual(monBinDrv.getForwardOperator(), true, "ForwardOperator should be set to true");

    return 0;
  }

  public int testSetReverseOperator()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);

    monBinDrv.setReverseOperator(true);

    bool dpValue;
    dpGet(_DpExists + ".RevOp", dpValue);
    assertEqual(dpValue, true, "Data point RevOp should be set to true");
    assertEqual(monBinDrv.getReverseOperator(), true, "ReverseOperator should be set to true");

    return 0;
  }

  public int testSetStopOperator()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);

    monBinDrv.setStopOperator(true);

    bool dpValue;
    dpGet(_DpExists + ".StopOp", dpValue);
    assertEqual(dpValue, true, "Data point StopOp should be set to true");
    assertEqual(monBinDrv.getStopOperator(), true, "StopOperator should be set to true");

    return 0;
  }

  public int testSetResetOperator()
  {
    shared_ptr<MonBinDrv> monBinDrv = new MonBinDrv(_DpExists);

    monBinDrv.setResetOperator(true);

    bool dpValue;
    dpGet(_DpExists + ".ResetOp", dpValue);
    assertEqual(dpValue, true, "Data point ResetOp should be set to true");
    assertEqual(monBinDrv.getResetOperator(), true, "ResetOperator should be set to true");

    return 0;
  }

  private void setForwardCheckbackSignalChangedCB(const bool &forwardCheckbackSignal)
  {
    _eventForwardCheckbackSignal = forwardCheckbackSignal;
  }

  private void setReverseCheckbackSignalChangedCB(const bool &reverseCheckbackSignal)
  {
    _eventReverseCheckbackSignal = reverseCheckbackSignal;
  }

  private void setSafetyPositionChangedCB(const bool &safetyPosition)
  {
    _eventSafetyPosition = safetyPosition;
  }

  private void setSafetyPositionActiveChangedCB(const bool &safetyPositionActive)
  {
    _eventSafetyPositionActive = safetyPositionActive;
  }

  private void setForwardEnableChangedCB(const bool &forwardEnable)
  {
    _eventForwardEnable = forwardEnable;
  }

  private void setReverseEnableChangedCB(const bool &reverseEnable)
  {
    _eventReverseEnable = reverseEnable;
  }

  private void setForwardAutomaticChangedCB(const bool &forwardAutomatic)
  {
    _eventForwardAutomatic = forwardAutomatic;
  }

  private void setReverseAutomaticChangedCB(const bool &reverseAutomatic)
  {
    _eventReverseAutomatic = reverseAutomatic;
  }

  private void setStopAutomaticChangedCB(const bool &stopAutomatic)
  {
    _eventStopAutomatic = stopAutomatic;
  }

  private void setForwardControlChangedCB(const bool &forwardControl)
  {
    _eventForwardControl = forwardControl;
  }

  private void setReverseControlChangedCB(const bool &reverseControl)
  {
    _eventReverseControl = reverseControl;
  }

  private void setDriveSafetyIndicatorChangedCB(const bool &driveSafetyIndicator)
  {
    _eventDriveSafetyIndicator = driveSafetyIndicator;
  }

  private void setResetAutomaticChangedCB(const bool &resetAutomatic)
  {
    _eventResetAutomatic = resetAutomatic;
  }
};

//-----------------------------------------------------------------------------
// Main

void main()
{
  TstMonBinDrv test;
  test.startAll();
}
