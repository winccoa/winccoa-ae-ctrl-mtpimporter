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
 * @class MtpFaceplateAlarm
 * @brief Represents the alarm faceplate functionality in the MTP library.
 */
class MtpFaceplateAlarm : MtpViewBase
{
  private shape _table; //!< The table shape used in the faceplate for displaying alarms.

  /**
   * @brief Constructor for MtpFaceplateAlarm.
   *
   * @param viewModel A shared pointer to the view model.
   * @param shapes A mapping of shapes used in the faceplate.
   */
  public MtpFaceplateAlarm(shared_ptr<MtpViewModelBase> viewModel, const mapping &shapes) : MtpViewBase(viewModel, shapes)
  {
    connectAlerts();
  }

  /**
   * @brief Handles row click events in the alarm table.
   *
   * @param column The column that was clicked.
   * @param row The row that was clicked.
   * @param value The value of the clicked cell.
   */
  public void clickRow(const string &column, const int &row, const string &value)
  {
    switch (column)
    {
      case "ack":
      {
        acknowledgeAlert(row, value);
        break;
      }

      default: break;
    }
  }

  /**
   * @brief Initializes the shapes used in the faceplate.
   * @details This method overrides the base class method to extract the table shape.
   */
  protected void initializeShapes() override
  {
    _table = MtpViewBase::extractShape("_table");
  }

  /**
   * @brief Acknowledges an alert in the alarm table.
   *
   * @param row The row of the alert to acknowledge.
   * @param value The value of the alert.
   */
  private void acknowledgeAlert(const int &row, const string &value)
  {
    string token = UDA_noAck_Token;

    if (strltrim(strrtrim(value)) == strltrim(strrtrim(token)))
    {
      return;
    }

    ep_acknowledgeTableFunction(_table.name(), "1", "dpekey", "time", "count", "ackable", row, row);
  }

  /**
   * @brief Connects the alert signals to their respective slots.
   */
  private void connectAlerts()
  {
    string dp = MtpViewBase::getViewModel().getDp();
    string systemName = dpSubStr(dp, DPSUB_SYS);

    string attributes = "'_alert_hdl.._prior', '_alert_hdl.._text', '_alert_hdl.._direction', '_alert_hdl.._ackable','_alert_hdl.._ack', " +
                        "'_alert_hdl.._ack_state', '_alert_hdl.._alert_color','_alert_hdl.._oldest_ack', '_alert_hdl.._obsolete', '_alert_hdl.._value', " +
                        "'_alert_hdl.._alert_fore_color', '_alert_hdl.._visible', '_alert_hdl.._class'";

    string from = dp + ".**";
    string query = "SELECT ALERT " + attributes + " FROM '" + from + "' WHERE  ('_alert_hdl.._sum' == 0)";
    query += (systemName == getSystemName()) ? "" : " REMOTE '" + systemName + "' ";

    dpQueryConnectSingle("alertCB", TRUE, dp, query);
  }

  /**
   * @brief Callback function for alert updates.
   *
   * @param dp The data point associated with the alert.
   * @param result The result set containing alert information.
   */
  private void alertCB(const string &dp, const dyn_dyn_anytype &result)
  {
    dyn_dyn_anytype updateList, deleteList;

    int size = result.count();

    for (int i = 1; i < size; i++)
    {
      if ((bool)result.at(i).at(5)) //ackable
      {
        alertCBUpdate(result.at(i), updateList, TRUE, deleteList);
      }
      else if ((bool)result.at(i).at(4) == FALSE) //direction == went
      {
        alertCBDelete(result.at(i), deleteList);
      }
      else if ((bool)result.at(i).at(10) == FALSE) //obsolete
      {
        alertCBUpdate(result.at(i), updateList, FALSE, deleteList);
      }
      else if ((bool)result.at(i).at(13) == FALSE) //remove invisible alarms
      {
        alertCBDelete(result.at(i), deleteList);
      }
    }

    if (updateList.count() > 0)
    {
      setValue(_table, "updateLines", 3, "dpekey", updateList[1], "time", updateList[2], "count", updateList[11],
               "dpe", updateList[3], "alertText", updateList[4], "ack", updateList[5], "detail", updateList[7], "prio", updateList[8],
               "quitt", updateList[9], "value", updateList[10], "direction", updateList[12], "ackable", updateList[13]);
    }

    if (deleteList.count() > 0)
    {
      setValue(_table, "deleteLines", 3, "dpekey", deleteList[1], "time", deleteList[2], "count", deleteList[3]);
    }

    setValue(_table, "sort", makeDynBool(FALSE, FALSE), "time", "quitt"); //first alert is : youngest, ackable
  }

