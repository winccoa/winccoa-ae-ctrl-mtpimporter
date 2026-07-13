// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewBase"
#uses "classes/MTP_BinMon/MTP_BinMon"
#uses "classes/MTP_Wqc/MTP_Wqc"

/**
 * @class MTP_BinMonFaceplateHome
 * @brief Represents the MTP_BinMonFaceplateHome class.
 */
class MTP_BinMonFaceplateHome : MTP_ViewBase
{
  private shape _txtValue; //!< Reference to the value text shape.
  private shape _rectValue; //!< Reference to the value rectangle shape.
  private shape _rectFlutterActive; //!< Reference to the flutter active rectangle shape.
  private shape _txtFlutterActive; //!< Reference to the flutter active text shape.
  private bool _flutterEnabled; //!< Indicates if fluttering is enabled for the monitored value.

  /**
   * @brief Constructor for MTP_BinMonFaceplateHome.
   *
   * @param viewModel A shared pointer to the BinMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_BinMonFaceplateHome(shared_ptr<MTP_BinMon> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnect(this, setValueCB, MTP_ViewBase::getViewModel(), MTP_BinMon::valueChanged);
    classConnect(this, setFlutterActiveCB, MTP_ViewBase::getViewModel(), MTP_BinMon::flutterActiveChanged);

    _flutterEnabled = MTP_ViewBase::getViewModel().getFlutterEnabled();

    setValueCB(MTP_ViewBase::getViewModel().getValue());
    setFlutterActiveCB(MTP_ViewBase::getViewModel().getFlutterActive());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes()
  {
    _txtValue = MTP_ViewBase::extractShape("_txtValue");
    _rectValue = MTP_ViewBase::extractShape("_rectValue");
    _rectFlutterActive = MTP_ViewBase::extractShape("_rectFlutterActive");
    _txtFlutterActive = MTP_ViewBase::extractShape("_txtFlutterActive");
  }

  /**
   * @brief Sets the value for the faceplate.
   *
   * @param value The boolean value to be set.
   */
  private void setValueCB(const bool &value)
  {
    if (value)
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/True.svg]]";
      _txtValue.text = MTP_ViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _txtValue.text = MTP_ViewBase::getViewModel().getValueStateFalseText();
    }
  }

  /**
   * @brief Sets the flutter active status for the faceplate.
   *
   * @param active The new flutter active status.
   */
  private void setFlutterActiveCB(const bool &active)
  {
    if (active && _flutterEnabled)
    {
      _rectFlutterActive.visible = TRUE;
      _rectFlutterActive.fill = "[pattern,[fit,any,MTP_Icones/Mainenance_2.svg]]";
      _rectFlutterActive.sizeAsDyn = makeDynInt(25, 25);
      _txtFlutterActive.visible = TRUE;
    }
    else if (_flutterEnabled)
    {
      _rectFlutterActive.visible = TRUE;
      _rectFlutterActive.fill = "[pattern,[fit,any,MTP_Icones/Ok_2.svg]]";
      _rectFlutterActive.sizeAsDyn = makeDynInt(30, 25);
      _txtFlutterActive.visible = TRUE;
    }
    else
    {
      _rectFlutterActive.visible = FALSE;
      _txtFlutterActive.visible = FALSE;
    }
  }
};
