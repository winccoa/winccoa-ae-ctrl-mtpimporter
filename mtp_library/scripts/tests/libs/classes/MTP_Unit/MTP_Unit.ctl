// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_Unit/MTP_Unit.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_Unit/MTP_Unit.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MTP_Unit/MTP_Unit" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_Unit.ctl
*/
class TstMTP_Unit : OaTest
{
  private const string _Dpt = "TestDptUnit";
  private const string _DpExists = "ExistingTestDatapointUnit";
  private int _unitValue;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "unit"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpSet(_DpExists + ".unit", 1000);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    if (dpTypes(_Dpt).count() > 0)
      dpTypeDelete(_Dpt);
    return OaTest::tearDown();
  }

  public int testConstructorToString()
  {
    shared_ptr<MTP_Unit> unit = new MTP_Unit(_DpExists + ".unit");
    string unitStr = unit.toString();

    assertEqual(unitStr, "K");
    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MTP_Unit> unit = new MTP_Unit("NoneExisting.Dpe");
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
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_Unit test;
  test.startAll();
}
