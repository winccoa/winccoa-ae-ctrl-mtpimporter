// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_ValueLimit/MTP_ValueLimitDInt.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_ValueLimit/MTP_ValueLimitDInt.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_ValueLimit/MTP_ValueLimitDInt" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_ValueLimitDInt.ctl
*/
class TstMtpValueLimitDInt : OaTest
{
  private const string _Dpt = "TestDpt";
  private const string _DpExists = "ExistingTestDatapoint";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "limit"), makeDynString("", "enabled"), makeDynString("", "active"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    if (dpTypes(_Dpt).count() > 0)
      dpTypeDelete(_Dpt);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_ValueLimitDInt> limitDInt = new MTP_ValueLimitDInt(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".active");
    int expectedLimit = 0;
    assertEqual(limitDInt.getLimit(), expectedLimit);

    return 0;
  }

  public int testSetGetLimit()
  {
    shared_ptr<MTP_ValueLimitDInt> limitDInt = new MTP_ValueLimitDInt(_DpExists + ".limit", _DpExists + ".enabled", _DpExists + ".active");

    int expectedLimit = 42;
    limitDInt.setLimit(expectedLimit);

    int limitValue;
    dpGet(_DpExists + ".limit", limitValue);

    assertEqual(limitDInt.getLimit(), expectedLimit);
    assertEqual(limitValue, expectedLimit);

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpValueLimitDInt test;
  test.startAll();
}
