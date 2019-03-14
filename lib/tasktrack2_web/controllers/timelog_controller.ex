defmodule Tasktrack2Web.TimelogController do
  use Tasktrack2Web, :controller

  alias Tasktrack2.Timelogs
  alias Tasktrack2.Timelogs.Timelog

  action_fallback Tasktrack2Web.FallbackController

  def index(conn, _params) do
    timelogs = Timelogs.list_timelogs()
    render(conn, "index.json", timelogs: timelogs)
  end

  def create(conn, %{"timelog" => timelog_params}) do
    with {:ok, %Timelog{} = timelog} <- Timelogs.create_timelog(timelog_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.timelog_path(conn, :show, timelog))
      |> render("show.json", timelog: timelog)
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
    timelog = Timelogs.get_timelog!(id)

    with {:ok, %Timelog{}} <- Timelogs.delete_timelog(timelog) do
      send_resp(conn, :no_content, "")
    end
  end
end
