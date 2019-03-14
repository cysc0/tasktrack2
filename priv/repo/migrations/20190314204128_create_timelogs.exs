defmodule Tasktrack2.Repo.Migrations.CreateTimelogs do
  use Ecto.Migration

  def change do
    create table(:timelogs) do
      add :timestamp, :utc_datetime
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:timelogs, [:task_id])
  end
end
