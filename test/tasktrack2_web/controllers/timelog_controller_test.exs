defmodule Tasktrack2Web.TimelogControllerTest do
  use Tasktrack2Web.ConnCase

  alias Tasktrack2.Timelogs
  alias Tasktrack2.Timelogs.Timelog

  @create_attrs %{
    timestamp: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    timestamp: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{timestamp: nil}

  def fixture(:timelog) do
    {:ok, timelog} = Timelogs.create_timelog(@create_attrs)
    timelog
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all timelogs", %{conn: conn} do
      conn = get(conn, Routes.timelog_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create timelog" do
    test "renders timelog when data is valid", %{conn: conn} do
      conn = post(conn, Routes.timelog_path(conn, :create), timelog: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.timelog_path(conn, :show, id))

      assert %{
               "id" => id,
               "timestamp" => "2010-04-17T14:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.timelog_path(conn, :create), timelog: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update timelog" do
    setup [:create_timelog]

    test "renders timelog when data is valid", %{conn: conn, timelog: %Timelog{id: id} = timelog} do
      conn = put(conn, Routes.timelog_path(conn, :update, timelog), timelog: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.timelog_path(conn, :show, id))

      assert %{
               "id" => id,
               "timestamp" => "2011-05-18T15:01:01Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, timelog: timelog} do
      conn = put(conn, Routes.timelog_path(conn, :update, timelog), timelog: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete timelog" do
    setup [:create_timelog]

    test "deletes chosen timelog", %{conn: conn, timelog: timelog} do
      conn = delete(conn, Routes.timelog_path(conn, :delete, timelog))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.timelog_path(conn, :show, timelog))
      end
    end
  end

  defp create_timelog(_) do
    timelog = fixture(:timelog)
    {:ok, timelog: timelog}
  end
end
