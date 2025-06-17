// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

class MtpNavigationButton
{
  private string _picture;
  private string _name;
  private string _fileName;

  public MtpNavigationButton(const string &picture, const string &name, const string &fileName)
  {
    _picture = picture;
    _name = name;
    _fileName = fileName;
  }

  public string getPicture()
  {
    return _picture;
  }

  public string getName()
  {
    return _name;
  }

  public string getFileName()
  {
    return _fileName;
  }
};
