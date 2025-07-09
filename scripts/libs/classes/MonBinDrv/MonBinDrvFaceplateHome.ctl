// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpMonitor/MtpMonitor"
#uses "classes/MonBinDrv/MonBinDrv"
#uses "classes/MtpView/MtpViewBase"

class MonBinDrvFaceplateHome : MtpViewBase
{
  private shape _refWqc;
  private shape _rectAutomatic;
  private shape _rectError;
  private shape _rectErrorInformation;
  private shape _rectForward;
  private shape _rectLock;
  private shape _rectMotor;
  private shape _rectMotorProtection;
  private shape _rectOff;
  private shape _rectOperator;
  private shape _rectPermission;
  private shape _rectProtection;
  private shape _rectReset;
  private shape _rectReverse;
  private shape _rectSafetyPosition;
  private shape _rectSafetyPositionInformation;
  private shape _rectStop;
  private shape _txtError;
  private shape _txtLock;
  private shape _txtMotorProtection;
  private shape _txtPermission;
  private shape _txtProtection;
  private shape _txtSafetyPosition;

  private bool _forwardFeedbackSignal;
  private bool _reverseFeedbackSignal;
  private bool _forwardControl;
  private bool _reverseControl;
  private bool _staticError;
  private bool _dynamicError;

  public MonBinDrvFaceplateHome(shared_ptr<MonBinDrv> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setMotorCB, "_forwardFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::forwardFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_reverseFeedbackSignal", MtpViewBase::getViewModel(), MonBinDrv::reverseFeedbackSignalChanged);
    classConnectUserData(this, setMotorCB, "_forwardControl", MtpViewBase::getViewModel(), MonBinDrv::forwardControlChanged);
    classConnectUserData(this, setMotorCB, "_reverseControl", MtpViewBase::getViewModel(), MonBinDrv::reverseControlChanged);
    classConnectUserData(this, setMotorCB, "_staticError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::staticErrorChanged);
    classConnectUserData(this, setMotorCB, "_dynamicError", MtpViewBase::getViewModel().getMonitor(), MtpMonitor::dynamicErrorChanged);

    _staticError =  MtpViewBase::getViewModel().getMonitor().getStaticError();
    _dynamicError =  MtpViewBase::getViewModel().getMonitor().getDynamicError();
    _forwardFeedbackSignal =  MtpViewBase::getViewModel().getForwardFeedbackSignal();
    _reverseFeedbackSignal =  MtpViewBase::getViewModel().getReverseFeedbackSignal();
    _forwardControl =  MtpViewBase::getViewModel().getForwardControl();
    _reverseControl =  MtpViewBase::getViewModel().getReverseControl();

    setMotorCB("_forwardFeedbackSignal", _forwardFeedbackSignal);
  }

  protected void initializeShapes()
  {
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectAutomatic = MtpViewBase::extractShape("_rectAutomatic");
    _rectError = MtpViewBase::extractShape("_rectError");
    _rectErrorInformation = MtpViewBase::extractShape("_rectErrorInformation");
    _rectForward = MtpViewBase::extractShape("_rectForward");
    _rectLock = MtpViewBase::extractShape("_rectLock");
    _rectMotor = MtpViewBase::extractShape("_rectMotor");
    _rectMotorProtection = MtpViewBase::extractShape("_rectMotorProtection");
    _rectOff = MtpViewBase::extractShape("_rectOff");
    _rectOperator = MtpViewBase::extractShape("_rectOperator");
    _rectPermission = MtpViewBase::extractShape("_rectPermission");
    _rectProtection = MtpViewBase::extractShape("_rectProtection");
    _rectReset = MtpViewBase::extractShape("_rectReset");
    _rectReverse = MtpViewBase::extractShape("_rectReverse");
    _rectSafetyPosition = MtpViewBase::extractShape("_rectSafetyPosition");
    _rectSafetyPositionInformation = MtpViewBase::extractShape("_rectSafetyPositionInformation");
    _rectStop = MtpViewBase::extractShape("_rectStop");
    _txtError = MtpViewBase::extractShape("_txtError");
    _txtLock = MtpViewBase::extractShape("_txtLock");
    _txtMotorProtection = MtpViewBase::extractShape("_txtMotorProtection");
    _txtPermission = MtpViewBase::extractShape("_txtPermission");
    _txtProtection = MtpViewBase::extractShape("_txtProtection");
    _txtSafetyPosition = MtpViewBase::extractShape("_txtSafetyPosition");
  }

  private void setMotorCB(const string &varName, const bool &motor)
  {
    switch (varName)
    {
      case "_forwardFeedbackSignal":
        _forwardFeedbackSignal = motor;
        break;

      case "_reverseFeedbackSignal":
        _reverseFeedbackSignal = motor;
        break;

      case "_forwardControl":
        _forwardControl = motor;
        break;

      case "_reverseControl":
        _reverseControl = motor;
        break;

      case "_staticError":
        _staticError = motor;
        break;

      case "_dynamicError":
        _dynamicError = motor;
        break;
    }

    if (((_forwardFeedbackSignal && _forwardControl) || (_reverseFeedbackSignal && _reverseControl)) && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorRun.svg]]";
      _rectMotor.visible = TRUE;
      return;
    }
    else if (!_forwardFeedbackSignal && !_forwardControl && !_reverseFeedbackSignal && !_reverseControl && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorStopped.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if (((_forwardFeedbackSignal && !_reverseFeedbackSignal) || (!_forwardFeedbackSignal && _reverseFeedbackSignal)) && !_forwardControl && !_reverseControl && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorMfwdStopped.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if (((_forwardControl && !_reverseControl) || (!_forwardControl && _reverseControl)) && !_forwardFeedbackSignal && !_reverseFeedbackSignal && !_dynamicError && !_staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorMfwdStarted.svg]]";
      _rectMotor.visible = TRUE;
    }
    else if ((_forwardFeedbackSignal && _reverseFeedbackSignal) || _dynamicError || _staticError)
    {
      _rectMotor.fill = "[pattern,[tile,any,MTP_Icones/MotorUnknown.svg]]";
      _rectMotor.visible = TRUE;
    }
    else
    {
      _rectMotor.visible = FALSE;
    }
  }
};
