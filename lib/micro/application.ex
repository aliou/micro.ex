defmodule Micro.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Micro.Repo,
      {
        Plug.Adapters.Cowboy,
        scheme: :http, plug: Micro.Router, options: [port: port()]
      }
    ]

    opts = [strategy: :one_for_one, name: Micro.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp port, do: Application.get_env(:micro, Micro.Router)[:port] || 4000
end
