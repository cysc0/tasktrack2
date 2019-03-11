alias Tasktrack2.Repo
alias Tasktrack2.Users.User

admin1 = %User{name: "admin1", admin: true}

# Repo.insert(admin1)
Repo.insert(%User{name: "admin2", admin: true})
Repo.insert(%User{name: "admin3", admin: true, manager: admin1})