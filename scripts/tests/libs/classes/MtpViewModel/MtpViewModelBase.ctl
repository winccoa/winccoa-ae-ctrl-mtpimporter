// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpViewModel/MtpViewModelBase.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpViewModel/MtpViewModelBase.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MtpViewModel/MtpViewModelBase" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants
class MtpViewModelBaseTest : MtpViewModelBase
{
  public MtpViewModelBaseTest(const string &dp): MtpViewModelBase(dp)
  {

  }
};

//-----------------------------------------------------------------------------
/** Tests for MtpViewModelBase.ctl
*/
class TstMtpViewModelBase : OaTest
{
  private const string _Dpt = "TestDpt";
  private const string _DpExists = "ExistingTestDatapoint";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "value"));
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

  public int testConstructor_Protected()
  {
    try
    {
      shared_ptr<MtpViewModelBase> viewModelBase = new MtpViewModelBase(_DpExists);
      assertTrue(false, "shouldn't reach here");
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
    shared_ptr<MtpViewModelBaseTest> viewModelBase = new MtpViewModelBaseTest(_DpExists);
    assertEqual(viewModelBase.getDp(), _DpExists);
    return 0;
  }

  public int testConstructor_NoneExisting()
  {
    try
    {
      shared_ptr<MtpViewModelBaseTest> viewModelBase = new MtpViewModelBaseTest("NoneExistingDp");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains("NoneExistingDp"));
    }

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpViewModelBase test;
  test.startAll();
}
