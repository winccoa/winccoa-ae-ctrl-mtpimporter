// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BarIndicator/MTP_BarIndicator.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BarIndicator/MTP_BarIndicator.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_BarIndicator/MTP_BarIndicator"
#uses "classes/oaTest/OaTest"

class TstMTP_BarIndicator : OaTest
{
  public int testConstructor_MissingShapes()
  {
    try
    {
      shared_ptr<MTP_BarIndicator> barIndicator = new MTP_BarIndicator(makeMapping());
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertTrue(getErrorText(err).contains("key '_body1' doesn't exist"));
    }

    return 0;
  }
};

void main()
{
  TstMTP_BarIndicator test;
  test.startAll();
}
