defmodule Eco.Repo do
  use Ecto.Repo,
    otp_app: :eco,
    adapter: Ecto.Adapters.Postgres
end
