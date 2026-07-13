// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_Services/ServParam/ServParamBaseFactory.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_Services/ServParam/ServParamBaseFactory.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_Services/ServParam/ServParamBaseFactory"
#uses "classes/MTP_Services/ServParam/ServParamBase"
#uses "classes/oaTest/OaTest"

class TstServParamBaseFactory : OaTest
{
  private const string _BinDp = "ExistingBinServParamFactoryDatapoint";
  private const string _AnaDp = "ExistingAnaServParamFactoryDatapoint";
  private const string _DIntDp = "ExistingDIntServParamFactoryDatapoint";
  private const string _StringDp = "ExistingStringServParamFactoryDatapoint";
  private const string _UnsupportedDpt = "MTP_ServParamFactoryUnsupported";
  private const string _UnsupportedDp = "ExistingUnsupportedServParamFactoryDatapoint";

  public int setUp() override
  {
    if (dpTypes("MTP_BinServParam").count() == 0 ||
        dpTypes("MTP_AnaServParam").count() == 0 ||
        dpTypes("MTP_DIntServParam").count() == 0 ||
        dpTypes("MTP_StringServParam").count() == 0)
    {
      DebugN("Service parameter data point types do not exist");
      return -1;
    }

    if (!dpExists(_BinDp))
      dpCreate(_BinDp, "MTP_BinServParam");
    if (!dpExists(_AnaDp))
      dpCreate(_AnaDp, "MTP_AnaServParam");
    if (!dpExists(_DIntDp))
      dpCreate(_DIntDp, "MTP_DIntServParam");
    if (!dpExists(_StringDp))
      dpCreate(_StringDp, "MTP_StringServParam");

    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_UnsupportedDpt),
                                         makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_UnsupportedDp))
      dpCreate(_UnsupportedDp, _UnsupportedDpt);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    if (dpExists(_BinDp))
      dpDelete(_BinDp);
    if (dpExists(_AnaDp))
      dpDelete(_AnaDp);
    if (dpExists(_DIntDp))
      dpDelete(_DIntDp);
    if (dpExists(_StringDp))
      dpDelete(_StringDp);

    if (dpExists(_UnsupportedDp))

      dpDelete(_UnsupportedDp);

    if (dpTypes(_UnsupportedDpt).count() > 0)
      dpTypeDelete(_UnsupportedDpt);

    return OaTest::tearDown();
  }

  public int testCreate()
  {
    shared_ptr<ServParamBase> binParam = ServParamBaseFactory::create(_BinDp);
    shared_ptr<ServParamBase> anaParam = ServParamBaseFactory::create(_AnaDp);
    shared_ptr<ServParamBase> dIntParam = ServParamBaseFactory::create(_DIntDp);
    shared_ptr<ServParamBase> stringParam = ServParamBaseFactory::create(_StringDp);

    assertTrue(binParam != nullptr);
    assertTrue(anaParam != nullptr);
    assertTrue(dIntParam != nullptr);
    assertTrue(stringParam != nullptr);
    assertEqual(binParam.getDp(), _BinDp);
    assertEqual(anaParam.getDp(), _AnaDp);
    assertEqual(dIntParam.getDp(), _DIntDp);
    assertEqual(stringParam.getDp(), _StringDp);
    return 0;
  }

  public int testCreate_UnsupportedType()
  {
    bool exceptionThrown = FALSE;

    try
    {
      shared_ptr<ServParamBase> param = ServParamBaseFactory::create(_UnsupportedDp);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      exceptionThrown = TRUE;
      dyn_errClass err = getLastException();
      assertTrue(getErrorText(err).contains("datapoint type not defined '" + _UnsupportedDpt + "'"));
    }

    assertTrue(exceptionThrown);
    return 0;
  }
};

void main()
{
  TstServParamBaseFactory test;
  test.startAll();
}
