alias Tasktrack2.Repo
alias Tasktrack2.Users.User


Repo.insert(%User{name: "admin1", admin: true})
Repo.insert(%User{name: "admin2", admin: true})
Repo.insert(%User{name: "admin3", admin: true})
