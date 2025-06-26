// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/BinMon/BinMon"
#uses "classes/MtpView/MtpViewFaceplateSettings"

class BinMonFaceplateSettings : MtpViewFaceplateSettings
{
  private shape _txtVFlutTi;
  private shape _txtVFlutCnt;

  public BinMonFaceplateSettings(shared_ptr<BinMon> viewModel, const mapping &shapes) : MtpViewFaceplateSettings(viewModel, shapes)
  {
    _txtVFlutTi.text = getViewModel().getFlutterTime();
    _txtVFlutCnt.text = getViewModel().getFlutterCount();
  }

  public void setFlutterTime(const float &flutterTime)
  {
    getViewModel().setFlutterTime(flutterTime);
  }

  public void setFlutterCount(const int &flutterCount)
  {
    getViewModel().setFlutterCount(flutterCount);
  }

  protected void initializeShapes()
  {
    _txtVFlutTi = MtpViewFaceplateSettings::extractShape("_txtVFlutTi");
    _txtVFlutCnt = MtpViewFaceplateSettings::extractShape("_txtVFlutCnt");
  }

  protected shape getTxtVFLutTi()
  {
    return _txtVFlutTi;
  }

  protected shape getTxtVFlutCnt()
  {
    return _txtVFlutCnt;
  }

};
