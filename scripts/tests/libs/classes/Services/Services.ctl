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
                            makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"), makeDynString("", "enabled"), makeDynString("", "tagName")
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
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING)
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
             makeDynString("", "StateAutAct"), makeDynString("", "StateOffAct"), makeDynString("", "enabled"), makeDynString("", "tagName")
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
    assertEqual(services.getCommandOperator(), 0L);
    assertEqual(services.getCommandInternal(), 0L);
    assertEqual(services.getCommandExternal(), 0L);
    assertEqual(services.getCurrentState(), 0L);
    assertEqual(services.getCommandEnabled(), 0L);
    assertEqual(services.getPositionTextId(), 0L);
    assertEqual(services.getInteractionQuestionId(), 0L);
    assertEqual(services.getInteractionAdditionalInfo(), "");
    assertEqual(services.getInteractionAnswerId(), 0L);
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
    string dptName = "ServicesInvalid_CommandInt";
    string dpName = "ExistingTestDatapointInvalid_CommandInt";
    dyn_dyn_string dpes = makeDynAnytype(
                            makeDynString(dptName),
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
                            makeDynString("", "enabled"), makeDynString("", "tagName")
                          );
    dyn_dyn_int values = makeDynAnytype(
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
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING)
                         );
    dpTypeCreate(dpes, values);
    dpCreate(dpName, dptName);

    try
    {
      shared_ptr<Services> services = new Services(dpName);
      assertTrue(false, "shouldn't reach here for missing CommandInt");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(dpName + ".CommandInt"));
    }

    dpDelete(dpName);
    dpTypeDelete(dptName);

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

    return 0;
  }

  public int testConstructor_MissingAllDpes()
  {
    dyn_string dpeNames = makeDynString(
                            "CommandExt", "ProcedureOp", "ProcedureInt", "ProcedureExt",
                            "CommandEn", "ProcedureCur", "ProcedureReq", "PosTextID", "InteractQuestionID",
                            "InteractAddInfo", "InteractAnswerID", "SrcChannel", "SrcExtAut", "SrcIntAut",
                            "SrcIntOp", "SrcExtOp", "SrcIntAct", "SrcExtAct", "ProcParamApplyEn",
                            "ProcParamApplyExt", "ProcParamApplyOp", "ProcParamApplyInt", "ConfigParamApplyEn",
                            "ConfigParamApplyExt", "ConfigParamApplyOp", "ConfigParamApplyInt", "ReportValueFreeze",
                            "numberOfProcedure", "WQC", "OSLevel", "StateChannel", "StateOffAut", "StateOpAut",
                            "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct",
                            "StateOffAct", "enabled", "tagName"
                          );
    dyn_int dpeTypes = makeDynAnytype(
                         DPEL_LONG, DPEL_LONG, DPEL_LONG, DPEL_LONG,
                         DPEL_LONG, DPEL_LONG, DPEL_LONG, DPEL_LONG, DPEL_LONG,
                         DPEL_STRING, DPEL_LONG, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                         DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                         DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                         DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_INT, DPEL_INT,
                         DPEL_INT, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                         DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                         DPEL_BOOL, DPEL_BOOL, DPEL_LANGSTRING
                       );

    for (int i = 1; i <= dynlen(dpeNames); i++)
    {
      string dptName = "ServicesInvalid_" + dpeNames[i];
      string dpName = "ExistingTestDatapointInvalid_" + dpeNames[i];

      // Create data point type with one DPE missing
      dyn_dyn_string dpes = makeDynAnytype(makeDynString(dptName));
      dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT));

      for (int j = 1; j <= dynlen(dpeNames); j++)
      {
        if (j != i)
        {
          dynAppend(dpes, makeDynString("", dpeNames[j]));
          dynAppend(values, makeDynInt(0, dpeTypes[j]));
        }
      }

      // Ensure CommandOp and StateCur are included to pass initial checks
      if (dpeNames[i] != "CommandOp")
      {
        dynAppend(dpes, makeDynString("", "CommandOp"));
        dynAppend(values, makeDynInt(0, DPEL_LONG));
      }

      if (dpeNames[i] != "StateCur")
      {
        dynAppend(dpes, makeDynString("", "StateCur"));
        dynAppend(values, makeDynInt(0, DPEL_LONG));
      }

      // Ensure CommandInt is included to pass its check
      if (dpeNames[i] != "CommandInt")
      {
        dynAppend(dpes, makeDynString("", "CommandInt"));
        dynAppend(values, makeDynInt(0, DPEL_LONG));
      }

      dpTypeCreate(dpes, values);
      dpCreate(dpName, dptName);
      delay(0, 100); // Allow system to stabilize after data point creation

      try
      {
        shared_ptr<Services> services = new Services(dpName);
        assertTrue(false, "shouldn't reach here for missing DPE: " + dpeNames[i]);
      }
      catch
      {
        dyn_errClass err = getLastException();
        assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
        assertTrue(getErrorText(err).contains("Datapoint does not exist"));
        assertTrue(getErrorText(err).contains(dpName + "." + dpeNames[i]));
      }

      dpDelete(dpName);
      dpTypeDelete(dptName);
      delay(0, 100); // Allow system to stabilize after deletion
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
