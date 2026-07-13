// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_DIntMan/MTP_DIntMan"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_Source/MTP_Source"

/**
 * @class MTP_DIntManInt
 * @brief Represents the MTP_DIntManInt class.
 */
class MTP_DIntManInt : MTP_DIntMan
{
  private int _valueInternal; //!< The value internal.
  private shared_ptr<MTP_Wqc> _wqc; //!< The WQC instance.
  private shared_ptr<MTP_Source> _source; //!< The source instance.

  /**
   * @brief Constructor for the MTP_DIntManInt object.
   *
   * @param dp The data point of the MTP_DIntManInt.
   */
  public MTP_DIntManInt(const string &dp) : MTP_DIntMan(dp)
  {
    if (!dpExists(getDp() + ".VInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VInt"));
    }

    dpConnect(this, setValueInternalCB, getDp() + ".VInt");

    _wqc = new MTP_Wqc(getDp() + ".WQC");
    _source = new MTP_Source(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
  }

  #event valueInternalChanged(const int &valueInternal) //!< Event triggered when the value internal changes.

  /**
   * @brief Retrieves the value internal.
   *
   * @return The value internal.
   */
  public int getValueInternal()
  {
    return _valueInternal;
  }

  /**
   * @brief Retrieves the WQC.
   *
   * @return The WQC.
   */
  public shared_ptr<MTP_Wqc> getWqc()
  {
    return _wqc;
  }

  /**
   * @brief Retrieves the source.
   *
   * @return The source.
   */
  public shared_ptr<MTP_Source> getSource()
  {
    return _source;
  }

  /**
   * @brief Sets the value internal from the connected data point element.
   *
   * @param dpe The data point element.
   * @param valueInternal The new value internal value.
   */
  private void setValueInternalCB(const string &dpe, const int &valueInternal)
  {
    _valueInternal = valueInternal;
    valueInternalChanged(_valueInternal);
  }
};
