// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/LockView4/LockView4"
#uses "classes/MtpView/MtpViewRef"

class LockView4Ref : MtpViewRef
{
  private shape _rectOutput;

  public LockView4Ref(shared_ptr<LockView4> viewModel, const mapping &shapes) : MtpViewRef(viewModel, shapes)
  {
    classConnect(this, setOutputCB, MtpViewRef::getViewModel(), LockView4::outputChanged);

    setOutputCB(MtpViewRef::getViewModel().getOutput());
  }

  protected void initializeShapes() override
  {
    _rectOutput = MtpViewRef::extractShape("_rectOutput");
  }

  private void setOutputCB(const bool &output)
  {
    if (output)
    {
      _rectOutput.backCol = "mtpGreen";
    }
    else
    {
      _rectOutput.backCol = "mtpRed";
    }
  }

};
