defmodule Tasktrack2.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :admin, :boolean, default: false, null: false
      add :underlings_id, references(:users, on_delete: :delete_all), null: true
      add :manager_id, references(:users, on_delete: :delete_all), null: true
      # add :underlings, references(:users), default: nil, null: true
      # add :manager, references(:users), default: nil, null: true

      timestamps()
    end

  end
end
