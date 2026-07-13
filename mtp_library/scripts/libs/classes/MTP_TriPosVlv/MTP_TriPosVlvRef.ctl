// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_State/MTP_State"
#uses "classes/MTP_Security/MTP_Security"
#uses "classes/MTP_TriPosVlv/MTP_TriPosVlv"
#uses "classes/MTP_View/MTP_ViewRef"

/**
 * @class MTP_TriPosVlvRef
 * @brief Represents the MTP_TriPosVlvRef class.
 */
class MTP_TriPosVlvRef : MTP_ViewRef
{
  protected shape _rectLocked;
  protected shape _rectMode;
  protected shape _rectValve0;
  protected shape _rectValve1;
  protected shape _rectValve2;

  protected bool _permit;
  protected bool _interlock;
  protected bool _protection;

  protected bool _stateOffActive;
  protected bool _stateOperatorActive;

  protected int _pos1Configuration;
  protected int _pos2Configuration;
  protected int _pos3Configuration;

  protected bool _pos1FeedbackSignal;
  protected bool _pos2FeedbackSignal;
  protected bool _pos3FeedbackSignal;
  protected bool _pos1Control;
  protected bool _pos2Control;
  protected bool _pos3Control;

  /**
   * @brief Constructor for the MTP_TriPosVlvRef object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_TriPosVlvRef object.
   */
  public MTP_TriPosVlvRef(shared_ptr<MTP_TriPosVlv> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnectUserData(this, setLockedCB, "_permit", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::permitChanged);
    classConnectUserData(this, setLockedCB, "_interlock", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::interlockChanged);
    classConnectUserData(this, setLockedCB, "_protection", MTP_ViewRef::getViewModel().getSecurity(), MTP_Security::protectionChanged);

    classConnectUserData(this, setModeCB, "_stateOffActive", MTP_ViewRef::getViewModel().getState(), MTP_State::offActiveChanged);
    classConnectUserData(this, setModeCB, "_stateOperatorActive", MTP_ViewRef::getViewModel().getState(), MTP_State::operatorActiveChanged);

    classConnectUserData(this, setConfigurationCB, "_pos1Configuration", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos1ConfigurationChanged);
    classConnectUserData(this, setConfigurationCB, "_pos2Configuration", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos2ConfigurationChanged);
    classConnectUserData(this, setConfigurationCB, "_pos3Configuration", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos3ConfigurationChanged);

    classConnectUserData(this, setValveCB, "_pos1FeedbackSignal", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos1FeedbackSignalChanged);
    classConnectUserData(this, setValveCB, "_pos2FeedbackSignal", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos2FeedbackSignalChanged);
    classConnectUserData(this, setValveCB, "_pos3FeedbackSignal", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos3FeedbackSignalChanged);
    classConnectUserData(this, setValveCB, "_pos1Control", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos1ControlChanged);
    classConnectUserData(this, setValveCB, "_pos2Control", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos2ControlChanged);
    classConnectUserData(this, setValveCB, "_pos3Control", MTP_ViewRef::getViewModel(), MTP_TriPosVlv::pos3ControlChanged);

    _permit = MTP_ViewRef::getViewModel().getSecurity().getPermit();
    _interlock = MTP_ViewRef::getViewModel().getSecurity().getInterlock();
    _protection = MTP_ViewRef::getViewModel().getSecurity().getProtection();

    _stateOffActive = MTP_ViewRef::getViewModel().getState().getOffActive();
    _stateOperatorActive = MTP_ViewRef::getViewModel().getState().getOperatorActive();

    _pos1Configuration = MTP_ViewRef::getViewModel().getPos1Configuration();
    _pos2Configuration = MTP_ViewRef::getViewModel().getPos2Configuration();
    _pos3Configuration = MTP_ViewRef::getViewModel().getPos3Configuration();

    _pos1FeedbackSignal = MTP_ViewRef::getViewModel().getPos1FeedbackSignal();
    _pos2FeedbackSignal = MTP_ViewRef::getViewModel().getPos2FeedbackSignal();
    _pos3FeedbackSignal = MTP_ViewRef::getViewModel().getPos3FeedbackSignal();
    _pos1Control = MTP_ViewRef::getViewModel().getPos1Control();
    _pos2Control = MTP_ViewRef::getViewModel().getPos2Control();
    _pos3Control = MTP_ViewRef::getViewModel().getPos3Control();

    setLockedCB("_permit", _permit);
    setModeCB("_stateOffActive", _stateOffActive);
    updateValveSymbol();
  }

