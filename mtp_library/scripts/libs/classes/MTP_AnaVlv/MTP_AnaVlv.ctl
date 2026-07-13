// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Unit/MTP_Unit"
#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_ActiveElement/MTP_ActiveElement"

/**
 * @class MTP_AnaVlv
 * @brief Represents the MTP_AnaVlv class.
 */
class MTP_AnaVlv : MTP_ActiveElement
{
  private bool _safetyPosition; //!< Indicates if the safety position is active.
  private bool _safetyPositionEnabled; //!< Indicates if the safety position is enabled.
  private bool _safetyPositionActive; //!< Indicates if the safety position is active.
  private bool _openAutomatic; //!< Indicates if the open automatic is active.
  private bool _closeAutomatic; //!< Indicates if the close automatic is active.
  private bool _openOperator; //!< Indicates if the open operator is active.
  private bool _closeOperator; //!< Indicates if the close operator is active.
  private bool _openActive; //!< Indicates if the open is active.
  private bool _closeActive; //!< Indicates if the close is active.
  private bool _openFeedbackCalculated; //!< Indicates if the open feedback calculated is active.
  private bool _openFeedback; //!< Indicates if the open feedback is active.
  private bool _closeFeedbackCalculated; //!< Indicates if the close feedback calculated is active.
  private bool _closeFeedback; //!< Indicates if the close feedback is active.
  private bool _positionFeedbackCalculated; //!< Indicates if the position feedback calculated is active.
  private bool _resetOperator; //!< Indicates if the reset operator is active.
  private bool _resetAutomatic; //!< Indicates if the reset automatic is active.

  private float _positionScaleMin; //!< The position scale min.
  private float _positionScaleMax; //!< The position scale max.
  private float _positionMin; //!< The position min.
  private float _positionMax; //!< The position max.
  private float _positionInternal; //!< The position internal.
  private float _positionManual; //!< The position manual.
  private float _positionReadback; //!< The position readback.
  private float _position; //!< The position.
  private float _positionFeedback; //!< The position feedback.

  private shared_ptr<MTP_State> _state; //!< The state instance.
  private shared_ptr<MTP_Source> _source; //!< The source instance.
  private shared_ptr<MTP_Security> _security; //!< The security instance.
  private shared_ptr<MTP_Unit> _positionUnit; //!< The position unit instance.

  /**
   * @brief Constructor for the MTP_AnaVlv object.
   *
   * @param dp The data point of the MTP_AnaVlv.
   */
  public MTP_AnaVlv(const string &dp) : MTP_ActiveElement(dp)
  {
    if (!dpExists(getDp() + ".SafePos"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePos"));
    }

    if (!dpExists(getDp() + ".SafePosEn"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePosEn"));
    }

    if (!dpExists(getDp() + ".SafePosAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".SafePosAct"));
    }

    if (!dpExists(getDp() + ".OpenAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenAut"));
    }

    if (!dpExists(getDp() + ".CloseAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseAut"));
    }

    if (!dpExists(getDp() + ".OpenOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenOp"));
    }

    if (!dpExists(getDp() + ".CloseOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseOp"));
    }

