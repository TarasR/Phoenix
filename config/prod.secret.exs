use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :tphx, TphxWeb.Endpoint,
  secret_key_base: "rYVMZLp7cUl5JVlt3rbtlG6cJWw6MrzYvuJqvwFKQ26vZXRxr9pACH0M+iPiPJ7j"

# Configure your database
config :tphx, Tphx.Repo,
  username: "postgres",
  password: "rtv82727",
  database: "tphx_prod",
  pool_size: 15
