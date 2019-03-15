defmodule Tasktrack2Web.TimelogController do
  use Tasktrack2Web, :controller

  alias Tasktrack2.Timelogs
  alias Tasktrack2.Timelogs.Timelog

  alias Tasktrack2.Tasks
  alias Tasktrack2.Users

  action_fallback Tasktrack2Web.FallbackController

  def index(conn, _params) do
    timelogs = Timelogs.list_timelogs()
    render(conn, "index.json", timelogs: timelogs)
  end

  def create(conn, %{"timelog" => timelog_params}) do
    curTask = Tasks.get_task!(Map.get(timelog_params, "task_id"))
    is_manager = Users.is_manager(Map.get(conn.assigns.current_user.id, "user_id"))

    timeend_year = String.to_integer(String.slice(Map.get(timelog_params, "timeend"), 0..3))
    timeend_mon = String.to_integer(String.slice(Map.get(timelog_params, "timeend"), 5..6))
    timeend_day = String.to_integer(String.slice(Map.get(timelog_params, "timeend"), 8..9))
    timeend_hour = String.to_integer(String.slice(Map.get(timelog_params, "timeend"), 11..12))
    timeend_min = String.to_integer(String.slice(Map.get(timelog_params, "timeend"), 14..16))
    timestart_year = String.to_integer(String.slice(Map.get(timelog_params, "timestart"), 0..3))
    timestart_mon = String.to_integer(String.slice(Map.get(timelog_params, "timestart"), 5..6))
    timestart_day = String.to_integer(String.slice(Map.get(timelog_params, "timestart"), 8..9))
    timestart_hour = String.to_integer(String.slice(Map.get(timelog_params, "timestart"), 11..12))
    timestart_min = String.to_integer(String.slice(Map.get(timelog_params, "timestart"), 14..16))
    
    timestart = %DateTime{year: timestart_year, month: timestart_mon, day: timestart_day,
                          hour: timestart_hour, minute: timestart_min, second: 0,
                          time_zone: "Etc/UTC", zone_abbr: "CET", utc_offset: 0, std_offset: 0}
    timeend = %DateTime{year: timeend_year, month: timeend_mon, day: timeend_day,
                        hour: timeend_hour, minute: timeend_min, second: 0,
                        time_zone: "Etc/UTC", zone_abbr: "CET", utc_offset: 0, std_offset: 0}


    with {:ok, %Timelog{} = timelog} <- Timelogs.create_timelog(Map.put(Map.put(timelog_params, "timeend", timeend), "timestart", timestart)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, curTask))
      |> redirect(to: Routes.task_path(conn, :show, curTask, is_manager: is_manager))
    end
  end

  def show(conn, %{"id" => id}) do
    timelog = Timelogs.get_timelog!(id)
    render(conn, "show.json", timelog: timelog)
  end

  def update(conn, %{"id" => id, "timelog" => timelog_params}) do
    timelog = Timelogs.get_timelog!(id)

    with {:ok, %Timelog{} = timelog} <- Timelogs.update_timelog(timelog, timelog_params) do
      render(conn, "show.json", timelog: timelog)
    end
  end

  def delete(conn, %{"id" => id}) do
    timelog = Timelogs.get_timelog!(String.to_integer(id))

    with {:ok, %Timelog{}} <- Timelogs.delete_timelog(timelog) do
      send_resp(conn, :no_content, "")
    end
  end
end
