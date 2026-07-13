// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author d.schermann
*/

#uses "classes/MTP_PEA/MTP_PEA"
#uses "classes/MTP_Ref/MTP_RefBase"
#uses "stdlib_hook_project"

/**
 * @class MTP_PEARef
 * @brief Represents the MTP_PEARef class.
 */
class MTP_PEARef : MTP_RefBase
{
  private shared_ptr<MTP_PEA> _viewModel; //!< The PEA view model.
  private shape _txtName; //!< Reference to the name text shape.
  private shape _txtDescription; //!< Reference to the description text shape.

  /**
   * @brief Constructor for MTP_PEARef.
   *
   * @param viewModel A shared pointer to the PEA view model.
   * @param shapes A mapping of shapes used in the reference.
   */
  public MTP_PEARef(shared_ptr<MTP_PEA> viewModel, const mapping &shapes) : MTP_RefBase(shapes)
  {
    assignPtr(_viewModel, viewModel);
    refresh();
  }

  /**
   * @brief Retrieves the view model associated with this reference.
   *
   * @return The shared pointer to the MTP_PEA instance.
   */
  public shared_ptr<MTP_PEA> getViewModel()
  {
    return _viewModel;
  }

  /**
   * @brief Refreshes the reference object texts.
   */
  public void refresh()
  {
    _txtName.text = getViewModel().getTitle();
    _txtDescription.text = getViewModel().getDescription();
  }

  /**
   * @brief Opens the PEA faceplate.
   */
  public void openFaceplate()
  {
    hook_openFaceplate(getViewModel().getDp());
  }

  /**
   * @brief Initializes the shapes used in the reference.
   */
  protected void initializeShapes() override
  {
    _txtName = MTP_RefBase::extractShape("_txtName");
    _txtDescription = MTP_RefBase::extractShape("_txtDescription");
  }
};
