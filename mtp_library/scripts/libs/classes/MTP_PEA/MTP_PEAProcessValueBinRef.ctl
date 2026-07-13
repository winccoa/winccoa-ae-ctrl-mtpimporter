// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_Ref/MTP_RefBase"
#uses "classes/MTP_PEA/MTP_PEAProcessValueRow"

/**
 * @class MTP_PEAProcessValueBinRef
 * @brief Row reference for binary process value rows.
 */
class MTP_PEAProcessValueBinRef : MTP_RefBase
{
  private shared_ptr<MTP_PEAProcessValueRow> _viewModel; //!< Row view model.
  private shape _txtName; //!< Name text.
  private shape _txtUnit; //!< Unit text.
  private shape _rectStatus; //!< WQC icon.
  private shape _rectCurrent; //!< Current bin state icon.

  /**
   * @brief Constructor for MTP_PEAProcessValueBinRef.
   *
   * @param viewModel Row view model.
   * @param shapes Shape mapping.
   */
  public MTP_PEAProcessValueBinRef(shared_ptr<MTP_PEAProcessValueRow> viewModel, const mapping &shapes) : MTP_RefBase(shapes)
  {
    assignPtr(_viewModel, viewModel);
    classConnect(this, refresh, _viewModel, MTP_PEAProcessValueRow::rowChanged);
    connectLiveUpdates();
    refresh();
  }

  /**
   * @brief Refreshes row values.
   */
  public void refresh()
  {
    _txtName.text = _viewModel.getName();
    _txtUnit.text = _viewModel.getUnit();

    if (_viewModel.getQualityGood())
    {
      _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/GreyOk.svg]]";
    }
    else
    {
      _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
    }

    if (_viewModel.getCurrentBool())
    {
      _rectCurrent.fill = "[pattern,[fit,any,pictures/MTP_Icones/True.svg]]";
    }
    else
    {
      _rectCurrent.fill = "[pattern,[fit,any,pictures/MTP_Icones/False.svg]]";
    }
  }

  /**
   * @brief Opens corresponding View faceplate with the current row datapoint.
   */
  public void gotoTarget()
  {
    _viewModel.openTargetViewFaceplate();
  }

  /**
   * @brief Toggles current binary value for ProcessValueIn rows.
   */
  public void toggleCurrent()
  {
    _viewModel.toggleBinaryValue();
    refresh();
  }

  /**
   * @brief Initializes required shapes.
   */
  protected void initializeShapes() override
  {
    _txtName = MTP_RefBase::extractShape("_txtName");
    _txtUnit = MTP_RefBase::extractShape("_txtUnit");
    _rectStatus = MTP_RefBase::extractShape("_rectStatus");
    _rectCurrent = MTP_RefBase::extractShape("_rectCurrent");
  }

  /**
   * @brief Connects direct DPE updates for reliable live refresh.
   */
  private void connectLiveUpdates()
  {
    string valueDpe = _viewModel.getValueDpe();
    string qualityDpe = _viewModel.getQualityDpe();

    if (dpExists(valueDpe))
    {
      dpConnect(this, valueChangedCB, false, valueDpe);
    }

    if (dpExists(qualityDpe))
    {
      dpConnect(this, qualityChangedCB, false, qualityDpe);
    }
  }

  /**
   * @brief Value callback.
   */
  private void valueChangedCB(const string &dpe, const bool &value)
  {
    refresh();
  }

  /**
   * @brief Quality callback.
   */
  private void qualityChangedCB(const string &dpe, const bit32 &quality)
  {
    refresh();
  }
};
