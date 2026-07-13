// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_DIntView/MTP_DIntView.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_DIntView/MTP_DIntView.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_DIntView/MTP_DIntView"
#uses "classes/oaTest/OaTest"

class TstMTP_DIntView : OaTest
{
  private const string _Dpt = "MTP_DIntView";
  private const string _DptInvalidMissingV = "MTP_DIntViewInvalid1";
  private const string _DptInvalidMissingVSclMin = "MTP_DIntViewInvalid2";
  private const string _DptInvalidMissingVSclMax = "MTP_DIntViewInvalid3";
  private const string _DptInvalidMissingVUnit = "MTP_DIntViewInvalid4";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingV = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingVSclMin = "ExistingTestDatapointInvalid2";
  private const string _DpExistsInvalidMissingVSclMax = "ExistingTestDatapointInvalid3";
  private const string _DpExistsInvalidMissingVUnit = "ExistingTestDatapointInvalid4";

  private int _eventValue;

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
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingV),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingV))
      dpCreate(_DpExistsInvalidMissingV, _DptInvalidMissingV);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMin),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVSclMin))
      dpCreate(_DpExistsInvalidMissingVSclMin, _DptInvalidMissingVSclMin);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVSclMax),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VUnit"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVSclMax))
      dpCreate(_DpExistsInvalidMissingVSclMax, _DptInvalidMissingVSclMax);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVUnit),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVUnit))
      dpCreate(_DpExistsInvalidMissingVUnit, _DptInvalidMissingVUnit);

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

    dpDelete(_DpExistsInvalidMissingVUnit);

    if (dpTypes(_DptInvalidMissingVUnit).count() > 0)
      dpTypeDelete(_DptInvalidMissingVUnit);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DIntView> dIntView = new MTP_DIntView(_DpExists);
    int expectedInitialValue = 0;
    assertEqual(dIntView.getDp(), _DpExists);
    assertEqual(dIntView.getValue(), expectedInitialValue);
    assertEqual(dIntView.getValueScaleMin(), expectedInitialValue);
    assertEqual(dIntView.getValueScaleMax(), expectedInitialValue);
    assertTrue(dIntView.getUnit() != nullptr);
    assertTrue(dIntView.getWqc() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_DIntView> dIntView = new MTP_DIntView(_DpExistsInvalidMissingV);
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
      shared_ptr<MTP_DIntView> dIntView = new MTP_DIntView(_DpExistsInvalidMissingVSclMin);
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
      shared_ptr<MTP_DIntView> dIntView = new MTP_DIntView(_DpExistsInvalidMissingVSclMax);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVSclMax + ".VSclMax"));
    }

    try
    {
      shared_ptr<MTP_DIntView> dIntView = new MTP_DIntView(_DpExistsInvalidMissingVUnit);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVUnit + ".VUnit"));
    }

    return 0;
  }

  public int testValueChanged()
  {
    shared_ptr<MTP_DIntView> dIntView = new MTP_DIntView(_DpExists);
    classConnect(this, setValueChangedCB, dIntView, MTP_DIntView::valueChanged);
    _eventValue = 0;
    int expectedValue = 123;

    dpSetWait(_DpExists + ".V", expectedValue);

    delay(0, 200);
    assertEqual(dIntView.getValue(), expectedValue);
    assertEqual(_eventValue, expectedValue);
    return 0;
  }

  private void setValueChangedCB(const int &value)
  {
    _eventValue = value;
  }
};

void main()
{
  TstMTP_DIntView test;
  test.startAll();
}
