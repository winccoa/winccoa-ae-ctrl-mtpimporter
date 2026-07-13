// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_DIntManInt/MTP_DIntManInt.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_DIntManInt/MTP_DIntManInt.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_DIntManInt/MTP_DIntManInt" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_DIntManInt.ctl
*/
class TstMTP_DIntManInt : OaTest
{
  private const string _Dpt = "MTP_DIntManInt";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingVInt = "MTP_DIntManIntInvalid1";
  private const string _DpExistsInvalidMissingVInt = "ExistingTestDatapointInvalid1";
  private const string _DptInvalidMissingWQC = "MTP_DIntManIntInvalid2";
  private const string _DpExistsInvalidMissingWQC = "ExistingTestDatapointInvalid2";
  private const string _DptInvalidMissingSrcChannel = "MTP_DIntManIntInvalid3";
  private const string _DpExistsInvalidMissingSrcChannel = "ExistingTestDatapointInvalid3";

  private int _eventValueInternal;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"),
                                         makeDynString("", "OSLevel"),
                                         makeDynString("", "WQC"),
                                         makeDynString("", "VOut"),
                                         makeDynString("", "VSclMin"),
                                         makeDynString("", "VSclMax"),
                                         makeDynString("", "VUnit"),
                                         makeDynString("", "VMan"),
                                         makeDynString("", "VInt"),
                                         makeDynString("", "VRbk"),
                                         makeDynString("", "VFbk"),
                                         makeDynString("", "VMin"),
                                         makeDynString("", "VMax"),
                                         makeDynString("", "SrcChannel"),
                                         makeDynString("", "SrcManAut"),
                                         makeDynString("", "SrcIntAut"),
                                         makeDynString("", "SrcManOp"),
                                         makeDynString("", "SrcIntOp"),
                                         makeDynString("", "SrcManAct"),
                                         makeDynString("", "SrcIntAct"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BIT32),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_INT),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL),
                                        makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVInt),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "WQC"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"),
                          makeDynString("", "SrcChannel"),
                          makeDynString("", "SrcManAut"),
                          makeDynString("", "SrcIntAut"),
                          makeDynString("", "SrcManOp"),
                          makeDynString("", "SrcIntOp"),
                          makeDynString("", "SrcManAct"),
                          makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVInt))
      dpCreate(_DpExistsInvalidMissingVInt, _DptInvalidMissingVInt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingWQC),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VInt"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"),
                          makeDynString("", "SrcChannel"),
                          makeDynString("", "SrcManAut"),
                          makeDynString("", "SrcIntAut"),
                          makeDynString("", "SrcManOp"),
                          makeDynString("", "SrcIntOp"),
                          makeDynString("", "SrcManAct"),
                          makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingWQC))
      dpCreate(_DpExistsInvalidMissingWQC, _DptInvalidMissingWQC);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingSrcChannel),
                          makeDynString("", "tagName"),
                          makeDynString("", "OSLevel"),
                          makeDynString("", "WQC"),
                          makeDynString("", "VOut"),
                          makeDynString("", "VSclMin"),
                          makeDynString("", "VSclMax"),
                          makeDynString("", "VUnit"),
                          makeDynString("", "VMan"),
                          makeDynString("", "VInt"),
                          makeDynString("", "VRbk"),
                          makeDynString("", "VFbk"),
                          makeDynString("", "VMin"),
                          makeDynString("", "VMax"),
                          makeDynString("", "SrcManAut"),
                          makeDynString("", "SrcIntAut"),
                          makeDynString("", "SrcManOp"),
                          makeDynString("", "SrcIntOp"),
                          makeDynString("", "SrcManAct"),
                          makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BIT32),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_INT),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL),
                            makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingSrcChannel))
      dpCreate(_DpExistsInvalidMissingSrcChannel, _DptInvalidMissingSrcChannel);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);

    dpDelete(_DpExistsInvalidMissingVInt);

    if (dpTypes(_DptInvalidMissingVInt).count() > 0)
      dpTypeDelete(_DptInvalidMissingVInt);

    dpDelete(_DpExistsInvalidMissingWQC);

    if (dpTypes(_DptInvalidMissingWQC).count() > 0)
      dpTypeDelete(_DptInvalidMissingWQC);

    dpDelete(_DpExistsInvalidMissingSrcChannel);

    if (dpTypes(_DptInvalidMissingSrcChannel).count() > 0)
      dpTypeDelete(_DptInvalidMissingSrcChannel);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DIntManInt> dIntManInt = new MTP_DIntManInt(_DpExists);
    int expectedInitialValue = 0;
    assertEqual(dIntManInt.getDp(), _DpExists);
    assertEqual(dIntManInt.getValueInternal(), expectedInitialValue);
    assertTrue(dIntManInt.getWqc() != nullptr);
    assertTrue(dIntManInt.getSource() != nullptr);
    assertTrue(dIntManInt.getOsLevel() != nullptr);
    assertTrue(dIntManInt.getValueUnit() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try { shared_ptr<MTP_DIntManInt> o = new MTP_DIntManInt(_DpExistsInvalidMissingVInt); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVInt + ".VInt")); }
    try { shared_ptr<MTP_DIntManInt> o = new MTP_DIntManInt(_DpExistsInvalidMissingWQC); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingWQC + ".WQC")); }
    try { shared_ptr<MTP_DIntManInt> o = new MTP_DIntManInt(_DpExistsInvalidMissingSrcChannel); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcChannel + ".SrcChannel")); }
    return 0;
  }

  public int testValueInternalChanged()
  {
    shared_ptr<MTP_DIntManInt> dIntManInt = new MTP_DIntManInt(_DpExists);
    classConnect(this, valueInternalChangedCB, dIntManInt, MTP_DIntManInt::valueInternalChanged);

    int expectedValue = 337;
    dpSetWait(_DpExists + ".VInt", expectedValue);
    delay(0, 200);

    assertEqual(dIntManInt.getValueInternal(), expectedValue);
    assertEqual(_eventValueInternal, expectedValue);
    return 0;
  }

  private void valueInternalChangedCB(const int &valueInternal)
  {
    _eventValueInternal = valueInternal;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_DIntManInt test;
  test.startAll();
}
