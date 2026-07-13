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
 * @class MTP_PEAProcessValueScalarRef
 * @brief Row reference for Ana/DInt/String process value rows.
 */
class MTP_PEAProcessValueScalarRef : MTP_RefBase
{
  private shared_ptr<MTP_PEAProcessValueRow> _viewModel; //!< Row view model.
  private shape _txtName; //!< Name text.
  private shape _txtRequired; //!< Value text field.
  private shape _txtUnit; //!< Unit text.
  private shape _rectStatus; //!< WQC icon.

  /**
   * @brief Constructor for MTP_PEAProcessValueScalarRef.
   *
   * @param viewModel Row view model.
   * @param shapes Shape mapping.
   */
  public MTP_PEAProcessValueScalarRef(shared_ptr<MTP_PEAProcessValueRow> viewModel, const mapping &shapes) : MTP_RefBase(shapes)
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
    _txtRequired.text = _viewModel.getCurrentValue();
    _txtUnit.text = _viewModel.getUnit();

    if (_viewModel.getQualityGood())
    {
      _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/GreyOk.svg]]";
    }
    else
    {
      _rectStatus.fill = "[pattern,[fit,any,MTP_Icones/Close.svg]]";
    }
  }

  /**
   * @brief Immediate write on text command event for ProcessValueIn rows.
   *
   * @param valueText Entered value text.
   */
  public void writeImmediate(const string &valueText)
  {
    _viewModel.setRequestedValue(valueText);
    refresh();
  }

  /**
   * @brief Opens corresponding View faceplate with the current row datapoint.
   */
  public void gotoTarget()
  {
    _viewModel.openTargetViewFaceplate();
  }

  /**
   * @brief Initializes required shapes.
   */
  protected void initializeShapes() override
  {
    _txtName = MTP_RefBase::extractShape("_txtName");
    _txtRequired = MTP_RefBase::extractShape("_txtRequired");
    _txtUnit = MTP_RefBase::extractShape("_txtUnit");
    _rectStatus = MTP_RefBase::extractShape("_rectStatus");
  }

  /**
   * @brief Connects direct DPE updates for reliable live refresh.
   */
  private void connectLiveUpdates()
  {
    string valueDpe = _viewModel.getValueDpe();
    string qualityDpe = _viewModel.getQualityDpe();
    string kind = _viewModel.getKind();

    if (dpExists(valueDpe))
    {
      switch (kind)
      {
        case "Ana":
        {
          dpConnect(this, valueChangedFloatCB, false, valueDpe);
          break;
        }

        case "DInt":
        {
          dpConnect(this, valueChangedIntCB, false, valueDpe);
          break;
        }

        default:
        {
          dpConnect(this, valueChangedStringCB, false, valueDpe);
          break;
        }
      }
    }

    if (dpExists(qualityDpe))
    {
      dpConnect(this, qualityChangedCB, false, qualityDpe);
    }
  }

  /**
   * @brief Value callback for ANA rows.
   */
  private void valueChangedFloatCB(const string &dpe, const float &value)
  {
    refresh();
  }

  /**
   * @brief Value callback for DINT rows.
   */
  private void valueChangedIntCB(const string &dpe, const int &value)
  {
    refresh();
  }

  /**
   * @brief Value callback for STRING rows.
   */
  private void valueChangedStringCB(const string &dpe, const string &value)
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
