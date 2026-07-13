// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_StringView/MTP_StringView.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_StringView/MTP_StringView.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_StringView/MTP_StringView"
#uses "classes/oaTest/OaTest"

class TstMTP_StringView : OaTest
{
  private const string _Dpt = "MTP_StringView";
  private const string _DptInvalidMissingText = "MTP_StringViewInvalid1";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingText = "ExistingTestDatapointInvalid1";

  private string _eventText;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "Text"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingText),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingText))
      dpCreate(_DpExistsInvalidMissingText, _DptInvalidMissingText);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingText);

    if (dpTypes(_DptInvalidMissingText).count() > 0)
      dpTypeDelete(_DptInvalidMissingText);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_StringView> stringView = new MTP_StringView(_DpExists);
    assertEqual(stringView.getDp(), _DpExists);
    assertTrue(stringView.getWqc() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_StringView> stringView = new MTP_StringView(_DpExistsInvalidMissingText);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingText + ".Text"));
    }

    return 0;
  }

  public int testTextChanged()
  {
    shared_ptr<MTP_StringView> stringView = new MTP_StringView(_DpExists);
    classConnect(this, setTextChangedCB, stringView, MTP_StringView::textChanged);
    _eventText = "";

    dpSetWait(_DpExists + ".Text", "Hello World");

    delay(0, 200);
    assertEqual(stringView.getText(), "Hello World");
    assertEqual(_eventText, "Hello World");
    return 0;
  }

  private void setTextChangedCB(const string &text)
  {
    _eventText = text;
  }
};

void main()
{
  TstMTP_StringView test;
  test.startAll();
}
