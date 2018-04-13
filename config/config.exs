# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Tell ecto what our repos are so the task work correctly.
config :micro, ecto_repos: [Micro.Repo]

# Tell the router what port to run on. This is overriden in the test
# environemnt.
config :micro, Micro.Router,
  port: String.to_integer(System.get_env("PORT") || "4000")

# Per environment configuration.
import_config "#{Mix.env()}.exs"
