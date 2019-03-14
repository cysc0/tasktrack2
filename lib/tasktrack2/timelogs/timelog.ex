defmodule Tasktrack2.Timelogs.Timelog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timelogs" do
    field :timestart, :utc_datetime
    field :timeend, :utc_datetime
    belongs_to :task, Tasktrack2.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(timelog, attrs) do
    timelog
    |> cast(attrs, [:timestart, :timeend])
    |> validate_required([:timestart, :timeend])
  end
end
