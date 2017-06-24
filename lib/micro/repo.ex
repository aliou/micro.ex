defmodule Micro.Repo do
  # Give Ecto the otp app, so it can look for the database credential in the app
  # configuration.
  use Ecto.Repo, otp_app: :micro
end
