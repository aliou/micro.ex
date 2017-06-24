use Mix.Config

config :micro, Micro.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "micro_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :micro, Micro.Router,
  port: 4001
