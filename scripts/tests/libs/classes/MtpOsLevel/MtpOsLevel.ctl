// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpOsLevel/MtpOsLevel.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpOsLevel/MtpOsLevel.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpOsLevel/MtpOsLevel" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpOsLevel.ctl
*/
class TstMtpOsLevel : OaTest
{
  private const string _Dpt = "TestDpt";
  private const string _DpExists = "ExistingTestDatapoint";

  private int _eventLevel;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "osLevel"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_INT));
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
    shared_ptr<MtpOsLevel> osLevel = new MtpOsLevel(_DpExists + ".osLevel");
    assertEqual(osLevel.getLevel(), 0);

    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpOsLevel> osLevel = new MtpOsLevel("NoneExisting.Dpe");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains("NoneExisting.Dpe"));
    }

    return 0;
  }

  public int testGetLevel()
  {
    shared_ptr<MtpOsLevel> osLevel = new MtpOsLevel(_DpExists + ".osLevel");
    classConnect(this, setOsLevelCB, osLevel, MtpOsLevel::osLevelChanged);

    dpSetWait(_DpExists + ".osLevel", 12);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(osLevel.getLevel(), 12);
    assertEqual(_eventLevel, 12);
    return 0 ;
  }

  private void setOsLevelCB(const int &level)
  {
    _eventLevel = level;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpOsLevel test;
  test.startAll();
}
