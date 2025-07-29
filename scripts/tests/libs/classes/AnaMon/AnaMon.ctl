// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/AnaMon/AnaMon.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/AnaMon/AnaMon.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/AnaMon/AnaMon" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for AnaMon.ctl
*/
class TstAnaMon : OaTest
{
  private const string _Dpt = "AnaMon";
  private const string _DptInvalidMissingV = "AnaMonInvalid1";
  private const string _DptInvalidMissingVSclMin = "AnaMonInvalid2";
  private const string _DptInvalidMissingVSclMax = "AnaMonInvalid3";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingV = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid3";

  private float _eventValue;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      return -1;
    }

    dpCreate(_DpExists, _Dpt);

    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_DptInvalidMissingV), makeDynString("", "VSclMin"), makeDynString("", "VSclMax"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingV, _DptInvalidMissingV);
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMin), makeDynString("", "V"), makeDynString("", "VSclMax"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVSclMin, _DptInvalidMissingVSclMin);
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMax), makeDynString("", "V"), makeDynString("", "VSclMin"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVSclMax, _DptInvalidMissingVSclMax);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingV);
    dpTypeDelete(_DptInvalidMissingV);

    dpDelete(_DpExistsInvalidMissingVSclMin);
    dpTypeDelete(_DptInvalidMissingVSclMin);

    dpDelete(_DpExistsInvalidMissingVSclMax);
    dpTypeDelete(_DptInvalidMissingVSclMax);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<AnaMon> anaMon = new AnaMon(_DpExists);
    assertEqual(anaMon.getDp(), _DpExists);
    assertEqual(anaMon.getValue(), 0.0);
    assertEqual(anaMon.getValueScaleMin(), 0.0);
    assertEqual(anaMon.getValueScaleMax(), 0.0);
    assertTrue(anaMon.getWqc() != nullptr);
    assertTrue(anaMon.getOsLevel() != nullptr);
    assertTrue(anaMon.getUnit() != nullptr);
    assertTrue(anaMon.getAlertHighLimit() != nullptr);
    assertTrue(anaMon.getWarningHighLimit() != nullptr);
    assertTrue(anaMon.getToleranceHighLimit() != nullptr);
    assertTrue(anaMon.getToleranceLowLimit() != nullptr);
    assertTrue(anaMon.getWarningLowLimit() != nullptr);
    assertTrue(anaMon.getAlertLowLimit() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<AnaMon> anaMon = new AnaMon(_DpExistsInvalidMissingV);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingV + ".V"));
    }

    try
    {
      shared_ptr<AnaMon> anaMon = new AnaMon(_DpExistsInvalidMissingVSclMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMin + ".VSclMin"));
    }

    try
    {
      shared_ptr<AnaMon> anaMon = new AnaMon(_DpExistsInvalidMissingVSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMax + ".VSclMax"));
    }

    return 0;
  }

  public int testValueChanged()
  {
    shared_ptr<AnaMon> anaMon = new AnaMon(_DpExists);
    classConnect(this, setValueChangedCB, anaMon, AnaMon::valueChanged);

    dpSetWait(_DpExists + ".V", 42);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaMon.getValue(), 42.0);
    assertEqual(_eventValue, 42.0);
    return 0;
  }

  private void setValueChangedCB(const float &value)
  {
    _eventValue = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstAnaMon test;
  test.startAll();
}
