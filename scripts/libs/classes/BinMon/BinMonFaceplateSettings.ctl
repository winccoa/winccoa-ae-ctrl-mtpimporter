// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MtpOsLevel/MtpOsLevel"
#uses "classes/BinMon/BinMon"
#uses "classes/MtpView/MtpViewFaceplateSettings"

/**
 * @class BinMonFaceplateSettings
 * @brief Represents the settings faceplate for the BinMon objects.
 */
class BinMonFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _txtVFlutTi; //!< Reference to the flutter time text shape.
  private shape _txtVFlutCnt; //!< Reference to the flutter count text shape.

  /**
   * @brief Constructor for BinMonFaceplateSettings.
   *
   * @param viewModel A shared pointer to the BinMon view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public BinMonFaceplateSettings(shared_ptr<BinMon> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    _txtVFlutTi.text = MtpViewFaceplateSettings::getViewModel().getFlutterTime();
    _txtVFlutCnt.text = MtpViewFaceplateSettings::getViewModel().getFlutterCount();
  }

  /**
   * @brief Sets the flutter time for the BinMon object.
   *
   * @param flutterTime The flutter time value to be set.
   */
  public void setFlutterTime(const float &flutterTime)
  {
    MtpViewFaceplateSettings::getViewModel().setFlutterTime(flutterTime);
  }

  /**
   * @brief Sets the flutter count for the BinMon object.
   *
   * @param flutterCount The flutter count value to be set.
   */
  public void setFlutterCount(const int &flutterCount)
  {
    MtpViewFaceplateSettings::getViewModel().setFlutterCount(flutterCount);
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the table shape.
   */
  protected void initializeShapes() override
  {
    _txtVFlutTi = MtpViewFaceplateSettings::extractShape("_txtVFlutTi");
    _txtVFlutCnt = MtpViewFaceplateSettings::extractShape("_txtVFlutCnt");
  }
};
