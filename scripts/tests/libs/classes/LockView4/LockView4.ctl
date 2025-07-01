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
                            makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4QC"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt")
                          );
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_BOOL),
                           makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_INT),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
                           makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING)
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
             makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4QC"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt")
           );
    values = makeDynAnytype(
               makeDynInt(DPEL_STRUCT),
               makeDynInt(0, DPEL_BOOL),
               makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_INT),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING),
               makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING)
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

  public int testOutputAndLogicChanged()
  {
    shared_ptr<LockView4> lockView = new LockView4(_DpExists);
    classConnect(this, setOutputChangedCB, lockView, LockView4::outputChanged);
    classConnect(this, setLogicChangedCB, lockView, LockView4::logicChanged);

    // Reset DPEs
    dpSetWait(_DpExists + ".Out", false, _DpExists + ".Logic", false);

    // Test output change
    _eventOutput = false;
    dpSetWait(_DpExists + ".Out", true);
    delay(0, 200);
    assertEqual(lockView.getOutput(), true, "Output should be true after dpSet");
    assertEqual(_eventOutput, true, "OutputChanged event should trigger with true");

    // Test logic change
    _eventLogic = false;
    dpSetWait(_DpExists + ".Logic", true);
    delay(0, 200);
    assertEqual(lockView.getLogic(), true, "Logic should be true after dpSet");
    assertEqual(_eventLogic, true, "LogicChanged event should trigger with true");

    // Test no event for same value
    _eventOutput = false;
    bool currentOut;
    dpGet(_DpExists + ".Out", currentOut);
    dpSetWait(_DpExists + ".Out", currentOut);
    delay(0, 200);
    assertEqual(_eventOutput, false, "OutputChanged should not trigger for same value");

    _eventLogic = false;
    bool currentLogic;
    dpGet(_DpExists + ".Logic", currentLogic);
    dpSetWait(_DpExists + ".Logic", currentLogic);
    delay(0, 200);
    assertEqual(_eventLogic, false, "LogicChanged should not trigger for same value");

    return 0;
  }

  public int testOutputCalculation()
  {
    shared_ptr<LockView4> lockView = new LockView4(_DpExists);
    classConnect(this, setOutputChangedCB, lockView, LockView4::outputChanged);

    // Reset all DPEs
    dpSetWait(_DpExists + ".Logic", false,
              _DpExists + ".Out", false,
              _DpExists + ".In1En", false, _DpExists + ".In1", false, _DpExists + ".In1Inv", false,
              _DpExists + ".In2En", false, _DpExists + ".In2", false, _DpExists + ".In2Inv", false,
              _DpExists + ".In3En", false, _DpExists + ".In3", false, _DpExists + ".In3Inv", false,
              _DpExists + ".In4En", false, _DpExists + ".In4", false, _DpExists + ".In4Inv", false);
    delay(0, 200);

    // Test OR mode (_logic = false)
    _eventOutput = false;
    dpSetWait(_DpExists + ".Logic", false,
              _DpExists + ".In1En", true, _DpExists + ".In1", false, _DpExists + ".In1Inv", false,
              _DpExists + ".In2En", true, _DpExists + ".In2", true, _DpExists + ".In2Inv", false,
              _DpExists + ".In3En", false, _DpExists + ".In3", false, _DpExists + ".In3Inv", false,
              _DpExists + ".In4En", false, _DpExists + ".In4", false, _DpExists + ".In4Inv", false);
    delay(0, 200);
    bool outValue;
    dpGet(_DpExists + ".Out", outValue);
    assertEqual(lockView.getOutput(), true, "OR mode: Output should be true when In2 is true");
    assertEqual(outValue, true, "OR mode: .Out DPE should be true");

    // Test OR mode with inverted input
    _eventOutput = false;
    dpSetWait(_DpExists + ".In1", true, _DpExists + ".In1Inv", true);
    delay(0, 200);
    dpGet(_DpExists + ".Out", outValue);
    assertEqual(lockView.getOutput(), true, "OR mode: Output should be true when In1 (inverted) is false or In2 is true");
    assertEqual(outValue, true, "OR mode: .Out DPE should be true");

    // Test OR mode with no enabled inputs
    _eventOutput = false;
    dpSetWait(_DpExists + ".In1En", false, _DpExists + ".In2En", false);
    delay(0, 200);
    dpGet(_DpExists + ".Out", outValue);
    assertEqual(lockView.getOutput(), false, "OR mode: Output should be false with no enabled inputs");
    assertEqual(outValue, false, "OR mode: .Out DPE should be false");

    // Test AND mode (_logic = true)
    _eventOutput = false;
    dpSetWait(_DpExists + ".Logic", true,
              _DpExists + ".In1En", true, _DpExists + ".In1", true, _DpExists + ".In1Inv", false,
              _DpExists + ".In2En", true, _DpExists + ".In2", true, _DpExists + ".In2Inv", false,
              _DpExists + ".In3En", false, _DpExists + ".In3", false, _DpExists + ".In3Inv", false,
              _DpExists + ".In4En", false, _DpExists + ".In4", false, _DpExists + ".In4Inv", false);
    delay(0, 200);
    dpGet(_DpExists + ".Out", outValue);
    assertEqual(lockView.getOutput(), true, "AND mode: Output should be true when all enabled inputs are true");
    assertEqual(outValue, true, "AND mode: .Out DPE should be true");

    // Test AND mode with inverted input
    _eventOutput = false;
    dpSetWait(_DpExists + ".In1Inv", true);
    delay(0, 200);
    dpGet(_DpExists + ".Out", outValue);
    assertEqual(lockView.getInput1().getInverted(), true, "AND mode: In1Inv should be true");
    assertEqual(lockView.getOutput(), false, "AND mode: Output should be false when In1 (inverted) is false");
    assertEqual(outValue, false, "AND mode: .Out DPE should be false");

    // Test AND mode with no enabled inputs
    _eventOutput = false;
    dpSetWait(_DpExists + ".In1En", false, _DpExists + ".In2En", false);
    delay(0, 200);
    dpGet(_DpExists + ".Out", outValue);
    assertEqual(lockView.getOutput(), true, "AND mode: Output should be true with no enabled inputs");
    assertEqual(outValue, true, "AND mode: .Out DPE should be true");

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
