// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/PIDCtrl/PIDCtrl.ctl.

   @file $relPath
   @test Unit tests for the library: scripts/libs/classes/PIDCtrl/PIDCtrl.ctl
   @copyright $copyright
   @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/PIDCtrl/PIDCtrl"           // tested object
#uses "classes/oaTest/OaTest"             // oaTest basic class
#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/MtpSource/MtpSource"
#uses "classes/MtpState/MtpState"
#uses "classes/MtpUnit/MtpUnit"

class TstPIDCtrl : OaTest
{
  // Valid datapoints
  private const string _Dpt = "PIDCtrl";

  // Invalid datapoints
  private const string _DptInvalidMissingPV = "PIDCtrlInvalid1";
  private const string _DptInvalidMissingPVSclMin = "PIDCtrlInvalid2";
  private const string _DptInvalidMissingPVSclMax = "PIDCtrlInvalid3";
  private const string _DptInvalidMissingSPMan = "PIDCtrlInvalid4";
  private const string _DptInvalidMissingSPInt = "PIDCtrlInvalid5";
  private const string _DptInvalidMissingSPSclMin = "PIDCtrlInvalid6";
  private const string _DptInvalidMissingSPSclMax = "PIDCtrlInvalid7";
  private const string _DptInvalidMissingSPIntMin = "PIDCtrlInvalid8";
  private const string _DptInvalidMissingSPIntMax = "PIDCtrlInvalid9";
  private const string _DptInvalidMissingSPManMin = "PIDCtrlInvalid10";
  private const string _DptInvalidMissingSPManMax = "PIDCtrlInvalid11";
  private const string _DptInvalidMissingSP = "PIDCtrlInvalid12";
  private const string _DptInvalidMissingMVMan = "PIDCtrlInvalid13";
  private const string _DptInvalidMissingMV = "PIDCtrlInvalid14";
  private const string _DptInvalidMissingMVMin = "PIDCtrlInvalid15";
  private const string _DptInvalidMissingMVMax = "PIDCtrlInvalid16";
  private const string _DptInvalidMissingMVSclMin = "PIDCtrlInvalid17";
  private const string _DptInvalidMissingMVSclMax = "PIDCtrlInvalid18";
  private const string _DptInvalidMissingP = "PIDCtrlInvalid19";
  private const string _DptInvalidMissingTi = "PIDCtrlInvalid20";
  private const string _DptInvalidMissingTd = "PIDCtrlInvalid21";

  // Existing datapoints
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingPV = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingPVSclMin = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingPVSclMax = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingSPMan = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingSPInt = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingSPSclMin = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingSPSclMax = "ExistingTestDatapointInvalid7";
  private const string _DpExistsInvalidMissingSPIntMin = "ExistingTestDatapointInvalid8";
  private const string _DpExistsInvalidMissingSPIntMax = "ExistingTestDatapointInvalid9";
  private const string _DpExistsInvalidMissingSPManMin = "ExistingTestDatapointInvalid10";
  private const string _DpExistsInvalidMissingSPManMax = "ExistingTestDatapointInvalid11";
  private const string _DpExistsInvalidMissingSP = "ExistingTestDatapointInvalid12";
  private const string _DpExistsInvalidMissingMVMan = "ExistingTestDatapointInvalid13";
  private const string _DpExistsInvalidMissingMV = "ExistingTestDatapointInvalid14";
  private const string _DpExistsInvalidMissingMVMin = "ExistingTestDatapointInvalid15";
  private const string _DpExistsInvalidMissingMVMax = "ExistingTestDatapointInvalid16";
  private const string _DpExistsInvalidMissingMVSclMin = "ExistingTestDatapointInvalid17";
  private const string _DpExistsInvalidMissingMVSclMax = "ExistingTestDatapointInvalid18";
  private const string _DpExistsInvalidMissingP = "ExistingTestDatapointInvalid19";
  private const string _DpExistsInvalidMissingTi = "ExistingTestDatapointInvalid20";
  private const string _DpExistsInvalidMissingTd = "ExistingTestDatapointInvalid21";

