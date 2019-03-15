defmodule Tasktrack2Web.PageController do
    use Tasktrack2Web, :controller
    alias Tasktrack2.Users
  
    def index(conn, _params) do
      # hide the task report for non-managers and non-users
      if conn.assigns.current_user == nil do
        render(conn, "index.html", is_manager: false)
      else
        is_manager = Users.is_manager(conn.assigns.current_user.id)
        render(conn, "index.html", is_manager: is_manager)
      end
    end
  end
  