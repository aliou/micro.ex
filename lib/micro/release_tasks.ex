defmodule Micro.ReleaseTasks do
  @moduledoc """
  Define a custom task to run with releases. In our case, this is a migration
  task.

  This follows the distillery documentation: <https://hexdocs.pm/distillery/running-migrations.html>
  """
  @start_apps [
    :postgrex,
    :ecto,
    :ssl,
    :crypto
  ]

  @myapps [
    :micro
  ]

  @repos [
    Micro.Repo
  ]

  def migrate do
    IO.puts("Loading myapp..")
    # Load the code for myapp, but don't start it
    :ok = Application.load(:micro)

    IO.puts("Starting dependencies..")
    # Start apps necessary for executing migrations
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    # Start the Repo(s) for myapp
    IO.puts("Starting repos..")
    Enum.each(@repos, & &1.start_link(pool_size: 1))

    # Run migrations
    Enum.each(@myapps, &run_migrations_for/1)

    # Signal shutdown
    IO.puts("Success!")
    :init.stop()
  end

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

  defp run_migrations_for(app) do
    IO.puts("Running migrations for #{app}")
    Ecto.Migrator.run(Micro.Repo, migrations_path(app), :up, all: true)
  end

  defp migrations_path(app), do: Path.join([priv_dir(app), "repo", "migrations"])
end
