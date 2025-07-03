// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpViewModel/MtpViewModelBase"

/**
 * @class MtpViewBase
 * @brief Base class for MTP view components.
 */
class MtpViewBase
{
  private mapping _shapes; //!< A mapping of shapes used in the view.
  private shared_ptr<MtpViewModelBase> _viewModel; //!< The view model associated with this view.

  /**
   * @brief Constructor for MtpViewBase.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the view.
   */
  protected MtpViewBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes)
  {
    assignPtr(_viewModel, viewModel);
    _shapes = shapes;

    initializeShapes();
  }

  /**
   * @brief Retrieves the view model associated with this view.
   * 
   * @return The shared pointer to the MtpViewModelBase instance.
   */
  protected shared_ptr<MtpViewModelBase> getViewModel()
  {
    return _viewModel;
  }

  /**
   * @brief Extracts a shape based on the provided key.
   * 
   * @param key The key used to locate the shape.
   * @return shape The extracted shape object associated with the provided key.
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
   * @brief Pure virtual function to initialize shapes.
   */
  protected void initializeShapes() = 0;
};
