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
  private const string _Dpt = "Services";
  private const string _DptInvalidMissingCommandOp = "ServicesInvalid1";
  private const string _DptInvalidMissingStateCur = "ServicesInvalid2";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingCommandOp = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingStateCur = "ExistingTestDatapointInvalid2";

  private long _eventCommandInternal;
  private long _eventStateCurrent;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      return -1;
    }

    dpCreate(_DpExists, _Dpt);

    // Create invalid data point type missing CommandOp
    dyn_dyn_string dpes = makeDynAnytype(
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
                            makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct")
                          );
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL),
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
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL)
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
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct")
           );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateCur, _DptInvalidMissingStateCur);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingCommandOp);
    dpTypeDelete(_DptInvalidMissingCommandOp);
    dpDelete(_DpExistsInvalidMissingStateCur);
    dpTypeDelete(_DptInvalidMissingStateCur);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    assertEqual(services.getDp(), _DpExists);
    assertEqual(services.getCommandOperator(), 0);
    assertEqual(services.getCommandInternal(), 0);
    assertEqual(services.getCommandExternal(), 0);
    assertEqual(services.getCurrentState(), 0);
    assertEqual(services.getCommandEnabled(), 0);
    assertEqual(services.getPositionTextId(), 0);
    assertEqual(services.getInteractionQuestionId(), 0);
    assertEqual(services.getInteractionAdditionalInfo(), "");
    assertEqual(services.getInteractionAnswerId(), 0);
    assertFalse(services.getSrcChannel());
    assertFalse(services.getSrcExternalAutomatic());
    assertFalse(services.getSrcInternalAutomatic());
    assertFalse(services.getSrcInternalOperator());
    assertFalse(services.getSrcExternalOperator());
    assertFalse(services.getSrcInternalActive());
    assertFalse(services.getSrcExternalActive());
    assertFalse(services.getProcParamApplyEnabled());
    assertFalse(services.getProcParamApplyExternal());
    assertFalse(services.getProcParamApplyOperator());
    assertFalse(services.getProcParamApplyInternal());
    assertFalse(services.getConfigParamApplyEnabled());
    assertFalse(services.getConfigParamApplyExternal());
    assertFalse(services.getConfigParamApplyOperator());
    assertFalse(services.getConfigParamApplyInternal());
    assertFalse(services.getReportValueFreeze());
    assertEqual(services.getNumberOfProcedure(), 0);
    assertTrue(services.getWqc() != nullptr);
    assertTrue(services.getOsLevel() != nullptr);
    assertTrue(services.getState() != nullptr);
    assertTrue(services.getProcedure() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingCommandOp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingCommandOp + ".CommandOp"));
    }

    try
    {
      shared_ptr<Services> services = new Services(_DpExistsInvalidMissingStateCur);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingStateCur + ".StateCur"));
    }

    return 0;
  }

  public int testCommandInternalChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setCommandInternalChangedCB, services, Services::commandInternalChanged);

    dpSetWait(_DpExists + ".CommandInt", 100);

    // Give it time to execute callback
    delay(0, 200);
    assertEqual(services.getCommandInternal(), 100);
    assertEqual(_eventCommandInternal, 100);
    return 0;
  }

  public int testCurrentStateChanged()
  {
    shared_ptr<Services> services = new Services(_DpExists);
    classConnect(this, setCurrentStateChangedCB, services, Services::currentStateChanged);

    dpSetWait(_DpExists + ".StateCur", 200);

    // Give it time to execute callback
    delay(0, 200);
    assertEqual(services.getCurrentState(), 200);
    assertEqual(_eventStateCurrent, 200);
    return 0;
  }

  private void setCommandInternalChangedCB(const long &commandInternal)
  {
    _eventCommandInternal = commandInternal;
  }

  private void setCurrentStateChangedCB(const long &stateCurrent)
  {
    _eventStateCurrent = stateCurrent;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstServices test;
  test.startAll();
}
