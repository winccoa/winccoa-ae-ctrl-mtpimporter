#uses "std"

// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

class MtpMonitor
{
  private bool _enabled;
  private bool _safePosition;
  private bool _staticError;
  private bool _dynamicError;
  private float _staticTime;
  private float _dynamicTime;
  private string _dpeEnabled;

  public MtpMonitor(const string &dpeEnabled, const string &dpeSafePosition, const string &dpeStaticError, const string &dpeDynamicError, const string &dpeStaticTime, const string &dpeDynamicTime)
  {
    if(!dpExists(dpeEnabled))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeEnabled));
    }

    if(!dpExists(dpeSafePosition))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeSafePosition));
    }

    if(!dpExists(dpeStaticError))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeStaticError));
    }

    if(!dpExists(dpeDynamicError))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeDynamicError));
    }

    if(!dpExists(dpeStaticTime))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeStaticTime));
    }

    if(!dpExists(dpeDynamicTime))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, dpeDynamicTime));
    }

    _dpeEnabled = dpeEnabled;

    dpGet(_dpeEnabled, _enabled);

    dpConnect(this, setStaticErrorCB, dpeStaticError);
    dpConnect(this, setDynamicErrorCB, dpeDynamicError);
    dpConnect(this, setSafePositionCB, dpeSafePosition);
    dpConnect(this, setStaticTimeCB, dpeStaticTime);
    dpConnect(this, setDynamicTimeCB, dpeDynamicTime);
  }

  #event staticErrorChanged(const bool &staticError)
  #event dynamicErrorChanged(const bool &dynamicError)
  #event safePositionChanged(const bool &safePosition)
  #event staticTimeChanged(const float &staticTime)
  #event dynamicTimeChanged(const float &dynamicTime)

  public bool getEnabled()
  {
    return _enabled;
  }

  public bool getSafePosition()
  {
    return _safePosition;
  }

  public bool getStaticError()
  {
    return _staticError;
  }

  public bool getDynamicError()
  {
    return _dynamicError;
  }

  public float getStaticTime()
  {
    return _staticTime;
  }

  public float getDynamicTime()
  {
    return _dynamicTime;
  }

  public void setEnabled(const bool &enabled)
  {
    _enabled = enabled;
    dpSet(_dpeEnabled, getEnabled());
  }

  private void setStaticErrorCB(const string &dpe, const bool &staticError)
  {
    _staticError = staticError;
    staticErrorChanged(getStaticError());
  }

  private void setDynamicErrorCB(const string &dpe, const bool &dynamicError)
  {
    _dynamicError = dynamicError;
    dynamicErrorChanged(getDynamicError());
  }

  private void setSafePositionCB(const string &dpe, const bool &safePosition)
  {
    _safePosition = safePosition;
    safePositionChanged(getSafePosition());
  }

  private void setStaticTimeCB(const string &dpe, const float &staticTime)
  {
    _staticTime = staticTime;
    staticTimeChanged(getStaticTime());
  }

  private void setDynamicTimeCB(const string &dpe, const float &dynamicTime)
  {
    _dynamicTime = dynamicTime;
    dynamicTimeChanged(getDynamicTime());
  }
};
