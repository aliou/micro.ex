defmodule Micro.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto Repo with the application.
      supervisor(Micro.Repo, []),

      # Start the web app through the router.
      Plug.Adapters.Cowboy.child_spec(
        :http, Micro.Router, [], [
          port: Application.get_env(:micro, Micro.Router)[:port]
        ]
      ),
    ]

    opts = [strategy: :one_for_one, name: Micro.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
