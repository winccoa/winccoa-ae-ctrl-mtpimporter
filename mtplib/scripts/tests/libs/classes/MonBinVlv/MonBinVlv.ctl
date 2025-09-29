// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MonBinVlv/MonBinVlv.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MonBinVlv/MonBinVlv.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MonBinVlv/MonBinVlv" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MonBinVlv.ctl
*/
class TstMonBinVlv : OaTest
{
  private const string _Dpt = "MonBinVlv";
  private const string _DptInvalidMissingSafePos = "MonBinVlvInvalid1";
  private const string _DptInvalidMissingSafePosEn = "MonBinVlvInvalid2";
  private const string _DptInvalidMissingSafePosAct = "MonBinVlvInvalid3";
  private const string _DptInvalidMissingOpenOp = "MonBinVlvInvalid4";
  private const string _DptInvalidMissingCloseOp = "MonBinVlvInvalid5";
  private const string _DptInvalidMissingOpenAut = "MonBinVlvInvalid6";
  private const string _DptInvalidMissingCloseAut = "MonBinVlvInvalid7";
  private const string _DptInvalidMissingCtrl = "MonBinVlvInvalid8";
  private const string _DptInvalidMissingOpenFbkCalc = "MonBinVlvInvalid9";
  private const string _DptInvalidMissingOpenFbk = "MonBinVlvInvalid10";
  private const string _DptInvalidMissingCloseFbkCalc = "MonBinVlvInvalid11";
  private const string _DptInvalidMissingCloseFbk = "MonBinVlvInvalid12";
  private const string _DptInvalidMissingResetOp = "MonBinVlvInvalid13";
  private const string _DptInvalidMissingResetAut = "MonBinVlvInvalid14";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingSafePos = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingSafePosEn = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingSafePosAct = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingOpenOp = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingCloseOp = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingOpenAut = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingCloseAut = "ExistingTestDatapointInvalid7";
  private const string _DpExistsInvalidMissingCtrl = "ExistingTestDatapointInvalid8";
  private const string _DpExistsInvalidMissingOpenFbkCalc = "ExistingTestDatapointInvalid9";
  private const string _DpExistsInvalidMissingOpenFbk = "ExistingTestDatapointInvalid10";
  private const string _DpExistsInvalidMissingCloseFbkCalc = "ExistingTestDatapointInvalid11";
  private const string _DpExistsInvalidMissingCloseFbk = "ExistingTestDatapointInvalid12";
  private const string _DpExistsInvalidMissingResetOp = "ExistingTestDatapointInvalid13";
  private const string _DpExistsInvalidMissingResetAut = "ExistingTestDatapointInvalid14";

