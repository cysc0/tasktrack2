defmodule Tasktrack2Web.TaskController do
  use Tasktrack2Web, :controller

  alias Tasktrack2.Tasks
  alias Tasktrack2.Tasks.Task
  alias Tasktrack2.Users

  def index(conn, _params) do
    IO.write("JREIOASJFIOSJFJIOJOInooooo")
    tasks = Tasks.list_tasks()
    is_manager = Users.is_manager(Map.get(conn.private.plug_session, "user_id"))
    render(conn, "index.html", tasks: tasks, is_manager: is_manager)
  end

  def new(conn, _params) do
    userList = Users.get_user_names()
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, userList: userList)
  end

  def create(conn, %{"task" => task_params}) do
    task_params = Map.replace(task_params, "user_id", Integer.to_string(Users.get_user_by_name(Map.get(task_params, "user_id")).id))
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    {curPath, _} = List.pop_at(String.split(conn.request_path, "/"), 1)
    {uid, _} = Integer.parse(id)
    if String.equivalent?(curPath, "mytasks") do
      # if we are showing all of one's users tasks, generate many results
      tasks = Tasks.list_tasks_by_id(uid)
      is_manager = Users.is_manager(Map.get(conn.private.plug_session, "user_id"))
      render(conn, "index.html", tasks: tasks, is_manager: is_manager)
    else
      # otherwise ...
      if String.equivalent?(curPath, "taskreport") do
        # if task report page
        tasks = Tasks.list_tasks_by_manager_id(uid)
        is_manager = Users.is_manager(Map.get(conn.private.plug_session, "user_id"))
        render(conn, "index.html", tasks: tasks, is_manager: is_manager)
      else
        # otherwise show a single task
        task = Tasks.get_task!(id)
        render(conn, "show.html", task: task)
      end
    end
  end

  def edit(conn, %{"id" => id}) do
    userList = Users.get_user_names()
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, userList: userList)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    {taskNum, _} = Integer.parse(id)
    task = Tasks.get_task!(taskNum)
    userList = Users.get_user_names()
    task_params = Map.replace(task_params, "user_id", Integer.to_string(Users.get_user_by_name(Map.get(task_params, "user_id")).id))
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, userList: userList)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
