defmodule TasktrackWeb.SessionController do
    use TasktrackWeb, :controller

    def create(conn, %{"name" => name}) do
      user = Tasktrack.Users.get_user_by_name(name)
      if user do
        conn
        |> put_session(:user_id, user.id)
        # |> put_flash(:info, "Welcome back #{user.name}") # deleting since it flashes for like 1 ms
        |> redirect(to: Routes.page_path(conn, :index))
      else
        conn
        |> put_flash(:error, "Login failed")
        |> redirect(to: Routes.page_path(conn, :index))
      end
    end
  
    def delete(conn, _params) do
      conn
      |> delete_session(:user_id)
      |> put_flash(:info, "Logged out.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end