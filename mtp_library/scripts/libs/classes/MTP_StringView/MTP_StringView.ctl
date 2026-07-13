// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_IndicatorElement/MTP_IndicatorElement"

/**
 * @class MTP_StringView
 * @brief Represents the MTP_StringView class.
 */
class MTP_StringView : MTP_IndicatorElement
{
  private string _text; //!< The text.

 /**
  * @brief Constructor for the MTP_StringView object.
  *
  * @param dp The data point of the MTP_StringView.
  */
 public MTP_StringView(const string &dp) : MTP_IndicatorElement(dp)
  {
    if (!dpExists(getDp() + ".Text"))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, (int)ErrCode::DPNOTEXISTENT, getDp() + ".Text"));
    }

    dpConnect(this, setTextCB, getDp() + ".Text");
  }

  #event textChanged(const string &text) //!< Event triggered when the text changes.

  /**
   * @brief Retrieves the text.
   *
   * @return The text.
   */
  public string getText()
  {
    return _text;
  }

  /**
   * @brief Sets the text from the connected data point element.
   *
   * @param dpe The data point element.
   * @param text The new text value.
   */
  private void setTextCB(const string &dpe, const string &text)
  {
    _text = text;
    textChanged(_text);
  }
};
