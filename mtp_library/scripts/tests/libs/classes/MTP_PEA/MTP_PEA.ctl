// $License: NOLICENSE
/** Tests for the library: scripts/libs/classes/MTP_PEA/MTP_PEA.ctl.

  @file $relPath
  @test Unit tests for the library: scripts/libs/classes/MTP_PEA/MTP_PEA.ctl
  @copyright $copyright
  @author d.schermann
 */

#uses "classes/MTP_PEA/MTP_PEA"
#uses "classes/oaTest/OaTest"

class TstMTP_PEA : OaTest
{
  private const string _Dpt = "MTP_PEA";
  private const string _DpExists = "ExistingTestDatapointPEA";

  private dyn_string _allFields;
  private dyn_int _allTypes;
  private dyn_string _constructorFields;
  private dyn_string _createdDpts;
  private dyn_string _createdDps;
  private dyn_string _invalidDps;

  private bit32 _eventDeviceHealth;
  private string _eventDeviceRevision;
  private string _eventHardwareRevision;
  private int _eventRevisionCounter;
  private string _eventSoftwareRevision;

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

    _allFields = makeDynString("tagName", "WQC", "AssetId", "ComponentName", "DeviceClass", "DeviceHealth",
                               "DeviceRevision", "HardwareRevision", "Manufacturer", "ManufacturerUri", "Model",
                               "ProductCode", "ProductInstanceUri", "RevisionCounter", "processValueIns",
                               "processValueOuts", "SerialNumber", "SoftwareRevision");

    _allTypes = makeDynInt(DPEL_LANGSTRING, DPEL_BIT32, DPEL_STRING, DPEL_STRING, DPEL_STRING, DPEL_BIT32,
                           DPEL_STRING, DPEL_STRING, DPEL_STRING, DPEL_STRING, DPEL_STRING,
                           DPEL_STRING, DPEL_STRING, DPEL_INT, DPEL_DPID,
                           DPEL_DPID, DPEL_STRING, DPEL_STRING);

    _constructorFields = makeDynString("AssetId", "ComponentName", "DeviceClass", "DeviceHealth",
                                       "DeviceRevision", "HardwareRevision", "Manufacturer", "ManufacturerUri", "Model",
                                       "ProductCode", "ProductInstanceUri", "RevisionCounter", "processValueIns",
                                       "processValueOuts", "SerialNumber", "SoftwareRevision");

