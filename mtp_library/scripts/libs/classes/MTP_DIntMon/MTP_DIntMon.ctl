// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimitDInt"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_DIntView/MTP_DIntView"

/**
 * @class MTP_DIntMon
 * @brief Represents the MTP_DIntMon class.
 */
class MTP_DIntMon : MTP_DIntView
{
  private shared_ptr<MTP_OsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MTP_ValueLimitDInt> _alertHighLimit; //!< The alert high limit for the monitored value.
  private shared_ptr<MTP_ValueLimitDInt> _warningHighLimit; //!< The warning high limit for the monitored value.
  private shared_ptr<MTP_ValueLimitDInt> _toleranceHighLimit; //!< The tolerance high limit for the monitored value.
  private shared_ptr<MTP_ValueLimitDInt> _toleranceLowLimit; //!< The tolerance low limit for the monitored value.
  private shared_ptr<MTP_ValueLimitDInt> _warningLowLimit; //!< The warning low limit for the monitored value.
  private shared_ptr<MTP_ValueLimitDInt> _alertLowLimit; //!< The alert low limit for the monitored value.

  /**
   * @brief Constructor for the MTP_DIntMon object.
   *
   * @param dp The data point of the MTP_DIntMon.
   */
  public MTP_DIntMon(const string &dp) : MTP_DIntView(dp)
  {
    _osLevel = new MTP_OsLevel(getDp() + ".OSLevel");
    _alertHighLimit = new MTP_ValueLimitDInt(getDp() + ".VAHLim", getDp() + ".VAHEn", getDp() + ".VAHAct");
    _warningHighLimit = new MTP_ValueLimitDInt(getDp() + ".VWHLim", getDp() + ".VWHEn", getDp() + ".VWHAct");
    _toleranceHighLimit = new MTP_ValueLimitDInt(getDp() + ".VTHLim", getDp() + ".VTHEn", getDp() + ".VTHAct");
    _toleranceLowLimit = new MTP_ValueLimitDInt(getDp() + ".VTLLim", getDp() + ".VTLEn", getDp() + ".VTLAct");
    _warningLowLimit = new MTP_ValueLimitDInt(getDp() + ".VWLLim", getDp() + ".VWLEn", getDp() + ".VWLAct");
    _alertLowLimit = new MTP_ValueLimitDInt(getDp() + ".VALLim", getDp() + ".VALEn", getDp() + ".VALAct");
  }

  /**
   * @brief Retrieves the operating system level information.
   *
   * @return The shared pointer to the MTP_OsLevel instance.
   */
  public shared_ptr<MTP_OsLevel> getOsLevel()
  {
    return _osLevel;
  }

  /**
   * @brief Retrieves the high alert limit value as a shared pointer.
   *
   * @return The shared pointer to the high alert limit instance.
   */
  public shared_ptr<MTP_ValueLimitDInt> getAlertHighLimit()
  {
    return _alertHighLimit;
  }

  /**
   * @brief Retrieves the high warning limit for the monitored value.
   *
   * @return The shared pointer to the high warning limit instance.
   */
  public shared_ptr<MTP_ValueLimitDInt> getWarningHighLimit()
  {
    return _warningHighLimit;
  }

  /**
   * @brief Retrieves the high tolerance limit for the monitored value.
   *
   * @return The shared pointer to the high tolerance limit instance.
   */
  public shared_ptr<MTP_ValueLimitDInt> getToleranceHighLimit()
  {
    return _toleranceHighLimit;
  }

  /**
   * @brief Retrieves the low tolerance limit for the monitored value.
   *
   * @return The shared pointer to the low tolerance limit instance.
   */
  public shared_ptr<MTP_ValueLimitDInt> getToleranceLowLimit()
  {
    return _toleranceLowLimit;
  }

  /**
   * @brief Retrieves the warning low limit for the monitored value.
   *
   * @return The shared pointer to the warning low limit instance.
   */
  public shared_ptr<MTP_ValueLimitDInt> getWarningLowLimit()
  {
    return _warningLowLimit;
  }

  /**
   * @brief Retrieves the alert low limit for the monitored value.
   *
   * @return The shared pointer to the alert low limit instance.
   */
  public shared_ptr<MTP_ValueLimitDInt> getAlertLowLimit()
  {
    return _alertLowLimit;
  }
};
