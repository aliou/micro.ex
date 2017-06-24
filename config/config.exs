# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Tell ecto what our repos are so the task work correctly.
config :micro, ecto_repos: [Micro.Repo]

# Per environment configuration.
import_config "#{Mix.env}.exs"
