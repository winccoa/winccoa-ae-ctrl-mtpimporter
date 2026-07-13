// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "std"

/**
 * @class MTP_PEAProcessValueRow
 * @brief Typed row model for ProcessValueIn/Out entries in the PEA faceplate.
 */
class MTP_PEAProcessValueRow
{
  private string _dp; //!< Process value datapoint.
  private string _direction; //!< "In" or "Out".
  private string _kind; //!< "Ana", "DInt", "Bin" or "String".

  /**
   * @brief Constructor for MTP_PEAProcessValueRow.
   *
   * @param dp The process value datapoint.
   * @param direction Direction of the process value ("In" or "Out").
   */
  public MTP_PEAProcessValueRow(const string &dp, const string &direction)
  {
    _dp = dp;
    _direction = direction;

    if (!dpExists(_dp))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, _dp));
    }

    string typeName = dpTypeName(_dp);

    if (strpos(typeName, "Ana") >= 0)
    {
      _kind = "Ana";
    }
    else if (strpos(typeName, "DInt") >= 0)
    {
      _kind = "DInt";
    }
    else if (strpos(typeName, "Bin") >= 0)
    {
      _kind = "Bin";
    }
    else
    {
      _kind = "String";
    }

    connectValueUpdates();
    connectQualityUpdates();
  }

  #event rowChanged() //!< Event triggered when row content changed.

  /**
   * @brief Retrieves the datapoint.
   *
   * @return The datapoint.
   */
  public string getDp()
  {
    return _dp;
  }

  /**
   * @brief Retrieves row kind.
   *
   * @return The row kind.
   */
  public string getKind()
  {
    return _kind;
  }

  /**
   * @brief Checks whether this row is ProcessValueIn.
   *
   * @return True for ProcessValueIn.
   */
  public bool isInput()
  {
    return _direction == "In";
  }

  /**
   * @brief Checks whether this row is binary.
   *
   * @return True for Bin rows.
   */
  public bool isBinary()
  {
    return _kind == "Bin";
  }

  /**
   * @brief Retrieves the display name.
   *
   * @return The tag name or datapoint.
   */
  public string getName()
  {
    langString name;

    if (dpExists(_dp + ".tagName"))
    {
      dpGet(_dp + ".tagName", name);
    }

    string displayName = name.text();

    if (displayName == "")
    {
      displayName = _dp;
    }

    return stripSystemPrefix(displayName);
  }

  /**
   * @brief Removes leading system prefix (e.g. "System1:") from display names.
   *
   * @param value Raw display value.
   * @return Display value without system prefix.
   */
  private string stripSystemPrefix(const string &value)
  {
    dyn_string parts = strsplit(value, ":");

    if (dynlen(parts) > 1)
    {
      return parts[2];
    }

    return value;
  }

  /**
   * @brief Retrieves the DPE currently displayed as value text.
   *
   * @return Displayed value DPE.
   */
  private string getDisplayedValueDpe()
  {
    if (_kind == "String" && dpExists(_dp + ".Text"))
    {
      return _dp + ".Text";
    }

    return _dp + ".V";
  }

  /**
   * @brief Retrieves displayed value DPE for connect subscriptions.
   *
   * @return Displayed value DPE.
   */
  public string getValueDpe()
  {
    return getDisplayedValueDpe();
  }

  /**
   * @brief Retrieves WQC DPE for connect subscriptions.
   *
   * @return WQC DPE.
   */
  public string getQualityDpe()
  {
    return _dp + ".WQC";
  }

  /**
   * @brief Connects value updates for automatic row refresh.
   */
  private void connectValueUpdates()
  {
    string valueDpe = getDisplayedValueDpe();

    if (!dpExists(valueDpe))
    {
      return;
    }

    switch (_kind)
    {
      case "Ana":
      {
        dpConnect(this, valueChangedFloatCB, valueDpe);
        break;
      }

      case "DInt":
      {
        dpConnect(this, valueChangedIntCB, valueDpe);
        break;
      }

      case "Bin":
      {
        dpConnect(this, valueChangedBoolCB, valueDpe);
        break;
      }

      default:
      {
        dpConnect(this, valueChangedStringCB, valueDpe);
        break;
      }
    }
  }

  /**
   * @brief Connects quality updates for automatic row refresh.
   */
  private void connectQualityUpdates()
  {
    string qualityDpe = _dp + ".WQC";

    if (!dpExists(qualityDpe))
    {
      return;
    }

    dpConnect(this, qualityChangedCB, qualityDpe);
  }

  /**
   * @brief Retrieves the current value text.
   *
   * @return The current value text.
   */
  public string getCurrentValue()
  {
    string value;

    switch (_kind)
    {
      case "Ana":
      {
        float anaValue;
        dpGet(_dp + ".V", anaValue);
        sprintf(value, "%.2f", anaValue);
        break;
      }

      case "DInt":
      {
        int dintValue;
        dpGet(_dp + ".V", dintValue);
        value = (string)dintValue;
        break;
      }

      case "Bin":
      {
        bool binValue;
        string state0;
        string state1;
        dpGet(_dp + ".V", binValue,
              _dp + ".VState0", state0,
              _dp + ".VState1", state1);
        value = binValue ? state1 : state0;

        if (value == "")
        {
          value = binValue ? "TRUE" : "FALSE";
        }

        break;
      }

      default:
      {
        string valueDpe = _dp + ".V";

        if (_kind == "String" && dpExists(_dp + ".Text"))
        {
          valueDpe = _dp + ".Text";
        }

        dpGet(valueDpe, value);
        break;
      }
    }

    return value;
  }

  /**
   * @brief Retrieves binary value.
   *
   * @return True if current binary value is true.
   */
  public bool getCurrentBool()
  {
    bool binValue;
    dpGet(_dp + ".V", binValue);
    return binValue;
  }

  /**
   * @brief Retrieves current unit text.
   *
   * @return The unit text.
   */
  public string getUnit()
  {
    string dpeUnit = isInput() ? (_dp + ".UnitCur") : (_dp + ".VUnit");

    if (!dpExists(dpeUnit))
    {
      return "";
    }

    int unitId;
    dpGet(dpeUnit, unitId);
    return getCatStr("LCFL_Unit", unitId);
  }

  /**
   * @brief Retrieves whether WQC is good.
   *
   * @return True if quality is good.
   */
  public bool getQualityGood()
  {
    bit32 qc;
    dpGet(_dp + ".WQC", qc);
    return (qc == 0x80 || qc == 0xFF);
  }

  /**
   * @brief Writes requested value immediately for editable ProcessValueIn rows.
   *
   * @param text The user text.
   * @return True if write succeeded.
   */
  public bool setRequestedValue(const string &text)
  {
    if (!isInput() || isBinary())
    {
      return false;
    }

    switch (_kind)
    {
      case "Ana":
      {
        float value;
        int readCount = sscanf(text, "%f", value);

        if (readCount != 1)
        {
          return false;
        }

        dpSet(_dp + ".V", value);
        return true;
      }

      case "DInt":
      {
        int value;
        int readCount = sscanf(text, "%d", value);

        if (readCount != 1)
        {
          return false;
        }

        dpSet(_dp + ".V", value);
        return true;
      }

      default:
      {
        string valueDpe = _dp + ".V";

        if (_kind == "String" && dpExists(_dp + ".Text"))
        {
          valueDpe = _dp + ".Text";
        }

        dpSet(valueDpe, text);
        return true;
      }
    }
  }

  /**
   * @brief Toggles binary value immediately for ProcessValueIn bin rows.
   *
   * @return True if toggle succeeded.
   */
  public bool toggleBinaryValue()
  {
    if (!isInput() || !isBinary())
    {
      return false;
    }

    bool currentValue;
    dpGet(_dp + ".V", currentValue);
    dpSet(_dp + ".V", !currentValue);
    return true;
  }

  /**
   * @brief Opens the corresponding View faceplate for this process value row.
   *
   * @return True if the faceplate open was triggered.
   */
  public bool openTargetViewFaceplate()
  {
    hook_openFaceplate(_dp);
    return true;
  }

  /**
   * @brief Callback for analog value updates.
   */
  private void valueChangedFloatCB(const string &dpe, const float &value)
  {
    rowChanged();
  }

  /**
   * @brief Callback for integer value updates.
   */
  private void valueChangedIntCB(const string &dpe, const int &value)
  {
    rowChanged();
  }

  /**
   * @brief Callback for binary value updates.
   */
  private void valueChangedBoolCB(const string &dpe, const bool &value)
  {
    rowChanged();
  }

  /**
   * @brief Callback for string value updates.
   */
  private void valueChangedStringCB(const string &dpe, const string &value)
  {
    rowChanged();
  }

  /**
   * @brief Callback for quality updates.
   */
  private void qualityChangedCB(const string &dpe, const bit32 &quality)
  {
    rowChanged();
  }
};
