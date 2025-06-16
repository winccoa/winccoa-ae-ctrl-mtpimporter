// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpSource/MtpSource.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpSource/MtpSource.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpSource/MtpSource" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpSource.ctl
*/
class TstMtpSource : OaTest
{
  private const string _Dpt = "TestDptSource";
  private const string _DpExists = "ExistingTestDatapointSource";

  private bool _eventChannel;
  private bool _eventManualAutomatic;
  private bool _eventInternalAutomatic;
  private bool _eventManualActive;
  private bool _eventInternalActive;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "channel"), makeDynString("", "manualAutomatic"), makeDynString("", "internalAutomatic"), makeDynString("", "manualOperator"), makeDynString("", "internalOperator"), makeDynString("", "manualActive"), makeDynString("", "internalActive"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
    dpTypeCreate(dpes, values);
    dpCreate(_DpExists, _Dpt);

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    dpTypeDelete(_Dpt);
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
    assertEqual(src.getChannel(), FALSE);
    assertEqual(src.getManualAutomatic(), FALSE);
    assertEqual(src.getInternalAutomatic(), FALSE);
    assertEqual(src.getManualOperator(), FALSE);
    assertEqual(src.getInternalOperator(), FALSE);
    assertEqual(src.getManualActive(), FALSE);
    assertEqual(src.getInternalActive(), FALSE);

    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".noneChannel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneChannel"));
    }

    try
    {
      shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".noneManualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneManualAutomatic"));
    }

    try
    {
      shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".noneInternalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneInternalAutomatic"));
    }

    try
    {
      shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".noneManualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneManualOperator"));
    }

    try
    {
      shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".noneInternalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneInternalOperator"));
    }

    try
    {
      shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".noneManualActive", _DpExists + ".internalActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneManualActive"));
    }

    try
    {
      shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".noneInternalActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneInternalActive"));
    }

    return 0;
  }

  public int testGetChannel()
  {
    shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
    classConnect(this, setChannelCB, src, MtpSource::channelChanged);

    dpSetWait(_DpExists + ".channel", TRUE);

    delay(0, 200);
    assertEqual(src.getChannel(), TRUE);
    assertEqual(_eventChannel, TRUE);
    return 0;
  }

  public int testGetManualAutomatic()
  {
    shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
    classConnect(this, setManualAutomaticCB, src, MtpSource::manualAutomaticChanged);

    dpSetWait(_DpExists + ".manualAutomatic", TRUE);

    delay(0, 200);
    assertEqual(src.getManualAutomatic(), TRUE);
    assertEqual(_eventManualAutomatic, TRUE);
    return 0;
  }

  public int testGetInternalAutomatic()
  {
    shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
    classConnect(this, setInternalAutomaticCB, src, MtpSource::internalAutomaticChanged);

    dpSetWait(_DpExists + ".internalAutomatic", TRUE);

    delay(0, 200);
    assertEqual(src.getInternalAutomatic(), TRUE);
    assertEqual(_eventInternalAutomatic, TRUE);
    return 0;
  }

  public int testGetManualActive()
  {
    shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
    classConnect(this, setManualActiveCB, src, MtpSource::manualActiveChanged);

    dpSetWait(_DpExists + ".manualActive", TRUE);

    delay(0, 200);
    assertEqual(src.getManualActive(), TRUE);
    assertEqual(_eventManualActive, TRUE);
    return 0;
  }

  public int testGetInternalActive()
  {
    shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
    classConnect(this, setInternalActiveCB, src, MtpSource::internalActiveChanged);

    dpSetWait(_DpExists + ".internalActive", TRUE);

    delay(0, 200);
    assertEqual(src.getInternalActive(), TRUE);
    assertEqual(_eventInternalActive, TRUE);
    return 0;
  }

  public int testSetGetManualOperator()
  {
    shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
    src.setManualOperator(TRUE);
    bool value;
    dpGet(_DpExists + ".manualOperator", value);
    assertEqual(src.getManualOperator(), TRUE);
    assertEqual(value, TRUE);
    return 0;
  }

  public int testSetGetInternalOperator()
  {
    shared_ptr<MtpSource> src = new MtpSource(_DpExists + ".channel", _DpExists + ".manualAutomatic", _DpExists + ".internalAutomatic", _DpExists + ".manualOperator", _DpExists + ".internalOperator", _DpExists + ".manualActive", _DpExists + ".internalActive");
    src.setInternalOperator(TRUE);
    bool value;
    dpGet(_DpExists + ".internalOperator", value);
    assertEqual(src.getInternalOperator(), TRUE);
    assertEqual(value, TRUE);
    return 0;
  }

  private void setChannelCB(const bool &value)
  {
    _eventChannel = value;
  }
  private void setManualAutomaticCB(const bool &value)
  {
    _eventManualAutomatic = value;
  }
  private void setInternalAutomaticCB(const bool &value)
  {
    _eventInternalAutomatic = value;
  }
  private void setManualActiveCB(const bool &value)
  {
    _eventManualActive = value;
  }
  private void setInternalActiveCB(const bool &value)
  {
    _eventInternalActive = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpSource test;
  test.startAll();
}
