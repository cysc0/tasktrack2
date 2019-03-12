defmodule Tasktrack2Web.PageController do
    use Tasktrack2Web, :controller
    alias Tasktrack2.Users
  
    def index(conn, _params) do
      # hide the task report for non-managers and non-users
      is_manager = Users.is_manager(Map.get(conn.private.plug_session, "user_id"))
      render(conn, "index.html", is_manager: is_manager)
    end
  end
  