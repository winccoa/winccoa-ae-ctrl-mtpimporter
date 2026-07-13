// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_DataAssembly/MTP_DataAssembly.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_DataAssembly/MTP_DataAssembly.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MTP_DataAssembly/MTP_DataAssembly" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_DataAssembly.ctl
*/
class TstMTPDataAssembly : OaTest
{
  private const string _Dpt = "MTP_DataAssembly";
  private const string _DptInvalidMissingTagName = "MTP_DataAssemblyInvalid1";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpNoneExists = "NoneExistingTestDatapoint";
  private const string _DpExistsInvalidMissingTagName = "ExistingTestDatapointInvalid1";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpSet(_DpExists + ".tagName", (langString)"TagName");

    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_DptInvalidMissingTagName),
                                         makeDynString("", "invalidDpe"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingTagName))
      dpCreate(_DpExistsInvalidMissingTagName, _DptInvalidMissingTagName);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingTagName);

    if (dpTypes(_DptInvalidMissingTagName).count() > 0)
      dpTypeDelete(_DptInvalidMissingTagName);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DataAssembly> dataAssembly = new MTP_DataAssembly(_DpExists);
    assertEqual(dataAssembly.getDp(), _DpExists);
    assertEqual(dataAssembly.getTagName(), (langString)"TagName");
    return 0;
  }

  public int testConstructor_InvalidDp()
  {
    try
    {
      shared_ptr<MTP_DataAssembly> dataAssembly = new MTP_DataAssembly(_DpNoneExists);
      assertTrue(false, "should not reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpNoneExists));
    }

    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_DataAssembly> anaView = new MTP_DataAssembly(_DpExistsInvalidMissingTagName);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingTagName + ".tagName"));
    }

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTPDataAssembly test;
  test.startAll();
}
