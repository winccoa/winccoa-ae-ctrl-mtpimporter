// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_PIDCtrl/MTP_PIDCtrl.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_PIDCtrl/MTP_PIDCtrl.ctl
  @copyright $copyright
  @author d.schermann
 */

//-----------------------------------------------------------------------------
// Libraries used (#uses)
#uses "classes/MTP_PIDCtrl/MTP_PIDCtrl" // tested object
#uses "classes/oaTest/OaTest" // oaTest basic class

//-----------------------------------------------------------------------------
/** Tests for MTP_PIDCtrl.ctl
*/
class TstMTP_PIDCtrl : OaTest
{
  private const string _Dpt = "MTP_PIDCtrl";
  private const string _DpExists = "ExistingTestDatapoint";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _pidConstructorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;

  private float _eventProcessValue;
  private float _eventSetpointInternal;
  private float _eventSetpoint;
  private float _eventManipulatedValue;
  private float _eventManipulatedValueMin;
  private float _eventManipulatedValueMax;
  private float _eventSetpointManual;
  private float _eventSetpointInternalMin;
  private float _eventSetpointInternalMax;
  private float _eventProcessValueScaleMin;
  private float _eventProcessValueScaleMax;
  private float _eventSetpointScaleMin;
  private float _eventSetpointScaleMax;
  private float _eventManipulatedValueScaleMin;
  private float _eventManipulatedValueScaleMax;

  private void createTypeAndDp(const string &dpt, const string &dp, const string &missingField)
  {
    dyn_dyn_string dpes = makeDynAnytype(makeDynString(dpt));
    dyn_dyn_int values = makeDynAnytype(makeDynInt(DPEL_STRUCT));

    for (int i = 1; i <= dynlen(_allFields); i++)
    {
      if (_allFields[i] == missingField)
      {
        continue;
      }

      dynAppend(dpes, makeDynString("", _allFields[i]));
      dynAppend(values, makeDynInt(0, _allTypes[i]));
    }

    if (dpTypes(dpes[1][1]).count() == 0)
      dpTypeCreate(dpes, values);
    if (!dpExists(dp))
      dpCreate(dp, dpt);

    dynAppend(_createdDpts, dpt);
    dynAppend(_createdDps, dp);
  }

  public int setUp() override
  {
    _createdDpts = makeDynString();
    _createdDps = makeDynString();
    _invalidDps = makeDynString();

    _allFields = makeDynString("tagName", "WQC", "OSLevel",
                               "PV", "PVSclMin", "PVSclMax",
                               "SPMan", "SPInt", "SPSclMin", "SPSclMax", "SPIntMin", "SPIntMax", "SPManMin", "SPManMax", "SP",
                               "MVMan", "MV", "MVMin", "MVMax", "MVSclMin", "MVSclMax",
                               "P", "Ti", "Td",
                               "SrcChannel", "SrcManAut", "SrcIntAut", "SrcManOp", "SrcIntOp", "SrcManAct", "SrcIntAct",
                               "StateChannel", "StateOffAut", "StateOpAut", "StateAutAut", "StateOffOp", "StateOpOp", "StateAutOp", "StateOpAct", "StateAutAct", "StateOffAct",
                               "PVUnit", "SPUnit", "MVUnit", "enabled");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_INT,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_FLOAT, DPEL_FLOAT, DPEL_FLOAT,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL, DPEL_BOOL,
                           DPEL_INT, DPEL_INT, DPEL_INT, DPEL_BOOL);

    _pidConstructorFields = makeDynString("PV", "PVSclMin", "PVSclMax", "SPMan", "SPInt", "SPSclMin", "SPSclMax", "SPIntMin", "SPIntMax", "SPManMin", "SPManMax", "SP", "MVMan", "MV", "MVMin", "MVMax", "MVSclMin", "MVSclMax", "P", "Ti", "Td");

    createTypeAndDp(_Dpt, _DpExists, "");

    for (int i = 1; i <= dynlen(_pidConstructorFields); i++)
    {
      string dptInvalid = _Dpt + "Invalid" + i;
      string dpInvalid = "ExistingTestDatapointInvalid" + i;
      createTypeAndDp(dptInvalid, dpInvalid, _pidConstructorFields[i]);
      dynAppend(_invalidDps, dpInvalid);
    }

    dpSetWait(_DpExists + ".SPMan", 11.1,
              _DpExists + ".SPManMin", 1.1,
              _DpExists + ".SPManMax", 99.9,
              _DpExists + ".MVMan", 22.2,
              _DpExists + ".P", 1.5,
              _DpExists + ".Ti", 0.8,
              _DpExists + ".Td", 0.3);

