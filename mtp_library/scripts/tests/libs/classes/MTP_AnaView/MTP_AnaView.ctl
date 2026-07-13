// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/AnaView/AnaView.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/AnaView/AnaView.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "wizardFramework"
#uses "classes/MTP_AnaView/MTP_AnaView" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for AnaView.ctl
*/
class TstMTP_AnaView : OaTest
{
  private const string _Dpt = "MTP_AnaView";
  private const string _DptInvalidMissingV = "MTP_AnaViewInvalid1";
  private const string _DptInvalidMissingVSclMin = "MTP_AnaViewInvalid2";
  private const string _DptInvalidMissingVSclMax = "MTP_AnaViewInvalid3";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingV = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid3";

  private float _eventValue;

  public int setUp() override
  {

    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "V"),
                                         makeDynString("", "VSclMin"),
                                         makeDynString("", "VSclMax"),
                                         makeDynString("", "VUnit"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_DptInvalidMissingV),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "VSclMin"),
                                         makeDynString("", "VSclMax"),
                                         makeDynString("", "VUnit"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingV))
      dpCreate(_DpExistsInvalidMissingV, _DptInvalidMissingV);

    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMin),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "V"),
                                         makeDynString("", "VSclMax"),
                                         makeDynString("", "VUnit"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVSclMin))
      dpCreate(_DpExistsInvalidMissingVSclMin, _DptInvalidMissingVSclMin);

    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMax),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "V"),
                                         makeDynString("", "VSclMin"),
                                         makeDynString("", "VUnit"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_FLOAT),
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVSclMax))
      dpCreate(_DpExistsInvalidMissingVSclMax, _DptInvalidMissingVSclMax);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingV);

    if (dpTypes(_DptInvalidMissingV).count() > 0)
      dpTypeDelete(_DptInvalidMissingV);

    dpDelete(_DpExistsInvalidMissingVSclMin);

    if (dpTypes(_DptInvalidMissingVSclMin).count() > 0)
      dpTypeDelete(_DptInvalidMissingVSclMin);

    dpDelete(_DpExistsInvalidMissingVSclMax);

    if (dpTypes(_DptInvalidMissingVSclMax).count() > 0)
      dpTypeDelete(_DptInvalidMissingVSclMax);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_AnaView> anaView = new MTP_AnaView(_DpExists);
    assertEqual(anaView.getDp(), _DpExists);
    assertEqual(anaView.getValue(), 0.0);
    assertEqual(anaView.getValueScaleMin(), 0.0);
    assertEqual(anaView.getValueScaleMax(), 0.0);
    assertTrue(anaView.getUnit() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_AnaView> anaView = new MTP_AnaView(_DpExistsInvalidMissingV);
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
      shared_ptr<MTP_AnaView> anaView = new MTP_AnaView(_DpExistsInvalidMissingVSclMin);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMin + ".VSclMin"));
    }

    try
    {
      shared_ptr<MTP_AnaView> anaView = new MTP_AnaView(_DpExistsInvalidMissingVSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMax + ".VSclMax"));
    }

    return 0;
  }

  public int testValueChanged()
  {
    shared_ptr<MTP_AnaView> anaView = new MTP_AnaView(_DpExists);
    classConnect(this, setValueChangedCB, anaView, MTP_AnaView::valueChanged);

    dpSetWait(_DpExists + ".V", 42);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(anaView.getValue(), 42.0);
    assertEqual(_eventValue, 42.0);
    return 0;
  }

  private void setValueChangedCB(const float &value)
  {
    _eventValue = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_AnaView test;
  test.startAll();
}
