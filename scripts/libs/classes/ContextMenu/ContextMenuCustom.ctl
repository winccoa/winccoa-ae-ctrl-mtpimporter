// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/ContextMenu/ContextMenu"
#uses "classes/ContextMenu/ContextMenuConfig"
#uses "classes/DialogFramework"

/**
  @brief ContextMenuCustom class represents a custom context menu that can be used to display a list of buttons.
 */
class ContextMenuCustom : ContextMenu
{
  private string _ref; //!< Reference to the button

  /**
    @brief Constructor for ContextMenuCustom.
    @param config A shared pointer to a ContextMenuConfig object.
    @param ref The name of the shape in the reference to be positioned at.
    @throw Error with FiaErrorCode::ShapeDoesNotExist
  */
  public ContextMenuCustom(shared_ptr<ContextMenuConfig> config, const string &ref) : ContextMenu(config)
  {
    if (ref.isEmpty())
    {
      throwError(makeError("", PRIO_WARNING, ERR_SYSTEM, 0, "ContextMenuCustom", "ContextMenuCustom Ref Config is empty."));
    }

    _ref = ref;
  }

  /**
    @brief Builds the popup.
    @param buttons The list of buttons.
    @param parent The parent shape.
   */
  public static void BuildPopup(const dyn_string &buttons, const shape &parent)
  {
    int posY = 0;

    for (int i = 0; i < buttons.count(); i++)
    {
      dyn_string item = buttons.at(i).split(",");

      dyn_int refSize;

      switch (item.at(0))
      {
        case "SEPARATOR": addSymbol(myModuleName(), myPanelName(), ContextMenu::SEPARATOR, (string)i, "", 0, posY); refSize = getPanelSize(ContextMenu::SEPARATOR); break;

        case "PUSH_BUTTON":
          addSymbol(myModuleName(), myPanelName(), ContextMenu::PUSHBUTTON, (string)i, makeDynString("$Text:" + item.at(1), "$Answer:" + item.at(2), "$Active:" + item.at(3)), 0, posY);
          refSize = getPanelSize(ContextMenu::PUSHBUTTON);
          invokeMethod((string)i, "SetParent", parent);
          break;

        case "PUSH_BUTTON_IMAGE":
          addSymbol(myModuleName(), myPanelName(), ContextMenu::PUSHBUTTONIMAGE, (string)i, makeDynString("$Text:" + item.at(1), "$Answer:" + item.at(2), "$Active:" + item.at(3), "$Image:" + item.at(4)), 0, posY);
          refSize = getPanelSize(ContextMenu::PUSHBUTTONIMAGE);
          invokeMethod((string)i, "SetParent", parent);
          break;

        case "CHECK_BUTTON":
          addSymbol(myModuleName(), myPanelName(), ContextMenu::CHECKBUTTON, (string)i, makeDynString("$Text:" + item.at(1), "$Answer:" + item.at(2), "$Checked:" + item.at(3), "$Active:" + item.at(4)), 0, posY);
          refSize = getPanelSize(ContextMenu::CHECKBUTTON);
          invokeMethod((string)i, "SetParent", parent);
          break;

        default: refSize = makeDynInt(0, 10); break;
      }

      posY += refSize.at(1);
    }

    setPanelSize(myModuleName(), myPanelName(), FALSE, 331, posY);
  }

  /**
    @brief Opens the popup.
    @return The answer of the button.
   */
  public int Open()
  {
    int answer;

    int x, y;
    int w, h;
    int xPos, yPos;
    int xAbsolute, yAbsolute;
    int wScreen, hScreen;

    getValue(_ref, "position", x, y,
             "size", w, h);

    dyn_int size = getPanelSize(ContextMenu::MODULE);

    panelPosition(myModuleName(), "", xAbsolute, yAbsolute);
    getScreenSize(wScreen, hScreen);

    int yPopup = 0;
    dyn_string buttonList = GetButtonList();
    int buttonListCount = buttonList.count();

    for (int i = 0; i < buttonListCount; i++)
    {
      dyn_string button = buttonList.at(i).split(",");

      dyn_int refSize;

      switch (button.at(0))
      {
        case "SEPARATOR": refSize = getPanelSize(ContextMenu::SEPARATOR); break;

        case "PUSH_BUTTON": refSize = getPanelSize(ContextMenu::PUSHBUTTON); break;

        case "PUSH_BUTTON_IMAGE": refSize = getPanelSize(ContextMenu::PUSHBUTTONIMAGE); break;

        case "CHECK_BUTTON": refSize = getPanelSize(ContextMenu::CHECKBUTTON); break;

        default: refSize = makeDynInt(0, 10); break;
      }

      if (yPopup < (10 * getPanelSize(ContextMenu::PUSHBUTTON).at(1)))
      {
        yPopup += refSize.at(1);
      }
    }

    if ((yAbsolute + y + yPopup) > hScreen)
    {
      y -= yPopup;
    }
    else
    {
      y += h;
    }

    x += w - size.at(0);

    dyn_anytype panel = makeDynAnytype(myModuleName(), getPath(PANELS_REL_PATH, ContextMenu::MODULE), myPanelName(), "popup",
                                       x, y,
                                       1.0, true,
                                       makeDynString("$Items:" + dynStringToString(buttonList, "~"), "$Height:" + yPopup, "$Width:" + 331), false,
                                       makeMapping("windowFlags", "Popup")); //open child panel as popup

    dyn_anytype ret;
    childPanel(panel, ret);

    return (ret.count()) ? ret.at(0) : -1;
  }
};
