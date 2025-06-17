// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author m.woegrath
*/

#uses "classes/MtpViewModel/MtpViewModelBase"
#uses "classes/MtpView/MtpViewBase"

class MtpFaceplateTrendBase : MtpViewBase
{
  private shape _trend;
  protected MtpFaceplateTrendBase(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    connectTrend();
  }

  protected void initializeShapes() override
  {
    _trend = MtpViewBase::extractShape("_trend");
  }

  protected dyn_string getTrendDpes() = 0;

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