  private bool _eventOpenCheckbackSignal;
  private bool _eventCloseCheckbackSignal;
  private bool _eventSafetyPosition;
  private bool _eventSafetyPositionActive;
  private bool _eventSafetyPositionEnabled;
  private bool _eventOpenAutomatic;
  private bool _eventCloseAutomatic;
  private bool _eventValveControl;
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
                            makeDynString("", "SafePosEn"), makeDynString("", "SafePosAct"),
                            makeDynString("", "OpenOp"), makeDynString("", "CloseOp"),
                            makeDynString("", "OpenAut"), makeDynString("", "CloseAut"),
                            makeDynString("", "Ctrl"), makeDynString("", "OpenFbkCalc"),
                            makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
                            makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
                            makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
                            makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSafePos, _DptInvalidMissingSafePos);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSafePosEn),
             makeDynString("", "SafePos"), makeDynString("", "SafePosAct"),
             makeDynString("", "OpenOp"), makeDynString("", "CloseOp"),
             makeDynString("", "OpenAut"), makeDynString("", "CloseAut"),
             makeDynString("", "Ctrl"), makeDynString("", "OpenFbkCalc"),
             makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSafePosEn, _DptInvalidMissingSafePosEn);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSafePosAct),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "OpenOp"), makeDynString("", "CloseOp"),
             makeDynString("", "OpenAut"), makeDynString("", "CloseAut"),
             makeDynString("", "Ctrl"), makeDynString("", "OpenFbkCalc"),
             makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSafePosAct, _DptInvalidMissingSafePosAct);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingOpenOp),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "CloseOp"),
             makeDynString("", "OpenAut"), makeDynString("", "CloseAut"),
             makeDynString("", "Ctrl"), makeDynString("", "OpenFbkCalc"),
             makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingOpenOp, _DptInvalidMissingOpenOp);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCloseOp),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "OpenAut"), makeDynString("", "CloseAut"),
             makeDynString("", "Ctrl"), makeDynString("", "OpenFbkCalc"),
             makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCloseOp, _DptInvalidMissingCloseOp);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingOpenAut),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "CloseAut"),
             makeDynString("", "Ctrl"), makeDynString("", "OpenFbkCalc"),
             makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingOpenAut, _DptInvalidMissingOpenAut);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCloseAut),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "OpenAut"),
             makeDynString("", "Ctrl"), makeDynString("", "OpenFbkCalc"),
             makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCloseAut, _DptInvalidMissingCloseAut);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCtrl),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "OpenAut"),
             makeDynString("", "CloseAut"), makeDynString("", "OpenFbkCalc"),
             makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCtrl, _DptInvalidMissingCtrl);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingOpenFbkCalc),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "OpenAut"),
             makeDynString("", "CloseAut"), makeDynString("", "Ctrl"),
             makeDynString("", "OpenFbk"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingOpenFbkCalc, _DptInvalidMissingOpenFbkCalc);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingOpenFbk),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "OpenAut"),
             makeDynString("", "CloseAut"), makeDynString("", "Ctrl"),
             makeDynString("", "OpenFbkCalc"), makeDynString("", "CloseFbkCalc"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingOpenFbk, _DptInvalidMissingOpenFbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCloseFbkCalc),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "OpenAut"),
             makeDynString("", "CloseAut"), makeDynString("", "Ctrl"),
             makeDynString("", "OpenFbkCalc"), makeDynString("", "OpenFbk"),
             makeDynString("", "CloseFbk"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCloseFbkCalc, _DptInvalidMissingCloseFbkCalc);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingCloseFbk),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "OpenAut"),
             makeDynString("", "CloseAut"), makeDynString("", "Ctrl"),
             makeDynString("", "OpenFbkCalc"), makeDynString("", "OpenFbk"),
             makeDynString("", "CloseFbkCalc"), makeDynString("", "ResetOp"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCloseFbk, _DptInvalidMissingCloseFbk);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingResetOp),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "OpenAut"),
             makeDynString("", "CloseAut"), makeDynString("", "Ctrl"),
             makeDynString("", "OpenFbkCalc"), makeDynString("", "OpenFbk"),
             makeDynString("", "CloseFbkCalc"), makeDynString("", "CloseFbk"),
             makeDynString("", "ResetAut"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingResetOp, _DptInvalidMissingResetOp);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingResetAut),
             makeDynString("", "SafePos"), makeDynString("", "SafePosEn"),
             makeDynString("", "SafePosAct"), makeDynString("", "OpenOp"),
             makeDynString("", "CloseOp"), makeDynString("", "OpenAut"),
             makeDynString("", "CloseAut"), makeDynString("", "Ctrl"),
             makeDynString("", "OpenFbkCalc"), makeDynString("", "OpenFbk"),
             makeDynString("", "CloseFbkCalc"), makeDynString("", "CloseFbk"),
             makeDynString("", "ResetOp"), makeDynString("", "WQC"),
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
             makeDynString("", "MonDynTi"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingResetAut, _DptInvalidMissingResetAut);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingSafePos);
    dpTypeDelete(_DptInvalidMissingSafePos);

    dpDelete(_DpExistsInvalidMissingSafePosEn);
    dpTypeDelete(_DptInvalidMissingSafePosEn);

    dpDelete(_DpExistsInvalidMissingSafePosAct);
    dpTypeDelete(_DptInvalidMissingSafePosAct);

    dpDelete(_DpExistsInvalidMissingOpenOp);
    dpTypeDelete(_DptInvalidMissingOpenOp);

    dpDelete(_DpExistsInvalidMissingCloseOp);
    dpTypeDelete(_DptInvalidMissingCloseOp);

    dpDelete(_DpExistsInvalidMissingOpenAut);
    dpTypeDelete(_DptInvalidMissingOpenAut);

    dpDelete(_DpExistsInvalidMissingCloseAut);
    dpTypeDelete(_DptInvalidMissingCloseAut);

    dpDelete(_DpExistsInvalidMissingCtrl);
    dpTypeDelete(_DptInvalidMissingCtrl);

    dpDelete(_DpExistsInvalidMissingOpenFbkCalc);
    dpTypeDelete(_DptInvalidMissingOpenFbkCalc);

    dpDelete(_DpExistsInvalidMissingOpenFbk);
    dpTypeDelete(_DptInvalidMissingOpenFbk);

    dpDelete(_DpExistsInvalidMissingCloseFbkCalc);
    dpTypeDelete(_DptInvalidMissingCloseFbkCalc);

    dpDelete(_DpExistsInvalidMissingCloseFbk);
    dpTypeDelete(_DptInvalidMissingCloseFbk);

    dpDelete(_DpExistsInvalidMissingResetOp);
    dpTypeDelete(_DptInvalidMissingResetOp);

    dpDelete(_DpExistsInvalidMissingResetAut);
    dpTypeDelete(_DptInvalidMissingResetAut);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    assertEqual(monBinVlv.getDp(), _DpExists);
    assertEqual(monBinVlv.getSafetyPosition(), false);
    assertEqual(monBinVlv.getSafetyPositionActive(), false);
    assertEqual(monBinVlv.getSafetyPositionEnabled(), false);
    assertEqual(monBinVlv.getOpenOperator(), false);
    assertEqual(monBinVlv.getCloseOperator(), false);
    assertEqual(monBinVlv.getOpenAutomatic(), false);
    assertEqual(monBinVlv.getCloseAutomatic(), false);
    assertEqual(monBinVlv.getValveControl(), false);
    assertEqual(monBinVlv.getOpenFeedbackSource(), false);
    assertEqual(monBinVlv.getOpenCheckbackSignal(), false);
    assertEqual(monBinVlv.getCloseFeedbackSource(), false);
    assertEqual(monBinVlv.getCloseCheckbackSignal(), false);
    assertEqual(monBinVlv.getResetOperator(), false);
    assertEqual(monBinVlv.getResetAutomatic(), false);
    assertTrue(monBinVlv.getWqc() != nullptr);
    assertTrue(monBinVlv.getOsLevel() != nullptr);
    assertTrue(monBinVlv.getState() != nullptr);
    assertTrue(monBinVlv.getMonitor() != nullptr);
    assertTrue(monBinVlv.getSecurity() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingSafePos);
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
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingSafePosEn);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSafePosEn + ".SafePosEn"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingSafePosAct);
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
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingOpenOp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingOpenOp + ".OpenOp"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingCloseOp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCloseOp + ".CloseOp"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingOpenAut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingOpenAut + ".OpenAut"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingCloseAut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCloseAut + ".CloseAut"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingCtrl);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCtrl + ".Ctrl"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingOpenFbkCalc);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingOpenFbkCalc + ".OpenFbkCalc"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingOpenFbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingOpenFbk + ".OpenFbk"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingCloseFbkCalc);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCloseFbkCalc + ".CloseFbkCalc"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingCloseFbk);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCloseFbk + ".CloseFbk"));
    }

    try
    {
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingResetOp);
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
      shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExistsInvalidMissingResetAut);
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

  public int testOpenCheckbackSignalChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setOpenCheckbackSignalChangedCB, monBinVlv, MonBinVlv::openCheckbackSignalChanged);

    dpSetWait(_DpExists + ".OpenFbk", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getOpenCheckbackSignal(), true);
    assertEqual(_eventOpenCheckbackSignal, true);
    return 0;
  }

  public int testCloseCheckbackSignalChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setCloseCheckbackSignalChangedCB, monBinVlv, MonBinVlv::closeCheckbackSignalChanged);

    dpSetWait(_DpExists + ".CloseFbk", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getCloseCheckbackSignal(), true);
    assertEqual(_eventCloseCheckbackSignal, true);
    return 0;
  }

  public int testSafetyPositionChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setSafetyPositionChangedCB, monBinVlv, MonBinVlv::safetyPositionChanged);

    dpSetWait(_DpExists + ".SafePos", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getSafetyPosition(), true);
    assertEqual(_eventSafetyPosition, true);
    return 0;
  }

  public int testSafetyPositionActiveChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setSafetyPositionActiveChangedCB, monBinVlv, MonBinVlv::safetyPositionActiveChanged);

    dpSetWait(_DpExists + ".SafePosAct", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getSafetyPositionActive(), true);
    assertEqual(_eventSafetyPositionActive, true);
    return 0;
  }

  public int testSafetyPositionEnabledChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setSafetyPositionEnabledChangedCB, monBinVlv, MonBinVlv::safetyPositionEnabledChanged);

    dpSetWait(_DpExists + ".SafePosEn", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getSafetyPositionEnabled(), true);
    assertEqual(_eventSafetyPositionEnabled, true);
    return 0;
  }

  public int testOpenAutomaticChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setOpenAutomaticChangedCB, monBinVlv, MonBinVlv::openAutomaticChanged);

    dpSetWait(_DpExists + ".OpenAut", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getOpenAutomatic(), true);
    assertEqual(_eventOpenAutomatic, true);
    return 0;
  }

  public int testCloseAutomaticChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setCloseAutomaticChangedCB, monBinVlv, MonBinVlv::closeAutomaticChanged);

    dpSetWait(_DpExists + ".CloseAut", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getCloseAutomatic(), true);
    assertEqual(_eventCloseAutomatic, true);
    return 0;
  }

  public int testValveControlChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setValveControlChangedCB, monBinVlv, MonBinVlv::valveControlChanged);

    dpSetWait(_DpExists + ".Ctrl", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getValveControl(), true);
    assertEqual(_eventValveControl, true);
    return 0;
  }

  public int testResetAutomaticChanged()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);
    classConnect(this, setResetAutomaticChangedCB, monBinVlv, MonBinVlv::resetAutomaticChanged);

    dpSetWait(_DpExists + ".ResetAut", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(monBinVlv.getResetAutomatic(), true);
    assertEqual(_eventResetAutomatic, true);
    return 0;
  }

  public int testSetOpenOperator()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);

    monBinVlv.setOpenOperator(true);

    bool dpValue;
    dpGet(_DpExists + ".OpenOp", dpValue);
    assertEqual(dpValue, true, "Data point OpenOp should be set to true");
    assertEqual(monBinVlv.getOpenOperator(), true, "OpenOperator should be set to true");

    return 0;
  }

  public int testSetCloseOperator()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);

    monBinVlv.setCloseOperator(true);

    bool dpValue;
    dpGet(_DpExists + ".CloseOp", dpValue);
    assertEqual(dpValue, true, "Data point CloseOp should be set to true");
    assertEqual(monBinVlv.getCloseOperator(), true, "CloseOperator should be set to true");

    return 0;
  }

  public int testSetResetOperator()
  {
    shared_ptr<MonBinVlv> monBinVlv = new MonBinVlv(_DpExists);

    monBinVlv.setResetOperator(true);

    bool dpValue;
    dpGet(_DpExists + ".ResetOp", dpValue);
    assertEqual(dpValue, true, "Data point ResetOp should be set to true");
    assertEqual(monBinVlv.getResetOperator(), true, "ResetOperator should be set to true");

    return 0;
  }

  private void setOpenCheckbackSignalChangedCB(const bool &openCheckbackSignal)
  {
    _eventOpenCheckbackSignal = openCheckbackSignal;
  }

  private void setCloseCheckbackSignalChangedCB(const bool &closeCheckbackSignal)
  {
    _eventCloseCheckbackSignal = closeCheckbackSignal;
  }

  private void setSafetyPositionChangedCB(const bool &safetyPosition)
  {
    _eventSafetyPosition = safetyPosition;
  }

  private void setSafetyPositionActiveChangedCB(const bool &safetyPositionActive)
  {
    _eventSafetyPositionActive = safetyPositionActive;
  }

  private void setSafetyPositionEnabledChangedCB(const bool &safetyPositionEnabled)
  {
    _eventSafetyPositionEnabled = safetyPositionEnabled;
  }

  private void setOpenAutomaticChangedCB(const bool &openAutomatic)
  {
    _eventOpenAutomatic = openAutomatic;
  }

  private void setCloseAutomaticChangedCB(const bool &closeAutomatic)
  {
    _eventCloseAutomatic = closeAutomatic;
  }

  private void setValveControlChangedCB(const bool &valveControl)
  {
    _eventValveControl = valveControl;
  }

  private void setResetAutomaticChangedCB(const bool &resetAutomatic)
  {
    _eventResetAutomatic = resetAutomatic;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMonBinVlv test;
  test.startAll();
}
