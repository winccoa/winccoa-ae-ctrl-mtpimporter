// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpUnit/MtpUnit.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpUnit/MtpUnit.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpUnit/MtpUnit" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpUnit.ctl
*/
class TstMtpUnit : OaTest
{
  private const string _Dpt = "TestDptUnit";
  private const string _DpExists = "ExistingTestDatapointUnit";
  private int _unitValue;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "unit"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_INT));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExists, _Dpt);

    dpSet(_DpExists + ".unit", 1000);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpTypeDelete(_Dpt);
    return OaTest::tearDown();
  }

  public int testConstructorToString()
  {
    shared_ptr<MtpUnit> unit = new MtpUnit(_DpExists + ".unit");
    string unitStr = unit.toString();

    assertEqual(unitStr, "K");
    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpUnit> unit = new MtpUnit("NoneExisting.Dpe");
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
  TstMtpUnit test;
  test.startAll();
}