    if (!dpExists(getDp() + ".OpenAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenAct"));
    }

    if (!dpExists(getDp() + ".CloseAct"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseAct"));
    }

    if (!dpExists(getDp() + ".PosSclMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosSclMin"));
    }

    if (!dpExists(getDp() + ".PosSclMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosSclMax"));
    }

    if (!dpExists(getDp() + ".PosMin"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosMin"));
    }

    if (!dpExists(getDp() + ".PosMax"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosMax"));
    }

    if (!dpExists(getDp() + ".PosInt"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosInt"));
    }

    if (!dpExists(getDp() + ".PosMan"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosMan"));
    }

    if (!dpExists(getDp() + ".PosRbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosRbk"));
    }

    if (!dpExists(getDp() + ".Pos"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Pos"));
    }

    if (!dpExists(getDp() + ".OpenFbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenFbkCalc"));
    }

    if (!dpExists(getDp() + ".OpenFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".OpenFbk"));
    }

    if (!dpExists(getDp() + ".CloseFbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseFbkCalc"));
    }

    if (!dpExists(getDp() + ".CloseFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".CloseFbk"));
    }

    if (!dpExists(getDp() + ".PosFbkCalc"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosFbkCalc"));
    }

    if (!dpExists(getDp() + ".PosFbk"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".PosFbk"));
    }

    if (!dpExists(getDp() + ".ResetOp"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ResetOp"));
    }

    if (!dpExists(getDp() + ".ResetAut"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".ResetAut"));
    }

    dpGet(getDp() + ".OpenOp", _openOperator,
          getDp() + ".CloseOp", _closeOperator,
          getDp() + ".PosSclMin", _positionScaleMin,
          getDp() + ".PosSclMax", _positionScaleMax,
          getDp() + ".PosMin", _positionMin,
          getDp() + ".PosMax", _positionMax,
          getDp() + ".PosMan", _positionManual,
          getDp() + ".PosRbk", _positionReadback,
          getDp() + ".OpenFbkCalc", _openFeedbackCalculated,
          getDp() + ".CloseFbkCalc", _closeFeedbackCalculated,
          getDp() + ".PosFbkCalc", _positionFeedbackCalculated,
          getDp() + ".ResetOp", _resetOperator);

    dpConnect(this, setSafetyPositionCB, getDp() + ".SafePos");
    dpConnect(this, setSafetyPositionEnabledCB, getDp() + ".SafePosEn");
    dpConnect(this, setSafetyPositionActiveCB, getDp() + ".SafePosAct");
    dpConnect(this, setOpenAutomaticCB, getDp() + ".OpenAut");
    dpConnect(this, setCloseAutomaticCB, getDp() + ".CloseAut");
    dpConnect(this, setOpenActiveCB, getDp() + ".OpenAct");
    dpConnect(this, setCloseActiveCB, getDp() + ".CloseAct");
    dpConnect(this, setPositionScaleMinCB, getDp() + ".PosSclMin");
    dpConnect(this, setPositionScaleMaxCB, getDp() + ".PosSclMax");
    dpConnect(this, setPositionMinCB, getDp() + ".PosMin");
    dpConnect(this, setPositionMaxCB, getDp() + ".PosMax");
    dpConnect(this, setPositionInternalCB, getDp() + ".PosInt");
    dpConnect(this, setPositionManualCB, getDp() + ".PosMan");
    dpConnect(this, setPositionReadbackCB, getDp() + ".PosRbk");
    dpConnect(this, setPositionCB, getDp() + ".Pos");
    dpConnect(this, setOpenFeedbackCalculatedCB, getDp() + ".OpenFbkCalc");
    dpConnect(this, setOpenFeedbackCB, getDp() + ".OpenFbk");
    dpConnect(this, setCloseFeedbackCalculatedCB, getDp() + ".CloseFbkCalc");
    dpConnect(this, setCloseFeedbackCB, getDp() + ".CloseFbk");
    dpConnect(this, setPositionFeedbackCalculatedCB, getDp() + ".PosFbkCalc");
    dpConnect(this, setPositionFeedbackCB, getDp() + ".PosFbk");
    dpConnect(this, setResetAutomaticCB, getDp() + ".ResetAut");

    _state = new MTP_State(getDp() + ".StateChannel", getDp() + ".StateOffAut", getDp() + ".StateOpAut", getDp() + ".StateAutAut", getDp() + ".StateOffOp", getDp() + ".StateOpOp", getDp() + ".StateAutOp", getDp() + ".StateOpAct", getDp() + ".StateAutAct", getDp() + ".StateOffAct");
    _source = new MTP_Source(getDp() + ".SrcChannel", getDp() + ".SrcManAut", getDp() + ".SrcIntAut", getDp() + ".SrcManOp", getDp() + ".SrcIntOp", getDp() + ".SrcManAct", getDp() + ".SrcIntAct");
    _security = new MTP_Security(getDp() + ".PermEn", getDp() + ".Permit", getDp() + ".IntlEn", getDp() + ".Interlock", getDp() + ".ProtEn", getDp() + ".Protect");
    _positionUnit = new MTP_Unit(getDp() + ".PosUnit");
  }

  #event safetyPositionChanged(const bool &safetyPosition) //!< Event triggered when the safety position changes.
  #event safetyPositionEnabledChanged(const bool &safetyPositionEnabled) //!< Event triggered when the safety position enabled changes.
  #event safetyPositionActiveChanged(const bool &safetyPositionActive) //!< Event triggered when the safety position active changes.
  #event openAutomaticChanged(const bool &openAutomatic) //!< Event triggered when the open automatic changes.
  #event closeAutomaticChanged(const bool &closeAutomatic) //!< Event triggered when the close automatic changes.
  #event openActiveChanged(const bool &openActive) //!< Event triggered when the open active changes.
  #event closeActiveChanged(const bool &closeActive) //!< Event triggered when the close active changes.
  #event positionScaleMinChanged(const float &positionScaleMin) //!< Event triggered when the position scale min changes.
  #event positionScaleMaxChanged(const float &positionScaleMax) //!< Event triggered when the position scale max changes.
  #event positionMinChanged(const float &positionMin) //!< Event triggered when the position min changes.
  #event positionMaxChanged(const float &positionMax) //!< Event triggered when the position max changes.
  #event positionInternalChanged(const float &positionInternal) //!< Event triggered when the position internal changes.
  #event positionManualChanged(const float &positionManual) //!< Event triggered when the position manual changes.
  #event positionReadbackChanged(const float &positionReadback) //!< Event triggered when the position readback changes.
  #event positionChanged(const float &position) //!< Event triggered when the position changes.
  #event openFeedbackCalculatedChanged(const bool &openFeedbackCalculated) //!< Event triggered when the open feedback calculated changes.
  #event openFeedbackChanged(const bool &openFeedback) //!< Event triggered when the open feedback changes.
  #event closeFeedbackCalculatedChanged(const bool &closeFeedbackCalculated) //!< Event triggered when the close feedback calculated changes.
  #event closeFeedbackChanged(const bool &closeFeedback) //!< Event triggered when the close feedback changes.
  #event positionFeedbackCalculatedChanged(const bool &positionFeedbackCalculated) //!< Event triggered when the position feedback calculated changes.
  #event positionFeedbackChanged(const float &positionFeedback) //!< Event triggered when the position feedback changes.
  #event resetAutomaticChanged(const bool &resetAutomatic) //!< Event triggered when the reset automatic changes.

  /**
   * @brief Retrieves the safety position.
   *
   * @return The safety position.
   */
  public bool getSafetyPosition()
  {
    return _safetyPosition;
  }

  /**
   * @brief Retrieves the safety position enabled.
   *
   * @return The safety position enabled.
   */
  public bool getSafetyPositionEnabled()
  {
    return _safetyPositionEnabled;
  }

  /**
   * @brief Retrieves the safety position active.
   *
   * @return The safety position active.
   */
  public bool getSafetyPositionActive()
  {
    return _safetyPositionActive;
  }

  /**
   * @brief Retrieves the open automatic.
   *
   * @return The open automatic.
   */
  public bool getOpenAutomatic()
  {
    return _openAutomatic;
  }

  /**
   * @brief Retrieves the close automatic.
   *
   * @return The close automatic.
   */
  public bool getCloseAutomatic()
  {
    return _closeAutomatic;
  }

  /**
   * @brief Retrieves the open operator.
   *
   * @return The open operator.
   */
  public bool getOpenOperator()
  {
    return _openOperator;
  }

  /**
   * @brief Retrieves the close operator.
   *
   * @return The close operator.
   */
  public bool getCloseOperator()
  {
    return _closeOperator;
  }

  /**
   * @brief Retrieves the open active.
   *
   * @return The open active.
   */
  public bool getOpenActive()
  {
    return _openActive;
  }

  /**
   * @brief Retrieves the close active.
   *
   * @return The close active.
   */
  public bool getCloseActive()
  {
    return _closeActive;
  }

  /**
   * @brief Retrieves the position scale min.
   *
   * @return The position scale min.
   */
  public float getPositionScaleMin()
  {
    return _positionScaleMin;
  }

  /**
   * @brief Retrieves the position scale max.
   *
   * @return The position scale max.
   */
  public float getPositionScaleMax()
  {
    return _positionScaleMax;
  }

  /**
   * @brief Retrieves the position min.
   *
   * @return The position min.
   */
  public float getPositionMin()
  {
    return _positionMin;
  }

  /**
   * @brief Retrieves the position max.
   *
   * @return The position max.
   */
  public float getPositionMax()
  {
    return _positionMax;
  }

  /**
   * @brief Retrieves the position internal.
   *
   * @return The position internal.
   */
  public float getPositionInternal()
  {
    return _positionInternal;
  }

  /**
   * @brief Retrieves the position manual.
   *
   * @return The position manual.
   */
  public float getPositionManual()
  {
    return _positionManual;
  }

  /**
   * @brief Retrieves the position readback.
   *
   * @return The position readback.
   */
  public float getPositionReadback()
  {
    return _positionReadback;
  }

  /**
   * @brief Retrieves the position.
   *
   * @return The position.
   */
  public float getPosition()
  {
    return _position;
  }

  /**
   * @brief Retrieves the open feedback calculated.
   *
   * @return The open feedback calculated.
   */
  public bool getOpenFeedbackCalculated()
  {
    return _openFeedbackCalculated;
  }

  /**
   * @brief Retrieves the open feedback.
   *
   * @return The open feedback.
   */
  public bool getOpenFeedback()
  {
    return _openFeedback;
  }

  /**
   * @brief Retrieves the close feedback calculated.
   *
   * @return The close feedback calculated.
   */
  public bool getCloseFeedbackCalculated()
  {
    return _closeFeedbackCalculated;
  }

  /**
   * @brief Retrieves the close feedback.
   *
   * @return The close feedback.
   */
  public bool getCloseFeedback()
  {
    return _closeFeedback;
  }

  /**
   * @brief Retrieves the position feedback calculated.
   *
   * @return The position feedback calculated.
   */
  public bool getPositionFeedbackCalculated()
  {
    return _positionFeedbackCalculated;
  }

  /**
   * @brief Retrieves the position feedback.
   *
   * @return The position feedback.
   */
  public float getPositionFeedback()
  {
    return _positionFeedback;
  }

  /**
   * @brief Retrieves the reset operator.
   *
   * @return The reset operator.
   */
  public bool getResetOperator()
  {
    return _resetOperator;
  }

  /**
   * @brief Retrieves the reset automatic.
   *
   * @return The reset automatic.
   */
  public bool getResetAutomatic()
  {
    return _resetAutomatic;
  }

  /**
   * @brief Retrieves the state.
   *
   * @return The state.
   */
  public shared_ptr<MTP_State> getState()
  {
    return _state;
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
   * @brief Retrieves the security.
   *
   * @return The security.
   */
  public shared_ptr<MTP_Security> getSecurity()
  {
    return _security;
  }

  /**
   * @brief Retrieves the position unit.
   *
   * @return The position unit.
   */
  public shared_ptr<MTP_Unit> getPositionUnit()
  {
    return _positionUnit;
  }

  /**
   * @brief Sets the open operator.
   *
   * @param openOperator The new open operator value.
   */
  public void setOpenOperator(const bool &openOperator)
  {
    _openOperator = openOperator;
    dpSet(getDp() + ".OpenOp", _openOperator);
  }

  /**
   * @brief Sets the close operator.
   *
   * @param closeOperator The new close operator value.
   */
  public void setCloseOperator(const bool &closeOperator)
  {
    _closeOperator = closeOperator;
    dpSet(getDp() + ".CloseOp", _closeOperator);
  }

  /**
   * @brief Sets the position manual.
   *
   * @param positionManual The new position manual value.
   */
  public void setPositionManual(const float &positionManual)
  {
    _positionManual = positionManual;
    dpSet(getDp() + ".PosMan", _positionManual);
  }

  /**
   * @brief Sets the reset operator.
   *
   * @param resetOperator The new reset operator value.
   */
  public void setResetOperator(const bool &resetOperator)
  {
    _resetOperator = resetOperator;
    dpSet(getDp() + ".ResetOp", _resetOperator);
  }

  /**
   * @brief Sets the safety position from the connected data point element.
   *
   * @param dpe The data point element.
   * @param safetyPosition The new safety position value.
   */
  private void setSafetyPositionCB(const string &dpe, const bool &safetyPosition)
  {
    _safetyPosition = safetyPosition;
    safetyPositionChanged(_safetyPosition);
  }

  /**
   * @brief Sets the safety position enabled from the connected data point element.
   *
   * @param dpe The data point element.
   * @param safetyPositionEnabled The new safety position enabled value.
   */
  private void setSafetyPositionEnabledCB(const string &dpe, const bool &safetyPositionEnabled)
  {
    _safetyPositionEnabled = safetyPositionEnabled;
    safetyPositionEnabledChanged(_safetyPositionEnabled);
  }

  /**
   * @brief Sets the safety position active from the connected data point element.
   *
   * @param dpe The data point element.
   * @param safetyPositionActive The new safety position active value.
   */
  private void setSafetyPositionActiveCB(const string &dpe, const bool &safetyPositionActive)
  {
    _safetyPositionActive = safetyPositionActive;
    safetyPositionActiveChanged(_safetyPositionActive);
  }

  /**
   * @brief Sets the open automatic from the connected data point element.
   *
   * @param dpe The data point element.
   * @param openAutomatic The new open automatic value.
   */
  private void setOpenAutomaticCB(const string &dpe, const bool &openAutomatic)
  {
    _openAutomatic = openAutomatic;
    openAutomaticChanged(_openAutomatic);
  }

  /**
   * @brief Sets the close automatic from the connected data point element.
   *
   * @param dpe The data point element.
   * @param closeAutomatic The new close automatic value.
   */
  private void setCloseAutomaticCB(const string &dpe, const bool &closeAutomatic)
  {
    _closeAutomatic = closeAutomatic;
    closeAutomaticChanged(_closeAutomatic);
  }

  /**
   * @brief Sets the open active from the connected data point element.
   *
   * @param dpe The data point element.
   * @param openActive The new open active value.
   */
  private void setOpenActiveCB(const string &dpe, const bool &openActive)
  {
    _openActive = openActive;
    openActiveChanged(_openActive);
  }

  /**
   * @brief Sets the close active from the connected data point element.
   *
   * @param dpe The data point element.
   * @param closeActive The new close active value.
   */
  private void setCloseActiveCB(const string &dpe, const bool &closeActive)
  {
    _closeActive = closeActive;
    closeActiveChanged(_closeActive);
  }

  /**
   * @brief Sets the position scale min from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionScaleMin The new position scale min value.
   */
  private void setPositionScaleMinCB(const string &dpe, const float &positionScaleMin)
  {
    _positionScaleMin = positionScaleMin;
    positionScaleMinChanged(_positionScaleMin);
  }

  /**
   * @brief Sets the position scale max from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionScaleMax The new position scale max value.
   */
  private void setPositionScaleMaxCB(const string &dpe, const float &positionScaleMax)
  {
    _positionScaleMax = positionScaleMax;
    positionScaleMaxChanged(_positionScaleMax);
  }

  /**
   * @brief Sets the position min from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionMin The new position min value.
   */
  private void setPositionMinCB(const string &dpe, const float &positionMin)
  {
    _positionMin = positionMin;
    positionMinChanged(_positionMin);
  }

  /**
   * @brief Sets the position max from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionMax The new position max value.
   */
  private void setPositionMaxCB(const string &dpe, const float &positionMax)
  {
    _positionMax = positionMax;
    positionMaxChanged(_positionMax);
  }

  /**
   * @brief Sets the position internal from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionInternal The new position internal value.
   */
  private void setPositionInternalCB(const string &dpe, const float &positionInternal)
  {
    _positionInternal = positionInternal;
    positionInternalChanged(_positionInternal);
  }

  /**
   * @brief Sets the position manual from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionManual The new position manual value.
   */
  private void setPositionManualCB(const string &dpe, const float &positionManual)
  {
    _positionManual = positionManual;
    positionManualChanged(_positionManual);
  }

  /**
   * @brief Sets the position readback from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionReadback The new position readback value.
   */
  private void setPositionReadbackCB(const string &dpe, const float &positionReadback)
  {
    _positionReadback = positionReadback;
    positionReadbackChanged(_positionReadback);
  }

  /**
   * @brief Sets the position from the connected data point element.
   *
   * @param dpe The data point element.
   * @param position The new position value.
   */
  private void setPositionCB(const string &dpe, const float &position)
  {
    _position = position;
    positionChanged(_position);
  }

  /**
   * @brief Sets the open feedback calculated from the connected data point element.
   *
   * @param dpe The data point element.
   * @param openFeedbackCalculated The new open feedback calculated value.
   */
  private void setOpenFeedbackCalculatedCB(const string &dpe, const bool &openFeedbackCalculated)
  {
    _openFeedbackCalculated = openFeedbackCalculated;
    openFeedbackCalculatedChanged(_openFeedbackCalculated);
  }

  /**
   * @brief Sets the open feedback from the connected data point element.
   *
   * @param dpe The data point element.
   * @param openFeedback The new open feedback value.
   */
  private void setOpenFeedbackCB(const string &dpe, const bool &openFeedback)
  {
    _openFeedback = openFeedback;
    openFeedbackChanged(_openFeedback);
  }

  /**
   * @brief Sets the close feedback calculated from the connected data point element.
   *
   * @param dpe The data point element.
   * @param closeFeedbackCalculated The new close feedback calculated value.
   */
  private void setCloseFeedbackCalculatedCB(const string &dpe, const bool &closeFeedbackCalculated)
  {
    _closeFeedbackCalculated = closeFeedbackCalculated;
    closeFeedbackCalculatedChanged(_closeFeedbackCalculated);
  }

  /**
   * @brief Sets the close feedback from the connected data point element.
   *
   * @param dpe The data point element.
   * @param closeFeedback The new close feedback value.
   */
  private void setCloseFeedbackCB(const string &dpe, const bool &closeFeedback)
  {
    _closeFeedback = closeFeedback;
    closeFeedbackChanged(_closeFeedback);
  }

  /**
   * @brief Sets the position feedback calculated from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionFeedbackCalculated The new position feedback calculated value.
   */
  private void setPositionFeedbackCalculatedCB(const string &dpe, const bool &positionFeedbackCalculated)
  {
    _positionFeedbackCalculated = positionFeedbackCalculated;
    positionFeedbackCalculatedChanged(_positionFeedbackCalculated);
  }

  /**
   * @brief Sets the position feedback from the connected data point element.
   *
   * @param dpe The data point element.
   * @param positionFeedback The new position feedback value.
   */
  private void setPositionFeedbackCB(const string &dpe, const float &positionFeedback)
  {
    _positionFeedback = positionFeedback;
    positionFeedbackChanged(_positionFeedback);
  }

  /**
   * @brief Sets the reset automatic from the connected data point element.
   *
   * @param dpe The data point element.
   * @param resetAutomatic The new reset automatic value.
   */
  private void setResetAutomaticCB(const string &dpe, const bool &resetAutomatic)
  {
    _resetAutomatic = resetAutomatic;
    resetAutomaticChanged(_resetAutomatic);
  }
};
