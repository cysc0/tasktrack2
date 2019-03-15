defmodule Tasktrack2Web.UserController do
  use Tasktrack2Web, :controller

  alias Tasktrack2.Users
  alias Tasktrack2.Users.User

  def index(conn, _params) do
    users = Users.list_users()
    is_manager = Users.is_manager(conn.assigns.current_user.id)
    render(conn, "index.html", users: users, is_manager: is_manager)
  end

  def new(conn, _params) do
    is_manager = Users.is_manager(conn.assigns.current_user.id)
    userId = conn.assigns.current_user.id
    userList = [nil] ++ Users.get_other_user_names(userId)
    changeset = Users.change_user(%User{})
    render(conn, "new.html", is_manager: is_manager, changeset: changeset, userList: userList)
  end

  def create(conn, %{"user" => user_params}) do
    userList = Users.get_user_by_name(Map.get(user_params, "name"))
    if userList != nil do
      conn
      |> put_session(:user_id, userList.id)
      |> redirect(to: Routes.user_path(conn, :show, userList))
    else
      case Users.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> put_session(:user_id, user.id)
          |> redirect(to: Routes.user_path(conn, :show, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    underlings = Users.get_underlings(id)
    is_manager = Users.is_manager(conn.assigns.current_user.id)
    render(conn, "show.html", user: user, underlings: underlings, is_manager: is_manager)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    userList = [nil] ++ Users.get_other_user_names(id)
    changeset = Users.change_user(user)
    is_manager = Users.is_manager(conn.assigns.current_user.id)
    render(conn, "edit.html", user: user, is_manager: is_manager, userList: userList, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    is_manager = Users.is_manager(conn.assigns.current_user.id)
    userList = [nil] ++ Users.get_other_user_names(id)
    user = Users.get_user!(id)
    manager = Users.get_user_by_name(Map.get(user_params, "manager_id"))
    
    if manager == nil do
      # if we are removing a manager
      case Users.update_user(user, user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user, is_manager: is_manager))
  
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset, is_manager: is_manager, userList: userList)
      end
    else
      # if we are adding/changing manager
      case Users.update_user(user, Map.put(user_params, "manager_id", manager.id)) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user, is_manager: is_manager))
  
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset, is_manager: is_manager, userList: userList)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
