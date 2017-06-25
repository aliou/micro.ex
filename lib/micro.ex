defmodule Micro do
  @moduledoc false

  defmodule Router do
    @moduledoc """
    The router for the Micro application. This will dispatch the actual routes
    to other plugs.
    """

    use Plug.Router

    plug Logster.Plugs.Logger
    plug :match
    plug :dispatch

    match _ do
      send_resp(conn, 404, "")
    end
  end
end
