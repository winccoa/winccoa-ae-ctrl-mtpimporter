// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @brief ContextMenu
  @details Is used to easily configure and open a context menu
  @since Version 3.19
  @author Mario Wögrath
  @copyright $copyright
*/

#uses "classes/ContextMenu/ContextMenuConfig"

/**
  @brief The ContextMenu class represents a context menu that can be used to display a list of buttons.
 */
class ContextMenu
{
  public static const string CHECKBUTTON = "contextMenu/popup_checkbutton.xml"; //!< Reference to the check button.
  public static const string PUSHBUTTON = "contextMenu/popup_pushbutton.xml"; //!< Reference to the push button.
  public static const string PUSHBUTTONIMAGE = "contextMenu/popup_pushbuttonWithImage.xml"; //!< Reference to the push button with image.
  public static const string SEPARATOR = "contextMenu/popup_seperator.xml"; //!< Reference to the seperator.
  public static const string POPUP = "contextMenu/popup.xml"; //!< Reference to the popup.
  public static const string MODULE = "contextMenu/popupModule.xml"; //!< Reference of the popup module.

  private shared_ptr<ContextMenuConfig> _config; //!< Context menu config.

  /**
    @brief Constructs a ContextMenu object with the given configuration.
    @param config A shared pointer to a ContextMenuConfig object. Must not be nullptr.
    @throw Error with FiaErrorCode::GivenObjectIsNull
  */
  public ContextMenu(shared_ptr<ContextMenuConfig> config)
  {
    if (config == nullptr)
    {
      throwError(makeError("", PRIO_WARNING, ERR_SYSTEM, 0, "ContextMenu", "ContextMenu Config is nullptr."));
    }

    _config = config;
  }

  /**
    @brief Retrieves the list of buttons from the configuration.
    @return A dyn_string containing the list of buttons.
   */
  public dyn_string GetButtonList()
  {
    dyn_string buttonList;
    buttonList = _config.GetButtonList();
    return buttonList;
  }

  /**
    @brief Opens the context menu.
    @return The answer of the button.
   */
  public int Open()
  {
    int answer;

    if (!_config.GetButtonList().isEmpty())
    {
      popupMenu(_config.GetButtonList(), answer);
    }

    return answer;
  }
};
