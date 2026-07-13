// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MTP_ValueLimit/MTP_ValueLimitFloat"
#uses "classes/MTP_AnaView/MTP_AnaView"
#uses "std"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_AnaMon
 * @brief Represents the MTP_AnaMon class.
 */
class MTP_AnaMon : MTP_AnaView
{
  private shared_ptr<MTP_OsLevel> _osLevel; //!< The operational state level of the monitored value.
  private shared_ptr<MTP_ValueLimitFloat> _alertHighLimit; //!< The alert high limit for the monitored value.
  private shared_ptr<MTP_ValueLimitFloat> _warningHighLimit; //!< The warning high limit for the monitored value.
  private shared_ptr<MTP_ValueLimitFloat> _toleranceHighLimit; //!< The tolerance high limit for the monitored value.
  private shared_ptr<MTP_ValueLimitFloat> _toleranceLowLimit; //!< The tolerance low limit for the monitored value.
  private shared_ptr<MTP_ValueLimitFloat> _warningLowLimit; //!< The warning low limit for the monitored value.
  private shared_ptr<MTP_ValueLimitFloat> _alertLowLimit; //!< The alert low limit for the monitored value.

  /**
   * @brief Constructor for the MTP_AnaMon object.
   *
   * @param dp The data point of the MTP_AnaMon.
   */
  public MTP_AnaMon(const string &dp) : MTP_AnaView(dp)
  {
    _osLevel = new MTP_OsLevel(getDp() + ".OSLevel");
    _alertHighLimit = new MTP_ValueLimitFloat(getDp() + ".VAHLim", getDp() + ".VAHEn", getDp() + ".VAHAct");
    _warningHighLimit = new MTP_ValueLimitFloat(getDp() + ".VWHLim", getDp() + ".VWHEn", getDp() + ".VWHAct");
    _toleranceHighLimit = new MTP_ValueLimitFloat(getDp() + ".VTHLim", getDp() + ".VTHEn", getDp() + ".VTHAct");
    _toleranceLowLimit = new MTP_ValueLimitFloat(getDp() + ".VTLLim", getDp() + ".VTLEn", getDp() + ".VTLAct");
    _warningLowLimit = new MTP_ValueLimitFloat(getDp() + ".VWLLim", getDp() + ".VWLEn", getDp() + ".VWLAct");
    _alertLowLimit = new MTP_ValueLimitFloat(getDp() + ".VALLim", getDp() + ".VALEn", getDp() + ".VALAct");
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
  public shared_ptr<MTP_ValueLimitFloat> getAlertHighLimit()
  {
    return _alertHighLimit;
  }

  /**
   * @brief Retrieves the high warning limit for the monitored value.
   *
   * @return The shared pointer to the high warning limit instance.
   */
  public shared_ptr<MTP_ValueLimitFloat> getWarningHighLimit()
  {
    return _warningHighLimit;
  }

  /**
   * @brief Retrieves the high tolerance limit for the monitored value.
   *
   * @return The shared pointer to the high tolerance limit instance.
   */
  public shared_ptr<MTP_ValueLimitFloat> getToleranceHighLimit()
  {
    return _toleranceHighLimit;
  }

  /**
   * @brief Retrieves the low tolerance limit for the monitored value.
   *
   * @return The shared pointer to the low tolerance limit instance.
   */
  public shared_ptr<MTP_ValueLimitFloat> getToleranceLowLimit()
  {
    return _toleranceLowLimit;
  }

  /**
   * @brief Retrieves the warning low limit for the monitored value.
   *
   * @return The shared pointer to the warning low limit instance.
   */
  public shared_ptr<MTP_ValueLimitFloat> getWarningLowLimit()
  {
    return _warningLowLimit;
  }

  /**
   * @brief Retrieves the alert low limit for the monitored value.
   *
   * @return The shared pointer to the alert low limit instance.
   */
  public shared_ptr<MTP_ValueLimitFloat> getAlertLowLimit()
  {
    return _alertLowLimit;
  }
};
