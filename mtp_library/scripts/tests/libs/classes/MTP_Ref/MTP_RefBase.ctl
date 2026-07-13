// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_Ref/MTP_RefBase.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_Ref/MTP_RefBase.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_Ref/MTP_RefBase"
#uses "classes/oaTest/OaTest"

class TstMTP_RefBaseNoop : MTP_RefBase
{
  public TstMTP_RefBaseNoop(const mapping &shapes) : MTP_RefBase(shapes)
  {
  }

  protected void initializeShapes() override
  {
  }
};

class TstMTP_RefBaseExtract : MTP_RefBase
{
  public TstMTP_RefBaseExtract(const mapping &shapes) : MTP_RefBase(shapes)
  {
  }

  protected void initializeShapes() override
  {
    MTP_RefBase::extractShape("shape");
  }
};

class TstMTP_RefBase : OaTest
{
  public int testConstructor()
  {
    shared_ptr<TstMTP_RefBaseNoop> refBase = new TstMTP_RefBaseNoop(makeMapping());
    assertTrue(refBase != nullptr);
    return 0;
  }

  public int testExtractShape_MissingKey()
  {
    try
    {
      shared_ptr<TstMTP_RefBaseExtract> refBase = new TstMTP_RefBaseExtract(makeMapping());
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertTrue(getErrorText(err).contains("key 'shape' doesn't exist"));
    }

    return 0;
  }

  public int testExtractShape_MissingShape()
  {
    bool exceptionThrown = FALSE;

    try
    {
      mapping shapes = makeMapping("shape", "MissingShape");
      shared_ptr<TstMTP_RefBaseExtract> refBase = new TstMTP_RefBaseExtract(shapes);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      exceptionThrown = TRUE;
    }

    assertTrue(exceptionThrown);
    return 0;
  }
};

void main()
{
  TstMTP_RefBase test;
  test.startAll();
}
