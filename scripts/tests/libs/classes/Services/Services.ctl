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
  private const string _DptInvalidMissingCommandInt = "ServicesInvalid3";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingCommandOp = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingStateCur = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingCommandInt = "ExistingTestDatapointInvalid3";

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

    dpCreate(_DpExists, _Dpt);

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
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_DPID),
               makeDynInt(0, DPEL_DPID)
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

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingStateCur, _DptInvalidMissingStateCur);

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
                            makeDynString("", "enabled"), makeDynString("", "tagName"),
                            makeDynString("", "procedures"), makeDynString("", "configParameters")
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
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_DPID),
                           makeDynInt(0, DPEL_DPID)
                         );

    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingCommandInt, _DptInvalidMissingCommandInt);

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
