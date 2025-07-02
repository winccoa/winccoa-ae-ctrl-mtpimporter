// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpViewModel/MtpViewModelBase"

class MtpViewBase
{
  private mapping _shapes;
  private shared_ptr<MtpViewModelBase> _viewModel;

  protected MtpViewBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes)
  {
    assignPtr(_viewModel, viewModel);
    _shapes = shapes;

    initializeShapes();
  }

  protected shared_ptr<MtpViewModelBase> getViewModel()
  {
    return _viewModel;
  }

  protected shape extractShape(const string &key)
  {
    if (!_shapes.contains(key))
    {
      throw (makeError("", PRIO_SEVERE, ERR_PARAM, 0, "key '" + key + "' doesn't exist"));
    }

    if (shapeExists(_shapes.value(key)))
    {
      return _shapes.value(key);
    }

    throw (makeError("", PRIO_SEVERE, ERR_PARAM, 0, "shape from key '" + key + "' doesn't exist: '" + _shapes.value(key, "key is empty") + "'"));
  }

  protected void initializeShapes() = 0;
};
