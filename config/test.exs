use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tasktrack2, Tasktrack2Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tasktrack2, Tasktrack2.Repo,
  username: "tasktrack2",
  password: "rish8Oob0Een",
  database: "tasktrack2_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
