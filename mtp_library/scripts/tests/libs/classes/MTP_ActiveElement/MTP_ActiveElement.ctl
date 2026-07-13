// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_ActiveElement/MTP_ActiveElement.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_ActiveElement/MTP_ActiveElement.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_ActiveElement/MTP_ActiveElement" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_ActiveElement.ctl
*/
class TstMTP_ActiveElement : OaTest
{
  private const string _Dpt = "MTP_ActiveElement";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpNoneExists = "NoneExistingTestDatapoint";
  private const string _DptInvalidMissingTagName = "MTP_ActiveElementInvalid1";
  private const string _DpExistsInvalidMissingTagName = "ExistingTestDatapointInvalid1";
  private const string _DptInvalidMissingWQC = "MTP_ActiveElementInvalid2";
  private const string _DpExistsInvalidMissingWQC = "ExistingTestDatapointInvalid2";
  private const string _DptInvalidMissingOSLevel = "MTP_ActiveElementInvalid3";
  private const string _DpExistsInvalidMissingOSLevel = "ExistingTestDatapointInvalid3";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "OSLevel"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingTagName),
                          makeDynString("", "WQC"),
                          makeDynString("", "OSLevel"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingTagName))
      dpCreate(_DpExistsInvalidMissingTagName, _DptInvalidMissingTagName);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingWQC),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingWQC))
      dpCreate(_DpExistsInvalidMissingWQC, _DptInvalidMissingWQC);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingOSLevel),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingOSLevel))
      dpCreate(_DpExistsInvalidMissingOSLevel, _DptInvalidMissingOSLevel);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingTagName);

    if (dpTypes(_DptInvalidMissingTagName).count() > 0)
      dpTypeDelete(_DptInvalidMissingTagName);

    dpDelete(_DpExistsInvalidMissingWQC);

    if (dpTypes(_DptInvalidMissingWQC).count() > 0)
      dpTypeDelete(_DptInvalidMissingWQC);

    dpDelete(_DpExistsInvalidMissingOSLevel);

    if (dpTypes(_DptInvalidMissingOSLevel).count() > 0)
      dpTypeDelete(_DptInvalidMissingOSLevel);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_ActiveElement> activeElement = new MTP_ActiveElement(_DpExists);
    assertEqual(activeElement.getDp(), _DpExists);
    assertTrue(activeElement.getWqc() != nullptr);
    assertTrue(activeElement.getOsLevel() != nullptr);
    return 0;
  }

  public int testConstructor_InvalidDp()
  {
    try
    {
      shared_ptr<MTP_ActiveElement> activeElement = new MTP_ActiveElement(_DpNoneExists);
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
      shared_ptr<MTP_ActiveElement> activeElement = new MTP_ActiveElement(_DpExistsInvalidMissingTagName);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingTagName + ".tagName"));
    }

    try
    {
      shared_ptr<MTP_ActiveElement> activeElement = new MTP_ActiveElement(_DpExistsInvalidMissingWQC);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingWQC + ".WQC"));
    }

    try
    {
      shared_ptr<MTP_ActiveElement> activeElement = new MTP_ActiveElement(_DpExistsInvalidMissingOSLevel);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingOSLevel + ".OSLevel"));
    }

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_ActiveElement test;
  test.startAll();
}
