// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpOsLevel/MtpOsLevel.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpOsLevel/MtpOsLevel.ctl
  @copyright $copyright
  @author m.woegrath
*/

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpOsLevel/MtpOsLevel" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpOsLevel.ctl
*/
class TstMtpOsLevel : OaTest
{
  private const string _Dpt = "TestDpt";
  private const string _DpExists = "ExistingTestDatapoint";

  private int _eventLevel;
  private bool _eventStationLevel;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "osLevel"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_INT));
    int result = dpTypeCreate(dpes, values);

    if (result != 0)
    {
      DebugTN("Failed to create data point type: " + _Dpt);
      return -1;
    }

    result = dpCreate(_DpExists, _Dpt);

    if (result != 0 || !dpExists(_DpExists))
    {
      DebugTN("Failed to create data point: " + _DpExists);
      return -1;
    }

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    int result = dpDelete(_DpExists);

    if (result != 0)
    {
      DebugTN("Failed to delete data point: " + _DpExists);
    }

    result = dpTypeDelete(_Dpt);

    if (result != 0)
    {
      DebugTN("Failed to delete data point type: " + _Dpt);
    }

    return OaTest::tearDown();
  }

  /**
    @test Verifies that the MtpOsLevel constructor initializes correctly with a valid data point.
  */
  public int testConstructor()
  {
    shared_ptr<MtpOsLevel> osLevel = new MtpOsLevel(_DpExists + ".osLevel");
    assertEqual(osLevel.getLevel(), 0, "Initial level should be 0");
    assertEqual(osLevel.getStationLevel(), false, "Initial station level should be false");

    return 0;
  }

  /**
    @test Verifies that the MtpOsLevel constructor throws an error for a non-existing data point.
  */
  public int testConstructor_NonExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpOsLevel> osLevel = new MtpOsLevel("NonExisting.Dpe");
      assertTrue(false, "Should have thrown an exception for non-existing data point");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Incorrect error code for non-existing data point");
      assertTrue(getErrorText(err).contains("Datapoint does not exist"), "Error message should contain 'Datapoint does not exist'");
      assertTrue(getErrorText(err).contains("NonExisting.Dpe"), "Error message should contain 'NonExisting.Dpe'");
    }

    return 0;
  }

  /**
    @test Verifies that getLevel() returns the correct level and that osLevelChanged and osStationLevelChanged events are triggered correctly.
  */
  public int testGetLevel()
  {
    shared_ptr<MtpOsLevel> osLevel = new MtpOsLevel(_DpExists + ".osLevel");
    classConnect(this, setOsStationLevelCB, osLevel, MtpOsLevel::osStationLevelChanged);

    // Test with level 0
    dpSetWait(_DpExists + ".osLevel", 0);
    delay(0, 200); // Allow callback to execute
    assertEqual(osLevel.getLevel(), 0, "Level should be 0");
    assertEqual(_eventStationLevel, false, "Station level event should be false for level 0");

    // Test with level 12
    dpSetWait(_DpExists + ".osLevel", 12);
    delay(0, 200); // Allow callback to execute
    assertEqual(osLevel.getLevel(), 12, "Level should be 12");
    assertEqual(_eventStationLevel, true, "Station level event should be true for level 12");

    // Test with negative level
    dpSetWait(_DpExists + ".osLevel", -5);
    delay(0, 200); // Allow callback to execute
    assertEqual(osLevel.getLevel(), -5, "Level should be -5");
    assertEqual(_eventStationLevel, false, "Station level event should be false for level -5");

    return 0;
  }

  /**
    @test Verifies that getStationLevel() returns the correct boolean based on the level value.
  */
  public int testGetStationLevel()
  {
    shared_ptr<MtpOsLevel> osLevel = new MtpOsLevel(_DpExists + ".osLevel");
    classConnect(this, setOsStationLevelCB, osLevel, MtpOsLevel::osStationLevelChanged);

    // Test with level 0
    dpSetWait(_DpExists + ".osLevel", 0);
    delay(0, 200); // Allow callback to execute
    assertEqual(osLevel.getStationLevel(), false, "Station level should be false for level 0");
    assertEqual(_eventStationLevel, false, "Station level event should be false for level 0");

    // Test with level 1
    dpSetWait(_DpExists + ".osLevel", 1);
    delay(0, 200); // Allow callback to execute
    assertEqual(osLevel.getStationLevel(), true, "Station level should be true for level 1");
    assertEqual(_eventStationLevel, true, "Station level event should be true for level 1");

    // Test with level -1
    dpSetWait(_DpExists + ".osLevel", -1);
    delay(0, 200); // Allow callback to execute
    assertEqual(osLevel.getStationLevel(), false, "Station level should be false for level -1");
    assertEqual(_eventStationLevel, false, "Station level event should be false for level -1");

    return 0;
  }

  private void setOsLevelCB(const int &level)
  {
    _eventLevel = level;
  }

  private void setOsStationLevelCB(const bool &stationLevel)
  {
    _eventStationLevel = stationLevel;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpOsLevel test;
  test.startAll();
}
