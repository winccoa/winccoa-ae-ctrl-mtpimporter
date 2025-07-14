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
  private int _index;
  private shape _button;

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

  public void nextIndex()
  {
    _index++;

    if (_index >= _fileName.count())
    {
      _index = 0;
    }
  }

  public void resetIndex()
  {
    _index = 0;
  }

  public void setButton(const shape &button)
  {
    _button= button;
  }
};
