use Mix.Config

config :micro, Micro.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "micro_test",
  hostname: "localhost"
