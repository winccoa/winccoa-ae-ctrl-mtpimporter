// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_LockView4/MTP_LockView4.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_LockView4/MTP_LockView4.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_LockView4/MTP_LockView4" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_LockView4.ctl
*/
class TstMTP_LockView4 : OaTest
{
  private const string _Dpt = "MTP_LockView4";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingLogic = "MTP_LockView4Invalid1";
  private const string _DpExistsInvalidMissingLogic = "ExistingTestDatapointInvalid1";
  private const string _DptInvalidMissingOut = "MTP_LockView4Invalid2";
  private const string _DpExistsInvalidMissingOut = "ExistingTestDatapointInvalid2";

  private bool _eventLogic;
  private bool _eventOutput;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "Logic"),
                                         makeDynString("", "Out"),
                                         makeDynString("", "OutQC"),
                                         makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"), makeDynString("", "In1QC"),
                                         makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"), makeDynString("", "In2QC"),
                                         makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"), makeDynString("", "In3QC"),
                                         makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "In4QC"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingLogic),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "Out"),
                          makeDynString("", "OutQC"),
                          makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"), makeDynString("", "In1QC"),
                          makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"), makeDynString("", "In2QC"),
                          makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"), makeDynString("", "In3QC"),
                          makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "In4QC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingLogic))
      dpCreate(_DpExistsInvalidMissingLogic, _DptInvalidMissingLogic);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingOut),
                          makeDynString("", "tagName"),
                          makeDynString("", "WQC"),
                          makeDynString("", "Logic"),
                          makeDynString("", "OutQC"),
                          makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"), makeDynString("", "In1QC"),
                          makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"), makeDynString("", "In2QC"),
                          makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"), makeDynString("", "In3QC"),
                          makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "In4QC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingOut))
      dpCreate(_DpExistsInvalidMissingOut, _DptInvalidMissingOut);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingLogic);
    if (dpTypes(_DptInvalidMissingLogic).count() > 0)
      dpTypeDelete(_DptInvalidMissingLogic);
    dpDelete(_DpExistsInvalidMissingOut);
    if (dpTypes(_DptInvalidMissingOut).count() > 0)
      dpTypeDelete(_DptInvalidMissingOut);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_LockView4> lockView4 = new MTP_LockView4(_DpExists);
    assertEqual(lockView4.getDp(), _DpExists);
    assertEqual(lockView4.getLogic(), false);
    assertEqual(lockView4.getOutput(), false);
    assertTrue(lockView4.getWqc() != nullptr);
    assertTrue(lockView4.getOutputQualityCode() != nullptr);
    assertTrue(lockView4.getInput1() != nullptr);
    assertTrue(lockView4.getInput2() != nullptr);
    assertTrue(lockView4.getInput3() != nullptr);
    assertTrue(lockView4.getInput4() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_LockView4> lockView4 = new MTP_LockView4(_DpExistsInvalidMissingLogic);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingLogic + ".Logic"));
    }

    try
    {
      shared_ptr<MTP_LockView4> lockView4 = new MTP_LockView4(_DpExistsInvalidMissingOut);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingOut + ".Out"));
    }

    return 0;
  }

  public int testOutputChanged()
  {
    shared_ptr<MTP_LockView4> lockView4 = new MTP_LockView4(_DpExists);
    classConnect(this, setOutputChangedCB, lockView4, MTP_LockView4::outputChanged);
    dpSetWait(_DpExists + ".Out", true);
    delay(0, 200);
    assertEqual(lockView4.getOutput(), true);
    assertEqual(_eventOutput, true);
    return 0;
  }

  public int testLogicChanged()
  {
    shared_ptr<MTP_LockView4> lockView4 = new MTP_LockView4(_DpExists);
    classConnect(this, setLogicChangedCB, lockView4, MTP_LockView4::logicChanged);
    dpSetWait(_DpExists + ".Logic", true);
    delay(0, 200);
    assertEqual(lockView4.getLogic(), true);
    assertEqual(_eventLogic, true);
    return 0;
  }

  public int testGetOutputQualityCode()
  {
    shared_ptr<MTP_LockView4> lockView4 = new MTP_LockView4(_DpExists);
    shared_ptr<MTP_Wqc> outQc = lockView4.getOutputQualityCode();

    assertTrue(outQc != nullptr);
    dpSetWait(_DpExists + ".OutQC", (bit32)0x80);
    delay(0, 200);
    assertTrue(outQc.getQualityGood());

    dpSetWait(_DpExists + ".OutQC", (bit32)0x01);
    delay(0, 200);
    assertFalse(outQc.getQualityGood());
    return 0;
  }

  public int testGetInputMethods()
  {
    shared_ptr<MTP_LockView4> lockView4 = new MTP_LockView4(_DpExists);

    shared_ptr<MTP_Input> in1 = lockView4.getInput1();
    shared_ptr<MTP_Input> in2 = lockView4.getInput2();
    shared_ptr<MTP_Input> in3 = lockView4.getInput3();
    shared_ptr<MTP_Input> in4 = lockView4.getInput4();

    assertTrue(in1 != nullptr);
    assertTrue(in2 != nullptr);
    assertTrue(in3 != nullptr);
    assertTrue(in4 != nullptr);

    dpSetWait(_DpExists + ".In1", true, _DpExists + ".In2", true, _DpExists + ".In3", true, _DpExists + ".In4", true);
    delay(0, 200);

    assertTrue(in1.getValue());
    assertTrue(in2.getValue());
    assertTrue(in3.getValue());
    assertTrue(in4.getValue());
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
  TstMTP_LockView4 test;
  test.startAll();
}
