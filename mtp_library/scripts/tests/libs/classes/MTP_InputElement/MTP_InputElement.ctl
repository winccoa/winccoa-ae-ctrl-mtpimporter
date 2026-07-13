// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_InputElement/MTP_InputElement.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_InputElement/MTP_InputElement.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_InputElement/MTP_InputElement"
#uses "classes/oaTest/OaTest"

/** Tests for MTP_InputElement.ctl
*/
class TstMTP_InputElement : OaTest
{
  private const string _Dpt = "MTP_InputElement";
  private const string _DptInvalidMissingTagName = "MTP_InputElementInvalid1";
  private const string _DptInvalidMissingWQC = "MTP_InputElementInvalid2";
  private const string _DptInvalidMissingVQC = "MTP_InputElementInvalid3";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpNoneExists = "NoneExistingTestDatapoint";
  private const string _DpExistsInvalidMissingTagName = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingWQC = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVQC = "ExistingTestDatapointInvalid3";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "VQC"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingTagName),
                          makeDynString("", "WQC"),
                          makeDynString("", "VQC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingTagName))
      dpCreate(_DpExistsInvalidMissingTagName, _DptInvalidMissingTagName);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingWQC),
                          makeDynString("", "tagName"),
                          makeDynString("", "VQC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingWQC))
      dpCreate(_DpExistsInvalidMissingWQC, _DptInvalidMissingWQC);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVQC),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVQC))
      dpCreate(_DpExistsInvalidMissingVQC, _DptInvalidMissingVQC);

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

    dpDelete(_DpExistsInvalidMissingVQC);

    if (dpTypes(_DptInvalidMissingVQC).count() > 0)
      dpTypeDelete(_DptInvalidMissingVQC);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_InputElement> inputElement = new MTP_InputElement(_DpExists);
    assertEqual(inputElement.getDp(), _DpExists);
    assertTrue(inputElement.getWqc() != nullptr);
    assertTrue(inputElement.getVqc() != nullptr);
    return 0;
  }

  public int testConstructor_InvalidDp()
  {
    try
    {
      shared_ptr<MTP_InputElement> inputElement = new MTP_InputElement(_DpNoneExists);
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
      shared_ptr<MTP_InputElement> inputElement = new MTP_InputElement(_DpExistsInvalidMissingTagName);
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
      shared_ptr<MTP_InputElement> inputElement = new MTP_InputElement(_DpExistsInvalidMissingWQC);
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
      shared_ptr<MTP_InputElement> inputElement = new MTP_InputElement(_DpExistsInvalidMissingVQC);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVQC + ".VQC"));
    }

    return 0;
  }
};

void main()
{
  TstMTP_InputElement test;
  test.startAll();
}
