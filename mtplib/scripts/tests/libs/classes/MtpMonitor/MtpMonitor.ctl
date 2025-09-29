// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpMonitor/MtpMonitor.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpMonitor/MtpMonitor.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpMonitor/MtpMonitor" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpMonitor.ctl
*/
class TstMtpMonitor : OaTest
{
  private const string _Dpt = "TestDpt";
  private const string _DpExists = "ExistingTestDatapoint";

  private bool _eventStaticError;
  private bool _eventDynamicError;
  private bool _eventSafePosition;
  private float _eventStaticTime;
  private float _eventDynamicTime;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "enabled"), makeDynString("", "safePosition"), makeDynString("", "staticError"), makeDynString("", "dynamicError"), makeDynString("", "staticTime"), makeDynString("", "dynamicTime"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_FLOAT), makeDynInt(0, DPEL_FLOAT));
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
    shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
    assertEqual(monitor.getEnabled(), FALSE);
    assertEqual(monitor.getSafePosition(), FALSE);
    assertEqual(monitor.getStaticError(), FALSE);
    assertEqual(monitor.getDynamicError(), FALSE);
    assertEqual(monitor.getStaticTime(), 0.0);
    assertEqual(monitor.getDynamicTime(), 0.0);

    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".noneEnabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
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
      shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".noneSafePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneSafePosition"));
    }

    try
    {
      shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".noneStaticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneStaticError"));
    }

    try
    {
      shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".noneDynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneDynamicError"));
    }

    try
    {
      shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".noneStaticTime", _DpExists + ".dynamicTime");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneStaticTime"));
    }

    try
    {
      shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".noneDynamicTime");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneDynamicTime"));
    }

    return 0;
  }

  public int testSetGetEnabled()
  {
    shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");

    monitor.setEnabled(TRUE);

    // Give it time to trigger callback.
    delay(0, 200);
    bool enabledValue;
    dpGet(_DpExists + ".enabled", enabledValue);

    assertEqual(monitor.getEnabled(), TRUE);
    assertEqual(enabledValue, TRUE);
    return 0;
  }

  public int testGetStaticError()
  {
    shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
    classConnect(this, setStaticErrorCB, monitor, MtpMonitor::staticErrorChanged);

    dpSetWait(_DpExists + ".staticError", TRUE);

    // Give it time to trigger callback.
    delay(0, 200);
    assertEqual(monitor.getStaticError(), TRUE);
    assertEqual(_eventStaticError, TRUE);
    return 0;
  }

  public int testGetDynamicError()
  {
    shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
    classConnect(this, setDynamicErrorCB, monitor, MtpMonitor::dynamicErrorChanged);

    dpSetWait(_DpExists + ".dynamicError", TRUE);

    // Give it time to trigger callback.
    delay(0, 200);
    assertEqual(monitor.getDynamicError(), TRUE);
    assertEqual(_eventDynamicError, TRUE);
    return 0;
  }

  public int testGetSafePosition()
  {
    shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
    classConnect(this, setSafePositionCB, monitor, MtpMonitor::safePositionChanged);

    dpSetWait(_DpExists + ".safePosition", TRUE);

    // Give it time to trigger callback.
    delay(0, 200);
    assertEqual(monitor.getSafePosition(), TRUE);
    assertEqual(_eventSafePosition, TRUE);
    return 0;
  }

  public int testGetStaticTime()
  {
    dpSetWait(_DpExists + ".staticTime", 123.45);
    shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
    classConnect(this, setStaticTimeCB, monitor, MtpMonitor::staticTimeChanged);

    dpSetWait(_DpExists + ".staticTime", 123.45);

    // Give it time to trigger callback.
    delay(0, 200);
    assertEqual(monitor.getStaticTime(), 123.45);
    assertEqual(_eventStaticTime, 123.45);
    return 0;
  }

  public int testGetDynamicTime()
  {
    dpSetWait(_DpExists + ".dynamicTime", 67.89);
    shared_ptr<MtpMonitor> monitor = new MtpMonitor(_DpExists + ".enabled", _DpExists + ".safePosition", _DpExists + ".staticError", _DpExists + ".dynamicError", _DpExists + ".staticTime", _DpExists + ".dynamicTime");
    classConnect(this, setDynamicTimeCB, monitor, MtpMonitor::dynamicTimeChanged);

    dpSetWait(_DpExists + ".dynamicTime", 67.89);

    // Give it time to trigger callback.
    delay(0, 200);
    assertEqual(monitor.getDynamicTime(), 67.89);
    assertEqual(_eventDynamicTime, 67.89);
    return 0;
  }

  private void setStaticErrorCB(const bool &staticError)
  {
    _eventStaticError = staticError;
  }

  private void setDynamicErrorCB(const bool &dynamicError)
  {
    _eventDynamicError = dynamicError;
  }

  private void setSafePositionCB(const bool &safePosition)
  {
    _eventSafePosition = safePosition;
  }

  private void setStaticTimeCB(const float &staticTime)
  {
    _eventStaticTime = staticTime;
  }

  private void setDynamicTimeCB(const float &dynamicTime)
  {
    _eventDynamicTime = dynamicTime;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpMonitor test;
  test.startAll();
}
