import Config

config :bankingengine,
  ecto_repos: [Bankingengine.Repo]

config :bankingengine_web,
  ecto_repos: [Bankingengine.Repo],
  generators: [context_app: :bankingengine, binary_id: true]

config :bankingengine_web, BankingengineWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v1LmcTikS78mNaKVkbWGR1QWK/f86qD8klBSeQ05Y3i9WScFpIIFcdNIoAV1g7Ot",
  render_errors: [view: BankingengineWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Bankingengine.PubSub,
  live_view: [signing_salt: "/llJjtAR"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
