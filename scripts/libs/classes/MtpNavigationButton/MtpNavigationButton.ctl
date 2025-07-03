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
  private string _picture; //!< The picture associated with the navigation button.
  private string _name; //!< The name of the navigation button.
  private string _fileName; //!< The file name associated with the navigation button.

  /**
   * @brief Constructor for MtpNavigationButton.
   *
   * @param picture The picture associated with the navigation button.
   * @param name The name of the navigation button.
   * @param fileName The file name associated with the navigation button.
   */
  public MtpNavigationButton(const string &picture, const string &name, const string &fileName)
  {
    _picture = picture;
    _name = name;
    _fileName = fileName;
  }

  /**
   * @brief Retrieves the picture associated with the navigation button.
   *
   * @return The picture associated with the navigation button.
   */
  public string getPicture()
  {
    return _picture;
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
    return _fileName;
  }
};
