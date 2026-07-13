// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_BinMan/MTP_BinMan"
#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_BinManInt
 * @brief Represents the MTP_BinManInt class.
 */
class MTP_BinManInt : MTP_BinMan
{
  private bool _valueInternal; //!< The internal value for the monitored variable.
  private shared_ptr<MTP_Wqc> _wqc; //!< The quality code associated with the monitored variable.
  private shared_ptr<MTP_Source> _source; //!< The source information for the monitored variable.

  /**
   * @brief Constructor for the MTP_BinManInt object.
   *
   * @param dp The data point of the MTP_BinManInt.
   */
  public MTP_BinManInt(const string &dp) : MTP_BinMan(dp)
  {
    if (!dpExists(getDp() + ".VInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VInt"));
    }

    dpConnect(this, setValueInternalCB, getDp() + ".VInt");

    _wqc = new MTP_Wqc(getDp() + ".WQC");
    _source =  new MTP_Source(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
  }

#event valueInternalChanged(const bool &value) //!< Event triggered when the internal value state changes.

  /**
   * @brief Retrieves the internal value.
   *
   * @return The internal value as a boolean.
   */
  public bool getValueInternal()
  {
    return _valueInternal;
  }

  /**
   * @brief Retrieves the quality code (WQC) associated with this object.
   *
   * @return The shared pointer to the MTP_Wqc instance.
   */
  public shared_ptr<MTP_Wqc> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the source information for the monitored variable.
   *
   * @return The shared pointer to the MtpSource instance.
   */
  public shared_ptr<MTP_Source> getSource()
  {
    return _source;
  }

  /**
   * @brief Sets the internal value of the monitored variable.
   *
   * @param dpe The data point element.
   * @param value The new internal value to set.
   */
  private void setValueInternalCB(const string &dpe, const bool &value)
  {
    _valueInternal = value;
    valueInternalChanged(_valueInternal);
  }
};
