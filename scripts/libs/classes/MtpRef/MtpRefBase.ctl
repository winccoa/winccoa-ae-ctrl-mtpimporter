// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

class MtpRefBase
{
  private mapping _shapes;

  protected MtpRefBase(const mapping &shapes)
  {
    _shapes = shapes;

    initializeShapes();
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
