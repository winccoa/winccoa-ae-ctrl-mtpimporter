// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/


/**
 * @class MtpRefBase
 * @brief Base class for MTP reference.
 */
class MtpRefBase
{
  private mapping _shapes; //!< Mapping of shapes used in the reference.

  /**
   * @brief Constructor for MtpRefBase.
   *
   * @param shapes A mapping of shapes used in the reference.
   */
  protected MtpRefBase(const mapping &shapes)
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
   * @details This method is pure virtual and must be implemented by derived classes to initialize their specific shapes.
   */
  protected void initializeShapes() = 0;
};