  // Event variables
  private float _eventProcessValue;
  private float _eventSetpointManual;
  private float _eventSetpointInternal;
  private float _eventSetpoint;
  private float _eventManipulatedValueManual;
  private float _eventManipulatedValue;
  private float _eventManipulatedValueMin;
  private float _eventManipulatedValueMax;
  private float _eventProcessValueScaleMin;
  private float _eventProcessValueScaleMax;
  private float _eventSetpointScaleMin;
  private float _eventSetpointScaleMax;
  private float _eventSetpointInternalMin;
  private float _eventSetpointInternalMax;
  private float _eventSetpointManualMin;
  private float _eventSetpointManualMax;
  private float _eventProportionalParameter;
  private float _eventIntegrationParameter;
  private float _eventDerivationParameter;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      DebugN("Data point type", _Dpt, "does not exist");
      return -1;
    }


    dpCreate(_DpExists, _Dpt);

    // Create data point types for invalid cases
    dyn_dyn_string dpes;
    dyn_dyn_int values;

    // _DptInvalidMissingPV
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingPV),
             makeDynString("", "PVSclMin"), makeDynString("", "PVSclMax"),
             makeDynString("", "SPMan"), makeDynString("", "SPInt"),
             makeDynString("", "SPSclMin"), makeDynString("", "SPSclMax"),
             makeDynString("", "SPIntMin"), makeDynString("", "SPIntMax"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingPV, _DptInvalidMissingPV);
    DebugN("Created data point type", _DptInvalidMissingPV, "with elements:", dpTypeGet(_DptInvalidMissingPV));

    // _DptInvalidMissingPVSclMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingPVSclMin),
             makeDynString("", "PV"), makeDynString("", "PVSclMax"),
             makeDynString("", "SPMan"), makeDynString("", "SPInt"),
             makeDynString("", "SPSclMin"), makeDynString("", "SPSclMax"),
             makeDynString("", "SPIntMin"), makeDynString("", "SPIntMax"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingPVSclMin, _DptInvalidMissingPVSclMin);
    DebugN("Created data point type", _DptInvalidMissingPVSclMin, "with elements:", dpTypeGet(_DptInvalidMissingPVSclMin));

    // _DptInvalidMissingPVSclMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingPVSclMax),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "SPMan"), makeDynString("", "SPInt"),
             makeDynString("", "SPSclMin"), makeDynString("", "SPSclMax"),
             makeDynString("", "SPIntMin"), makeDynString("", "SPIntMax"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingPVSclMax, _DptInvalidMissingPVSclMax);
    DebugN("Created data point type", _DptInvalidMissingPVSclMax, "with elements:", dpTypeGet(_DptInvalidMissingPVSclMax));

    // _DptInvalidMissingSPMan
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSPMan),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPInt"),
             makeDynString("", "SPSclMin"), makeDynString("", "SPSclMax"),
             makeDynString("", "SPIntMin"), makeDynString("", "SPIntMax"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSPMan, _DptInvalidMissingSPMan);
    DebugN("Created data point type", _DptInvalidMissingSPMan, "with elements:", dpTypeGet(_DptInvalidMissingSPMan));

    // _DptInvalidMissingSPInt
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSPInt),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPSclMin"), makeDynString("", "SPSclMax"),
             makeDynString("", "SPIntMin"), makeDynString("", "SPIntMax"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSPInt, _DptInvalidMissingSPInt);
    DebugN("Created data point type", _DptInvalidMissingSPInt, "with elements:", dpTypeGet(_DptInvalidMissingSPInt));

    // _DptInvalidMissingSPSclMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSPSclMin),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMax"),
             makeDynString("", "SPIntMin"), makeDynString("", "SPIntMax"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSPSclMin, _DptInvalidMissingSPSclMin);
    DebugN("Created data point type", _DptInvalidMissingSPSclMin, "with elements:", dpTypeGet(_DptInvalidMissingSPSclMin));

    // _DptInvalidMissingSPSclMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSPSclMax),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPIntMin"), makeDynString("", "SPIntMax"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSPSclMax, _DptInvalidMissingSPSclMax);
    DebugN("Created data point type", _DptInvalidMissingSPSclMax, "with elements:", dpTypeGet(_DptInvalidMissingSPSclMax));

    // _DptInvalidMissingSPIntMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSPIntMin),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMax"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSPIntMin, _DptInvalidMissingSPIntMin);
    DebugN("Created data point type", _DptInvalidMissingSPIntMin, "with elements:", dpTypeGet(_DptInvalidMissingSPIntMin));

    // _DptInvalidMissingSPIntMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSPIntMax),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPManMin"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSPIntMax, _DptInvalidMissingSPIntMax);
    DebugN("Created data point type", _DptInvalidMissingSPIntMax, "with elements:", dpTypeGet(_DptInvalidMissingSPIntMax));

    // _DptInvalidMissingSPManMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSPManMin),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMax"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSPManMin, _DptInvalidMissingSPManMin);
    DebugN("Created data point type", _DptInvalidMissingSPManMin, "with elements:", dpTypeGet(_DptInvalidMissingSPManMin));

    // _DptInvalidMissingSPManMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSPManMax),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SP"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSPManMax, _DptInvalidMissingSPManMax);
    DebugN("Created data point type", _DptInvalidMissingSPManMax, "with elements:", dpTypeGet(_DptInvalidMissingSPManMax));

    // _DptInvalidMissingSP
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingSP),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "MVMan"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingSP, _DptInvalidMissingSP);
    DebugN("Created data point type", _DptInvalidMissingSP, "with elements:", dpTypeGet(_DptInvalidMissingSP));

    // _DptInvalidMissingMVMan
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingMVMan),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MV"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingMVMan, _DptInvalidMissingMVMan);
    DebugN("Created data point type", _DptInvalidMissingMVMan, "with elements:", dpTypeGet(_DptInvalidMissingMVMan));

    // _DptInvalidMissingMV
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingMV),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MVMan"), makeDynString("", "MVMin"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingMV, _DptInvalidMissingMV);
    DebugN("Created data point type", _DptInvalidMissingMV, "with elements:", dpTypeGet(_DptInvalidMissingMV));

    // _DptInvalidMissingMVMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingMVMin),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MVMan"), makeDynString("", "MV"),
             makeDynString("", "MVMax"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingMVMin, _DptInvalidMissingMVMin);
    DebugN("Created data point type", _DptInvalidMissingMVMin, "with elements:", dpTypeGet(_DptInvalidMissingMVMin));

    // _DptInvalidMissingMVMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingMVMax),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MVMan"), makeDynString("", "MV"),
             makeDynString("", "MVMin"), makeDynString("", "MVSclMin"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingMVMax, _DptInvalidMissingMVMax);
    DebugN("Created data point type", _DptInvalidMissingMVMax, "with elements:", dpTypeGet(_DptInvalidMissingMVMax));

    // _DptInvalidMissingMVSclMin
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingMVSclMin),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MVMan"), makeDynString("", "MV"),
             makeDynString("", "MVMin"), makeDynString("", "MVMax"),
             makeDynString("", "MVSclMax"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingMVSclMin, _DptInvalidMissingMVSclMin);
    DebugN("Created data point type", _DptInvalidMissingMVSclMin, "with elements:", dpTypeGet(_DptInvalidMissingMVSclMin));

    // _DptInvalidMissingMVSclMax
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingMVSclMax),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MVMan"), makeDynString("", "MV"),
             makeDynString("", "MVMin"), makeDynString("", "MVMax"),
             makeDynString("", "MVSclMin"), makeDynString("", "P"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingMVSclMax, _DptInvalidMissingMVSclMax);
    DebugN("Created data point type", _DptInvalidMissingMVSclMax, "with elements:", dpTypeGet(_DptInvalidMissingMVSclMax));

    // _DptInvalidMissingP
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingP),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MVMan"), makeDynString("", "MV"),
             makeDynString("", "MVMin"), makeDynString("", "MVMax"),
             makeDynString("", "MVSclMin"), makeDynString("", "MVSclMax"),
             makeDynString("", "Ti"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingP, _DptInvalidMissingP);
    DebugN("Created data point type", _DptInvalidMissingP, "with elements:", dpTypeGet(_DptInvalidMissingP));

    // _DptInvalidMissingTi
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingTi),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MVMan"), makeDynString("", "MV"),
             makeDynString("", "MVMin"), makeDynString("", "MVMax"),
             makeDynString("", "MVSclMin"), makeDynString("", "MVSclMax"),
             makeDynString("", "P"), makeDynString("", "Td"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingTi, _DptInvalidMissingTi);
    DebugN("Created data point type", _DptInvalidMissingTi, "with elements:", dpTypeGet(_DptInvalidMissingTi));

    // _DptInvalidMissingTd
    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingTd),
             makeDynString("", "PV"), makeDynString("", "PVSclMin"),
             makeDynString("", "PVSclMax"), makeDynString("", "SPMan"),
             makeDynString("", "SPInt"), makeDynString("", "SPSclMin"),
             makeDynString("", "SPSclMax"), makeDynString("", "SPIntMin"),
             makeDynString("", "SPIntMax"), makeDynString("", "SPManMin"),
             makeDynString("", "SPManMax"), makeDynString("", "SP"),
             makeDynString("", "MVMan"), makeDynString("", "MV"),
             makeDynString("", "MVMin"), makeDynString("", "MVMax"),
             makeDynString("", "MVSclMin"), makeDynString("", "MVSclMax"),
             makeDynString("", "P"), makeDynString("", "Ti"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT),
               makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingTd, _DptInvalidMissingTd);
    DebugN("Created data point type", _DptInvalidMissingTd, "with elements:", dpTypeGet(_DptInvalidMissingTd));

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingPV);
    dpTypeDelete(_DptInvalidMissingPV);

    dpDelete(_DpExistsInvalidMissingPVSclMin);
    dpTypeDelete(_DptInvalidMissingPVSclMin);

    dpDelete(_DpExistsInvalidMissingPVSclMax);
    dpTypeDelete(_DptInvalidMissingPVSclMax);

    dpDelete(_DpExistsInvalidMissingSPMan);
    dpTypeDelete(_DptInvalidMissingSPMan);

    dpDelete(_DpExistsInvalidMissingSPInt);
    dpTypeDelete(_DptInvalidMissingSPInt);

    dpDelete(_DpExistsInvalidMissingSPSclMin);
    dpTypeDelete(_DptInvalidMissingSPSclMin);

    dpDelete(_DpExistsInvalidMissingSPSclMax);
    dpTypeDelete(_DptInvalidMissingSPSclMax);

    dpDelete(_DpExistsInvalidMissingSPIntMin);
    dpTypeDelete(_DptInvalidMissingSPIntMin);

    dpDelete(_DpExistsInvalidMissingSPIntMax);
    dpTypeDelete(_DptInvalidMissingSPIntMax);

    dpDelete(_DpExistsInvalidMissingSPManMin);
    dpTypeDelete(_DptInvalidMissingSPManMin);

    dpDelete(_DpExistsInvalidMissingSPManMax);
    dpTypeDelete(_DptInvalidMissingSPManMax);

    dpDelete(_DpExistsInvalidMissingSP);
    dpTypeDelete(_DptInvalidMissingSP);

    dpDelete(_DpExistsInvalidMissingMVMan);
    dpTypeDelete(_DptInvalidMissingMVMan);

    dpDelete(_DpExistsInvalidMissingMV);
    dpTypeDelete(_DptInvalidMissingMV);

    dpDelete(_DpExistsInvalidMissingMVMin);
    dpTypeDelete(_DptInvalidMissingMVMin);

    dpDelete(_DpExistsInvalidMissingMVMax);
    dpTypeDelete(_DptInvalidMissingMVMax);

    dpDelete(_DpExistsInvalidMissingMVSclMin);
    dpTypeDelete(_DptInvalidMissingMVSclMin);

    dpDelete(_DpExistsInvalidMissingMVSclMax);
    dpTypeDelete(_DptInvalidMissingMVSclMax);

    dpDelete(_DpExistsInvalidMissingP);
    dpTypeDelete(_DptInvalidMissingP);

    dpDelete(_DpExistsInvalidMissingTi);
    dpTypeDelete(_DptInvalidMissingTi);

    dpDelete(_DpExistsInvalidMissingTd);
    dpTypeDelete(_DptInvalidMissingTd);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    assertEqual(pidCtrl.getDp(), _DpExists);
    assertEqual(pidCtrl.getProcessValue(), 0.0);
    assertEqual(pidCtrl.getProcessValueScaleMin(), 0.0);
    assertEqual(pidCtrl.getProcessValueScaleMax(), 0.0);
    assertEqual(pidCtrl.getSetpointManual(), 0.0);
    assertEqual(pidCtrl.getSetpointInternal(), 0.0);
    assertEqual(pidCtrl.getSetpointScaleMin(), 0.0);
    assertEqual(pidCtrl.getSetpointScaleMax(), 0.0);
    assertEqual(pidCtrl.getSetpointInternalMin(), 0.0);
    assertEqual(pidCtrl.getSetpointInternalMax(), 0.0);
    assertEqual(pidCtrl.getSetpointManualMin(), 0.0);
    assertEqual(pidCtrl.getSetpointManualMax(), 0.0);
    assertEqual(pidCtrl.getSetpoint(), 0.0);
    assertEqual(pidCtrl.getManipulatedValueManual(), 0.0);
    assertEqual(pidCtrl.getManipulatedValue(), 0.0);
    assertEqual(pidCtrl.getManipulatedValueMin(), 0.0);
    assertEqual(pidCtrl.getManipulatedValueMax(), 0.0);
    assertEqual(pidCtrl.getManipulatedValueScaleMin(), 0.0);
    assertEqual(pidCtrl.getManipulatedValueScaleMax(), 0.0);
    assertEqual(pidCtrl.getProportionalParameter(), 0.0);
    assertEqual(pidCtrl.getIntegrationParameter(), 0.0);
    assertEqual(pidCtrl.getDerivationParameter(), 0.0);
    assertTrue(pidCtrl.getWqc() != nullptr);
    assertTrue(pidCtrl.getOsLevel() != nullptr);
    assertTrue(pidCtrl.getSource() != nullptr);
    assertTrue(pidCtrl.getState() != nullptr);
    assertTrue(pidCtrl.getProcessValueUnit() != nullptr);
    assertTrue(pidCtrl.getSetpointUnit() != nullptr);
    assertTrue(pidCtrl.getManipulatedValueUnit() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingPV);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingPV + ".PV"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingPVSclMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingPVSclMin + ".PVSclMin"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingPVSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingPVSclMax + ".PVSclMax"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSPMan);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSPMan + ".SPMan"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSPInt);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSPInt + ".SPInt"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSPSclMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSPSclMin + ".SPSclMin"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSPSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSPSclMax + ".SPSclMax"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSPIntMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSPIntMin + ".SPIntMin"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSPIntMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSPIntMax + ".SPIntMax"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSPManMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSPManMin + ".SPManMin"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSPManMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSPManMax + ".SPManMax"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingSP);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSP + ".SP"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingMVMan);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingMVMan + ".MVMan"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingMV);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingMV + ".MV"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingMVMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingMVMin + ".MVMin"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingMVMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingMVMax + ".MVMax"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingMVSclMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingMVSclMin + ".MVSclMin"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingMVSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingMVSclMax + ".MVSclMax"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingP);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingP + ".P"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingTi);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingTi + ".Ti"));
    }

    try
    {
      shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExistsInvalidMissingTd);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingTd + ".Td"));
    }

    return 0;

  }

  public int testProcessValueChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setProcessValueChangedCB, pidCtrl, PIDCtrl::processValueChanged);

    dpSetWait(_DpExists + ".PV", 42.5);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getProcessValue(), 42.5);
    assertEqual(_eventProcessValue, 42.5);
    return 0;

  }

  public int testSetpointInternalChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setSetpointInternalChangedCB, pidCtrl, PIDCtrl::setpointInternalChanged);

    dpSetWait(_DpExists + ".SPInt", 33.7);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointInternal(), 33.7);
    assertEqual(_eventSetpointInternal, 33.7);
    return 0;

  }

  public int testSetpointChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setSetpointChangedCB, pidCtrl, PIDCtrl::setpointChanged);

    dpSetWait(_DpExists + ".SP", 50.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getSetpoint(), 50.0);
    assertEqual(_eventSetpoint, 50.0);
    return 0;

  }

  public int testManipulatedValueChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setManipulatedValueChangedCB, pidCtrl, PIDCtrl::manipulatedValueChanged);

    dpSetWait(_DpExists + ".MV", 75.2);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getManipulatedValue(), 75.2);
    assertEqual(_eventManipulatedValue, 75.2);
    return 0;

  }

  public int testManipulatedValueMinChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setManipulatedValueMinChangedCB, pidCtrl, PIDCtrl::manipulatedValueMinChanged);

    dpSetWait(_DpExists + ".MVMin", -50.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getManipulatedValueMin(), -50.0);
    assertEqual(_eventManipulatedValueMin, -50.0);
    return 0;

  }

  public int testManipulatedValueMaxChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setManipulatedValueMaxChangedCB, pidCtrl, PIDCtrl::manipulatedValueMaxChanged);

    dpSetWait(_DpExists + ".MVMax", 200.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getManipulatedValueMax(), 200.0);
    assertEqual(_eventManipulatedValueMax, 200.0);
    return 0;

  }

  public int testProcessValueScaleMinChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setProcessValueScaleMinChangedCB, pidCtrl, PIDCtrl::processValueScaleMinChanged);

    dpSetWait(_DpExists + ".PVSclMin", -100.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getProcessValueScaleMin(), -100.0);
    assertEqual(_eventProcessValueScaleMin, -100.0);
    return 0;

  }

  public int testProcessValueScaleMaxChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setProcessValueScaleMaxChangedCB, pidCtrl, PIDCtrl::processValueScaleMaxChanged);

    dpSetWait(_DpExists + ".PVSclMax", 100.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getProcessValueScaleMax(), 100.0);
    assertEqual(_eventProcessValueScaleMax, 100.0);
    return 0;

  }

  public int testSetpointScaleMinChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setSetpointScaleMinChangedCB, pidCtrl, PIDCtrl::setpointScaleMinChanged);

    dpSetWait(_DpExists + ".SPSclMin", -75.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointScaleMin(), -75.0);
    assertEqual(_eventSetpointScaleMin, -75.0);
    return 0;

  }

  public int testSetpointScaleMaxChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setSetpointScaleMaxChangedCB, pidCtrl, PIDCtrl::setpointScaleMaxChanged);

    dpSetWait(_DpExists + ".SPSclMax", 75.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointScaleMax(), 75.0);
    assertEqual(_eventSetpointScaleMax, 75.0);
    return 0;

  }

  public int testSetpointInternalMinChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setSetpointInternalMinChangedCB, pidCtrl, PIDCtrl::setpointInternalMinChanged);

    dpSetWait(_DpExists + ".SPIntMin", -25.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointInternalMin(), -25.0);
    assertEqual(_eventSetpointInternalMin, -25.0);
    return 0;

  }

  public int testSetpointInternalMaxChanged()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    classConnect(this, setSetpointInternalMaxChangedCB, pidCtrl, PIDCtrl::setpointInternalMaxChanged);

    dpSetWait(_DpExists + ".SPIntMax", 25.0);

