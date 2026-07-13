// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_Wqc/MTP_Wqc.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_Wqc/MTP_Wqc.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MTP_Wqc/MTP_Wqc" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_Wqc.ctl
*/
class TstMTP_Wqc : OaTest
{
  private const string _Dpt = "TestDpt";
  private const string _DpExists = "ExistingTestDatapoint";

  private bool _eventQuality;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "qc"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    if (dpTypes(_Dpt).count() > 0)
      dpTypeDelete(_Dpt);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_Wqc> qc = new MTP_Wqc(_DpExists + ".qc");
    assertEqual(qc.getQualityGood(), FALSE);

    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MTP_Wqc> osLevel = new MTP_Wqc("NoneExisting.Dpe");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains("NoneExisting.Dpe"));
    }

    return 0;
  }

  public int testSetGetQc()
  {
    shared_ptr<MTP_Wqc> qc = new MTP_Wqc(_DpExists + ".qc");
    classConnect(this, setQcCB, qc, MTP_Wqc::qualityGoodChanged);

    bit32 value = 0x80;

    dpSetWait(_DpExists + ".qc", value);

    // Give it time to execute callback.
    delay(0, 200);

    assertEqual(qc.getQualityGood(), TRUE);
    assertEqual(_eventQuality, TRUE);

    bit32 value = 0xFF;

    dpSetWait(_DpExists + ".qc", value);

    // Give it time to execute callback.
    delay(0, 200);

    assertEqual(qc.getQualityGood(), TRUE);
    assertEqual(_eventQuality, TRUE);

    bit32 value = 0xFD;

    dpSetWait(_DpExists + ".qc", value);

    // Give it time to execute callback.
    delay(0, 200);

    assertEqual(qc.getQualityGood(), FALSE);
    assertEqual(_eventQuality, FALSE);

    return 0;
  }

  private void setQcCB(const bool &quality)
  {
    _eventQuality = quality;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_Wqc test;
  test.startAll();
}
