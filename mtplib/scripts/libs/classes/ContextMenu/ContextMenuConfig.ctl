// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author n.holzersoellner
*/

/**
  @brief The ContextMenuConfig class holds the configuration for a context menu.
 */
class ContextMenuConfig
{
  private dyn_string _buttons; //!< List of buttons
  private mapping _branches; //!< List of branches

  /**
    @brief Constructor for ContextMenuConfig.
   */
  public ContextMenuConfig()
  {
  }

  /**
    @brief Adds a cascade button to the context menu.
    @param text The text of the button.
    @param active The active state of the button.
    @param branchName The name of the branch.
   */
  public void AddCascadeButton(const string &text, const int active = 1, const string branchName = "")
  {
    string button = "CASCADE_BUTTON," + text + "," + (string)active;
    AddButton(branchName, button);
  }

  /**
    @brief Adds a check button to the context menu.
    @param text The text of the button.
    @param answer The answer of the button.
    @param checked The checked state of the button.
    @param active The active state of the button.
    @param branchName The name of the branch.
   */
  public void AddCheckButton(const string &text, const int &answer, const int checked = 0, const int active = 1, const string branchName = "")
  {
    string button = "CHECK_BUTTON," + text + "," + (string)answer + "," + (string)active + "," + (string)checked;
    AddButton(branchName, button);
  }

  /**
    @brief Adds a push button to the context menu.
    @param text The text of the button.
    @param answer The answer of the button.
    @param active The active state of the button.
    @param branchName The name of the branch.
   */
  public void AddPushButton(const string &text, const int &answer, const int active = 1, const string branchName = "")
  {
    string button = "PUSH_BUTTON," + text + "," + (string) answer + "," + (string) active;
    AddButton(branchName, button);
  }

  /**
  @brief Adds a push button with an image to the context menu.
  @param text The text of the button.
  @param answer The answer of the button.
  @param active The active state of the button.
  @param branchName The name of the branch.
  @param image The image of the row.
  */
  public void AddPushButtonWithImage(const string &text, const int &answer, const int active = 1, const string branchName = "", const string image)
  {
    string button = "PUSH_BUTTON_IMAGE," + text + "," + (string) answer + "," + (string) active + "," + (string) image;
    AddButton(branchName, button);
  }

  /**
    @brief Adds a seperator to the context menu.
    @param branchName The name of the branch.
   */
  public void AddSeperator(const string branchName = "")
  {
    string button = "SEPARATOR";
    AddButton(branchName, button);
  }

  /**
    @brief Clears the context menu.
   */
  public void Clear()
  {
    _buttons.clear();
    _branches.clear();
  }

  /**
    @brief Gets the button list.
    @return The button list.
   */
  public dyn_string GetButtonList()
  {
    dyn_string buttonList = _buttons;
    int branchCount = _branches.count();

    for (int i = 0; i < branchCount; i++)
    {
      dynAppend(buttonList, _branches.keyAt(i));
      dynAppend(buttonList, _branches.valueAt(i));
    }

    return buttonList;
  }

  /**
    @brief Adds a button to the branch list of the context menu.
    @param branchName The name of the branch.
    @param button The name of the button to be added.
   */
  private void AddBranchButton(const string &branchName, const string &button)
  {
    dyn_string branchList = _branches.value(branchName);
    branchList.append(button);
    _branches.insert(branchName, branchList);
  }

  /**
    @brief Adds a button to the context menu.
    @param branchName The name of the branch.
    @param button The name of the button to be added.
   */
  private void AddButton(const string &branchName, const string &button)
  {
    if (branchName.isEmpty())
    {
      _buttons.append(button);
    }
    else
    {
      AddBranchButton(branchName, button);
    }
  }
};
