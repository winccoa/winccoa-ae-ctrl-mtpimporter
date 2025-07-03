// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/BinManInt/BinManInt.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/BinManInt/BinManInt.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/BinManInt/BinManInt" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class


class TstBinManInt : OaTest
{
  //---------------------------------------------------------------------------
  /**
    @test Describe the test scenario here.
   */
  public int testSetAssertionState()
  {
    // type your test script here like
    this.assertEqual("currentValue1", "currentValue1");

    return 0;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstBinManInt test;
  test.startAll();
}
