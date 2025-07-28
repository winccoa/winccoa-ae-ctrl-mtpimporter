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
  private const string _DptInvalidMissingEnabled = "TestDptInvalidMissingEnabled";
  private const string _DptInvalidMissingTagName = "TestDptInvalidMissingTagName";
  private const string _DpExistsInvalidMissingEnabled = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingTagName = "ExistingTestDatapointInvalid2";
  private bool _eventEnabled;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "value"),
                                         makeDynString("", "enabled"),
                                         makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingEnabled),
             makeDynString("", "value"),
             makeDynString("", "tagName"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_LANGSTRING));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingEnabled, _DptInvalidMissingEnabled);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingTagName),
             makeDynString("", "value"),
             makeDynString("", "enabled"));
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingTagName, _DptInvalidMissingTagName);

    // Set a default tagName value for testing
    langString defaultTagName;
    setLangString(defaultTagName, getLangIdx("de_AT.utf8"), "TestTag");
    dpSetWait(_DpExists + ".tagName", defaultTagName);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpTypeDelete(_Dpt);

    dpDelete(_DpExistsInvalidMissingEnabled);
    dpTypeDelete(_DptInvalidMissingEnabled);

    dpDelete(_DpExistsInvalidMissingTagName);
    dpTypeDelete(_DptInvalidMissingTagName);
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
    assertEqual(viewModelBase.getEnabled(), false);
    langString tagName = viewModelBase.getTagName();
    assertTrue(tagName.text(getLangIdx("de_AT.utf8")) == "TestTag", "tagName should be initialized to 'TestTag'");

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

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MtpViewModelBaseTest> viewModelBase = new MtpViewModelBaseTest(_DpExistsInvalidMissingEnabled);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingEnabled + ".enabled"));
    }

    try
    {
      shared_ptr<MtpViewModelBaseTest> viewModelBase = new MtpViewModelBaseTest(_DpExistsInvalidMissingTagName);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingTagName + ".tagName"));
    }

    return 0;
  }

  public int testEnabledChanged()
  {
    shared_ptr<MtpViewModelBaseTest> viewModelBase = new MtpViewModelBaseTest(_DpExists);
    classConnect(this, setEnabledChangedCB, viewModelBase, MtpViewModelBase::enabledChanged);

    dpSetWait(_DpExists + ".enabled", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertTrue(viewModelBase.getEnabled());
    assertTrue(_eventEnabled);
    return 0;
  }

  private void setEnabledChangedCB(const bool &enabled)
  {
    _eventEnabled = enabled;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpViewModelBase test;
  test.startAll();
}
