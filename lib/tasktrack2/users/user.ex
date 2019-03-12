defmodule Tasktrack2.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :admin, :boolean, default: false
    field :name, :string
    has_many :tasks, Tasktrack2.Tasks.Task
    has_many :underlings, Tasktrack2.Users.User
    belongs_to :manager, Tasktrack2.Users.User

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :admin, :manager_id])
    |> validate_required([:name, :admin])
  end
end
