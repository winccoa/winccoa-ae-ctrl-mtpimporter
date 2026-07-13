// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_PIDCtrlCfl/MTP_PIDCtrlCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_PIDCtrlCfl/MTP_PIDCtrlCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_PIDCtrlCfl/MTP_PIDCtrlCfl" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_PIDCtrlCfl.ctl
*/
class TstMTP_PIDCtrlCfl : OaTest
{
  private const string _Dpt = "MTP_PIDCtrlCfl";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingEnabled = "MTP_PIDCtrlCflInvalid1";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid1";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private bool _eventEnabled;

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

    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(dp))
      dpCreate(dp, dpt);
  }

  public int setUp() override
  {
    _allFields = makeDynString("tagName", "WQC", "OSLevel",
                               "PV", "PVSclMin", "PVSclMax",
                               "SPMan", "SPInt", "SPSclMin", "SPSclMax", "SPIntMin", "SPIntMax", "SPManMin", "SPManMax", "SP",
                               "MVMan", "MV", "MVMin", "MVMax", "MVSclMin", "MVSclMax",
                               "P", "Ti", "Td",
                               "SrcChannel", "SrcManAut", "SrcIntAut", "SrcManOp", "SrcIntOp", "SrcManAct", "SrcIntAct",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "PVUnit", "SPUnit", "MVUnit", "enabled");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_INT, DPEL_INT, DPEL_INT, DPEL_BOOL);

    createTypeAndDp(_Dpt, _DpExists, "");
    createTypeAndDp(_DptInvalidMissingEnabled, _DpExistsInvalidMissingEnabled, "enabled");

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingEnabled);

    if (dpTypes(_DptInvalidMissingEnabled).count() > 0)
      dpTypeDelete(_DptInvalidMissingEnabled);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_PIDCtrlCfl> pidCtrlCfl = new MTP_PIDCtrlCfl(_DpExists);
    assertFalse(pidCtrlCfl.getEnabled());
    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(pidCtrlCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_PIDCtrlCfl> pidCtrlCfl = new MTP_PIDCtrlCfl(_DpExistsInvalidMissingEnabled);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingEnabled + ".enabled"));
    }

    return 0;
  }

  public int testEnabledChanged()
  {
    shared_ptr<MTP_PIDCtrlCfl> pidCtrlCfl = new MTP_PIDCtrlCfl(_DpExists);
    classConnect(this, enabledChangedCB, pidCtrlCfl, MTP_PIDCtrlCfl::enabledChanged);
    _eventEnabled = false;
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

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_PIDCtrlCfl test;
  test.startAll();
}
