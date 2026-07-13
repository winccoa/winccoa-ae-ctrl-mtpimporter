// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "std"

/**
 * @class MTP_PEA
 * @brief Represents the MTP_PEA class.
 */
class MTP_PEA
{
  private string _dp; //!< The data point.
  private string _assetId; //!< The asset id.
  private string _componentName; //!< The component name.
  private string _deviceClass; //!< The device class.
  private bit32 _deviceHealth; //!< The device health.
  private string _deviceRevision; //!< The device revision.
  private string _hardwareRevision; //!< The hardware revision.
  private string _manufacturer; //!< The manufacturer.
  private string _manufacturerUri; //!< The manufacturer URI.
  private string _model; //!< The model.
  private string _productCode; //!< The product code.
  private string _productInstanceUri; //!< The product instance URI.
  private int _revisionCounter; //!< The revision counter.
  private dyn_string _processValueIns; //!< Global ProcessValueIn datapoints.
  private dyn_string _processValueOuts; //!< Global ProcessValueOut datapoints.
  private string _serialNumber; //!< The serial number.
  private string _softwareRevision; //!< The software revision.

  /**
   * @brief Constructor for the MTP_PEA object.
   *
   * @param dp The data point of the MTP_PEA.
   */
  public MTP_PEA(const string &dp)
  {
    _dp = dp;

    if (!dpExists(_dp))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dp));
    }

    if (!dpExists(getDp() + ".AssetId"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".AssetId"));
    }

    if (!dpExists(getDp() + ".ComponentName"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ComponentName"));
    }

    if (!dpExists(getDp() + ".DeviceClass"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".DeviceClass"));
    }

    if (!dpExists(getDp() + ".DeviceHealth"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".DeviceHealth"));
    }

    if (!dpExists(getDp() + ".DeviceRevision"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".DeviceRevision"));
    }

    if (!dpExists(getDp() + ".HardwareRevision"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".HardwareRevision"));
    }

    if (!dpExists(getDp() + ".Manufacturer"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Manufacturer"));
    }

    if (!dpExists(getDp() + ".ManufacturerUri"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ManufacturerUri"));
    }

    if (!dpExists(getDp() + ".Model"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Model"));
    }

    if (!dpExists(getDp() + ".ProductCode"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProductCode"));
    }

    if (!dpExists(getDp() + ".ProductInstanceUri"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ProductInstanceUri"));
    }

    if (!dpExists(getDp() + ".RevisionCounter"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".RevisionCounter"));
    }

    if (!dpExists(getDp() + ".processValueIns"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".processValueIns"));
    }

    if (!dpExists(getDp() + ".processValueOuts"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".processValueOuts"));
    }

    if (!dpExists(getDp() + ".SerialNumber"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SerialNumber"));
    }

    if (!dpExists(getDp() + ".SoftwareRevision"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SoftwareRevision"));
    }

    dpGet(getDp() + ".AssetId", _assetId,
          getDp() + ".ComponentName", _componentName,
          getDp() + ".DeviceClass", _deviceClass,
          getDp() + ".Manufacturer", _manufacturer,
          getDp() + ".ManufacturerUri", _manufacturerUri,
          getDp() + ".Model", _model,
          getDp() + ".ProductCode", _productCode,
          getDp() + ".ProductInstanceUri", _productInstanceUri,
          getDp() + ".processValueIns", _processValueIns,
          getDp() + ".processValueOuts", _processValueOuts,
          getDp() + ".SerialNumber", _serialNumber);

    dpConnect(this, setDeviceHealthCB, getDp() + ".DeviceHealth");
    dpConnect(this, setDeviceRevisionCB, getDp() + ".DeviceRevision");
    dpConnect(this, setHardwareRevisionCB, getDp() + ".HardwareRevision");
    dpConnect(this, setRevisionCounterCB, getDp() + ".RevisionCounter");
    dpConnect(this, setSoftwareRevisionCB, getDp() + ".SoftwareRevision");
  }

  #event deviceHealthChanged(const bit32 &deviceHealth) //!< Event triggered when the device health changes.
  #event deviceRevisionChanged(const string &deviceRevision) //!< Event triggered when the device revision changes.
  #event hardwareRevisionChanged(const string &hardwareRevision) //!< Event triggered when the hardware revision changes.
  #event revisionCounterChanged(const int &revisionCounter) //!< Event triggered when the revision counter changes.
  #event softwareRevisionChanged(const string &softwareRevision) //!< Event triggered when the software revision changes.

  /**
   * @brief Retrieves the data point.
   *
   * @return The data point.
   */
  public string getDp()
  {
    return _dp;
  }

  /**
   * @brief Retrieves the faceplate title.
   *
   * @return The faceplate title.
   */
  public string getTitle()
  {
    if (_componentName != "")
    {
      return _componentName;
    }

    return "PEA";
  }

  /**
   * @brief Retrieves the compact object description.
   *
   * @return The compact object description.
   */
  public string getDescription()
  {
    if (_deviceClass != "")
    {
      return _deviceClass;
    }

    return "PEA Information";
  }

  /**
   * @brief Retrieves the asset id.
   *
   * @return The asset id.
   */
  public string getAssetId()
  {
    return _assetId;
  }

  /**
   * @brief Retrieves the component name.
   *
   * @return The component name.
   */
  public string getComponentName()
  {
    return _componentName;
  }

  /**
   * @brief Retrieves the device class.
   *
   * @return The device class.
   */
  public string getDeviceClass()
  {
    return _deviceClass;
  }

  /**
   * @brief Retrieves the device health.
   *
   * @return The device health.
   */
  public bit32 getDeviceHealth()
  {
    return _deviceHealth;
  }

  /**
   * @brief Retrieves the device revision.
   *
   * @return The device revision.
   */
  public string getDeviceRevision()
  {
    return _deviceRevision;
  }

  /**
   * @brief Retrieves the hardware revision.
   *
   * @return The hardware revision.
   */
  public string getHardwareRevision()
  {
    return _hardwareRevision;
  }

  /**
   * @brief Retrieves the manufacturer.
   *
   * @return The manufacturer.
   */
  public string getManufacturer()
  {
    return _manufacturer;
  }

  /**
   * @brief Retrieves the manufacturer URI.
   *
   * @return The manufacturer URI.
   */
  public string getManufacturerUri()
  {
    return _manufacturerUri;
  }

  /**
   * @brief Retrieves the model.
   *
   * @return The model.
   */
  public string getModel()
  {
    return _model;
  }

  /**
   * @brief Retrieves the product code.
   *
   * @return The product code.
   */
  public string getProductCode()
  {
    return _productCode;
  }

  /**
   * @brief Retrieves the product instance URI.
   *
   * @return The product instance URI.
   */
  public string getProductInstanceUri()
  {
    return _productInstanceUri;
  }

  /**
   * @brief Retrieves the revision counter.
   *
   * @return The revision counter.
   */
  public int getRevisionCounter()
  {
    return _revisionCounter;
  }

  /**
   * @brief Retrieves global ProcessValueIns.
   *
   * @return List of ProcessValueIn datapoints.
   */
  public dyn_string getProcessValueIns()
  {
    return _processValueIns;
  }

  /**
   * @brief Retrieves global ProcessValueOuts.
   *
   * @return List of ProcessValueOut datapoints.
   */
  public dyn_string getProcessValueOuts()
  {
    return _processValueOuts;
  }

  /**
   * @brief Retrieves the serial number.
   *
   * @return The serial number.
   */
  public string getSerialNumber()
  {
    return _serialNumber;
  }

  /**
   * @brief Retrieves the software revision.
   *
   * @return The software revision.
   */
  public string getSoftwareRevision()
  {
    return _softwareRevision;
  }

  /**
   * @brief Sets the device health from the connected data point element.
   *
   * @param dpe The data point element.
   * @param deviceHealth The new device health.
   */
  private void setDeviceHealthCB(const string &dpe, const bit32 &deviceHealth)
  {
    _deviceHealth = deviceHealth;
    deviceHealthChanged(_deviceHealth);
  }

  /**
   * @brief Sets the device revision from the connected data point element.
   *
   * @param dpe The data point element.
   * @param deviceRevision The new device revision.
   */
  private void setDeviceRevisionCB(const string &dpe, const string &deviceRevision)
  {
    _deviceRevision = deviceRevision;
    deviceRevisionChanged(_deviceRevision);
  }

  /**
   * @brief Sets the hardware revision from the connected data point element.
   *
   * @param dpe The data point element.
   * @param hardwareRevision The new hardware revision.
   */
  private void setHardwareRevisionCB(const string &dpe, const string &hardwareRevision)
  {
    _hardwareRevision = hardwareRevision;
    hardwareRevisionChanged(_hardwareRevision);
  }

  /**
   * @brief Sets the revision counter from the connected data point element.
   *
   * @param dpe The data point element.
   * @param revisionCounter The new revision counter.
   */
  private void setRevisionCounterCB(const string &dpe, const int &revisionCounter)
  {
    _revisionCounter = revisionCounter;
    revisionCounterChanged(_revisionCounter);
  }

  /**
   * @brief Sets the software revision from the connected data point element.
   *
   * @param dpe The data point element.
   * @param softwareRevision The new software revision.
   */
  private void setSoftwareRevisionCB(const string &dpe, const string &softwareRevision)
  {
    _softwareRevision = softwareRevision;
    softwareRevisionChanged(_softwareRevision);
  }
};