    return OaTest::setUp();
  }


  private bool isTestOnlyDpt(const string &dpt)
  {
    return dpt.contains("Invalid") || dpt.contains("Unsupported") || dpt.contains("UT") || dpt.contains("Tst") || dpt == "TestDpt";
  }
  public int tearDown() override
  {
    for (int i = 1; i <= dynlen(_createdDps); i++)
    {
      dpDelete(_createdDps[i]);
    }


    for (int i = 1; i <= dynlen(_createdDpts); i++)
    {
      if (isTestOnlyDpt(_createdDpts[i]) && dpTypes(_createdDpts[i]).count() > 0)
        dpTypeDelete(_createdDpts[i]);
    }
    return OaTest::tearDown();
  }

  public int testConstructor()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    assertEqual(pidCtrl.getDp(), _DpExists);
    assertEqual(pidCtrl.getSetpointManual(), 11.1);
    assertEqual(pidCtrl.getSetpointManualMin(), 1.1);
    assertEqual(pidCtrl.getSetpointManualMax(), 99.9);
    assertEqual(pidCtrl.getManipulatedValueManual(), 22.2);
    assertEqual(pidCtrl.getProportionalParameter(), 1.5);
    assertEqual(pidCtrl.getIntegrationParameter(), 0.8);
    assertEqual(pidCtrl.getDerivationParameter(), 0.3);
    assertTrue(pidCtrl.getWqc() != nullptr);
    assertTrue(pidCtrl.getOsLevel() != nullptr);
    assertTrue(pidCtrl.getSource() != nullptr);
    assertTrue(pidCtrl.getState() != nullptr);
    assertTrue(pidCtrl.getProcessValueUnit() != nullptr);
    assertTrue(pidCtrl.getSetpointUnit() != nullptr);
    assertTrue(pidCtrl.getManipulatedValueUnit() != nullptr);
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_pidConstructorFields); i++)
    {
      try
      {
        shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_invalidDps[i]);
        assertTrue(false, "shouldn't reach here");
      }
      catch
      {
        dyn_errClass err = getLastException();
        assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
        assertTrue(getErrorText(err).contains(_invalidDps[i] + "." + _pidConstructorFields[i]));
      }
    }

    return 0;
  }

  public int testProcessValueChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setProcessValueChangedCB, pidCtrl, MTP_PIDCtrl::processValueChanged);
    dpSetWait(_DpExists + ".PV", 42.5);
    delay(0, 200);
    assertEqual(pidCtrl.getProcessValue(), 42.5);
    assertEqual(_eventProcessValue, 42.5);
    return 0;
  }

  public int testSetpointInternalChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setSetpointInternalChangedCB, pidCtrl, MTP_PIDCtrl::setpointInternalChanged);
    dpSetWait(_DpExists + ".SPInt", 33.7);
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointInternal(), 33.7);
    assertEqual(_eventSetpointInternal, 33.7);
    return 0;
  }

  public int testSetpointManualChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setSetpointManualChangedCB, pidCtrl, MTP_PIDCtrl::setpointManualChanged);
    dpSetWait(_DpExists + ".SPMan", 12.3);
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointManual(), 12.3);
    assertEqual(_eventSetpointManual, 12.3);
    return 0;
  }

  public int testSetpointChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setSetpointChangedCB, pidCtrl, MTP_PIDCtrl::setpointChanged);
    dpSetWait(_DpExists + ".SP", 50.0);
    delay(0, 200);
    assertEqual(pidCtrl.getSetpoint(), 50.0);
    assertEqual(_eventSetpoint, 50.0);
    return 0;
  }

  public int testManipulatedValueChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setManipulatedValueChangedCB, pidCtrl, MTP_PIDCtrl::manipulatedValueChanged);
    dpSetWait(_DpExists + ".MV", 75.2);
    delay(0, 200);
    assertEqual(pidCtrl.getManipulatedValue(), 75.2);
    assertEqual(_eventManipulatedValue, 75.2);
    return 0;
  }

  public int testManipulatedValueMinChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setManipulatedValueMinChangedCB, pidCtrl, MTP_PIDCtrl::manipulatedValueMinChanged);
    dpSetWait(_DpExists + ".MVMin", -50.0);
    delay(0, 200);
    assertEqual(pidCtrl.getManipulatedValueMin(), -50.0);
    assertEqual(_eventManipulatedValueMin, -50.0);
    return 0;
  }

  public int testManipulatedValueMaxChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setManipulatedValueMaxChangedCB, pidCtrl, MTP_PIDCtrl::manipulatedValueMaxChanged);
    dpSetWait(_DpExists + ".MVMax", 200.0);
    delay(0, 200);
    assertEqual(pidCtrl.getManipulatedValueMax(), 200.0);
    assertEqual(_eventManipulatedValueMax, 200.0);
    return 0;
  }

  public int testSetpointInternalMinChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setSetpointInternalMinChangedCB, pidCtrl, MTP_PIDCtrl::setpointInternalMinChanged);
    dpSetWait(_DpExists + ".SPIntMin", -25.0);
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointInternalMin(), -25.0);
    assertEqual(_eventSetpointInternalMin, -25.0);
    return 0;
  }

  public int testSetpointInternalMaxChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setSetpointInternalMaxChangedCB, pidCtrl, MTP_PIDCtrl::setpointInternalMaxChanged);
    dpSetWait(_DpExists + ".SPIntMax", 25.0);
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointInternalMax(), 25.0);
    assertEqual(_eventSetpointInternalMax, 25.0);
    return 0;
  }

  public int testProcessValueScaleMinChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setProcessValueScaleMinChangedCB, pidCtrl, MTP_PIDCtrl::processValueScaleMinChanged);
    dpSetWait(_DpExists + ".PVSclMin", -100.0);
    delay(0, 200);
    assertEqual(pidCtrl.getProcessValueScaleMin(), -100.0);
    assertEqual(_eventProcessValueScaleMin, -100.0);
    return 0;
  }

  public int testProcessValueScaleMaxChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setProcessValueScaleMaxChangedCB, pidCtrl, MTP_PIDCtrl::processValueScaleMaxChanged);
    dpSetWait(_DpExists + ".PVSclMax", 100.0);
    delay(0, 200);
    assertEqual(pidCtrl.getProcessValueScaleMax(), 100.0);
    assertEqual(_eventProcessValueScaleMax, 100.0);
    return 0;
  }

  public int testSetpointScaleMinChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setSetpointScaleMinChangedCB, pidCtrl, MTP_PIDCtrl::setpointScaleMinChanged);
    dpSetWait(_DpExists + ".SPSclMin", -75.0);
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointScaleMin(), -75.0);
    assertEqual(_eventSetpointScaleMin, -75.0);
    return 0;
  }

  public int testSetpointScaleMaxChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setSetpointScaleMaxChangedCB, pidCtrl, MTP_PIDCtrl::setpointScaleMaxChanged);
    dpSetWait(_DpExists + ".SPSclMax", 75.0);
    delay(0, 200);
    assertEqual(pidCtrl.getSetpointScaleMax(), 75.0);
    assertEqual(_eventSetpointScaleMax, 75.0);
    return 0;
  }

  public int testManipulatedValueScaleMinChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setManipulatedValueScaleMinChangedCB, pidCtrl, MTP_PIDCtrl::manipulatedValueScaleMinChanged);
    dpSetWait(_DpExists + ".MVSclMin", -10.0);
    delay(0, 200);
    assertEqual(pidCtrl.getManipulatedValueScaleMin(), -10.0);
    assertEqual(_eventManipulatedValueScaleMin, -10.0);
    return 0;
  }

  public int testManipulatedValueScaleMaxChanged()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    classConnect(this, setManipulatedValueScaleMaxChangedCB, pidCtrl, MTP_PIDCtrl::manipulatedValueScaleMaxChanged);
    dpSetWait(_DpExists + ".MVSclMax", 10.0);
    delay(0, 200);
    assertEqual(pidCtrl.getManipulatedValueScaleMax(), 10.0);
    assertEqual(_eventManipulatedValueScaleMax, 10.0);
    return 0;
  }

  public int testSetSetpointManual()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setSetpointManual(75.5);
    float dpValue;
    dpGet(_DpExists + ".SPMan", dpValue);
    assertEqual(pidCtrl.getSetpointManual(), 75.5);
    assertEqual(dpValue, 75.5);
    return 0;
  }

  public int testSetManipulatedValueManual()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setManipulatedValueManual(-25.0);
    float dpValue;
    dpGet(_DpExists + ".MVMan", dpValue);
    assertEqual(pidCtrl.getManipulatedValueManual(), -25.0);
    assertEqual(dpValue, -25.0);
    return 0;
  }

  public int testSetSetpointManualMin()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setSetpointManualMin(10.0);
    float dpValue;
    dpGet(_DpExists + ".SPManMin", dpValue);
    assertEqual(pidCtrl.getSetpointManualMin(), 10.0);
    assertEqual(dpValue, 10.0);
    return 0;
  }

  public int testSetSetpointManualMax()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setSetpointManualMax(100.0);
    float dpValue;
    dpGet(_DpExists + ".SPManMax", dpValue);
    assertEqual(pidCtrl.getSetpointManualMax(), 100.0);
    assertEqual(dpValue, 100.0);
    return 0;
  }

  public int testSetProcessValue()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setProcessValue(50.0);
    float dpValue;
    dpGet(_DpExists + ".PV", dpValue);
    assertEqual(pidCtrl.getProcessValue(), 50.0);
    assertEqual(dpValue, 50.0);
    return 0;
  }

  public int testSetSetpoint()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setSetpoint(75.0);
    float dpValue;
    dpGet(_DpExists + ".SP", dpValue);
    assertEqual(pidCtrl.getSetpoint(), 75.0);
    assertEqual(dpValue, 75.0);
    return 0;
  }

  public int testSetManipulatedValue()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setManipulatedValue(25.0);
    float dpValue;
    dpGet(_DpExists + ".MV", dpValue);
    assertEqual(pidCtrl.getManipulatedValue(), 25.0);
    assertEqual(dpValue, 25.0);
    return 0;
  }

  public int testSetProportionalParameter()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setProportionalParameter(1.5);
    float dpValue;
    dpGet(_DpExists + ".P", dpValue);
    assertEqual(pidCtrl.getProportionalParameter(), 1.5);
    assertEqual(dpValue, 1.5);
    return 0;
  }

  public int testSetIntegrationParameter()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setIntegrationParameter(0.8);
    float dpValue;
    dpGet(_DpExists + ".Ti", dpValue);
    assertEqual(pidCtrl.getIntegrationParameter(), 0.8);
    assertEqual(dpValue, 0.8);
    return 0;
  }

  public int testSetDerivationParameter()
  {
    shared_ptr<MTP_PIDCtrl> pidCtrl = new MTP_PIDCtrl(_DpExists);
    pidCtrl.setDerivationParameter(0.3);
    float dpValue;
    dpGet(_DpExists + ".Td", dpValue);
    assertEqual(pidCtrl.getDerivationParameter(), 0.3);
    assertEqual(dpValue, 0.3);
    return 0;
  }

  private void setProcessValueChangedCB(const float &value)
  {
    _eventProcessValue = value;
  }

  private void setSetpointInternalChangedCB(const float &value)
  {
    _eventSetpointInternal = value;
  }

  private void setSetpointChangedCB(const float &value)
  {
    _eventSetpoint = value;
  }

  private void setManipulatedValueChangedCB(const float &value)
  {
    _eventManipulatedValue = value;
  }

  private void setManipulatedValueMinChangedCB(const float &value)
  {
    _eventManipulatedValueMin = value;
  }

  private void setManipulatedValueMaxChangedCB(const float &value)
  {
    _eventManipulatedValueMax = value;
  }

  private void setSetpointManualChangedCB(const float &value)
  {
    _eventSetpointManual = value;
  }

  private void setSetpointInternalMinChangedCB(const float &value)
  {
    _eventSetpointInternalMin = value;
  }

  private void setSetpointInternalMaxChangedCB(const float &value)
  {
    _eventSetpointInternalMax = value;
  }

  private void setProcessValueScaleMinChangedCB(const float &value)
  {
    _eventProcessValueScaleMin = value;
  }

  private void setProcessValueScaleMaxChangedCB(const float &value)
  {
    _eventProcessValueScaleMax = value;
  }

  private void setSetpointScaleMinChangedCB(const float &value)
  {
    _eventSetpointScaleMin = value;
  }

  private void setSetpointScaleMaxChangedCB(const float &value)
  {
    _eventSetpointScaleMax = value;
  }

  private void setManipulatedValueScaleMinChangedCB(const float &value)
  {
    _eventManipulatedValueScaleMin = value;
  }

  private void setManipulatedValueScaleMaxChangedCB(const float &value)
  {
    _eventManipulatedValueScaleMax = value;
  }
};

//-----------------------------------------------------------------------------
void main()
{
  TstMTP_PIDCtrl test;
  test.startAll();
}
