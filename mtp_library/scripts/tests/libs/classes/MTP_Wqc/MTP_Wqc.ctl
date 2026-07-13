// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_Wqc/MTP_Wqc.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_Wqc/MTP_Wqc.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/oaTest/OaTest"

class TstMTP_Wqc : OaTest
{
  private const string _Dpt = "MTP_Wqc";
  private const string _DpExists = "ExistingTestDatapointWqc";

  private bool _eventQualityGood;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "qc"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);
    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    dpSetWait(_DpExists + ".qc", (bit32)0x80);
    shared_ptr<MTP_Wqc> wqc = new MTP_Wqc(_DpExists + ".qc");
    delay(0, 200);
    assertTrue(wqc.getQualityGood());
    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MTP_Wqc> wqc = new MTP_Wqc(_DpExists + ".noneQc");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExists + ".noneQc"));
    }

    return 0;
  }

  public int testQualityGoodChanged()
  {
    shared_ptr<MTP_Wqc> wqc = new MTP_Wqc(_DpExists + ".qc");
    classConnect(this, setQualityGoodChangedCB, wqc, MTP_Wqc::qualityGoodChanged);

    dpSetWait(_DpExists + ".qc", (bit32)0x80);
    delay(0, 200);
    assertTrue(wqc.getQualityGood());
    assertTrue(_eventQualityGood);

    dpSetWait(_DpExists + ".qc", (bit32)0x01);
    delay(0, 200);
    assertFalse(wqc.getQualityGood());
    assertFalse(_eventQualityGood);

    dpSetWait(_DpExists + ".qc", (bit32)0xFF);
    delay(0, 200);
    assertTrue(wqc.getQualityGood());
    assertTrue(_eventQualityGood);

    return 0;
  }

  private void setQualityGoodChangedCB(const bool &qualityGood)
  {
    _eventQualityGood = qualityGood;
  }
};

void main()
{
  TstMTP_Wqc test;
  test.startAll();
}
