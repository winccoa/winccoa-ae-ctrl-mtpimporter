// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_MonTriPosVlv/MTP_MonTriPosVlv"
#uses "classes/MTP_View/MTP_ViewBase"

/**
 * @class MTP_MonTriPosVlvFaceplateConfigurationInformation
 * @brief Represents the MTP_MonTriPosVlvFaceplateConfigurationInformation class.
 */
class MTP_MonTriPosVlvFaceplateConfigurationInformation : MTP_ViewBase
{
  private shape _txtPos1Configuration; //!< The text pos1 configuration shape.
  private shape _txtPos2Configuration; //!< The text pos2 configuration shape.
  private shape _txtPos3Configuration; //!< The text pos3 configuration shape.
  private shape _rectValvePos1_0; //!< The rectangle valve pos1_0 shape.
  private shape _rectValvePos1_1; //!< The rectangle valve pos1_1 shape.
  private shape _rectValvePos1_2; //!< The rectangle valve pos1_2 shape.
  private shape _rectValvePos2_0; //!< The rectangle valve pos2_0 shape.
  private shape _rectValvePos2_1; //!< The rectangle valve pos2_1 shape.
  private shape _rectValvePos2_2; //!< The rectangle valve pos2_2 shape.
  private shape _rectValvePos3_0; //!< The rectangle valve pos3_0 shape.
  private shape _rectValvePos3_1; //!< The rectangle valve pos3_1 shape.
  private shape _rectValvePos3_2; //!< The rectangle valve pos3_2 shape.

  /**
   * @brief Constructor for the MTP_MonTriPosVlvFaceplateConfigurationInformation object.
   *
   * @param viewModel The view model instance.
   * @param shapes The mapping of shapes used by the MTP_MonTriPosVlvFaceplateConfigurationInformation object.
   */
  public MTP_MonTriPosVlvFaceplateConfigurationInformation(shared_ptr<MTP_MonTriPosVlv> viewModel, const mapping &shapes) : MTP_ViewBase(viewModel, shapes)
  {
    classConnectUserData(this, setConfigurationCB, "_txtPos1Configuration", getMonTriPosVlv(), MTP_MonTriPosVlv::pos1ConfigurationChanged);
    classConnectUserData(this, setConfigurationCB, "_txtPos2Configuration", getMonTriPosVlv(), MTP_MonTriPosVlv::pos2ConfigurationChanged);
    classConnectUserData(this, setConfigurationCB, "_txtPos3Configuration", getMonTriPosVlv(), MTP_MonTriPosVlv::pos3ConfigurationChanged);

    setConfigurationCB("_txtPos1Configuration", getMonTriPosVlv().getPos1Configuration());
    setConfigurationCB("_txtPos2Configuration", getMonTriPosVlv().getPos2Configuration());
    setConfigurationCB("_txtPos3Configuration", getMonTriPosVlv().getPos3Configuration());
  }

  /**
   * @brief Initializes the MTP_MonTriPosVlvFaceplateConfigurationInformation object.
   */
  protected void initializeShapes()
  {
    _txtPos1Configuration = MTP_ViewBase::extractShape("_txtPos1Configuration");
    _txtPos2Configuration = MTP_ViewBase::extractShape("_txtPos2Configuration");
    _txtPos3Configuration = MTP_ViewBase::extractShape("_txtPos3Configuration");
    _rectValvePos1_0 = MTP_ViewBase::extractShape("_rectValvePos1_0");
    _rectValvePos1_1 = MTP_ViewBase::extractShape("_rectValvePos1_1");
    _rectValvePos1_2 = MTP_ViewBase::extractShape("_rectValvePos1_2");
    _rectValvePos2_0 = MTP_ViewBase::extractShape("_rectValvePos2_0");
    _rectValvePos2_1 = MTP_ViewBase::extractShape("_rectValvePos2_1");
    _rectValvePos2_2 = MTP_ViewBase::extractShape("_rectValvePos2_2");
    _rectValvePos3_0 = MTP_ViewBase::extractShape("_rectValvePos3_0");
    _rectValvePos3_1 = MTP_ViewBase::extractShape("_rectValvePos3_1");
    _rectValvePos3_2 = MTP_ViewBase::extractShape("_rectValvePos3_2");
  }

  /**
   * @brief Retrieves the mon tri position vlv.
   *
   * @return The mon tri position vlv.
   */
  private shared_ptr<MTP_MonTriPosVlv> getMonTriPosVlv()
  {
    return MTP_ViewBase::getViewModel();
  }

  /**
   * @brief Sets the configuration from the connected data point element.
   *
   * @param shapeName The new shape name value.
   * @param configuration The new configuration value.
   */
  private void setConfigurationCB(const string &shapeName, const int &configuration)
  {
    switch (shapeName)
    {
      case "_txtPos1Configuration":
        _rectValvePos1_0.fill = configuration >= 4 ? "[pattern,[fit,any,MTP_Icones/opened-valve0.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve0.svg]]";
        _rectValvePos1_1.fill = configuration == 2 || configuration == 3 || configuration == 6 || configuration == 7 ? "[pattern,[fit,any,MTP_Icones/opened-valve1.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve1.svg]]";
        _rectValvePos1_2.fill = configuration == 1 || configuration == 3 || configuration == 5 || configuration == 7 ? "[pattern,[fit,any,MTP_Icones/opened-valve2.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve2.svg]]";
        break;

      case "_txtPos2Configuration":
        _rectValvePos2_0.fill = configuration >= 4 ? "[pattern,[fit,any,MTP_Icones/opened-valve0.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve0.svg]]";
        _rectValvePos2_1.fill = configuration == 2 || configuration == 3 || configuration == 6 || configuration == 7 ? "[pattern,[fit,any,MTP_Icones/opened-valve1.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve1.svg]]";
        _rectValvePos2_2.fill = configuration == 1 || configuration == 3 || configuration == 5 || configuration == 7 ? "[pattern,[fit,any,MTP_Icones/opened-valve2.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve2.svg]]";
        break;

      case "_txtPos3Configuration":
        _rectValvePos3_0.fill = configuration >= 4 ? "[pattern,[fit,any,MTP_Icones/opened-valve0.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve0.svg]]";
        _rectValvePos3_1.fill = configuration == 2 || configuration == 3 || configuration == 6 || configuration == 7 ? "[pattern,[fit,any,MTP_Icones/opened-valve1.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve1.svg]]";
        _rectValvePos3_2.fill = configuration == 1 || configuration == 3 || configuration == 5 || configuration == 7 ? "[pattern,[fit,any,MTP_Icones/opened-valve2.svg]]" : "[pattern,[fit,any,MTP_Icones/closed-valve2.svg]]";
        break;
    }
  }
};
