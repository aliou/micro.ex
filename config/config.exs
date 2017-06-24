# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Tell ecto what our repos are so the task work correctly.
config :micro, ecto_repos: [Micro.Repo]

config :micro, Micro.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "micro_repo",
  hostname: "localhost"
