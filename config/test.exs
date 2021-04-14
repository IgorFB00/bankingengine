import Config

config :bankingengine, Bankingengine.Repo,
  username: "postgres",
  password: "postgres",
  database: "bankingengine_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :bankingengine_web, BankingengineWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
