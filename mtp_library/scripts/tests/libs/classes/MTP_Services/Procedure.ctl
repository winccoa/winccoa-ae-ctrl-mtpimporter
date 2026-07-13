// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_Services/Procedure.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_Services/Procedure.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_Services/Procedure"
#uses "classes/oaTest/OaTest"

class TstProcedure : OaTest
{
  private const string _Dpt = "TstMTP_Procedure";
  private const string _DptInvalidMissingName = "TstMTP_ProcedureInvalid1";
  private const string _DptInvalidMissingParameters = "TstMTP_ProcedureInvalid2";
  private const string _DpExists = "TstMTP_ProcedureDp";
  private const string _DpExistsInvalidMissingName = "TstMTP_ProcedureInvalidDp1";
  private const string _DpExistsInvalidMissingParameters = "TstMTP_ProcedureInvalidDp2";

  public int setUp() override
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(_Dpt),
                                         makeDynString("", "Name"),
                                         makeDynString("", "parameters"));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                                        makeDynInt(0, DPEL_LANGSTRING),
                                        makeDynInt(0, DPEL_DYN_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExists))
      dpCreate(_DpExists, _Dpt);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingName),
                          makeDynString("", "parameters"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_DYN_STRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingName))
      dpCreate(_DpExistsInvalidMissingName, _DptInvalidMissingName);

    dpes = makeDynAnytype(makeDynString(_DptInvalidMissingParameters),
                          makeDynString("", "Name"));
    values = makeDynAnytype(makeDynInt(DPEL_STRUCT),
                            makeDynInt(0, DPEL_LANGSTRING));
    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(_DpExistsInvalidMissingParameters))
      dpCreate(_DpExistsInvalidMissingParameters, _DptInvalidMissingParameters);

    dpSetWait(_DpExists + ".Name", "ProcedureName",
              _DpExists + ".parameters", makeDynString());

    return OaTest::setUp();
  }

  public int tearDown() override
  {
    dpDelete(_DpExists);
    if (dpTypes(_Dpt).count() > 0)
      dpTypeDelete(_Dpt);

    dpDelete(_DpExistsInvalidMissingName);

    if (dpTypes(_DptInvalidMissingName).count() > 0)
      dpTypeDelete(_DptInvalidMissingName);

    dpDelete(_DpExistsInvalidMissingParameters);

    if (dpTypes(_DptInvalidMissingParameters).count() > 0)
      dpTypeDelete(_DptInvalidMissingParameters);

    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<Procedure> procedure = new Procedure(_DpExists);

    assertEqual(procedure.getName(), "ProcedureName");
    assertEqual(procedure.getParameters().count(), 0);
    return 0;
  }

  public int testConstructor_MissingDp()
  {
    try
    {
      shared_ptr<Procedure> procedure = new Procedure("MissingProcedureDp");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("MissingProcedureDp"));
    }

    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    try
    {
      shared_ptr<Procedure> procedure = new Procedure(_DpExistsInvalidMissingName);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingName + ".Name"));
    }

    try
    {
      shared_ptr<Procedure> procedure = new Procedure(_DpExistsInvalidMissingParameters);
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains(_DpExistsInvalidMissingParameters + ".parameters"));
    }

    return 0;
  }
};

void main()
{
  TstProcedure test;
  test.startAll();
}
