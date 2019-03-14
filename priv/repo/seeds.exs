alias Tasktrack2.Repo
alias Tasktrack2.Users.User
alias Tasktrack2.Tasks.Task
alias Tasktrack2.Timelogs.Timelog

admin1 = %User{name: "admin1", admin: true}

# Repo.insert(admin1)
Repo.insert(%User{name: "admin2", admin: true})
# Repo.insert(%User{name: "admin3", admin: true, manager: admin1})

task1 = %Task{complete: false, title: "sampletask", description: "a sample task", user: admin1}

{_, atime} = DateTime.now("Etc/UTC")
time1 = %Timelog{timestamp: atime, task: task1}

# Repo.insert(admin1)

Repo.insert(time1)