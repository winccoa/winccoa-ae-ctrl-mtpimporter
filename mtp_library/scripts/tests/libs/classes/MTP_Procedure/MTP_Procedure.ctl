// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_Procedure/MTP_Procedure.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_Procedure/MTP_Procedure.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "std"
#uses "classes/MTP_Procedure/MTP_Procedure" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
// Variables and Constants

//-----------------------------------------------------------------------------
/** Tests for MTP_Procedure.ctl
*/
class TstMTP_Procedure : OaTest
{
  private const string _Dpt = "TestDptProcedure";
  private const string _DpExists = "ExistingTestDatapointProcedure";

  private uint _eventExternal;
  private uint _eventCurrent;
  private uint _eventInternal;
  private uint _eventRequested;

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
                           makeDynInt(0, DPEL_UINT),
                           makeDynInt(0, DPEL_UINT),
                           makeDynInt(0, DPEL_UINT),
                           makeDynInt(0, DPEL_UINT),
                           makeDynInt(0, DPEL_UINT)
                         );
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

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
    shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    assertEqual(procedure.getOperator(), (uint)0);
    assertEqual(procedure.getInternal(), (uint)0);
    assertEqual(procedure.getExternal(), (uint)0);
    assertEqual(procedure.getCurrent(), (uint)0);
    assertEqual(procedure.getRequested(), (uint)0);

    return 0;
  }

  public int testConstructor_NonExistingDatapoint()
  {
    try
    {
      shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
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
      shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
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
      shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
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
      shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
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
      shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
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
    shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    classConnect(this, setExternalCB, procedure, MTP_Procedure::externalChanged);

    dpSetWait(_DpExists + ".external", (uint)1);

    delay(0, 200);
    assertEqual(procedure.getExternal(), (uint)1);
    assertEqual(_eventExternal, (uint)1);
    return 0;
  }

  public int testGetCurrent()
  {
    shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    classConnect(this, setCurrentCB, procedure, MTP_Procedure::currentChanged);

    dpSetWait(_DpExists + ".current", (uint)1);

    delay(0, 200);
    assertEqual(procedure.getCurrent(), (uint)1);
    assertEqual(_eventCurrent, (uint)1);
    return 0;
  }

  public int testGetInternal()
  {
    shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    classConnect(this, setInternalCB, procedure, MTP_Procedure::internalChanged);

    dpSetWait(_DpExists + ".internal", (uint)1);

    delay(0, 200);
    assertEqual(procedure.getInternal(), (uint)1);
    assertEqual(_eventInternal, (uint)1);
    return 0;
  }

  public int testGetRequested()
  {
    shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    classConnect(this, setRequestedCB, procedure, MTP_Procedure::requestedChanged);

    dpSetWait(_DpExists + ".requested", (uint)1);

    delay(0, 200);
    assertEqual(procedure.getRequested(), (uint)1);
    assertEqual(_eventRequested, (uint)1);
    return 0;
  }

  public int testSetOperator()
  {
    shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    procedure.setOperator(TRUE);
    uint value;
    dpGet(_DpExists + ".operator", value);
    assertEqual(value, (uint)1);
    assertEqual(procedure.getOperator(), (uint)1);
    return 0;
  }

  public int testSetRequested()
  {
    shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    procedure.setRequested((uint)1);
    uint value;
    dpGet(_DpExists + ".requested", value);
    assertEqual(value, (uint)1);
    assertEqual(procedure.getRequested(), (uint)1);
    return 0;
  }

  public int testSetCurrent()
  {
    shared_ptr<MTP_Procedure> procedure = new MTP_Procedure(
      _DpExists + ".operator",
      _DpExists + ".internal",
      _DpExists + ".external",
      _DpExists + ".current",
      _DpExists + ".requested"
    );
    procedure.setCurrent((uint)1);
    uint value;
    dpGet(_DpExists + ".current", value);
    assertEqual(value, (uint)1);
    assertEqual(procedure.getCurrent(), (uint)1);
    return 0;
  }

  private void setExternalCB(const uint &value)
  {
    _eventExternal = value;
  }

  private void setCurrentCB(const uint &value)
  {
    _eventCurrent = value;
  }

  private void setInternalCB(const uint &value)
  {
    _eventInternal = value;
  }

  private void setRequestedCB(const uint &value)
  {
    _eventRequested = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_Procedure test;
  test.startAll();
}