// Give it time to execute callback.
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointInternalMax(), 25.0);
    assertEqual(_eventSetpointInternalMax, 25.0);
    return 0;

  }

  public int testSetSetpointManual()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    float testValue = 75.5;
    pidCtrl.setSetpointManual(testValue);
    delay(0, 100); // Wait for dpSet to complete
    float dpValue; dpGet(_DpExists + ".SPMan", dpValue);
    assertEqual(pidCtrl.getSetpointManual(), testValue, "SetpointManual internal value");
    assertEqual(dpValue, testValue, "SetpointManual data point value");
    return 0;
  }

  public int testSetManipulatedValueManual()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    float testValue = -25.0;
    pidCtrl.setManipulatedValueManual(testValue);
    delay(0, 100); // Wait for dpSet to complete
    float dpValue; dpGet(_DpExists + ".MVMan", dpValue);
    assertEqual(pidCtrl.getManipulatedValueManual(), testValue, "ManipulatedValueManual internal value");
    assertEqual(dpValue, testValue, "ManipulatedValueManual data point value");
    return 0;
  }

  public int testSetSetpointManualMin()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    float testValue = 10.0;
    pidCtrl.setSetpointManualMin(testValue);
    delay(0, 100); // Wait for dpSet to complete
    float dpValue; dpGet(_DpExists + ".SPManMin", dpValue);
    assertEqual(pidCtrl.getSetpointManualMin(), testValue, "SetpointManualMin internal value");
    assertEqual(dpValue, testValue, "SetpointManualMin data point value");
    return 0;
  }

  public int testSetSetpointManualMax()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    float testValue = 100.0;
    pidCtrl.setSetpointManualMax(testValue);
    delay(0, 100); // Wait for dpSet to complete
    float dpValue; dpGet(_DpExists + ".SPManMax", dpValue);
    assertEqual(pidCtrl.getSetpointManualMax(), testValue, "SetpointManualMax internal value");
    assertEqual(dpValue, testValue, "SetpointManualMax data point value");
    return 0;
  }

  public int testSetProportionalParameter()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    float testValue = 1.5;
    pidCtrl.setProportionalParameter(testValue);
    delay(0, 100); // Wait for dpSet to complete
    float dpValue; dpGet(_DpExists + ".P", dpValue);
    assertEqual(pidCtrl.getProportionalParameter(), testValue, "ProportionalParameter internal value");
    assertEqual(dpValue, testValue, "ProportionalParameter data point value");
    return 0;
  }

  public int testSetIntegrationParameter()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    float testValue = 0.8;
    pidCtrl.setIntegrationParameter(testValue);
    delay(0, 100); // Wait for dpSet to complete
    float dpValue; dpGet(_DpExists + ".Ti", dpValue);
    assertEqual(pidCtrl.getIntegrationParameter(), testValue, "IntegrationParameter internal value");
    assertEqual(dpValue, testValue, "IntegrationParameter data point value");
    return 0;
  }

  public int testSetDerivationParameter()
  {
    shared_ptr<PIDCtrl> pidCtrl = new PIDCtrl(_DpExists);
    float testValue = 0.3;
    pidCtrl.setDerivationParameter(testValue);
    delay(0, 100); // Wait for dpSet to complete
    float dpValue; dpGet(_DpExists + ".Td", dpValue);
    assertEqual(pidCtrl.getDerivationParameter(), testValue, "DerivationParameter internal value");
    assertEqual(dpValue, testValue, "DerivationParameter data point value");
    return 0;
  }


  private void setProcessValueChangedCB(const float &value)
  {
    _eventProcessValue = value;
  }

  private void setSetpointInternalChangedCB(const float &value)
  {
    _eventSetpointInternal = value;
  }

  private void setSetpointChangedCB(const float &value)
  {
    _eventSetpoint = value;
  }

  private void setManipulatedValueChangedCB(const float &value)
  {
    _eventManipulatedValue = value;
  }

  private void setManipulatedValueMinChangedCB(const float &value)
  {
    _eventManipulatedValueMin = value;
  }

  private void setManipulatedValueMaxChangedCB(const float &value)
  {
    _eventManipulatedValueMax = value;
  }

  private void setProcessValueScaleMinChangedCB(const float &value)
  {
    _eventProcessValueScaleMin = value;
  }

  private void setProcessValueScaleMaxChangedCB(const float &value)
  {
    _eventProcessValueScaleMax = value;
  }

  private void setSetpointScaleMinChangedCB(const float &value)
  {
    _eventSetpointScaleMin = value;
  }

  private void setSetpointScaleMaxChangedCB(const float &value)
  {
    _eventSetpointScaleMax = value;
  }

  private void setSetpointInternalMinChangedCB(const float &value)
  {
    _eventSetpointInternalMin = value;
  }

  private void setSetpointInternalMaxChangedCB(const float &value)
  {
    _eventSetpointInternalMax = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstPIDCtrl test;
  test.startAll();
}
