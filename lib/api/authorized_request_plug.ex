defmodule Micro.Api.AuthorizedRequestPlug do
  @moduledoc """
  Plug checking if the given request is authorized. Halts the request if not.
  """

  import Plug.Conn, only: [halt: 1, send_resp: 3]

  def init(options) do
    options
  end

  def call(%Plug.Conn{req_headers: headers} = conn, options) do
    with authorization_header <- List.keyfind(headers, "authorization", 0),
         {"authorization", api_key} <- authorization_header,
         ^api_key <- options[:api_key] do
      conn
    else
      _ ->
        conn |> send_resp(403, "") |> halt()
    end
  end
end
