defmodule BankingengineWeb.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      BankingengineWeb.Telemetry,
      BankingengineWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: BankingengineWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    BankingengineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
