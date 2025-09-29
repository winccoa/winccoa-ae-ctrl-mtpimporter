// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

/**
 * @class MtpNavigationButton
 * @brief Represents a navigation button in the MTP main faceplate.
 */
class MtpNavigationButton
{
  private dyn_string _picture; //!< The picture associated with the navigation button.
  private string _name; //!< The name of the navigation button.
  private dyn_string _fileName; //!< The file name associated with the navigation button.
  private int _index; //!< The current index for selecting the picture and file name.
  private shape _button; //!< The shape representing the navigation button.

  /**
   * @brief Constructor for MtpNavigationButton.
   *
   * @param picture The picture associated with the navigation button.
   * @param name The name of the navigation button.
   * @param fileName The file name associated with the navigation button.
   */
  public MtpNavigationButton(const dyn_string &picture, const string &name, const dyn_string &fileName)
  {
    _picture = picture;
    _name = name;
    _fileName = fileName;
    resetIndex();
  }

  /**
   * @brief Sets the picture for the navigation button.
   * @details Updates the button's appearance by setting its picture to the one at the current index.
   */
  public void setPicture()
  {
    _button.setPicture(_picture.at(_index));
  }

  /**
   * @brief Retrieves the name of the navigation button.
   *
   * @return The name of the navigation button.
   */
  public string getName()
  {
    return _name;
  }

  /**
   * @brief Retrieves the file name associated with the navigation button.
   *
   * @return The file name associated with the navigation button.
   */
  public string getFileName()
  {
    return _fileName.at(_index);
  }

  /**
   * @brief Increments the index for selecting the picture and file name.
   * @details Advances the index to the next picture and file name, looping back to zero if the end is reached.
   */
  public void nextIndex()
  {
    _index++;

    if (_index >= _fileName.count())
    {
      _index = 0;
    }
  }

  /**
   * @brief Resets the index to zero.
   * @details Sets the index back to the first picture and file name in the respective collections.
   */
  public void resetIndex()
  {
    _index = 0;
  }

  /**
   * @brief Sets the shape for the navigation button.
   * @details Assigns the provided shape to the button for display and interaction.
   *
   * @param button The shape to set as the navigation button.
   */
  public void setButton(const shape &button)
  {
    _button = button;
  }
};
