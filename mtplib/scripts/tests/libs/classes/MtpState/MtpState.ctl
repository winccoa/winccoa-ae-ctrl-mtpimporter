// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpState/MtpState.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpState/MtpState.ctl
  @copyright $copyright
  @author m.woegrath
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpState/MtpState" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpState.ctl
*/
class TstMtpState : OaTest
{
  private const string _Dpt = "TestDptState";
  private const string _DpExists = "ExistingTestDatapointState";

  private bool _eventChannel;
  private bool _eventOffAutomatic;
  private bool _eventOperatorAutomatic;
  private bool _eventAutomaticAutomatic;
  private bool _eventOperatorActive;
  private bool _eventAutomaticActive;
  private bool _eventOffActive;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt), makeDynString("", "channel"), makeDynString("", "offAutomatic"), makeDynString("", "operatorAutomatic"), makeDynString("", "automaticAutomatic"), makeDynString("", "offOperator"), makeDynString("", "operatorOperator"), makeDynString("", "automaticOperator"), makeDynString("", "operatorActive"), makeDynString("", "automaticActive"), makeDynString("", "offActive"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL), makeDynInt(0, DPEL_BOOL));
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
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    assertEqual(state.getChannel(), FALSE);
    assertEqual(state.getOffAutomatic(), FALSE);
    assertEqual(state.getOperatorAutomatic(), FALSE);
    assertEqual(state.getAutomaticAutomatic(), FALSE);
    assertEqual(state.getOffOperator(), FALSE);
    assertEqual(state.getOperatorOperator(), FALSE);
    assertEqual(state.getAutomaticOperator(), FALSE);
    assertEqual(state.getOperatorActive(), FALSE);
    assertEqual(state.getAutomaticActive(), FALSE);
    assertEqual(state.getOffActive(), FALSE);

    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".noneChannel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
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
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".noneOffAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneOffAutomatic"));
    }

    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".noneOperatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneOperatorAutomatic"));
    }

    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".noneAutomaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneAutomaticAutomatic"));
    }

    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".noneOffOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneOffOperator"));
    }

    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".noneOperatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneOperatorOperator"));
    }

    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".noneAutomaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneAutomaticOperator"));
    }

    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".noneOperatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneOperatorActive"));
    }

    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".noneAutomaticActive", _DpExists + ".offActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneAutomaticActive"));
    }

    try
    {
      shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".noneOffActive");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneOffActive"));
    }

    return 0;
  }

  public int testGetChannel()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    classConnect(this, setChannelCB, state, MtpState::channelChanged);

    dpSetWait(_DpExists + ".channel", TRUE);

    delay(0, 200);
    assertEqual(state.getChannel(), TRUE);
    assertEqual(_eventChannel, TRUE);
    return 0;
  }

  public int testGetOffAutomatic()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    classConnect(this, setOffAutomaticCB, state, MtpState::offAutomaticChanged);

    dpSetWait(_DpExists + ".offAutomatic", TRUE);

    delay(0, 200);
    assertEqual(state.getOffAutomatic(), TRUE);
    assertEqual(_eventOffAutomatic, TRUE);
    return 0;
  }

  public int testGetOperatorAutomatic()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    classConnect(this, setOperatorAutomaticCB, state, MtpState::operatorAutomaticChanged);

    dpSetWait(_DpExists + ".operatorAutomatic", TRUE);

    delay(0, 200);
    assertEqual(state.getOperatorAutomatic(), TRUE);
    assertEqual(_eventOperatorAutomatic, TRUE);
    return 0;
  }

  public int testGetAutomaticAutomatic()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    classConnect(this, setAutomaticAutomaticCB, state, MtpState::automaticAutomaticChanged);

    dpSetWait(_DpExists + ".automaticAutomatic", TRUE);

    delay(0, 200);
    assertEqual(state.getAutomaticAutomatic(), TRUE);
    assertEqual(_eventAutomaticAutomatic, TRUE);
    return 0;
  }

  public int testGetOffOperator()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    state.setOffOperator(TRUE);
    bool value;
    dpGet(_DpExists + ".offOperator", value);
    assertEqual(state.getOffOperator(), TRUE);
    assertEqual(value, TRUE);
    return 0;
  }

  public int testGetOperatorOperator()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    state.setOperatorOperator(TRUE);
    bool value;
    dpGet(_DpExists + ".operatorOperator", value);
    assertEqual(state.getOperatorOperator(), TRUE);
    assertEqual(value, TRUE);
    return 0;
  }

  public int testGetAutomaticOperator()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    state.setAutomaticOperator(TRUE);
    bool value;
    dpGet(_DpExists + ".automaticOperator", value);
    assertEqual(state.getAutomaticOperator(), TRUE);
    assertEqual(value, TRUE);
    return 0;
  }

  public int testGetOperatorActive()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    classConnect(this, setOperatorActiveCB, state, MtpState::operatorActiveChanged);

    dpSetWait(_DpExists + ".operatorActive", TRUE);

    delay(0, 200);
    assertEqual(state.getOperatorActive(), TRUE);
    assertEqual(_eventOperatorActive, TRUE);
    return 0;
  }

  public int testGetAutomaticActive()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    classConnect(this, setAutomaticActiveCB, state, MtpState::automaticActiveChanged);

    dpSetWait(_DpExists + ".automaticActive", TRUE);

    delay(0, 200);
    assertEqual(state.getAutomaticActive(), TRUE);
    assertEqual(_eventAutomaticActive, TRUE);
    return 0;
  }

  public int testGetOffActive()
  {
    shared_ptr<MtpState> state = new MtpState(_DpExists + ".channel", _DpExists + ".offAutomatic", _DpExists + ".operatorAutomatic", _DpExists + ".automaticAutomatic", _DpExists + ".offOperator", _DpExists + ".operatorOperator", _DpExists + ".automaticOperator", _DpExists + ".operatorActive", _DpExists + ".automaticActive", _DpExists + ".offActive");
    classConnect(this, setOffActiveCB, state, MtpState::offActiveChanged);

    dpSetWait(_DpExists + ".offActive", TRUE);

    delay(0, 200);
    assertEqual(state.getOffActive(), TRUE);
    assertEqual(_eventOffActive, TRUE);
    return 0;
  }

  private void setChannelCB(const bool &value)
  {
    _eventChannel = value;
  }
  private void setOffAutomaticCB(const bool &value)
  {
    _eventOffAutomatic = value;
  }
  private void setOperatorAutomaticCB(const bool &value)
  {
    _eventOperatorAutomatic = value;
  }
  private void setAutomaticAutomaticCB(const bool &value)
  {
    _eventAutomaticAutomatic = value;
  }
  private void setOperatorActiveCB(const bool &value)
  {
    _eventOperatorActive = value;
  }
  private void setAutomaticActiveCB(const bool &value)
  {
    _eventAutomaticActive = value;
  }
  private void setOffActiveCB(const bool &value)
  {
    _eventOffActive = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpState test;
  test.startAll();
}
