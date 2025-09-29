// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/LockView4/LockView4.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/LockView4/LockView4.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/LockView4/LockView4" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for LockView4.ctl
*/
class TstLockView4 : OaTest
{
  private const string _Dpt = "LockView4";
  private const string _DptInvalidMissingLogic = "LockViewInvalid1";
  private const string _DptInvalidMissingOutput = "LockViewInvalid2";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DpExistsInvalidMissingLogic = "ExistingTestDatapointInvalid1";
  private const string _DpExistsInvalidMissingOutput = "ExistingTestDatapointInvalid2";

  private bool _eventLogic;
  private bool _eventOutput;

  public int setUp() override
  {
    if (dpTypes(_Dpt).count() == 0)
    {
      return -1;
    }

    dpCreate(_DpExists, _Dpt);

    dyn_dyn_string dpes = makeDynAnytype(
                            makeDynString(_DptInvalidMissingLogic),
                            makeDynString("", "Out"),
                            makeDynString("", "WQC"),
                            makeDynString("", "OutQC"),
                            makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1QC"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"),
                            makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2QC"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"),
                            makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3QC"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"),
                            makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4QC"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "enabled"), makeDynString("", "tagName")
                          );
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING)
                         );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingLogic, _DptInvalidMissingLogic);

    dpes = makeDynAnytype(
             makeDynString(_DptInvalidMissingOutput),
             makeDynString("", "Logic"),
             makeDynString("", "WQC"),
             makeDynString("", "OutQC"),
             makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1QC"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"),
             makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2QC"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"),
             makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3QC"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"),
             makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4QC"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "enabled"), makeDynString("", "tagName")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_LANGSTRING)
             );
    dpTypeCreate(dpes, values);
    dpCreate(_DpExistsInvalidMissingOutput, _DptInvalidMissingOutput);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingLogic);
    dpTypeDelete(_DptInvalidMissingLogic);
    dpDelete(_DpExistsInvalidMissingOutput);
    dpTypeDelete(_DptInvalidMissingOutput);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<LockView4> lockView = new LockView4(_DpExists);
    assertEqual(lockView.getDp(), _DpExists, "DP should match constructor input");
    assertEqual(lockView.getLogic(), false, "Initial logic should be false");
    assertEqual(lockView.getOutput(), false, "Initial output should be false");
    assertTrue(lockView.getWqc() != nullptr, "WQC should not be null");
    assertTrue(lockView.getOutputQualityCode() != nullptr, "OutputQualityCode should not be null");
    assertTrue(lockView.getInput1() != nullptr, "Input1 should not be null");
    assertEqual(lockView.getInput1().getValue(), false, "Input1 value should be false");
    assertTrue(lockView.getInput2() != nullptr, "Input2 should not be null");
    assertEqual(lockView.getInput2().getValue(), false, "Input2 value should be false");
    assertTrue(lockView.getInput3() != nullptr, "Input3 should not be null");
    assertEqual(lockView.getInput3().getValue(), false, "Input3 value should be false");
    assertTrue(lockView.getInput4() != nullptr, "Input4 should not be null");
    assertEqual(lockView.getInput4().getValue(), false, "Input4 value should be false");
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<LockView4> lockView = new LockView4(_DpExistsInvalidMissingLogic);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Error code should be DPNOTEXISTENT");
      assertTrue(getErrorText(err).contains("Datapoint does not exist"), "Error should mention datapoint does not exist");
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingLogic + ".Logic"), "Error should reference .Logic");
    }

    try
    {
      shared_ptr<LockView4> lockView = new LockView4(_DpExistsInvalidMissingOutput);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT, "Error code should be DPNOTEXISTENT");
      assertTrue(getErrorText(err).contains("Datapoint does not exist"), "Error should mention datapoint does not exist");
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingOutput + ".Out"), "Error should reference .Out");
    }

    return 0;
  }

  public int testOutputChanged()
  {
    shared_ptr<LockView4> lockView = new LockView4(_DpExists);
    classConnect(this, setOutputChangedCB, lockView, LockView4::outputChanged);

    dpSetWait(_DpExists + ".Out", true);

    // Give it time to execute callback.
    delay(0, 200);
    assertEqual(lockView.getOutput(), true);
    assertEqual(_eventOutput, true);
    return 0;
  }

  private void setOutputChangedCB(const bool &output)
  {
    _eventOutput = output;
  }

  private void setLogicChangedCB(const bool &logic)
  {
    _eventLogic = logic;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstLockView4 test;
  test.startAll();
}