    createTypeAndDp(_Dpt, _DpExists, "");

    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      string dptInvalid = _Dpt + "Invalid" + i;
      string dpInvalid = "ExistingTestDatapointPEAInvalid" + i;
      createTypeAndDp(dptInvalid, dpInvalid, _constructorFields[i]);
      dynAppend(_invalidDps, dpInvalid);
    }

    dpSetWait(_DpExists + ".AssetId", "assetId",
              _DpExists + ".ComponentName", "componentName",
              _DpExists + ".DeviceClass", "deviceClass",
              _DpExists + ".Manufacturer", "manufacturer",
              _DpExists + ".ManufacturerUri", "manufacturerUri",
              _DpExists + ".Model", "model",
              _DpExists + ".ProductCode", "productCode",
              _DpExists + ".ProductInstanceUri", "instanceUri",
              _DpExists + ".processValueIns", _DpExists,
              _DpExists + ".processValueOuts", _DpExists,
              _DpExists + ".SerialNumber", "serialNumber",
              _DpExists + ".DeviceHealth", (bit32)0x00,
              _DpExists + ".DeviceRevision", "rev1",
              _DpExists + ".HardwareRevision", "hw1",
              _DpExists + ".RevisionCounter", 1,
              _DpExists + ".SoftwareRevision", "sw1");

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

  public int testConstructorAndGetters()
  {
    shared_ptr<MTP_PEA> pea = new MTP_PEA(_DpExists);

    assertEqual(pea.getDp(), _DpExists);
    assertEqual(pea.getTitle(), "componentName");
    assertEqual(pea.getDescription(), "deviceClass");
    assertEqual(pea.getAssetId(), "assetId");
    assertEqual(pea.getComponentName(), "componentName");
    assertEqual(pea.getDeviceClass(), "deviceClass");
    assertEqual(pea.getManufacturer(), "manufacturer");
    assertEqual(pea.getManufacturerUri(), "manufacturerUri");
    assertEqual(pea.getModel(), "model");
    assertEqual(pea.getProductCode(), "productCode");
    assertEqual(pea.getProductInstanceUri(), "instanceUri");
    assertEqual(pea.getSerialNumber(), "serialNumber");
    assertTrue(pea.getProcessValueIns().count() > 0);
    assertTrue(pea.getProcessValueOuts().count() > 0);
    assertEqual(pea.getDeviceHealth(), (bit32)0x00);
    return 0;
  }

  public int testTitleAndDescriptionFallback()
  {
    dpSetWait(_DpExists + ".ComponentName", "",
              _DpExists + ".DeviceClass", "");

    shared_ptr<MTP_PEA> pea = new MTP_PEA(_DpExists);
    assertEqual(pea.getTitle(), "PEA");
    assertEqual(pea.getDescription(), "PEA Information");
    return 0;
  }

  public int testConstructor_MissingDpes()
  {
    for (int i = 1; i <= dynlen(_constructorFields); i++)
    {
      try
      {
        shared_ptr<MTP_PEA> pea = new MTP_PEA(_invalidDps[i]);
        assertTrue(false, "shouldn't reach here");
      }
      catch
      {
        dyn_errClass err = getLastException();
        assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
        assertTrue(getErrorText(err).contains(_invalidDps[i] + "." + _constructorFields[i]));
      }
    }
    return 0;
  }

  public int testConstructor_NoneExistingDatapoint()
  {
    try
    {
      shared_ptr<MTP_PEA> pea = new MTP_PEA("NoneExistingDatapointPEA");
      assertTrue(false, "shouldn't reach here");
    }
    catch
    {
      dyn_errClass err = getLastException();
      assertEqual(getErrorCode(err), (int)ErrCode::DPNOTEXISTENT);
      assertTrue(getErrorText(err).contains("NoneExistingDatapointPEA"));
    }

    return 0;
  }

  public int testChangedEventsAndGetters()
  {
    shared_ptr<MTP_PEA> pea = new MTP_PEA(_DpExists);

    classConnect(this, setDeviceHealthChangedCB, pea, MTP_PEA::deviceHealthChanged);
    classConnect(this, setDeviceRevisionChangedCB, pea, MTP_PEA::deviceRevisionChanged);
    classConnect(this, setHardwareRevisionChangedCB, pea, MTP_PEA::hardwareRevisionChanged);
    classConnect(this, setRevisionCounterChangedCB, pea, MTP_PEA::revisionCounterChanged);
    classConnect(this, setSoftwareRevisionChangedCB, pea, MTP_PEA::softwareRevisionChanged);

    dpSetWait(_DpExists + ".DeviceHealth", (bit32)0xAA,
              _DpExists + ".DeviceRevision", "rev2",
              _DpExists + ".HardwareRevision", "hw2",
              _DpExists + ".RevisionCounter", 2,
              _DpExists + ".SoftwareRevision", "sw2");

    delay(0, 200);

    assertEqual(pea.getDeviceHealth(), (bit32)0xAA);
    assertEqual(pea.getDeviceRevision(), "rev2");
    assertEqual(pea.getHardwareRevision(), "hw2");
    assertEqual(pea.getRevisionCounter(), 2);
    assertEqual(pea.getSoftwareRevision(), "sw2");

    assertEqual(_eventDeviceHealth, (bit32)0xAA);
    assertEqual(_eventDeviceRevision, "rev2");
    assertEqual(_eventHardwareRevision, "hw2");
    assertEqual(_eventRevisionCounter, 2);
    assertEqual(_eventSoftwareRevision, "sw2");
    return 0;
  }

  private void setDeviceHealthChangedCB(const bit32 &deviceHealth)
  {
    _eventDeviceHealth = deviceHealth;
  }

  private void setDeviceRevisionChangedCB(const string &deviceRevision)
  {
    _eventDeviceRevision = deviceRevision;
  }

  private void setHardwareRevisionChangedCB(const string &hardwareRevision)
  {
    _eventHardwareRevision = hardwareRevision;
  }

  private void setRevisionCounterChangedCB(const int &revisionCounter)
  {
    _eventRevisionCounter = revisionCounter;
  }

  private void setSoftwareRevisionChangedCB(const string &softwareRevision)
  {
    _eventSoftwareRevision = softwareRevision;
  }
};

void main()
{
  TstMTP_PEA test;
  test.startAll();
}
