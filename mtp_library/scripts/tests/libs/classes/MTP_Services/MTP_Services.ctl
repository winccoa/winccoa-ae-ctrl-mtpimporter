// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_Services/MTP_Services.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_Services/MTP_Services.ctl
  @copyright $copyright
  @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MTP_Services/MTP_Services"
#uses "classes/oaTest/OaTest"

class TstServices : OaTest
{
  private const string _DpExists = "ExistingServicesTestDatapoint";

  private string _dpt;
  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _constructorFields;
  private dyn_string _invalidDps;
  private dyn_string _invalidFields;
  private dyn_string _createdDps;
  private dyn_string _createdDpts;

  private uint _evCommandInternal;
  private uint _evCommandExternal;
  private uint _evStateCurrent;
  private bool _evSrcChannel;
  private bool _evSrcExtAut;
  private bool _evSrcIntAut;
  private bool _evSrcIntAct;
  private bool _evSrcExtAct;
  private bool _evProcApplyEn;
  private bool _evProcApplyExt;
  private bool _evProcApplyInt;
  private bool _evCfgApplyEn;
  private bool _evCfgApplyExt;
  private bool _evCfgApplyInt;
  private bool _evFreeze;
  private bool _hasProcessValueFields;

  private int createInvalidTypeAndDp(const string &dpt, const string &dp, const string &missingField)
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(dpt));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT));

    for (int i = 1; i <= dynlen(_allFields); i++)
    {
      if (_allFields[i] == missingField)
      {
        continue;
      }

      dynAppend(dpes, makeDynString("", _allFields[i]));
      dynAppend(values, makeDynInt(0, _allTypes[i]));
    }

    if (dpExists(dp))
    {
      dpDelete(dp);
    }


    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(dp))
      dpCreate(dp, dpt);

    if (!dpExists(dp))
    {
      return -1;
    }

    dynAppend(_createdDpts, dpt);
    dynAppend(_createdDps, dp);
    return 0;
  }

  public int setUp() override
  {
    _createdDps = makeDynString();
    _createdDpts = makeDynString();
    _invalidDps = makeDynString();
    _invalidFields = makeDynString();

    if (dpTypes("MTP_Services").count() > 0)
    {
      _dpt = "MTP_Services";
    }
    else if (dpTypes("ServiceControl").count() > 0)
    {
      _dpt = "ServiceControl";
    }
    else
    {
      DebugN("No services DPT found (MTP_Services/ServiceControl)");
      return -1;
    }

    _allFields = makeDynString("tagName", "WQC", "OSLevel",
                               "CommandOp", "CommandInt", "CommandExt",
                               "ProcedureOp", "ProcedureInt", "ProcedureExt",
                               "StateCur", "CommandEn", "ProcedureCur", "ProcedureReq",
                               "PosTextID", "InteractQuestionID", "InteractAddInfo", "InteractAnswerID",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOffAct", "StateOpAct", "StateAutAct",
                               "SrcChannel", "SrcExtAut", "SrcIntAut", "SrcIntOp", "SrcExtOp", "SrcIntAct", "SrcExtAct",
                               "ProcParamApplyEn", "ProcParamApplyExt", "ProcParamApplyOp", "ProcParamApplyInt",
                               "ConfigParamApplyEn", "ConfigParamApplyExt", "ConfigParamApplyOp", "ConfigParamApplyInt",
                               "ReportValueFreeze", "numberOfProcedure", "configParameters", "procedures", "processValueIns", "processValueOuts");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_UINT, DPEL_UINT, DPEL_UINT,
                           DPEL_UINT, DPEL_UINT, DPEL_UINT,
                           DPEL_UINT, DPEL_UINT, DPEL_UINT, DPEL_UINT,
                           DPEL_UINT, DPEL_UINT, DPEL_STRING, DPEL_UINT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_INT, DPEL_DPID, DPEL_DPID, DPEL_DPID, DPEL_DPID);

    _constructorFields = makeDynString("CommandOp", "CommandInt", "CommandExt",
                                       "ProcedureOp", "ProcedureInt", "ProcedureExt",
                                       "StateCur", "CommandEn", "ProcedureCur", "ProcedureReq",
                                       "PosTextID", "InteractQuestionID", "InteractAddInfo", "InteractAnswerID",
                                       "SrcChannel", "SrcExtAut", "SrcIntAut", "SrcIntOp", "SrcExtOp", "SrcIntAct", "SrcExtAct",
                                       "ProcParamApplyEn", "ProcParamApplyExt", "ProcParamApplyOp", "ProcParamApplyInt",
                                       "ConfigParamApplyEn", "ConfigParamApplyExt", "ConfigParamApplyOp", "ConfigParamApplyInt",
                                       "ReportValueFreeze", "numberOfProcedure", "procedures", "configParameters", "processValueIns", "processValueOuts");

    if (dpExists(_DpExists))
    {
      dpDelete(_DpExists);
    }

    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _dpt);
    if (!dpExists(_DpExists))
    {
      return -1;
    }

    _hasProcessValueFields = dpExists(_DpExists + ".processValueIns") && dpExists(_DpExists + ".processValueOuts");

    // Prefer ServiceControl if MTP_Services in the local project is not yet updated with process values.
    if (!_hasProcessValueFields && _dpt != "ServiceControl" && dpTypes("ServiceControl").count() > 0)
    {
      dpDelete(_DpExists);
      _dpt = "ServiceControl";
      if (!dpExists(_DpExists))
        dpCreate(_DpExists, _dpt);
      if (!dpExists(_DpExists))
      {
        return -1;
      }

      _hasProcessValueFields = dpExists(_DpExists + ".processValueIns") && dpExists(_DpExists + ".processValueOuts");
    }

    if (!_hasProcessValueFields)
    {
      DebugN("Selected DPT has no process values; update/import DPT schema first: " + _dpt);
      return -1;
    }

    dynAppend(_createdDps, _DpExists);

    _evCommandInternal = 0;
    _evCommandExternal = 0;
    _evStateCurrent = 0;
    _evSrcChannel = FALSE;
    _evSrcExtAut = FALSE;
    _evSrcIntAut = FALSE;
    _evSrcIntAct = FALSE;
    _evSrcExtAct = FALSE;
    _evProcApplyEn = FALSE;
    _evProcApplyExt = FALSE;
    _evProcApplyInt = FALSE;
    _evCfgApplyEn = FALSE;
    _evCfgApplyExt = FALSE;
    _evCfgApplyInt = FALSE;
    _evFreeze = FALSE;

    dpSetWait(_DpExists + ".numberOfProcedure", 0,
              _DpExists + ".procedures", makeDynString(),
              _DpExists + ".configParameters", makeDynString(),
              _DpExists + ".processValueIns", makeDynString(),
              _DpExists + ".processValueOuts", makeDynString());

    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      string dptInvalid = "MTP_ServicesUTInvalid" + i;
      string dpInvalid = "ExistingServicesTestDatapointInvalid" + i;

      if (createInvalidTypeAndDp(dptInvalid, dpInvalid, _constructorFields[i]) == 0)
      {
        dynAppend(_invalidDps, dpInvalid);
        dynAppend(_invalidFields, _constructorFields[i]);

        if (dpExists(dpInvalid + ".numberOfProcedure"))
        {
          dpSetWait(dpInvalid + ".numberOfProcedure", 0);
        }

        if (dpExists(dpInvalid + ".procedures"))
        {
          dpSetWait(dpInvalid + ".procedures", makeDynString());
        }

        if (dpExists(dpInvalid + ".configParameters"))
        {
          dpSetWait(dpInvalid + ".configParameters", makeDynString());
        }

        if (dpExists(dpInvalid + ".processValueIns"))
        {
          dpSetWait(dpInvalid + ".processValueIns", makeDynString());
        }

        if (dpExists(dpInvalid + ".processValueOuts"))
        {
          dpSetWait(dpInvalid + ".processValueOuts", makeDynString());
        }
      }
    }

    return OaTest::setUp();
  }


  private bool isTestOnlyDpt(const string &dpt)
  {
    return dpt.contains("Invalid") || dpt.contains("Unsupported") || dpt.contains("UT") || dpt.contains("Tst") || dpt == "TestDpt";
  }
  public int tearDown() override
  {
    for (int i = 1; i <= dynlen(_createdDps); i++)
    {
      dpDelete(_createdDps[i]);
    }


    for (int i = 1; i <= dynlen(_createdDpts); i++)
    {
      if (isTestOnlyDpt(_createdDpts[i]) && dpTypes(_createdDpts[i]).count() > 0)
        dpTypeDelete(_createdDpts[i]);
    }
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_Services> services = new MTP_Services(_DpExists);
    assertEqual(services.getDp(), _DpExists);
    assertEqual(services.getCommandOperator(), (uint)0);
    assertEqual(services.getNumberOfProcedure(), 0);
    assertEqual(services.getProcedures().count(), 0);
    assertEqual(services.getConfigParameters().count(), 0);
    assertTrue(services.getWqc() != nullptr);
    assertTrue(services.getOsLevel() != nullptr);
    assertTrue(services.getState() != nullptr);
    assertTrue(services.getProcedure() != nullptr);
    return 0;
  }

  public int testAdditionalGetters()
  {
    dpSetWait(_DpExists + ".CommandEn", (uint)44,
              _DpExists + ".ProcedureCur", (uint)55,
              _DpExists + ".ProcedureReq", (uint)66,
              _DpExists + ".PosTextID", (uint)77,
              _DpExists + ".InteractQuestionID", (uint)88,
              _DpExists + ".InteractAddInfo", "question",
              _DpExists + ".InteractAnswerID", (uint)99,
              _DpExists + ".SrcIntOp", TRUE,
              _DpExists + ".SrcExtOp", FALSE,
              _DpExists + ".ProcParamApplyOp", TRUE,
              _DpExists + ".ConfigParamApplyOp", FALSE,
              _DpExists + ".CommandOp", (uint)123,
              _DpExists + ".processValueIns", makeDynString(_DpExists),
              _DpExists + ".processValueOuts", makeDynString(_DpExists, _DpExists));

    shared_ptr<MTP_Services> services = new MTP_Services(_DpExists);

    assertEqual(services.getCommandEnabled(), (uint)44);
    assertEqual(services.getPositionTextId(), (uint)77);
    assertEqual(services.getInteractionQuestionId(), (uint)88);
    assertEqual(services.getInteractionAdditionalInfo(), "question");
    assertEqual(services.getInteractionAnswerId(), (uint)99);
    assertTrue(services.getSrcInternalOperator());
    assertFalse(services.getSrcExternalOperator());
    assertTrue(services.getProcParamApplyOperator());
    assertFalse(services.getConfigParamApplyOperator());
    assertEqual(services.getCommandOperator(), (uint)123);
    assertEqual(dynlen(services.getProcessValueIns()), 1);
    assertTrue(services.getProcessValueIns()[1].contains(_DpExists));
    assertEqual(dynlen(services.getProcessValueOuts()), 2);
    assertTrue(services.getProcessValueOuts()[1].contains(_DpExists));
    assertTrue(services.getProcessValueOuts()[2].contains(_DpExists));

    return 0;
  }

  public int testConstructor_WithProcedureAndConfigParameter()
  {
    string procedureDpt = "ProcedureHealthView";
    string configParamDpt = "StringServParam";
    string procedureDp = _DpExists + "_ProcedureUT1";
    string configParamDp = _DpExists + "_ConfigParamUT1";

    if (dpTypes(procedureDpt).count() == 0 || dpTypes(configParamDpt).count() == 0)
    {
      DebugN("ProcedureHealthView/StringServParam DPT missing - skipping list constructor test");
      return 0;
    }

    if (dpExists(procedureDp))
    {
      dpDelete(procedureDp);
    }

    if (dpExists(configParamDp))
    {
      dpDelete(configParamDp);
    }

    if (!dpExists(procedureDp))
      dpCreate(procedureDp, procedureDpt);
    if (!dpExists(configParamDp))
      dpCreate(configParamDp, configParamDpt);

    if (dpExists(procedureDp))
    {
      dynAppend(_createdDps, procedureDp);
    }

    if (dpExists(configParamDp))
    {
      dynAppend(_createdDps, configParamDp);
    }

    dpSetWait(_DpExists + ".numberOfProcedure", 1,
              _DpExists + ".procedures", makeDynString(procedureDp),
              _DpExists + ".configParameters", makeDynString(configParamDp));

    shared_ptr<MTP_Services> services = new MTP_Services(_DpExists);
    assertEqual(services.getNumberOfProcedure(), 1);
    assertEqual(services.getProcedures().count(), 1);
    assertEqual(services.getConfigParameters().count(), 1);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_invalidDps); i++)
    {
      try
      {
        shared_ptr<MTP_Services> services = new MTP_Services(_invalidDps[i]);
        assertTrue(false, "shouldn't reach here");
      }
      catch
      {
        dyn_errClass err = getLastException();
        assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
        string errText = getErrorText(err);
        assertTrue(errText.contains(_invalidDps[i] + "." + _invalidFields[i]) || errText.contains(_invalidDps[i]));
      }
    }

    return 0;
  }

  public int testChangedEventsAndGetters()
  {
    dpSetWait(_DpExists + ".CommandInt", (uint)0,
              _DpExists + ".CommandExt", (uint)0,
              _DpExists + ".StateCur", (uint)0,
              _DpExists + ".SrcChannel", FALSE,
              _DpExists + ".SrcExtAut", FALSE,
              _DpExists + ".SrcIntAut", FALSE,
              _DpExists + ".SrcIntAct", FALSE,
              _DpExists + ".SrcExtAct", FALSE,
              _DpExists + ".ProcParamApplyEn", FALSE,
              _DpExists + ".ProcParamApplyExt", FALSE,
              _DpExists + ".ProcParamApplyInt", FALSE,
              _DpExists + ".ConfigParamApplyEn", FALSE,
              _DpExists + ".ConfigParamApplyExt", FALSE,
              _DpExists + ".ConfigParamApplyInt", FALSE,
              _DpExists + ".ReportValueFreeze", FALSE);

    shared_ptr<MTP_Services> services = new MTP_Services(_DpExists);

    classConnect(this, commandInternalChangedCB, services, MTP_Services::commandInternalChanged);
    classConnect(this, commandExternalChangedCB, services, MTP_Services::commandExternalChanged);
    classConnect(this, currentStateChangedCB, services, MTP_Services::currentStateChanged);
    classConnect(this, sourceChannelChangedCB, services, MTP_Services::sourceChannelChanged);
    classConnect(this, sourceExternalAutomaticChangedCB, services, MTP_Services::sourceExternalAutomaticChanged);
    classConnect(this, sourceInternalAutomaticChangedCB, services, MTP_Services::sourceInternalAutomaticChanged);
    classConnect(this, sourceInternalActiveChangedCB, services, MTP_Services::sourceInternalActiveChanged);
    classConnect(this, sourceExternalActiveChangedCB, services, MTP_Services::sourceExternalActiveChanged);
    classConnect(this, procParamApplyEnabledChangedCB, services, MTP_Services::procParamApplyEnabledChanged);
    classConnect(this, procParamApplyExternalChangedCB, services, MTP_Services::procParamApplyExternalChanged);
    classConnect(this, procParamApplyInternalChangedCB, services, MTP_Services::procParamApplyInternalChanged);
    classConnect(this, configParamApplyEnabledChangedCB, services, MTP_Services::configParamApplyEnabledChanged);
    classConnect(this, configParamApplyExternalChangedCB, services, MTP_Services::configParamApplyExternalChanged);
    classConnect(this, configParamApplyInternalChangedCB, services, MTP_Services::configParamApplyInternalChanged);
    classConnect(this, reportValueFreezeChangedCB, services, MTP_Services::reportValueFreezeChanged);

    dpSetWait(_DpExists + ".CommandInt", (uint)11,
              _DpExists + ".CommandExt", (uint)22,
              _DpExists + ".StateCur", (uint)33,
              _DpExists + ".SrcChannel", TRUE,
              _DpExists + ".SrcExtAut", TRUE,
              _DpExists + ".SrcIntAut", TRUE,
              _DpExists + ".SrcIntAct", TRUE,
              _DpExists + ".SrcExtAct", TRUE,
              _DpExists + ".ProcParamApplyEn", TRUE,
              _DpExists + ".ProcParamApplyExt", TRUE,
              _DpExists + ".ProcParamApplyInt", TRUE,
              _DpExists + ".ConfigParamApplyEn", TRUE,
              _DpExists + ".ConfigParamApplyExt", TRUE,
              _DpExists + ".ConfigParamApplyInt", TRUE,
              _DpExists + ".ReportValueFreeze", TRUE);

    delay(0, 200);

    assertEqual(services.getCommandInternal(), (uint)11);
    assertEqual(services.getCommandExternal(), (uint)22);
    assertEqual(services.getCurrentState(), (uint)33);
    assertTrue(services.getSrcChannel());
    assertTrue(services.getSrcExternalAutomatic());
    assertTrue(services.getSrcInternalAutomatic());
    assertTrue(services.getSrcInternalActive());
    assertTrue(services.getSrcExternalActive());
    assertTrue(services.getProcParamApplyEnabled());
    assertTrue(services.getProcParamApplyExternal());
    assertTrue(services.getProcParamApplyInternal());
    assertTrue(services.getConfigParamApplyEnabled());
    assertTrue(services.getConfigParamApplyExternal());
    assertTrue(services.getConfigParamApplyInternal());
    assertTrue(services.getReportValueFreeze());

    assertEqual(_evCommandInternal, (uint)11);
    assertEqual(_evCommandExternal, (uint)22);
    assertEqual(_evStateCurrent, (uint)33);
    assertTrue(_evSrcChannel);
    assertTrue(_evSrcExtAut);
    assertTrue(_evSrcIntAut);
    assertTrue(_evSrcIntAct);
    assertTrue(_evSrcExtAct);
    assertTrue(_evProcApplyEn);
    assertTrue(_evProcApplyExt);
    assertTrue(_evProcApplyInt);
    assertTrue(_evCfgApplyEn);
    assertTrue(_evCfgApplyExt);
    assertTrue(_evCfgApplyInt);
    assertTrue(_evFreeze);

    return 0;
  }

  public int testSetters()
  {
    shared_ptr<MTP_Services> services = new MTP_Services(_DpExists);

    services.setCommandOperator((uint)7);
    services.setSrcExternalOperator(TRUE);
    services.setSrcInternalOperator(TRUE);
    services.setProcParamApplyOperator(TRUE);
    services.setConfigParamApplyOperator(TRUE);

    delay(0, 100);

    uint commandOp;
    bool srcExtOp;
    bool srcIntOp;
    bool procApplyOp;
    bool cfgApplyOp;

    dpGet(_DpExists + ".CommandOp", commandOp,
          _DpExists + ".SrcExtOp", srcExtOp,
          _DpExists + ".SrcIntOp", srcIntOp,
          _DpExists + ".ProcParamApplyOp", procApplyOp,
          _DpExists + ".ConfigParamApplyOp", cfgApplyOp);

    assertEqual(commandOp, (uint)7);
    assertTrue(srcExtOp);
    assertTrue(srcIntOp);
    assertTrue(procApplyOp);
    assertTrue(cfgApplyOp);
    assertEqual(services.getCommandOperator(), (uint)7);
    assertTrue(services.getSrcExternalOperator());
    assertTrue(services.getSrcInternalOperator());
    assertTrue(services.getProcParamApplyOperator());
    assertTrue(services.getConfigParamApplyOperator());
    return 0;
  }

  private void commandInternalChangedCB(const uint &v) { _evCommandInternal = v; }
  private void commandExternalChangedCB(const uint &v) { _evCommandExternal = v; }
  private void currentStateChangedCB(const uint &v) { _evStateCurrent = v; }
  private void sourceChannelChangedCB(const bool &v) { _evSrcChannel = v; }
  private void sourceExternalAutomaticChangedCB(const bool &v) { _evSrcExtAut = v; }
  private void sourceInternalAutomaticChangedCB(const bool &v) { _evSrcIntAut = v; }
  private void sourceInternalActiveChangedCB(const bool &v) { _evSrcIntAct = v; }
  private void sourceExternalActiveChangedCB(const bool &v) { _evSrcExtAct = v; }
  private void procParamApplyEnabledChangedCB(const bool &v) { _evProcApplyEn = v; }
  private void procParamApplyExternalChangedCB(const bool &v) { _evProcApplyExt = v; }
  private void procParamApplyInternalChangedCB(const bool &v) { _evProcApplyInt = v; }
  private void configParamApplyEnabledChangedCB(const bool &v) { _evCfgApplyEn = v; }
  private void configParamApplyExternalChangedCB(const bool &v) { _evCfgApplyExt = v; }
  private void configParamApplyInternalChangedCB(const bool &v) { _evCfgApplyInt = v; }
  private void reportValueFreezeChangedCB(const bool &v) { _evFreeze = v; }
};

void main()
{
  TstServices test;
  test.startAll();
}
