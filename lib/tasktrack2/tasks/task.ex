defmodule Tasktrack2.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :complete, :boolean, default: false
    field :title, :string, default: ""
    field :description, :string
    has_many :timelogs, Tasktrack2.Timelogs.Timelog
    belongs_to :user, Tasktrack2.Users.User
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:complete, :title, :description, :user_id])
    |> validate_required([:complete, :title, :description, :user_id])
  end
end
