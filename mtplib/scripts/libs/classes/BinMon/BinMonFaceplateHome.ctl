// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpQualityCode/MtpQualityCode"
#uses "classes/MtpView/MtpViewBase"
#uses "classes/BinMon/BinMon"

/**
 * @class BinMonFaceplateHome
 * @brief Represents the home faceplate for BinMon objects.
 */
class BinMonFaceplateHome : MtpViewBase
{
  private shape _txtValue; //!< Reference to the value text shape.
  private shape _rectValue; //!< Reference to the value rectangle shape.
  private shape _refWqc; //!< Reference to the quality code shape.
  private shape _rectFlutterActive; //!< Reference to the flutter active rectangle shape.
  private shape _txtFlutterActive; //!< Reference to the flutter active text shape.
  private bool _flutterEnabled; //!< Indicates if fluttering is enabled for the monitored value.

  /**
   * @brief Constructor for BinMonFaceplateHome.
   *
   * @param viewModel A shared pointer to the BinMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public BinMonFaceplateHome(shared_ptr<BinMon> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    classConnect(this, setValueCB, MtpViewBase::getViewModel(), BinMon::valueChanged);
    classConnect(this, setFlutterActiveCB, MtpViewBase::getViewModel(), BinMon::flutterActiveChanged);
    classConnect(this, setWqcCB, MtpViewBase::getViewModel().getWqc(), MtpQualityCode::qualityGoodChanged);

    _flutterEnabled = MtpViewBase::getViewModel().getFlutterEnabled();

    setWqcCB(MtpViewBase::getViewModel().getWqc().getQualityGood());
    setValueCB(MtpViewBase::getViewModel().getValue());
    setFlutterActiveCB(MtpViewBase::getViewModel().getFlutterActive());
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the table shape.
   */
  protected void initializeShapes()
  {
    _txtValue = MtpViewBase::extractShape("_txtValue");
    _refWqc = MtpViewBase::extractShape("_refWqc");
    _rectValue = MtpViewBase::extractShape("_rectValue");
    _rectFlutterActive = MtpViewBase::extractShape("_rectFlutterActive");
    _txtFlutterActive = MtpViewBase::extractShape("_txtFlutterActive");
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
      _txtValue.text = MtpViewBase::getViewModel().getValueStateTrueText();
    }
    else
    {
      _rectValue.fill = "[pattern,[fit,any,MTP_Icones/False.svg]]";
      _txtValue.text = MtpViewBase::getViewModel().getValueStateFalseText();
    }
  }

  /**
   * @brief Sets the WQC status for the faceplate.
   *
   * @param qualityGoodChanged The new quality status.
   */
  private void setWqcCB(const bool &qualityGoodChanged)
  {
    _refWqc.setStatus(qualityGoodChanged);
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
