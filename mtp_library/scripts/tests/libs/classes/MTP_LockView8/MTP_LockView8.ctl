// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_LockView8/MTP_LockView8.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_LockView8/MTP_LockView8.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_LockView8/MTP_LockView8"
#uses "classes/oaTest/OaTest"

class TstMTP_LockView8 : OaTest
{
  private const string _Dpt = "MTP_LockView8";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingIn5En = "MTP_LockView8Invalid1";
  private const string _DpExistsInvalidMissingIn5En = "ExistingTestDatapointInvalid1";
  private const string _DptInvalidMissingIn8QC = "MTP_LockView8Invalid2";
  private const string _DpExistsInvalidMissingIn8QC = "ExistingTestDatapointInvalid2";

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
                                         makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "In4QC"),
                                         makeDynString("", "In5En"), makeDynString("", "In5"), makeDynString("", "In5Inv"), makeDynString("", "In5Txt"), makeDynString("", "In5QC"),
                                         makeDynString("", "In6En"), makeDynString("", "In6"), makeDynString("", "In6Inv"), makeDynString("", "In6Txt"), makeDynString("", "In6QC"),
                                         makeDynString("", "In7En"), makeDynString("", "In7"), makeDynString("", "In7Inv"), makeDynString("", "In7Txt"), makeDynString("", "In7QC"),
                                         makeDynString("", "In8En"), makeDynString("", "In8"), makeDynString("", "In8Inv"), makeDynString("", "In8Txt"), makeDynString("", "In8QC"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingIn5En),
                          makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "Logic"), makeDynString("", "Out"), makeDynString("", "OutQC"),
                          makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"), makeDynString("", "In1QC"),
                          makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"), makeDynString("", "In2QC"),
                          makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"), makeDynString("", "In3QC"),
                          makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "In4QC"),
                          makeDynString("", "In5"), makeDynString("", "In5Inv"), makeDynString("", "In5Txt"), makeDynString("", "In5QC"),
                          makeDynString("", "In6En"), makeDynString("", "In6"), makeDynString("", "In6Inv"), makeDynString("", "In6Txt"), makeDynString("", "In6QC"),
                          makeDynString("", "In7En"), makeDynString("", "In7"), makeDynString("", "In7Inv"), makeDynString("", "In7Txt"), makeDynString("", "In7QC"),
                          makeDynString("", "In8En"), makeDynString("", "In8"), makeDynString("", "In8Inv"), makeDynString("", "In8Txt"), makeDynString("", "In8QC"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingIn5En))
      dpCreate(_DpExistsInvalidMissingIn5En, _DptInvalidMissingIn5En);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingIn8QC),
                          makeDynString("", "tagName"), makeDynString("", "WQC"), makeDynString("", "Logic"), makeDynString("", "Out"), makeDynString("", "OutQC"),
                          makeDynString("", "In1En"), makeDynString("", "In1"), makeDynString("", "In1Inv"), makeDynString("", "In1Txt"), makeDynString("", "In1QC"),
                          makeDynString("", "In2En"), makeDynString("", "In2"), makeDynString("", "In2Inv"), makeDynString("", "In2Txt"), makeDynString("", "In2QC"),
                          makeDynString("", "In3En"), makeDynString("", "In3"), makeDynString("", "In3Inv"), makeDynString("", "In3Txt"), makeDynString("", "In3QC"),
                          makeDynString("", "In4En"), makeDynString("", "In4"), makeDynString("", "In4Inv"), makeDynString("", "In4Txt"), makeDynString("", "In4QC"),
                          makeDynString("", "In5En"), makeDynString("", "In5"), makeDynString("", "In5Inv"), makeDynString("", "In5Txt"), makeDynString("", "In5QC"),
                          makeDynString("", "In6En"), makeDynString("", "In6"), makeDynString("", "In6Inv"), makeDynString("", "In6Txt"), makeDynString("", "In6QC"),
                          makeDynString("", "In7En"), makeDynString("", "In7"), makeDynString("", "In7Inv"), makeDynString("", "In7Txt"), makeDynString("", "In7QC"),
                          makeDynString("", "In8En"), makeDynString("", "In8"), makeDynString("", "In8Inv"), makeDynString("", "In8Txt"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingIn8QC))
      dpCreate(_DpExistsInvalidMissingIn8QC, _DptInvalidMissingIn8QC);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpDelete(_DpExistsInvalidMissingIn5En);
    if (dpTypes(_DptInvalidMissingIn5En).count() > 0)
      dpTypeDelete(_DptInvalidMissingIn5En);
    dpDelete(_DpExistsInvalidMissingIn8QC);
    if (dpTypes(_DptInvalidMissingIn8QC).count() > 0)
      dpTypeDelete(_DptInvalidMissingIn8QC);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_LockView8> lockView8 = new MTP_LockView8(_DpExists);
    assertEqual(lockView8.getDp(), _DpExists);
    assertTrue(lockView8.getInput1() != nullptr);
    assertTrue(lockView8.getInput2() != nullptr);
    assertTrue(lockView8.getInput3() != nullptr);
    assertTrue(lockView8.getInput4() != nullptr);
    assertTrue(lockView8.getInput5() != nullptr);
    assertTrue(lockView8.getInput6() != nullptr);
    assertTrue(lockView8.getInput7() != nullptr);
    assertTrue(lockView8.getInput8() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<MTP_LockView8> lockView8 = new MTP_LockView8(_DpExistsInvalidMissingIn5En);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingIn5En + ".In5En"));
    }

    try
    {
      shared_ptr<MTP_LockView8> lockView8 = new MTP_LockView8(_DpExistsInvalidMissingIn8QC);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingIn8QC + ".In8QC"));
    }

    return 0;
  }

  public int testGetInputMethods5to8()
  {
    shared_ptr<MTP_LockView8> lockView8 = new MTP_LockView8(_DpExists);

    shared_ptr<MTP_Input> in1 = lockView8.getInput1();
    shared_ptr<MTP_Input> in5 = lockView8.getInput5();
    shared_ptr<MTP_Input> in6 = lockView8.getInput6();
    shared_ptr<MTP_Input> in7 = lockView8.getInput7();
    shared_ptr<MTP_Input> in8 = lockView8.getInput8();

    dpSetWait(_DpExists + ".In1", FALSE,
              _DpExists + ".In5", TRUE,
              _DpExists + ".In6", TRUE,
              _DpExists + ".In7", TRUE,
              _DpExists + ".In8", TRUE);
    delay(0, 200);

    assertFalse(in1.getValue());
    assertTrue(in5.getValue());
    assertTrue(in6.getValue());
    assertTrue(in7.getValue());
    assertTrue(in8.getValue());
    return 0;
  }
};

void main()
{
  TstMTP_LockView8 test;
  test.startAll();
}
