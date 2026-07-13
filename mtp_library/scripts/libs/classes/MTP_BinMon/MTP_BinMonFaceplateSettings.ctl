// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_View/MTP_ViewFaceplateSettings"
#uses "classes/MTP_BinMon/MTP_BinMon"
#uses "classes/MTP_OsLevel/MTP_OsLevel"

/**
 * @class MTP_BinMonFaceplateSettings
 * @brief Represents the MTP_BinMonFaceplateSettings class.
 */
class MTP_BinMonFaceplateSettings : MTP_ViewFaceplateSettings
{
  private shape _txtVFlutTi; //!< Reference to the flutter time text shape.
  private shape _txtVFlutCnt; //!< Reference to the flutter count text shape.

  /**
   * @brief Constructor for MTP_BinMonFaceplateSettings.
   *
   * @param viewModel A shared pointer to the MTP_BinMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MTP_BinMonFaceplateSettings(shared_ptr<MTP_BinMon> viewModel, const mapping &shapes) : MTP_ViewFaceplateSettings(viewModel, shapes)
  {
    _txtVFlutTi.text = MTP_ViewFaceplateSettings::getViewModel().getFlutterTime();
    _txtVFlutCnt.text = MTP_ViewFaceplateSettings::getViewModel().getFlutterCount();
  }

  /**
   * @brief Sets the flutter time for the MTP_BinMon object.
   *
   * @param flutterTime The flutter time value to be set.
   */
  public void setFlutterTime(const float &flutterTime)
  {
    MTP_ViewFaceplateSettings::getViewModel().setFlutterTime(flutterTime);
  }

  /**
   * @brief Sets the flutter count for the MTP_BinMon object.
   *
   * @param flutterCount The flutter count value to be set.
   */
  public void setFlutterCount(const int &flutterCount)
  {
    MTP_ViewFaceplateSettings::getViewModel().setFlutterCount(flutterCount);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   */
  protected void initializeShapes() override
  {
    _txtVFlutTi = MTP_ViewFaceplateSettings::extractShape("_txtVFlutTi");
    _txtVFlutCnt = MTP_ViewFaceplateSettings::extractShape("_txtVFlutCnt");
  }
};
