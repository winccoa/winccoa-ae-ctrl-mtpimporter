// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_OperationElement/MTP_OperationElement.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_OperationElement/MTP_OperationElement.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_OperationElement/MTP_OperationElement" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_OperationElement.ctl
*/
class TstMTP_OperationElement : OaTest
{
  private const string _Dpt = "MTP_OperationElement";
  private const string _DptInvalidMissingOsLevel = "MTP_OperationElementInvalid1";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingOsLevel = "ExistingTestDatapointInvalid1";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "OSLevel"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingOsLevel),
                          makeDynString("", "tagName"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingOsLevel))
      dpCreate(_DpExistsInvalidMissingOsLevel, _DptInvalidMissingOsLevel);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingOsLevel);

    if (dpTypes(_DptInvalidMissingOsLevel).count() > 0)
      dpTypeDelete(_DptInvalidMissingOsLevel);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_OperationElement> operationElement = new MTP_OperationElement(_DpExists);
    assertEqual(operationElement.getDp(), _DpExists);
    assertTrue(operationElement.getOsLevel() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_OperationElement> operationElement = new MTP_OperationElement(_DpExistsInvalidMissingOsLevel);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingOsLevel + ".OSLevel"));
    }

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_OperationElement test;
  test.startAll();
}
