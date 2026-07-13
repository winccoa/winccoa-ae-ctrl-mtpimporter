// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_BinManInt/MTP_BinManInt.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_BinManInt/MTP_BinManInt.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_BinManInt/MTP_BinManInt" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_BinManInt.ctl
*/
class TstMTP_BinManInt : OaTest
{
  private const string _Dpt = "MTP_BinManInt";
  private const string _DpExists = "ExistingTestDatapoint";
  private const string _DptInvalidMissingVInt = "MTP_BinManIntInvalid1";
  private const string _DpExistsInvalidMissingVInt = "ExistingTestDatapointInvalid1";
  private const string _DptInvalidMissingWQC = "MTP_BinManIntInvalid2";
  private const string _DpExistsInvalidMissingWQC = "ExistingTestDatapointInvalid2";
  private const string _DptInvalidMissingSrcChannel = "MTP_BinManIntInvalid3";
  private const string _DpExistsInvalidMissingSrcChannel = "ExistingTestDatapointInvalid3";

  private bool _eventValueInternal;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "WQC"), makeDynString("", "VOut"), makeDynString("", "VState0"), makeDynString("", "VState1"), makeDynString("", "VMan"), makeDynString("", "VInt"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"), makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"), makeDynString("", "SrcIntAct"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingVInt), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "WQC"), makeDynString("", "VOut"), makeDynString("", "VState0"), makeDynString("", "VState1"), makeDynString("", "VMan"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"), makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"), makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingVInt))
      dpCreate(_DpExistsInvalidMissingVInt, _DptInvalidMissingVInt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingWQC), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "VOut"), makeDynString("", "VState0"), makeDynString("", "VState1"), makeDynString("", "VMan"), makeDynString("", "VInt"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "SrcChannel"), makeDynString("", "SrcManAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"), makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"), makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingWQC))
      dpCreate(_DpExistsInvalidMissingWQC, _DptInvalidMissingWQC);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingSrcChannel), makeDynString("", "tagName"), makeDynString("", "OSLevel"), makeDynString("", "WQC"), makeDynString("", "VOut"), makeDynString("", "VState0"), makeDynString("", "VState1"), makeDynString("", "VMan"), makeDynString("", "VInt"), makeDynString("", "VRbk"), makeDynString("", "VFbk"), makeDynString("", "SrcManAut"), makeDynString("", "SrcIntAut"), makeDynString("", "SrcManOp"), makeDynString("", "SrcIntOp"), makeDynString("", "SrcManAct"), makeDynString("", "SrcIntAct"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_LANGSTRING), makeDynInt(0, DPEL_INT), makeDynInt(0, DPEL_BIT32), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_STRING), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
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
    shared_ptr<MTP_BinManInt> binManInt = new MTP_BinManInt(_DpExists);
    assertEqual(binManInt.getDp(), _DpExists);
    assertEqual(binManInt.getValueInternal(), false);
    assertTrue(binManInt.getWqc() != nullptr);
    assertTrue(binManInt.getOsLevel() != nullptr);
    assertTrue(binManInt.getSource() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try { shared_ptr<MTP_BinManInt> o = new MTP_BinManInt(_DpExistsInvalidMissingVInt); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingVInt + ".VInt")); }
    try { shared_ptr<MTP_BinManInt> o = new MTP_BinManInt(_DpExistsInvalidMissingWQC); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingWQC + ".WQC")); }
    try { shared_ptr<MTP_BinManInt> o = new MTP_BinManInt(_DpExistsInvalidMissingSrcChannel); assertTrue(false, "shouldn't reach here"); } catch { dyn_errClass err = getLastException(); assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT); assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingSrcChannel + ".SrcChannel")); }
    return 0;
  }

  public int testValueInternalChanged()
  {
    shared_ptr<MTP_BinManInt> binManInt = new MTP_BinManInt(_DpExists);
    classConnect(this, valueInternalChangedCB, binManInt, MTP_BinManInt::valueInternalChanged);
    dpSetWait(_DpExists + ".VInt", true);
    delay(0, 200);
    assertEqual(binManInt.getValueInternal(), true);
    assertEqual(_eventValueInternal, true);
    return 0;
  }

  public int testValueInternalChanged_False()
  {
    shared_ptr<MTP_BinManInt> binManInt = new MTP_BinManInt(_DpExists);
    classConnect(this, valueInternalChangedCB, binManInt, MTP_BinManInt::valueInternalChanged);

    dpSetWait(_DpExists + ".VInt", true);
    delay(0, 200);
    dpSetWait(_DpExists + ".VInt", false);
    delay(0, 200);

    assertEqual(binManInt.getValueInternal(), false);
    assertEqual(_eventValueInternal, false);
    return 0;
  }

  private void valueInternalChangedCB(const bool &value)
  {
    _eventValueInternal = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_BinManInt test;
  test.startAll();
}
