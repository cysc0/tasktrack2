defmodule Tasktrack2Web.TimelogView do
  use Tasktrack2Web, :view
  alias Tasktrack2Web.TimelogView

  def render("index.json", %{timelogs: timelogs}) do
    %{data: render_many(timelogs, TimelogView, "timelog.json")}
  end

  def render("show.json", %{timelog: timelog}) do
    %{data: render_one(timelog, TimelogView, "timelog.json")}
  end

  def render("timelog.json", %{timelog: timelog}) do
    %{id: timelog.id,
      timestamp: timelog.timestamp}
  end
end
