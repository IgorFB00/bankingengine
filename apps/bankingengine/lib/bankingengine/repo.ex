defmodule Bankingengine.Repo do
  use Ecto.Repo,
    otp_app: :bankingengine,
    adapter: Ecto.Adapters.Postgres
end
