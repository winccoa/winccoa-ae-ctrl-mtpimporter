// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpSecurity/MtpSecurity.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpSecurity/MtpSecurity.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpSecurity/MtpSecurity" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpSecurity.ctl
*/
class TstMtpSecurity : OaTest
{
  private const string _Dpt = "TestDptSecurity";
  private const string _DpExists = "ExistingTestDatapointSecurity";

  private bool _eventPermissionEnabled;
  private bool _eventPermit;
  private bool _eventInterlockEnabled;
  private bool _eventInterlock;
  private bool _eventProtectionEnabled;
  private bool _eventProtection;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "permissionEnabled"), makeDynString("", "permit"), makeDynString("", "interlockEnabled"), makeDynString("", "interlock"), makeDynString("", "protectionEnabled"), makeDynString("", "protection"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
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
    shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
    assertEqual(sec.getPermissionEnabled(), FALSE);
    assertEqual(sec.getPermit(), FALSE);
    assertEqual(sec.getInterlockEnabled(), FALSE);
    assertEqual(sec.getInterlock(), FALSE);
    assertEqual(sec.getProtectionEnabled(), FALSE);
    assertEqual(sec.getProtection(), FALSE);

    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".nonePermissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".nonePermissionEnabled"));
    }

    try
    {
      shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".nonePermit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".nonePermit"));
    }

    try
    {
      shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".noneInterlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneInterlockEnabled"));
    }

    try
    {
      shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".noneInterlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneInterlock"));
    }

    try
    {
      shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".noneProtectionEnabled", _DpExists + ".protection");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneProtectionEnabled"));
    }

    try
    {
      shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".noneProtection");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneProtection"));
    }

    return 0;
  }

  public int testGetPermissionEnabled()
  {
    shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
    classConnect(this, setPermissionEnabledCB, sec, MtpSecurity::permissionEnabledChanged);

    dpSetWait(_DpExists + ".permissionEnabled", TRUE);

    delay(0, 200);
    assertEqual(sec.getPermissionEnabled(), TRUE);
    assertEqual(_eventPermissionEnabled, TRUE);
    return 0;
  }

  public int testGetPermit()
  {
    shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
    classConnect(this, setPermitCB, sec, MtpSecurity::permitChanged);

    dpSetWait(_DpExists + ".permit", TRUE);

    delay(0, 200);
    assertEqual(sec.getPermit(), TRUE);
    assertEqual(_eventPermit, TRUE);
    return 0;
  }

  public int testGetInterlockEnabled()
  {
    shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
    classConnect(this, setInterlockEnabledCB, sec, MtpSecurity::interlockEnabledChanged);

    dpSetWait(_DpExists + ".interlockEnabled", TRUE);

    delay(0, 200);
    assertEqual(sec.getInterlockEnabled(), TRUE);
    assertEqual(_eventInterlockEnabled, TRUE);
    return 0;
  }

  public int testGetInterlock()
  {
    shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
    classConnect(this, setInterlockCB, sec, MtpSecurity::interlockChanged);

    dpSetWait(_DpExists + ".interlock", TRUE);

    delay(0, 200);
    assertEqual(sec.getInterlock(), TRUE);
    assertEqual(_eventInterlock, TRUE);
    return 0;
  }

  public int testGetProtectionEnabled()
  {
    shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
    classConnect(this, setProtectionEnabledCB, sec, MtpSecurity::protectionEnabledChanged);

    dpSetWait(_DpExists + ".protectionEnabled", TRUE);

    delay(0, 200);
    assertEqual(sec.getProtectionEnabled(), TRUE);
    assertEqual(_eventProtectionEnabled, TRUE);
    return 0;
  }

  public int testGetProtection()
  {
    shared_ptr<MtpSecurity> sec = new MtpSecurity(_DpExists + ".permissionEnabled", _DpExists + ".permit", _DpExists + ".interlockEnabled", _DpExists + ".interlock", _DpExists + ".protectionEnabled", _DpExists + ".protection");
    classConnect(this, setProtectionCB, sec, MtpSecurity::protectionChanged);

    dpSetWait(_DpExists + ".protection", TRUE);

    delay(0, 200);
    assertEqual(sec.getProtection(), TRUE);
    assertEqual(_eventProtection, TRUE);
    return 0;
  }

  private void setPermissionEnabledCB(const bool &value)
  {
    _eventPermissionEnabled = value;
  }

  private void setPermitCB(const bool &value)
  {
    _eventPermit = value;
  }

  private void setInterlockEnabledCB(const bool &value)
  {
    _eventInterlockEnabled = value;
  }

  private void setInterlockCB(const bool &value)
  {
    _eventInterlock = value;
  }

  private void setProtectionEnabledCB(const bool &value)
  {
    _eventProtectionEnabled = value;
  }

  private void setProtectionCB(const bool &value)
  {
    _eventProtection = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpSecurity test;
  test.startAll();
}