  protected void initializeShapes() override
  {
    _rectLocked = MTP_ViewRef::extractShape("_rectLocked");
    _rectMode = MTP_ViewRef::extractShape("_rectMode");
    _rectValve0 = MTP_ViewRef::extractShape("_rectValve0");
    _rectValve1 = MTP_ViewRef::extractShape("_rectValve1");
    _rectValve2 = MTP_ViewRef::extractShape("_rectValve2");
  }

  /**
   * @brief Sets the locked from the connected data point element.
   *
   * @param varName The new var name value.
   * @param locked The new locked value.
   */
  protected void setLockedCB(const string &varName, const bool &locked)
  {
    switch (varName)
    {
      case "_permit":
        _permit = locked;
        break;

      case "_interlock":
        _interlock = locked;
        break;

      case "_protection":
        _protection = locked;
        break;
    }

    if (_rectLocked.enabled())
    {
      if (!_permit || !_interlock || !_protection)
      {
        _rectLocked.fill = "[pattern,[fit,any,MTP_Icones/locked_.svg]]";
        _rectLocked.visible = TRUE;
        return;
      }
      else
      {
        _rectLocked.visible = FALSE;
      }
    }
  }

  /**
   * @brief Sets the mode from the connected data point element.
   *
   * @param varName The new var name value.
   * @param mode The new mode value.
   */
  protected void setModeCB(const string &varName, const bool &mode)
  {
    switch (varName)
    {
      case "_stateOffActive":
        _stateOffActive = mode;
        break;

      case "_stateOperatorActive":
        _stateOperatorActive = mode;
        break;
    }

    if (_rectMode.enabled())
    {
      if (_stateOffActive)
      {
        _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Power.svg]]";
        _rectMode.visible = TRUE;
        return;
      }
      else if (_stateOperatorActive)
      {
        _rectMode.fill = "[pattern,[fit,any,MTP_Icones/Manual_1.svg]]";
        _rectMode.visible = TRUE;
      }
      else
      {
        _rectMode.visible = FALSE;
      }
    }
  }

  /**
   * @brief Sets the configuration from the connected data point element.
   *
   * @param varName The new var name value.
   * @param configuration The new configuration value.
   */
  protected void setConfigurationCB(const string &varName, const int &configuration)
  {
    switch (varName)
    {
      case "_pos1Configuration":
        _pos1Configuration = configuration;
        break;

      case "_pos2Configuration":
        _pos2Configuration = configuration;
        break;

      case "_pos3Configuration":
        _pos3Configuration = configuration;
        break;
    }

    updateValveSymbol();
  }

  /**
   * @brief Sets the valve from the connected data point element.
   *
   * @param varName The new var name value.
   * @param valve The new valve value.
   */
  protected void setValveCB(const string &varName, const bool &valve)
  {
    switch (varName)
    {
      case "_pos1FeedbackSignal":
        _pos1FeedbackSignal = valve;
        break;

      case "_pos2FeedbackSignal":
        _pos2FeedbackSignal = valve;
        break;

      case "_pos3FeedbackSignal":
        _pos3FeedbackSignal = valve;
        break;

      case "_pos1Control":
        _pos1Control = valve;
        break;

      case "_pos2Control":
        _pos2Control = valve;
        break;

      case "_pos3Control":
        _pos3Control = valve;
        break;
    }

    updateValveSymbol();
  }

  /**
   * @brief Executes the is valid configuration operation.
   *
   * @param configuration The configuration.
   *
   * @return The result of the is valid configuration operation.
   */
  private bool isValidConfiguration(const int &configuration)
  {
    return configuration >= 0 && configuration <= 7;
  }

  /**
   * @brief Retrieves the position configuration.
   *
   * @param position The position.
   *
   * @return The position configuration.
   */
  private int getPositionConfiguration(const int &position)
  {
    switch (position)
    {
      case 1:
        return _pos1Configuration;

      case 2:
        return _pos2Configuration;

      case 3:
        return _pos3Configuration;
    }

    return 0;
  }

  /**
   * @brief Executes the is valve segment open operation.
   *
   * @param configuration The configuration.
   * @param segment The segment.
   *
   * @return The result of the is valve segment open operation.
   */
  private bool isValveSegmentOpen(const int &configuration, const int &segment)
  {
    switch (segment)
    {
      case 0:
        return configuration >= 4;

      case 1:
        return configuration == 2 || configuration == 3 || configuration == 6 || configuration == 7;

      case 2:
        return configuration == 1 || configuration == 3 || configuration == 5 || configuration == 7;
    }

    return FALSE;
  }

  /**
   * @brief Updates the valve symbol.
   */
  private void updateValveSymbol()
  {
    int feedbackCount = (_pos1FeedbackSignal ? 1 : 0) + (_pos2FeedbackSignal ? 1 : 0) + (_pos3FeedbackSignal ? 1 : 0);
    int controlCount = (_pos1Control ? 1 : 0) + (_pos2Control ? 1 : 0) + (_pos3Control ? 1 : 0);

    if (feedbackCount > 1 || controlCount > 1)
    {
      setUnknownValveSymbol();
      return;
    }

    int activePosition = getActiveFeedbackPosition();
    int targetPosition = getActiveControlPosition();

    if (activePosition > 0 && targetPosition > 0 && activePosition != targetPosition)
    {
      renderValveTransition(getPositionConfiguration(activePosition), getPositionConfiguration(targetPosition));
      return;
    }

    if (activePosition > 0)
    {
      renderValveConfiguration(getPositionConfiguration(activePosition), "opened");
      return;
    }

    if (targetPosition > 0)
    {
      renderValveConfiguration(getPositionConfiguration(targetPosition), "opening");
      return;
    }

    renderValveConfiguration(0, "opened");
  }

  /**
   * @brief Retrieves the active feedback position.
   *
   * @return The active feedback position.
   */
  private int getActiveFeedbackPosition()
  {
    if (_pos1FeedbackSignal)
    {
      return 1;
    }

    if (_pos2FeedbackSignal)
    {
      return 2;
    }

    if (_pos3FeedbackSignal)
    {
      return 3;
    }

    return 0;
  }

  /**
   * @brief Retrieves the active control position.
   *
   * @return The active control position.
   */
  private int getActiveControlPosition()
  {
    if (_pos1Control)
    {
      return 1;
    }

    if (_pos2Control)
    {
      return 2;
    }

    if (_pos3Control)
    {
      return 3;
    }

    return 0;
  }

  /**
   * @brief Executes the render valve configuration operation.
   *
   * @param configuration The configuration.
   * @param openState The open state.
   */
  private void renderValveConfiguration(const int &configuration, const string &openState)
  {
    if (!isValidConfiguration(configuration))
    {
      setUnknownValveSymbol();
      return;
    }

    setValveSegment(0, isValveSegmentOpen(configuration, 0) ? openState : "closed");
    setValveSegment(1, isValveSegmentOpen(configuration, 1) ? openState : "closed");
    setValveSegment(2, isValveSegmentOpen(configuration, 2) ? openState : "closed");
  }

  /**
   * @brief Executes the render valve transition operation.
   *
   * @param activeConfiguration The active configuration.
   * @param targetConfiguration The target configuration.
   */
  private void renderValveTransition(const int &activeConfiguration, const int &targetConfiguration)
  {
    if (!isValidConfiguration(activeConfiguration) || !isValidConfiguration(targetConfiguration))
    {
      setUnknownValveSymbol();
      return;
    }

    for (int segment = 0; segment <= 2; segment++)
    {
      bool activeOpen = isValveSegmentOpen(activeConfiguration, segment);
      bool targetOpen = isValveSegmentOpen(targetConfiguration, segment);

      if (activeOpen && targetOpen)
      {
        setValveSegment(segment, "opened");
      }
      else if (activeOpen && !targetOpen)
      {
        setValveSegment(segment, "closing");
      }
      else if (!activeOpen && targetOpen)
      {
        setValveSegment(segment, "opening");
      }
      else
      {
        setValveSegment(segment, "closed");
      }
    }
  }

  /**
   * @brief Sets the unknown valve symbol.
   */
  private void setUnknownValveSymbol()
  {
    setValveSegment(0, "unknown");
    setValveSegment(1, "unknown");
    setValveSegment(2, "unknown");
  }

  /**
   * @brief Sets the valve segment.
   *
   * @param segment The new segment value.
   * @param state The new state value.
   */
  private void setValveSegment(const int &segment, const string &state)
  {
    switch (segment)
    {
      case 0:
        if (_rectValve0.enabled())
        {
          _rectValve0.fill = "[pattern,[fit,any,MTP_Icones/" + state + "-valve0.svg]]";
          _rectValve0.visible = TRUE;
        }
        break;

      case 1:
        if (_rectValve1.enabled())
        {
          _rectValve1.fill = "[pattern,[fit,any,MTP_Icones/" + state + "-valve1.svg]]";
          _rectValve1.visible = TRUE;
        }
        break;

      case 2:
        if (_rectValve2.enabled())
        {
          _rectValve2.fill = "[pattern,[fit,any,MTP_Icones/" + state + "-valve2.svg]]";
          _rectValve2.visible = TRUE;
        }
        break;
    }
  }
};
