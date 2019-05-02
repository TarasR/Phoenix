defmodule Tphx.Repo do
  use Ecto.Repo,
    otp_app: :tphx,
    adapter: Ecto.Adapters.Postgres
end
