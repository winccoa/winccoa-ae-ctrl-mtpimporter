// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_IndicatorElement/MTP_IndicatorElement.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_IndicatorElement/MTP_IndicatorElement.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_IndicatorElement/MTP_IndicatorElement" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_IndicatorElement.ctl
*/
class TstMTPIndicatorElement : OaTest
{
  private const string _Dpt = "MTP_IndicatorElement";
  private const string _DpExists = "ExistingTestDatapoint";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"));
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
    shared_ptr<MTP_IndicatorElement> indicatorElement = new MTP_IndicatorElement(_DpExists);
    assertTrue(indicatorElement.getWqc() != nullptr);
    return 0;
  }

};

//-----------------------------------------------------------------------------
void main()
{
  TstMTPIndicatorElement test;
  test.startAll();
}
