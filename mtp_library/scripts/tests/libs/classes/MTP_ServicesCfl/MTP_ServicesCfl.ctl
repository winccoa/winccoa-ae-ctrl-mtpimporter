// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_ServicesCfl/MTP_ServicesCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_ServicesCfl/MTP_ServicesCfl.ctl
  @copyright $copyright
  @author d.schermann
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_ServicesCfl/MTP_ServicesCfl"
#uses "classes/oaTest/OaTest"

class TstMTP_ServicesCfl : OaTest
{
  private const string _DpExists = "ExistingServicesCflTestDatapoint";
  private const string _DptInvalidMissingEnabled = "MTP_ServicesCflUTInvalid1";
  private const string _DpExistsInvalidMissingEnabled = "ExistingServicesCflTestDatapointInvalid1";
  private const string _DpExistsFromMtpServices = "ExistingServicesCflFromMtpServicesUT";

  private string _dpt;
  private dyn_string _allFields;
  private dyn_int _allTypes;
  private bool _eventEnabled;
  private bool _hasMtpServices;
  private bool _hasProcessValueFields;

  private void createTypeAndDp(const string &dpt, const string &dp, const string &missingField)
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
  }

  public int setUp() override
  {
    _hasMtpServices = FALSE;

    if (dpTypes("MTP_ServicesCfl").count() > 0)
    {
      _dpt = "MTP_ServicesCfl";
    }
    else if (dpTypes("ServiceControl").count() > 0)
    {
      _dpt = "ServiceControl";
    }
    else
    {
      DebugN("No services-cfl DPT found (MTP_ServicesCfl/ServiceControl)");
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
                               "ReportValueFreeze", "enabled", "numberOfProcedure", "configParameters", "procedures", "processValueIns", "processValueOuts");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_UINT, DPEL_UINT, DPEL_UINT,
                           DPEL_UINT, DPEL_UINT, DPEL_UINT,
                           DPEL_UINT, DPEL_UINT, DPEL_UINT, DPEL_UINT,
                           DPEL_UINT, DPEL_UINT, DPEL_STRING, DPEL_UINT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_INT, DPEL_DPID, DPEL_DPID, DPEL_DPID, DPEL_DPID);

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

    // Prefer ServiceControl if MTP_ServicesCfl in the local project is not yet updated with process values.
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

    dpSetWait(_DpExists + ".enabled", FALSE);
    dpSetWait(_DpExists + ".numberOfProcedure", 0,
              _DpExists + ".procedures", makeDynString(),
              _DpExists + ".configParameters", makeDynString(),
              _DpExists + ".processValueIns", makeDynString(),
              _DpExists + ".processValueOuts", makeDynString());

    createTypeAndDp(_DptInvalidMissingEnabled, _DpExistsInvalidMissingEnabled, "enabled");
    if (dpExists(_DpExistsInvalidMissingEnabled + ".numberOfProcedure"))
    {
      dpSetWait(_DpExistsInvalidMissingEnabled + ".numberOfProcedure", 0,
                _DpExistsInvalidMissingEnabled + ".procedures", makeDynString(),
                _DpExistsInvalidMissingEnabled + ".configParameters", makeDynString(),
                _DpExistsInvalidMissingEnabled + ".processValueIns", makeDynString(),
                _DpExistsInvalidMissingEnabled + ".processValueOuts", makeDynString());
    }

    if (dpTypes("MTP_Services").count() > 0)
    {
      _hasMtpServices = TRUE;

      if (dpExists(_DpExistsFromMtpServices))
      {
        dpDelete(_DpExistsFromMtpServices);
      }

      if (!dpExists(_DpExistsFromMtpServices))
        dpCreate(_DpExistsFromMtpServices, "MTP_Services");
      if (dpExists(_DpExistsFromMtpServices + ".numberOfProcedure"))
      {
        dpSetWait(_DpExistsFromMtpServices + ".numberOfProcedure", 0,
                  _DpExistsFromMtpServices + ".procedures", makeDynString(),
                  _DpExistsFromMtpServices + ".configParameters", makeDynString(),
                  _DpExistsFromMtpServices + ".processValueIns", makeDynString(),
                  _DpExistsFromMtpServices + ".processValueOuts", makeDynString());
      }
    }

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingEnabled);
    if (dpTypes(_DptInvalidMissingEnabled).count() > 0)
      dpTypeDelete(_DptInvalidMissingEnabled);
    dpDelete(_DpExistsFromMtpServices);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_ServicesCfl> servicesCfl = new MTP_ServicesCfl(_DpExists);
    assertEqual(servicesCfl.getDp(), _DpExists);
    assertTrue(servicesCfl.getWqc() != nullptr);
    assertTrue(servicesCfl.getOsLevel() != nullptr);
    assertTrue(servicesCfl.getState() != nullptr);
    assertTrue(servicesCfl.getProcedure() != nullptr);
    assertEqual(servicesCfl.getProcedures().count(), 0);
    assertEqual(servicesCfl.getConfigParameters().count(), 0);

    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(servicesCfl.getEnabled());

    dpSetWait(_DpExists + ".enabled", FALSE);
    delay(0, 200);
    assertFalse(servicesCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_ServicesCfl> servicesCfl = new MTP_ServicesCfl(_DpExistsInvalidMissingEnabled);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
    }

    return 0;
  }

  public int testConstructor_MissingEnabled_FromMtpServices()
  {
    if (!_hasMtpServices || !dpExists(_DpExistsFromMtpServices))
    {
      DebugN("MTP_Services DPT not available - skipping explicit enabled-missing path test");
      return 0;
    }

    try
    {
      shared_ptr<MTP_ServicesCfl> servicesCfl = new MTP_ServicesCfl(_DpExistsFromMtpServices);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      string errText = getErrorText(err);
      if (errText != "")
      {
        assertTrue(errText.contains(_DpExistsFromMtpServices + ".enabled") || errText.contains(".enabled"));
      }
    }

    return 0;
  }

  public int testEnabledChanged()
  {
    shared_ptr<MTP_ServicesCfl> servicesCfl = new MTP_ServicesCfl(_DpExists);
    classConnect(this, enabledChangedCB, servicesCfl, MTP_ServicesCfl::enabledChanged);
    _eventEnabled = FALSE;

    dpSetWait(_DpExists + ".enabled", FALSE);
    delay(0, 100);

    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);

    assertTrue(_eventEnabled);
    return 0;
  }

  private void enabledChangedCB(const bool &enabled)
  {
    _eventEnabled = enabled;
  }
};

void main()
{
  TstMTP_ServicesCfl test;
  test.startAll();
}
