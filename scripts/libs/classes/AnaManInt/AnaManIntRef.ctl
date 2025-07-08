// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpSource/MtpSource"
#uses "classes/AnaManInt/AnaManInt"
#uses "classes/MtpView/MtpViewRef"

class AnaManIntRef : MtpViewRef
{
  private shape _rectLimit;
  private shape _rectSource;
  private shape _txtUnit;
  private shape _txtValue;

  private bool _sourceManualActive;
  private bool _sourceInternalActive;
  private bool _sourceChannel;

  private float _valueMin;
  private float _valueMax;

  public AnaManIntRef(shared_ptr<AnaManInt> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setValueOutCB, MtpViewRef::getViewModel(), AnaManInt::valueOutChanged);

    classConnectUserData(this, setSourceCB, "_sourceManualActive", MtpViewRef::getViewModel().getSource(), MtpSource::manualActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceInternalActive", MtpViewRef::getViewModel().getSource(), MtpSource::internalActiveChanged);
    classConnectUserData(this, setSourceCB, "_sourceChannel", MtpViewRef::getViewModel().getSource(), MtpSource::channelChanged);

    classConnectUserData(this, setValueMinMaxCB, "_valueMin", MtpViewRef::getViewModel(),  AnaManInt::valueMinChanged);
    classConnectUserData(this, setValueMinMaxCB, "_valueMax", MtpViewRef::getViewModel(),  AnaManInt::valueMaxChanged);

    _sourceManualActive = MtpViewRef::getViewModel().getSource().getManualActive();
    _sourceInternalActive = MtpViewRef::getViewModel().getSource().getInternalActive();
    _sourceChannel = MtpViewRef::getViewModel().getSource().getChannel();

    _valueMin = MtpViewRef::getViewModel().getValueMin();
    _valueMax = MtpViewRef::getViewModel().getValueMax();

    setUnit(MtpViewRef::getViewModel().getValueUnit());
    setValueOutCB(MtpViewRef::getViewModel().getValueOut());
    setSourceCB("_sourceManualActive", _sourceManualActive);
    setValueMinMaxCB("_valueMin", _valueMin);
  }

  /**
  * @brief Initializes the shapes used in the faceplate.
  * @details This method overrides the base class method to extract the shapes.
  */
  protected void initializeShapes() override
  {
    _rectLimit = MtpViewRef::extractShape("_rectLimit");
    _rectSource = MtpViewRef::extractShape("_rectSource");
    _txtUnit = MtpViewRef::extractShape("_txtUnit");
    _txtValue = MtpViewRef::extractShape("_txtValue");
  }

  private void setUnit(shared_ptr<MtpUnit> unit)
  {
    _txtUnit.text = unit.toString();
  }

  private void setValueOutCB(const float &valueOut)
  {
    _txtValue.text = valueOut;
  }

  private void setSourceCB(const string &varName, const bool &source)
  {
    switch (varName)
    {
      case "_sourceManualActive":
        _sourceManualActive = source;
        break;

      case "_sourceInternalActive":
        _sourceInternalActive = source;
        break;

      case "_sourceChannel":
        _sourceChannel = source;
        break;
    }

    if (_sourceManualActive && !_sourceChannel)
    {
      _rectSource.fill = "[pattern,[tile,any,MTP_Icones/Manual__2.svg]]";
      _rectSource.visible = TRUE;
      return;
    }
    else if (_sourceInternalActive && !_sourceChannel)
    {
      _rectSource.fill = "[pattern,[tile,any,MTP_Icones/internal.svg]]";
      _rectSource.visible = TRUE;
    }
    else
    {
      _rectSource.visible = FALSE;
    }
  }

  private void setValueMinMaxCB(const string &varName, const float &minMax)
  {
    switch (varName)
    {
      case "_valueMin":
        _valueMin = minMax;
        break;

      case "_valueMax":
        _valueMax = minMax;
        break;
    }

    if (_valueMin == 1 || _valueMax == 1)
    {
      _rectLimit.fill = "[pattern,[tile,any,MTP_Icones/Tolerance.svg]]";
      _rectLimit.visible = TRUE;
      return;
    }
    else
    {
      _rectLimit.visible = FALSE;
    }
  }
};
