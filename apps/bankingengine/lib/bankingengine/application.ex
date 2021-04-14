defmodule Bankingengine.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Bankingengine.Repo,
      {Phoenix.PubSub, name: Bankingengine.PubSub}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Bankingengine.Supervisor)
  end
end
