// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MtpProcedure/MtpProcedure.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MtpProcedure/MtpProcedure.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MtpProcedure/MtpProcedure" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MtpProcedure.ctl
*/
class TstMtpProcedure : OaTest
{
  private const string _Dpt = "TestDptProcedure";
  private const string _DpExists = "ExistingTestDatapointProcedure";

  private long _eventExternal;
  private long _eventCurrent;
  private long _eventInternal;
  private long _eventRequested;

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(
                            makeDynString(_Dpt),
                            makeDynString("", "operator"),
                            makeDynString("", "internal"),
                            makeDynString("", "external"),
                            makeDynString("", "current"),
                            makeDynString("", "requested")
                          );
    dyn_dyn_int values = makeDynAnytype(
                           makeDynInt(DPEL_STRUCT),
                           makeDynInt(0, DPEL_LONG),
                           makeDynInt(0, DPEL_LONG),
                           makeDynInt(0, DPEL_LONG),
                           makeDynInt(0, DPEL_LONG),
                           makeDynInt(0, DPEL_LONG)
                         );
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
    shared_ptr<MtpProcedure> procedure = new MtpProcedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    assertEqual(procedure.getOperator(), 0L);
    assertEqual(procedure.getInternal(), 0L);
    assertEqual(procedure.getExternal(), 0L);
    assertEqual(procedure.getCurrent(), 0L);
    assertEqual(procedure.getRequested(), 0L);

    return 0;
  }

  public int testConstructor_NonExistingDatapoint()
  {
    try
    {
      shared_ptr<MtpProcedure> procedure = new MtpProcedure(
        _DpExists + ".noneOperator",
        _DpExists + ".internal",
        _DpExists + ".external",
        _DpExists + ".current",
        _DpExists + ".requested"
      );
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneOperator"));
    }

    try
    {
      shared_ptr<MtpProcedure> procedure = new MtpProcedure(
        _DpExists + ".operator",
        _DpExists + ".noneInternal",
        _DpExists + ".external",
        _DpExists + ".current",
        _DpExists + ".requested"
      );
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneInternal"));
    }

    try
    {
      shared_ptr<MtpProcedure> procedure = new MtpProcedure(
        _DpExists + ".operator",
        _DpExists + ".internal",
        _DpExists + ".noneExternal",
        _DpExists + ".current",
        _DpExists + ".requested"
      );
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneExternal"));
    }

    try
    {
      shared_ptr<MtpProcedure> procedure = new MtpProcedure(
        _DpExists + ".operator",
        _DpExists + ".internal",
        _DpExists + ".external",
        _DpExists + ".noneCurrent",
        _DpExists + ".requested"
      );
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneCurrent"));
    }

    try
    {
      shared_ptr<MtpProcedure> procedure = new MtpProcedure(
        _DpExists + ".operator",
        _DpExists + ".internal",
        _DpExists + ".external",
        _DpExists + ".current",
        _DpExists + ".noneRequested"
      );
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("Datapoint does not exist"));
      assertTrue(getErrorText(err).contains(_DpExists + ".noneRequested"));
    }

    return 0;
  }

  public int testGetExternal()
  {
    shared_ptr<MtpProcedure> procedure = new MtpProcedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    classConnect(this, setExternalCB, procedure, MtpProcedure::externalChanged);

    dpSetWait(_DpExists + ".external", 1L);

    delay(0, 200);
    assertEqual(procedure.getExternal(), 1L);
    assertEqual(_eventExternal, 1L);
    return 0;
  }

  public int testGetCurrent()
  {
    shared_ptr<MtpProcedure> procedure = new MtpProcedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    classConnect(this, setCurrentCB, procedure, MtpProcedure::currentChanged);

    dpSetWait(_DpExists + ".current", 1L);

    delay(0, 200);
    assertEqual(procedure.getCurrent(), 1L);
    assertEqual(_eventCurrent, 1L);
    return 0;
  }

  public int testGetInternal()
  {
    shared_ptr<MtpProcedure> procedure = new MtpProcedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    classConnect(this, setInternalCB, procedure, MtpProcedure::internalChanged);

    dpSetWait(_DpExists + ".internal", 1L);

    delay(0, 200);
    assertEqual(procedure.getInternal(), 1L);
    assertEqual(_eventInternal, 1L);
    return 0;
  }

  public int testGetRequested()
  {
    shared_ptr<MtpProcedure> procedure = new MtpProcedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    classConnect(this, setRequestedCB, procedure, MtpProcedure::requestedChanged);

    dpSetWait(_DpExists + ".requested", 1L);

    delay(0, 200);
    assertEqual(procedure.getRequested(), 1L);
    assertEqual(_eventRequested, 1L);
    return 0;
  }

  public int testSetOperator()
  {
    shared_ptr<MtpProcedure> procedure = new MtpProcedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    procedure.setOperator(TRUE);
    long value;
    dpGet(_DpExists + ".operator", value);
    assertEqual(value, 1L);
    assertEqual(procedure.getOperator(), 1L);
    return 0;
  }

  public int testSetRequested()
  {
    shared_ptr<MtpProcedure> procedure = new MtpProcedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    procedure.setRequested(1L);
    long value;
    dpGet(_DpExists + ".requested", value);
    assertEqual(value, 1L);
    assertEqual(procedure.getRequested(), 1L);
    return 0;
  }

  public int testSetCurrent()
  {
    shared_ptr<MtpProcedure> procedure = new MtpProcedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    procedure.setCurrent(1L);
    long value;
    dpGet(_DpExists + ".current", value);
    assertEqual(value, 1L);
    assertEqual(procedure.getCurrent(), 1L);
    return 0;
  }

  private void setExternalCB(const long &value)
  {
    _eventExternal = value;
  }

  private void setCurrentCB(const long &value)
  {
    _eventCurrent = value;
  }

  private void setInternalCB(const long &value)
  {
    _eventInternal = value;
  }

  private void setRequestedCB(const long &value)
  {
    _eventRequested = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMtpProcedure test;
  test.startAll();
}
