# Tasktrack2

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tasktrack2` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tasktrack2, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tasktrack2](https://hexdocs.pm/tasktrack2).

------

# Design Decisions etc.

### User Info
  For non-admins, the user page only displays username and admin status
  For admins, they have the option to edit any user's name or delete them.
  I've seeded 3 admin users, admin1, admin2, admin3 for demonstration purposes.
  Admins can only be edited or deleted by themselves.

  The user page displays all registered users, with each username
  serving as a link to that user's info.

  A user is able to edit themselves, and choose who their manager is.

  The Task Report link will only be showed to a user if they have
  members signed up on their team (people they manage).

### Task Info
  The main task page displays all tasks for all users. Each task offers
  a link to the corresponding user's page, and a link to the corresponding task.

  The My Tasks page is the same as the Tasks page, but it filters tasks
  for the currently signed in user. This route is disabled if there is no
  active user session.

  For timelogs, a user can create timelogs manually by editing a task
  and entering a start and end time.

  Timelogs can be deleted individually from the task edit page.

  On the task show page, there is a start working button (if that task
  belongs to the current user). When the user clicks start,
  the current time will be saved, and when the user clicks the end button,
  the current time will be saved. This data will be send to the DB,
  and the page will be reloaded to reflect that new timelog.