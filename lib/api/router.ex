defmodule Micro.Api.Router do
  @moduledoc """
  The router handling the API web requests.
  """

  use Plug.Router

  plug Micro.Api.AuthorizedRequestPlug, api_key: "hey"
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison

  plug :match
  plug :dispatch

  post "/" do
    result =
      %Micro.Post{}
      |> Micro.Post.changeset(conn.params)
      |> Micro.Repo.insert

    case result do
      {:ok, post} ->
        conn
        |> send_resp(:created, Poison.encode!(post))
      {:error, _} ->
        conn
        |> send_resp(422, "{}")
    end
  end
end
