// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpValueLimit/MtpValueLimitInt.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpValueLimit/MtpValueLimitInt.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MtpValueLimit/MtpValueLimitInt" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpValueLimitInt.ctl
*/
class TstMtpValueLimitInt : OaTest
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

  public int testConstructor()
  {
    shared_ptr<MtpValueLimitInt> limitInt = new MtpValueLimitInt(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".active");
    assertEqual(limitInt.getLimit(), 0);

    return 0;
  }

  public int testSetGetLimit()
  {
    shared_ptr<MtpValueLimitInt> limitInt = new MtpValueLimitInt(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".active");

    limitInt.setLimit(42);
    int limitValue;
    dpGet(_DpExists + ".limit", limitValue);

    assertEqual(limitInt.getLimit(), 42);
    assertEqual(limitValue, 42);

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpValueLimitInt test;
  test.startAll();
}
