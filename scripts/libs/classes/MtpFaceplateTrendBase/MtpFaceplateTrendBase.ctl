// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpViewModel/MtpViewModelBase"
#uses "classes/MtpView/MtpViewBase"

/**
 * @class MtpFaceplateTrendBase
 * @brief A base class for implementing faceplate trend functionality in the MTP library object.
 */
class MtpFaceplateTrendBase : MtpViewBase
{
  private shape _trend; //!< The trend shape used in the faceplate.

  /**
   * @brief Constructor for MtpFaceplateTrendBase.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  protected MtpFaceplateTrendBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    connectTrend();
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method.
   */
  protected void initializeShapes() override
  {
    _trend = MtpViewBase::extractShape("_trend");
  }

  /**
   * @brief Retrieves the data point elements for the trend.
   *
   * @return A dynamic string containing the data point elements.
   */
  protected dyn_string getTrendDpes()
  {
    return makeDynString();
  }

  /**
   * @brief Connects the trend to the data point elements.
   */
  private void connectTrend()
  {
    removeCurves();
    int area = 0;
    dyn_string dpes = getTrendDpes();

    int size = dpes.count();

    for (int i = 0; i < size; i++)
    {
      string curve = dpSubStr(dpes.at(i), DPSUB_SYS_DP_EL) + ":_online.._value";
      _trend.addCurve(area, curve);
      _trend.curveLegendName(curve, dpGetDescription(curve));
      _trend.curveScaleVisibility(curve, TRUE);
      _trend.curveAutoscale(curve, TRUE);
      _trend.connectDirectly(curve, curve);
    }
  }

  /**
   * @brief Removes all curves from the trend.
   */
  private void removeCurves()
  {
    dyn_string curves = _trend.curveNames(0);

    int size = curves.count();

    for (int i = 0; i < size; i++)
    {
      _trend.removeCurve(curves.at(i));
    }
  }
};
