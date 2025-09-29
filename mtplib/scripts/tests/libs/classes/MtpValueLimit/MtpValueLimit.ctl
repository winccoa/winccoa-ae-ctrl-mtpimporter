// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpValueLimit/MtpValueLimit.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpValueLimit/MtpValueLimit.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpValueLimit/MtpValueLimit" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants
class MtpValueLimitTest : MtpValueLimit
{
  public MtpValueLimitTest(const string &dpeLimit, const string &dpeEnabled, const string &dpeActive): MtpValueLimit(dpeLimit, dpeEnabled, dpeActive)
  {

  }

  public anytype getLimit()override
  {
    return MtpValueLimit::getLimit();
  }

  public void setLimit(const anytype &value) override
  {
    MtpValueLimit::setLimit(value);
  }
};

//-----------------------------------------------------------------------------
/** Tests for MtpValueLimit.ctl
*/
class TstMtpValueLimit : OaTest
{
  private const string _Dpt = "TestDpt";
  private const string _DpExists = "ExistingTestDatapoint";
  private bool _eventActive;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "limit"), makeDynString("", "enabled"), makeDynString("", "active"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
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

  public int testConstructor_Protected()
  {
    try
    {
      shared_ptr<MtpValueLimit> limit = new MtpValueLimit(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".active");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertTrue(getErrorText(err).contains("protected"));
    }

    return 0;
  }

  public int testConstructor()
  {
    shared_ptr<MtpValueLimitTest> limit = new MtpValueLimitTest(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".active");

    assertEqual(limit.getLimit(), 0);
    assertEqual(limit.getEnabled(), FALSE);
    assertEqual(limit.getActive(), FALSE);

    return 0;
  }

  public int testConstructor_NonExistingDpes()
  {
    try
    {
      shared_ptr<MtpValueLimitTest> limit = new MtpValueLimitTest(_DpExists + ".noneLimit", _DpExists + ".enabled", _DpExists + ".active");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains("noneLimit"));
    }

    try
    {
      shared_ptr<MtpValueLimitTest> limit = new MtpValueLimitTest(_DpExists + ".limit", _DpExists + ".noneEnabled", _DpExists + ".active");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains("noneEnabled"));
    }

    try
    {
      shared_ptr<MtpValueLimitTest> limit = new MtpValueLimitTest(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".noneActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains("noneActive"));
    }

    return 0;
  }

  public int testSetGetLimit()
  {
    shared_ptr<MtpValueLimitTest> limit = new MtpValueLimitTest(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".active");

    limit.setLimit(123);
    int limitValue;
    dpGet(_DpExists + ".limit", limitValue);

    assertEqual(limit.getLimit(), 123);
    assertEqual(limitValue, 123);
    return 0;
  }

  public int testGetActive()
  {
    shared_ptr<MtpValueLimitTest> limit = new MtpValueLimitTest(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".active");
    classConnect(this, setActiveCB, limit, MtpValueLimitTest::activeChanged);

    dpSetWait(_DpExists + ".active", TRUE);
    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(limit.getActive(), TRUE);
    assertEqual(_eventActive, TRUE);

    return 0;
  }

  private void setActiveCB(const bool &active)
  {
    _eventActive = active;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpValueLimit test;
  test.startAll();
}
