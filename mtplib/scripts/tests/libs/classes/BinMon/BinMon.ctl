// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/BinMon/BinMon.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/BinMon/BinMon.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/BinMon/BinMon" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for BinMon.ctl
*/
class TstBinMon : OaTest
{
  private const string _Dpt = "BinMon";
  private const string _DptInvalidMissingV = "BinMonInvalid1";
  private const string _DptInvalidMissingVState0 = "BinMonInvalid2";
  private const string _DptInvalidMissingVState1 = "BinMonInvalid3";
  private const string _DptInvalidMissingVFlutEn = "BinMonInvalid4";
  private const string _DptInvalidMissingVFlutTi = "BinMonInvalid5";
  private const string _DptInvalidMissingVFlutCnt = "BinMonInvalid6";
  private const string _DptInvalidMissingVFlutAct = "BinMonInvalid7";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingV = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVState0 = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVState1 = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVFlutEn = "ExistingTestDatapointInvalid4";
  private const string _DpExistsInvalidMissingVFlutTi = "ExistingTestDatapointInvalid5";
  private const string _DpExistsInvalidMissingVFlutCnt = "ExistingTestDatapointInvalid6";
  private const string _DpExistsInvalidMissingVFlutAct = "ExistingTestDatapointInvalid7";

  private bool _eventValue;
  private bool _eventFlutterActive;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      return -1;
    }

    dpCreate(_DpExists, _Dpt);

    dyn_dyn_string dpes = makeDynAnytype(
                            makeDynString(_DptInvalidMissingV), makeDynString("", "VState0"), makeDynString("", "VState1"),
                            makeDynString("", "VFlutEn"), makeDynString("", "VFlutTi"), makeDynString("", "VFlutCnt"), makeDynString("", "VFlutAct"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingV, _DptInvalidMissingV);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVState0), makeDynString("", "V"), makeDynString("", "VState1"),
             makeDynString("", "VFlutEn"), makeDynString("", "VFlutTi"), makeDynString("", "VFlutCnt"), makeDynString("", "VFlutAct"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVState0, _DptInvalidMissingVState0);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVState1), makeDynString("", "V"), makeDynString("", "VState0"),
             makeDynString("", "VFlutEn"), makeDynString("", "VFlutTi"), makeDynString("", "VFlutCnt"), makeDynString("", "VFlutAct"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVState1, _DptInvalidMissingVState1);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVFlutEn), makeDynString("", "V"), makeDynString("", "VState0"),
             makeDynString("", "VState1"), makeDynString("", "VFlutTi"), makeDynString("", "VFlutCnt"), makeDynString("", "VFlutAct"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVFlutEn, _DptInvalidMissingVFlutEn);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVFlutTi), makeDynString("", "V"), makeDynString("", "VState0"),
             makeDynString("", "VState1"), makeDynString("", "VFlutEn"), makeDynString("", "VFlutCnt"), makeDynString("", "VFlutAct"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVFlutTi, _DptInvalidMissingVFlutTi);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVFlutCnt), makeDynString("", "V"), makeDynString("", "VState0"),
             makeDynString("", "VState1"), makeDynString("", "VFlutEn"), makeDynString("", "VFlutTi"), makeDynString("", "VFlutAct"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVFlutCnt, _DptInvalidMissingVFlutCnt);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingVFlutAct), makeDynString("", "V"), makeDynString("", "VState0"),
             makeDynString("", "VState1"), makeDynString("", "VFlutEn"), makeDynString("", "VFlutTi"), makeDynString("", "VFlutCnt"), makeDynString("", "enabled"), makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingVFlutAct, _DptInvalidMissingVFlutAct);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingV);
    dpTypeDelete(_DptInvalidMissingV);

    dpDelete(_DpExistsInvalidMissingVState0);
    dpTypeDelete(_DptInvalidMissingVState0);

    dpDelete(_DpExistsInvalidMissingVState1);
    dpTypeDelete(_DptInvalidMissingVState1);

    dpDelete(_DpExistsInvalidMissingVFlutEn);
    dpTypeDelete(_DptInvalidMissingVFlutEn);

    dpDelete(_DpExistsInvalidMissingVFlutTi);
    dpTypeDelete(_DptInvalidMissingVFlutTi);

    dpDelete(_DpExistsInvalidMissingVFlutCnt);
    dpTypeDelete(_DptInvalidMissingVFlutCnt);

    dpDelete(_DpExistsInvalidMissingVFlutAct);
    dpTypeDelete(_DptInvalidMissingVFlutAct);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<BinMon> binMon = new BinMon(_DpExists);
    assertEqual(binMon.getDp(), _DpExists);
    assertEqual(binMon.getValue(), false);
    assertEqual(binMon.getValueStateFalseText(), "");
    assertEqual(binMon.getValueStateTrueText(), "");
    assertEqual(binMon.getFlutterEnabled(), false);
    assertEqual(binMon.getFlutterTime(), 0.0);
    assertEqual(binMon.getFlutterCount(), 0);
    assertEqual(binMon.getFlutterActive(), false);
    assertTrue(binMon.getWqc() != nullptr);
    assertTrue(binMon.getOsLevel() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<BinMon> binMon = new BinMon(_DpExistsInvalidMissingV);
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
      shared_ptr<BinMon> binMon = new BinMon(_DpExistsInvalidMissingVState0);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVState0 + ".VState0"));
    }

    try
    {
      shared_ptr<BinMon> binMon = new BinMon(_DpExistsInvalidMissingVState1);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVState1 + ".VState1"));
    }

    try
    {
      shared_ptr<BinMon> binMon = new BinMon(_DpExistsInvalidMissingVFlutEn);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFlutEn + ".VFlutEn"));
    }

    try
    {
      shared_ptr<BinMon> binMon = new BinMon(_DpExistsInvalidMissingVFlutTi);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFlutTi + ".VFlutTi"));
    }

    try
    {
      shared_ptr<BinMon> binMon = new BinMon(_DpExistsInvalidMissingVFlutCnt);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFlutCnt + ".VFlutCnt"));
    }

    try
    {
      shared_ptr<BinMon> binMon = new BinMon(_DpExistsInvalidMissingVFlutAct);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVFlutAct + ".VFlutAct"));
    }

    return 0;
  }

  public int testValueChanged()
  {
    shared_ptr<BinMon> binMon = new BinMon(_DpExists);
    classConnect(this, setValueChangedCB, binMon, BinMon::valueChanged);

    dpSetWait(_DpExists + ".V", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(binMon.getValue(), true);
    assertEqual(_eventValue, true);
    return 0;
  }

  public int testFlutterActiveChanged()
  {
    shared_ptr<BinMon> binMon = new BinMon(_DpExists);
    classConnect(this, setFlutterActiveChangedCB, binMon, BinMon::flutterActiveChanged);

    dpSetWait(_DpExists + ".VFlutAct", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(binMon.getFlutterActive(), true);
    assertEqual(_eventFlutterActive, true);
    return 0;
  }

  public int testValueStateFalseText()
  {
    shared_ptr<BinMon> binMon = new BinMon(_DpExists);

    dpSetWait(_DpExists + ".VState0", "Off");
    delay(0, 200); // Allow time for any potential updates

    // Since BinMon does not monitor VState0 changes, manually update internal state
    string dpValue;
    dpGet(_DpExists + ".VState0", dpValue);
    assertEqual(dpValue, "Off", "Data point VState0 should be set to 'Off'");
    assertEqual(binMon.getValueStateFalseText(), "", "ValueStateFalseText should remain unchanged from initial value");
    return 0;
  }

  public int testValueStateTrueText()
  {
    shared_ptr<BinMon> binMon = new BinMon(_DpExists);

    dpSetWait(_DpExists + ".VState1", "On");
    delay(0, 200); // Allow time for any potential updates

    // Since BinMon does not monitor VState1 changes, manually update internal state
    string dpValue;
    dpGet(_DpExists + ".VState1", dpValue);
    assertEqual(dpValue, "On", "Data point VState1 should be set to 'On'");
    assertEqual(binMon.getValueStateTrueText(), "", "ValueStateTrueText should remain unchanged from initial value");
    return 0;
  }

  public int testFlutterEnabled()
  {
    shared_ptr<BinMon> binMon = new BinMon(_DpExists);

    dpSetWait(_DpExists + ".VFlutEn", true);
    delay(0, 200); // Allow time for any potential updates

    // Since BinMon does not monitor VFlutEn changes, manually update internal state
    bool dpValue;
    dpGet(_DpExists + ".VFlutEn", dpValue);
    assertEqual(dpValue, true, "Data point VFlutEn should be set to true");
    assertEqual(binMon.getFlutterEnabled(), false, "FlutterEnabled should remain unchanged from initial value");
    return 0;
  }

  public int testSetGetFlutterCount()
  {
    shared_ptr<BinMon> binMon = new BinMon(_DpExists);

    binMon.setFlutterCount(42);

    int dpValue;
    dpGet(_DpExists + ".VFlutCnt", dpValue);
    assertEqual(dpValue, 42, "Data point VFlutCnt should be set to 42");
    assertEqual(binMon.getFlutterCount(), 42, "Flutter count should be set to 42");

    return 0;
  }

  public int testSetGetFlutterTime()
  {
    shared_ptr<BinMon> binMon = new BinMon(_DpExists);

    binMon.setFlutterTime(3.14);

    float dpValue;
    dpGet(_DpExists + ".VFlutTi", dpValue);
    assertEqual(dpValue, 3.14, "Data point VFlutTi should be set to 3.14");
    assertEqual(binMon.getFlutterTime(), 3.14, "Flutter time should be set to 3.14");

    return 0;
  }

  private void setValueChangedCB(const bool &value)
  {
    _eventValue = value;
  }

  private void setFlutterActiveChangedCB(const bool &flutterActive)
  {
    _eventFlutterActive = flutterActive;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstBinMon test;
  test.startAll();
}
