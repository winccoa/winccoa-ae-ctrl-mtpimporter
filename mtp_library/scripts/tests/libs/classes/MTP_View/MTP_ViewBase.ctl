// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_View/MTP_ViewBase.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_View/MTP_ViewBase.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/oaTest/OaTest"

class TstMTP_ViewBaseImpl : MTP_ViewBase
{
  public TstMTP_ViewBaseImpl(shared_ptr<MTP_DataAssembly> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
  }

  public string getViewModelDpForTest()
  {
    return MTP_ViewBase::getViewModel().getDp();
  }

  protected void initializeShapes() override
  {
  }
};

class TstMTP_ViewBase : OaTest
{
  private const string _Dpt = "TstMTP_ViewBase";
  private const string _DpExists = "TstMTP_ViewBaseDp";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "tagName"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpSetWait(_DpExists + ".tagName", "ViewModel");

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    if (dpTypes(_Dpt).count() > 0)
      dpTypeDelete(_Dpt);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_DataAssembly> viewModel = new MTP_DataAssembly(_DpExists);
    shared_ptr<TstMTP_ViewBaseImpl> viewBase = new TstMTP_ViewBaseImpl(viewModel, makeMapping());

    assertEqual(viewBase.getViewModelDpForTest(), _DpExists);
    return 0;
  }
};

void main()
{
  TstMTP_ViewBase test;
  test.startAll();
}
