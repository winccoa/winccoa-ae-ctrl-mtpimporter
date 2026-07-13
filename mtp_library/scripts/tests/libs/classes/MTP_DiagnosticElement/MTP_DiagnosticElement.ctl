// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_DiagnosticElement/MTP_DiagnosticElement.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_DiagnosticElement/MTP_DiagnosticElement.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_DiagnosticElement/MTP_DiagnosticElement" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_DiagnosticElement.ctl
*/
class TstMTP_DiagnosticElement : OaTest
{
  private const string _Dpt = "MTP_DiagnosticElement";
  private const string _DptInvalidMissingWQC = "MTP_DiagnosticElementInvalid1";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpNoneExists = "NoneExistingTestDatapoint";
  private const string _DpExistsInvalidMissingWQC = "ExistingTestDatapointInvalid1";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingWQC),
                          makeDynString("", "tagName"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingWQC))
      dpCreate(_DpExistsInvalidMissingWQC, _DptInvalidMissingWQC);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingWQC);

    if (dpTypes(_DptInvalidMissingWQC).count() > 0)
      dpTypeDelete(_DptInvalidMissingWQC);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DiagnosticElement> diagnosticElement = new MTP_DiagnosticElement(_DpExists);
    assertEqual(diagnosticElement.getDp(), _DpExists);
    assertTrue(diagnosticElement.getWqc() != nullptr);
    return 0;
  }

  public int testConstructor_InvalidDp()
  {
    try
    {
      shared_ptr<MTP_DiagnosticElement> diagnosticElement = new MTP_DiagnosticElement(_DpNoneExists);
      assertTrue(false, "shouldn't reach here");
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
      shared_ptr<MTP_DiagnosticElement> diagnosticElement = new MTP_DiagnosticElement(_DpExistsInvalidMissingWQC);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingWQC + ".WQC"));
    }

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_DiagnosticElement test;
  test.startAll();
}
