// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpInput/MtpInput.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpInput/MtpInput.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MtpInput/MtpInput" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpInput.ctl
*/
class TstMtpInput : OaTest
{
  private const string _Dpt = "TestDpt";
  private const string _DpExists = "ExistingTestDatapoint";

  private bool _eventEnabled;
  private bool _eventValue;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "enabled"), makeDynString("", "value"), makeDynString("", "inverted"), makeDynString("", "text"), makeDynString("", "qc"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExists, _Dpt);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpTypeDelete(_Dpt);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".enabled", _DpExists + ".value", _DpExists + ".inverted", _DpExists + ".text", _DpExists + ".qc");
    assertEqual(input.getEnabled(), FALSE);
    assertEqual(input.getValue(), FALSE);
    assertEqual(input.getInverted(), FALSE);
    assertEqual(input.getText(), "");
    assertTrue(input.getQualityCode() != nullptr);

    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".noneEnabled", _DpExists + ".value", _DpExists + ".inverted", _DpExists + ".text", _DpExists + ".qc");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneEnabled"));
    }

    try
    {
      shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".enabled", _DpExists + ".noneValue", _DpExists + ".inverted", _DpExists + ".text", _DpExists + ".qc");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneValue"));
    }

    try
    {
      shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".enabled", _DpExists + ".value", _DpExists + ".noneInverted", _DpExists + ".text", _DpExists + ".qc");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneInverted"));
    }

    try
    {
      shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".enabled", _DpExists + ".value", _DpExists + ".inverted", _DpExists + ".noneText", _DpExists + ".qc");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneText"));
    }

    return 0;
  }

  public int testGetInverted()
  {
    dpSetWait(_DpExists + ".inverted", TRUE);
    shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".enabled", _DpExists + ".value", _DpExists + ".inverted", _DpExists + ".text", _DpExists + ".qc");

    assertEqual(input.getInverted(), TRUE);
    return 0;
  }

  public int testGetText()
  {
    dpSetWait(_DpExists + ".text", "newText");
    shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".enabled", _DpExists + ".value", _DpExists + ".inverted", _DpExists + ".text", _DpExists + ".qc");

    assertEqual(input.getText(), "newText");
    return 0;
  }

  public int testGetEnabled()
  {
    shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".enabled", _DpExists + ".value", _DpExists + ".inverted", _DpExists + ".text", _DpExists + ".qc");
    classConnect(this, setEnabledCB, input, MtpInput::enabledChanged);

    dpSetWait(_DpExists + ".enabled", TRUE);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(input.getEnabled(), TRUE);
    assertEqual(_eventEnabled, TRUE);
    return 0 ;
  }

  public int testGetValue()
  {
    shared_ptr<MtpInput> input = new MtpInput(_DpExists + ".enabled", _DpExists + ".value", _DpExists + ".inverted", _DpExists + ".text", _DpExists + ".qc");
    classConnect(this, setValueCB, input, MtpInput::valueChanged);

    dpSetWait(_DpExists + ".value", TRUE);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(input.getValue(), TRUE);
    assertEqual(_eventValue, TRUE);
    return 0 ;
  }

  private void setEnabledCB(const bool &enabled)
  {
    _eventEnabled = enabled;
  }

  private void setValueCB(const bool &value)
  {
    _eventValue = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpInput test;
  test.startAll();
}