  /**
   * @brief Updates the alert information in the alarm table.
   *
   * @param result The result set containing the updated alert information.
   * @param updateList The list of alerts to update.
   * @param alertIsAckable Indicates if the alert is ackable.
   * @param deleteList The list of alerts to delete.
   */
  private void alertCBUpdate(const dyn_anytype &result, dyn_dyn_anytype &updateList, const bool &alertIsAckable, dyn_dyn_anytype &deleteList)
  {
    if (result.at(8) == "") //no alert color
    {
      alertCBDelete(result, deleteList);
      return;
    }

    bool oldestAck = (bool)result.at(9);

    int i = -1;

    if (updateList.count())
    {
      i = updateList.at(0).indexOf(dpSubStr(result.at(0), DPSUB_SYS_DP_EL));
    }

    if (i < 0)
    {
      i = (updateList.count()) ? (updateList.at(0).count()) : 0; //DP not found in update-array
      appendEmptyAlert(updateList, 14);
    }

    updateList.at(0).at(i) = getAIdentifier(result.at(1));//alert identifier

    updateList.at(1).at(i) = (time)result.at(1);//alert time

    string description = dpGetDescription(dpSubStr(result.at(0), DPSUB_SYS_DP_EL));

    updateList.at(2).at(i) = (description != "") ? description : dpSubStr(result[1], DPSUB_DP_EL); //DPE without System name

    updateList.at(3).at(i) = makeDynString(result.at(3), result.at(8), result.at(12)); //alert text + alert color + alert forecolor

    if (alertIsAckable)
    {
      updateList.at(4).at(i) = makeDynString("!!!", (oldestAck ? "weiss" : "_3DFace"), "rot");
      updateList.at(8).at(i) = oldestAck ? "B" : "A"; //flag for table sort
    }
    else
    {
      updateList.at(4).at(i) = makeDynString((result.at(6) == DPATTR_ACKTYPE_MULTIPLE) ? "xxx" : "x", "_3DFace", "black"); //single or multiple acknowledged
      updateList.at(9).at(i) = "A";//flag for table sort
    }

    updateList.at(12).at(i) = alertIsAckable;

    updateList.at(5).at(i) = (bool)result.at(4) ? getCatStr("sc", "entered") : getCatStr("sc", "left"); //direction

    updateList.at(6).at(i) = "...";
    updateList.at(7).at(i) = makeDynString((int)result.at(2), result.at(8), result.at(12)); //prio + alert color + alert forecolor
    updateList.at(9).at(i) = (string)result.at(11);//value
    updateList.at(10).at(i) = (string)getACount(result.at(1));//alert count
    updateList.at(11).at(i) = getCatStr("sc", ((bool)result.at(4) ? "entered" : "left")); //direction
    updateList.at(13).at(i) = result.at(14);
  }

  /**
   * @brief Callback function for alert deletion.
   *
   * @param result The result set containing alert information.
   * @param deleteList The list of alerts to delete.
   */
  private void alertCBDelete(const dyn_anytype &result, dyn_dyn_anytype &deleteList)
  {
    int i = -1;

    if (deleteList.count())
    {
      i = deleteList.at(0).indexOf(dpSubStr(result[1], DPSUB_SYS_DP_EL));
    }

    if (i < 0)
    {
      i = (deleteList.count()) ? (deleteList.at(0).count()) : 0; //DP not found in update-array
      appendEmptyAlert(deleteList, 3);
    }

    deleteList.at(0).at(i) = getAIdentifier(result.at(1)); //alert identifier
    deleteList.at(1).at(i) = (time)result.at(1); //alert time
    deleteList.at(2).at(i) = getACount(result.at(1));
  }

  /**
   * @brief Appends an empty alert to the specified list.
   *
   * @param list The list to append the empty alert to.
   * @param size The size of the alert.
   */
  private void appendEmptyAlert(dyn_dyn_anytype &list, const int &size)
  {
    while (list.count() < size)
    {
      list.append(makeDynAnytype());
    }

    for (int i = 0; i < size; i++)
    {
      anytype temp;
      list.at(i).append(temp);
    }
  }
};
