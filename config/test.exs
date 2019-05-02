use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tphx, TphxWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tphx, Tphx.Repo,
  username: "postgres",
  password: "rtv82727",
  database: "tphx_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
  #config :comeonin, bcrypt_log_rounds: 4
