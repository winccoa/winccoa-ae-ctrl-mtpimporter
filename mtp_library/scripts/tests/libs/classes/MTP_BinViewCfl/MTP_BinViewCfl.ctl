// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinViewCfl/MTP_BinViewCfl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinViewCfl/MTP_BinViewCfl.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_BinViewCfl/MTP_BinViewCfl"
#uses "classes/oaTest/OaTest"

class TstMTP_BinViewCfl : OaTest
{
  private const string _Dpt = "TstMTP_BinViewCfl";
  private const string _DptInvalidMissingEnabled = "TstMTP_BinViewCflInvalid1";
  private const string _DpExists = "TstMTP_BinViewCflDp";
  private const string _DpExistsInvalidMissingEnabled = "TstMTP_BinViewCflInvalidDp1";

  private bool _eventEnabled;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "V"),
                                         makeDynString("", "VState0"),
                                         makeDynString("", "VState1"),
                                         makeDynString("", "enabled"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_STRING),
                                        makeDynInt(0, DPEL_STRING),
                                        makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingEnabled),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "V"),
                          makeDynString("", "VState0"),
                          makeDynString("", "VState1"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_STRING),
                            makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingEnabled))
      dpCreate(_DpExistsInvalidMissingEnabled, _DptInvalidMissingEnabled);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    if (dpTypes(_Dpt).count() > 0)
      dpTypeDelete(_Dpt);

    dpDelete(_DpExistsInvalidMissingEnabled);

    if (dpTypes(_DptInvalidMissingEnabled).count() > 0)
      dpTypeDelete(_DptInvalidMissingEnabled);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_BinViewCfl> binViewCfl = new MTP_BinViewCfl(_DpExists);

    assertEqual(binViewCfl.getDp(), _DpExists);
    assertFalse(binViewCfl.getEnabled());
    assertTrue(binViewCfl.getWqc() != nullptr);

    dpSetWait(_DpExists + ".enabled", TRUE);
    delay(0, 200);
    assertTrue(binViewCfl.getEnabled());
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_BinViewCfl> binViewCfl = new MTP_BinViewCfl(_DpExistsInvalidMissingEnabled);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingEnabled + ".enabled"));
    }

    return 0;
  }

  public int testEnabledChanged()
  {
    shared_ptr<MTP_BinViewCfl> binViewCfl = new MTP_BinViewCfl(_DpExists);
    classConnect(this, enabledChangedCB, binViewCfl, MTP_BinViewCfl::enabledChanged);
    _eventEnabled = FALSE;

    dpSetWait(_DpExists + ".enabled", TRUE);

    delay(0, 200);
    assertTrue(_eventEnabled);
    return 0;
  }

  private void enabledChangedCB(const bool &enabled)
  {
    _eventEnabled = enabled;
  }
};

void main()
{
  TstMTP_BinViewCfl test;
  test.startAll();
}
