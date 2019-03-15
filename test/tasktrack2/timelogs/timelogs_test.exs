defmodule Tasktrack2.TimelogsTest do
  use Tasktrack2.DataCase

  alias Tasktrack2.Timelogs

  describe "timelogs" do
    alias Tasktrack2.Timelogs.Timelog

    @valid_attrs %{timestamp: ~N[2010-04-17 14:00:00]}
    @update_attrs %{timestamp: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{timestamp: nil}

    def timelog_fixture(attrs \\ %{}) do
      {:ok, timelog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timelogs.create_timelog()

      timelog
    end

    test "list_timelogs/0 returns all timelogs" do
      timelog = timelog_fixture()
      assert Timelogs.list_timelogs() == [timelog]
    end

    test "get_timelog!/1 returns the timelog with given id" do
      timelog = timelog_fixture()
      assert Timelogs.get_timelog!(timelog.id) == timelog
    end

    test "create_timelog/1 with valid data creates a timelog" do
      assert {:ok, %Timelog{} = timelog} = Timelogs.create_timelog(@valid_attrs)
      assert timelog.timestamp == ~N[2010-04-17 14:00:00]
    end

    test "create_timelog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timelogs.create_timelog(@invalid_attrs)
    end

    test "update_timelog/2 with valid data updates the timelog" do
      timelog = timelog_fixture()
      assert {:ok, %Timelog{} = timelog} = Timelogs.update_timelog(timelog, @update_attrs)
      assert timelog.timestamp == ~N[2011-05-18 15:01:01]
    end

    test "update_timelog/2 with invalid data returns error changeset" do
      timelog = timelog_fixture()
      assert {:error, %Ecto.Changeset{}} = Timelogs.update_timelog(timelog, @invalid_attrs)
      assert timelog == Timelogs.get_timelog!(timelog.id)
    end

    test "delete_timelog/1 deletes the timelog" do
      timelog = timelog_fixture()
      assert {:ok, %Timelog{}} = Timelogs.delete_timelog(timelog)
      assert_raise Ecto.NoResultsError, fn -> Timelogs.get_timelog!(timelog.id) end
    end

    test "change_timelog/1 returns a timelog changeset" do
      timelog = timelog_fixture()
      assert %Ecto.Changeset{} = Timelogs.change_timelog(timelog)
    end
  end

  describe "timelogs" do
    alias Tasktrack2.Timelogs.Timelog

    @valid_attrs %{timestamp: "2010-04-17T14:00:00Z"}
    @update_attrs %{timestamp: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{timestamp: nil}

    def timelog_fixture(attrs \\ %{}) do
      {:ok, timelog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timelogs.create_timelog()

      timelog
    end

    test "list_timelogs/0 returns all timelogs" do
      timelog = timelog_fixture()
      assert Timelogs.list_timelogs() == [timelog]
    end

    test "get_timelog!/1 returns the timelog with given id" do
      timelog = timelog_fixture()
      assert Timelogs.get_timelog!(timelog.id) == timelog
    end

    test "create_timelog/1 with valid data creates a timelog" do
      assert {:ok, %Timelog{} = timelog} = Timelogs.create_timelog(@valid_attrs)
      assert timelog.timestamp == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_timelog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timelogs.create_timelog(@invalid_attrs)
    end

    test "update_timelog/2 with valid data updates the timelog" do
      timelog = timelog_fixture()
      assert {:ok, %Timelog{} = timelog} = Timelogs.update_timelog(timelog, @update_attrs)
      assert timelog.timestamp == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_timelog/2 with invalid data returns error changeset" do
      timelog = timelog_fixture()
      assert {:error, %Ecto.Changeset{}} = Timelogs.update_timelog(timelog, @invalid_attrs)
      assert timelog == Timelogs.get_timelog!(timelog.id)
    end

    test "delete_timelog/1 deletes the timelog" do
      timelog = timelog_fixture()
      assert {:ok, %Timelog{}} = Timelogs.delete_timelog(timelog)
      assert_raise Ecto.NoResultsError, fn -> Timelogs.get_timelog!(timelog.id) end
    end

    test "change_timelog/1 returns a timelog changeset" do
      timelog = timelog_fixture()
      assert %Ecto.Changeset{} = Timelogs.change_timelog(timelog)
    end
  end

  describe "timelogs" do
    alias Tasktrack2.Timelogs.Timelog

    @valid_attrs %{timeend: "2010-04-17T14:00:00Z", timestart: "2010-04-17T14:00:00Z"}
    @update_attrs %{timeend: "2011-05-18T15:01:01Z", timestart: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{timeend: nil, timestart: nil}

    def timelog_fixture(attrs \\ %{}) do
      {:ok, timelog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Timelogs.create_timelog()

      timelog
    end

    test "list_timelogs/0 returns all timelogs" do
      timelog = timelog_fixture()
      assert Timelogs.list_timelogs() == [timelog]
    end

    test "get_timelog!/1 returns the timelog with given id" do
      timelog = timelog_fixture()
      assert Timelogs.get_timelog!(timelog.id) == timelog
    end

    test "create_timelog/1 with valid data creates a timelog" do
      assert {:ok, %Timelog{} = timelog} = Timelogs.create_timelog(@valid_attrs)
      assert timelog.timeend == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert timelog.timestart == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_timelog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timelogs.create_timelog(@invalid_attrs)
    end

    test "update_timelog/2 with valid data updates the timelog" do
      timelog = timelog_fixture()
      assert {:ok, %Timelog{} = timelog} = Timelogs.update_timelog(timelog, @update_attrs)
      assert timelog.timeend == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert timelog.timestart == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_timelog/2 with invalid data returns error changeset" do
      timelog = timelog_fixture()
      assert {:error, %Ecto.Changeset{}} = Timelogs.update_timelog(timelog, @invalid_attrs)
      assert timelog == Timelogs.get_timelog!(timelog.id)
    end

    test "delete_timelog/1 deletes the timelog" do
      timelog = timelog_fixture()
      assert {:ok, %Timelog{}} = Timelogs.delete_timelog(timelog)
      assert_raise Ecto.NoResultsError, fn -> Timelogs.get_timelog!(timelog.id) end
    end

    test "change_timelog/1 returns a timelog changeset" do
      timelog = timelog_fixture()
      assert %Ecto.Changeset{} = Timelogs.change_timelog(timelog)
    end
  end
end
