// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinVlvCfl/MTP_BinVlvCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinVlvCfl/MTP_BinVlvCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_BinVlvCfl/MTP_BinVlvCfl" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_BinVlvCfl.ctl
 */
class TstMTP_BinVlvCfl : OaTest
{
  private const string _Dpt = "MTP_BinVlvCfl";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingEnabled = "MTP_BinVlvCflInvalid1";
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
                               "SafePos", "SafePosEn", "SafePosAct",
                               "OpenOp", "CloseOp", "OpenAut", "CloseAut", "Ctrl",
                               "OpenFbkCalc", "OpenFbk", "CloseFbkCalc", "CloseFbk",
                               "ResetOp", "ResetAut",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "PermEn", "Permit", "IntlEn", "Interlock", "ProtEn", "Protect",
                               "enabled");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL);

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
    shared_ptr<MTP_BinVlvCfl> binVlvCfl = new MTP_BinVlvCfl(_DpExists);
    assertFalse(binVlvCfl.getEnabled());
    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(binVlvCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_BinVlvCfl> binVlvCfl = new MTP_BinVlvCfl(_DpExistsInvalidMissingEnabled);
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
    shared_ptr<MTP_BinVlvCfl> binVlvCfl = new MTP_BinVlvCfl(_DpExists);
    classConnect(this, enabledChangedCB, binVlvCfl, MTP_BinVlvCfl::enabledChanged);
    _eventEnabled = FALSE;
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
  TstMTP_BinVlvCfl test;
  test.startAll();
}
