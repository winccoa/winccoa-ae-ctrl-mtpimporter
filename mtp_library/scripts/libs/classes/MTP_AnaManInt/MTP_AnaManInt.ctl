// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_AnaMan/MTP_AnaMan"
#uses "classes/MTP_Unit/MTP_Unit"
#uses "std"
#uses "classes/MTP_Wqc/MTP_Wqc"
#uses "classes/MTP_OsLevel/MTP_OsLevel"
#uses "classes/MTP_Source/MTP_Source"

/**
 * @class MTP_AnaManInt
 * @brief Represents the MTP_AnaManInt class.
 */
class MTP_AnaManInt : MTP_AnaMan
{
  private float _valueInternal; //!< The internally set value for the monitored analog drive.
  private shared_ptr<MTP_Wqc> _wqc; //!< The quality code associated with the monitored analog drive.
  private shared_ptr<MTP_Source> _source; //!< The source of the monitored analog drive (e.g., manual or internal).

  /**
   * @brief Constructor for the MTP_AnaManInt object.
   *
   * @param dp The data point of the MTP_AnaManInt.
   */
  public MTP_AnaManInt(const string &dp) : MTP_AnaMan(dp)
  {
    if (!dpExists(getDp() + ".VInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".VInt"));
    }

    dpConnect(this, setValueInternalCB, getDp() + ".VInt");

    _wqc = new MTP_Wqc(getDp() + ".WQC");
    _source =  new MTP_Source(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
  }

  #event valueInternalChanged(const float &valueInternal) //!< Event triggered when the internally set value changes.

  /**
  * @brief Retrieves the internal value.
  *
  * @return The internal value as a float.
  */
  public float getValueInternal()
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
   * @return The shared pointer to the MTP_Source instance.
   */
  public shared_ptr<MTP_Source> getSource()
  {
    return _source;
  }

  /**
   * @brief Sets the internal value of the monitored variable.
   *
   * @param dpe The data point element.
   * @param valueInternal The new internal value to set.
   */
  private void setValueInternalCB(const string &dpe, const float &valueInternal)
  {
    _valueInternal = valueInternal;
    valueInternalChanged(_valueInternal);
  }
};
