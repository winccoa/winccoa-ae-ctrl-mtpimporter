// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewRef"
#uses "classes/MTP_BinManIntCfl/MTP_BinManIntCfl"
#uses "classes/MTP_Source/MTP_Source"
#uses "classes/MTP_BinManInt/MTP_BinManInt"

/**
 * @class MTP_BinManIntRef
 * @brief Represents the MTP_BinManIntRef class.
 */
class MTP_BinManIntRef : MTP_ViewRef
{
  protected shape _rectValue; //!< Reference to the value rectangle shape.
  protected shape _rectStatus; //!< Reference to the status rectangle shape.

  protected bool _manualActive; //!< Indicates if the manual source is active.
  protected bool _internalActive; //!< Indicates if the internal source is active.
  private bool _channel; //!< Indicates if the channel source is active.

  /**
   * @brief Constructor for MTP_BinManIntRef.
   *
   * @param viewModel A shared pointer to the BinManInt view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_BinManIntRef(shared_ptr<MTP_BinManInt> viewModel, const mapping &shapes) : MTP_ViewRef(viewModel, shapes)
  {
    classConnect(this, setValueCB, MTP_ViewRef::getViewModel(), MTP_BinManInt::valueOutChanged);
    classConnectUserData(this, setStatusCB, "_manualActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::manualActiveChanged);
    classConnectUserData(this, setStatusCB, "_internalActive", MTP_ViewRef::getViewModel().getSource(), MTP_Source::internalActiveChanged);
    classConnectUserData(this, setStatusCB, "_channel", MTP_ViewRef::getViewModel().getSource(), MTP_Source::channelChanged);

    setValueCB(MTP_ViewRef::getViewModel().getValueOut());
    setStatusCB("_manualActive", MTP_ViewRef::getViewModel().getSource().getManualActive());
    setStatusCB("_internalActive", MTP_ViewRef::getViewModel().getSource().getInternalActive());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _rectValue = MTP_ViewRef::extractShape("_rectValue");
    _rectStatus = MTP_ViewRef::extractShape("_rectStatus");
  }

  /**
   * @brief Sets the output value for the reference.
   *
   * @param value The boolean value to be set.
   */
  protected void setValueCB(const bool &value)
  {
    if (value && _rectValue.enabled())
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
    }
  }

  /**
   * @brief Sets the status for the reference.
   *
   * @param varName The name of the variable to be set.
   * @param active The active state to be set.
   */
  protected void setStatusCB(const string &varName, const bool &active)
  {
    switch (varName)
    {
      case "_manualActive":
        _manualActive = active;
        break;

      case "_internalActive":
        _internalActive = active;
        break;

      case "_channel":
        _channel = active;
        break;
    }

    if (_rectStatus.enabled())
    {
      if (!_channel && _manualActive)
      {
        _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/Manual__2.svg]]";
        _rectStatus.visible = TRUE;
        return;
      }
      else if (!_channel && _internalActive)
      {
        _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/internal.svg]]";
        _rectStatus.visible = TRUE;
        return;
      }
      else
      {
        _rectStatus.visible = FALSE;
      }
    }
  }
};
