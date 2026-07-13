// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/


/**
 * @class MTP_RefBase
 * @brief Represents the MTP_RefBase class.
 */
class MTP_RefBase
{
  private mapping _shapes; //!< Mapping of shapes used in the reference.

  /**
   * @brief Constructor for MTP_RefBase.
   *
   * @param shapes A mapping of shapes used in the reference.
   */
  protected MTP_RefBase(const mapping &shapes)
  {
    _shapes = shapes;

    initializeShapes();
  }

  /**
   * @brief Checks if a shape exists in the mapping and extracts it.
   *
   * @param key The key of the shape to check.
   * @return True if the shape exists, false otherwise.
   */
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

  /**
   * @brief Initializes the shapes used in the reference.
   */
  protected void initializeShapes() = 0;
};
