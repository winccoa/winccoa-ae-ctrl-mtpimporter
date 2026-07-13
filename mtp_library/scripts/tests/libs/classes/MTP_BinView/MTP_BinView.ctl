// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinView/MTP_BinView.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinView/MTP_BinView.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_BinView/MTP_BinView" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_BinView.ctl
*/
class TstMTP_BinView : OaTest
{
  private const string _Dpt = "MTP_BinView";
  private const string _DptInvalidMissingV = "MTP_BinViewInvalid1";
  private const string _DptInvalidMissingVState0 = "MTP_BinViewInvalid2";
  private const string _DptInvalidMissingVState1 = "MTP_BinViewInvalid3";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingV = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVState0 = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVState1 = "ExistingTestDatapointInvalid3";

  private bool _eventValue;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "V"),
                                         makeDynString("", "VState0"),
                                         makeDynString("", "VState1"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_STRING),
                                        makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingV),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "VState0"),
                          makeDynString("", "VState1"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_STRING),
                            makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingV))
      dpCreate(_DpExistsInvalidMissingV, _DptInvalidMissingV);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVState0),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VState1"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVState0))
      dpCreate(_DpExistsInvalidMissingVState0, _DptInvalidMissingVState0);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVState1),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VState0"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVState1))
      dpCreate(_DpExistsInvalidMissingVState1, _DptInvalidMissingVState1);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingV);

    if (dpTypes(_DptInvalidMissingV).count() > 0)
      dpTypeDelete(_DptInvalidMissingV);

    dpDelete(_DpExistsInvalidMissingVState0);

    if (dpTypes(_DptInvalidMissingVState0).count() > 0)
      dpTypeDelete(_DptInvalidMissingVState0);

    dpDelete(_DpExistsInvalidMissingVState1);

    if (dpTypes(_DptInvalidMissingVState1).count() > 0)
      dpTypeDelete(_DptInvalidMissingVState1);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_BinView> binView = new MTP_BinView(_DpExists);
    assertEqual(binView.getDp(), _DpExists);
    assertEqual(binView.getValue(), false);
    assertEqual(binView.getValueStateFalseText(), "");
    assertEqual(binView.getValueStateTrueText(), "");
    assertTrue(binView.getWqc() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_BinView> binView = new MTP_BinView(_DpExistsInvalidMissingV);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingV + ".V"));
    }

    try
    {
      shared_ptr<MTP_BinView> binView = new MTP_BinView(_DpExistsInvalidMissingVState0);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVState0 + ".VState0"));
    }

    try
    {
      shared_ptr<MTP_BinView> binView = new MTP_BinView(_DpExistsInvalidMissingVState1);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVState1 + ".VState1"));
    }

    return 0;
  }

  public int testValueChanged()
  {
    shared_ptr<MTP_BinView> binView = new MTP_BinView(_DpExists);
    classConnect(this, setValueChangedCB, binView, MTP_BinView::valueChanged);
    _eventValue = false;

    dpSetWait(_DpExists + ".V", true);

    delay(0, 200);
    assertEqual(binView.getValue(), true);
    assertEqual(_eventValue, true);
    return 0;
  }

  private void setValueChangedCB(const bool &value)
  {
    _eventValue = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_BinView test;
  test.startAll();
}
