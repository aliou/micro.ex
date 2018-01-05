defmodule Micro.Router do
  @moduledoc """
  The router for the Micro application. This will dispatch the actual routes
  to other plugs.
  """

  use Plug.Router
  import Micro.Router.Utils, only: [redirect: 2, not_found: 1]

  if Mix.env() != :test do
    plug Logster.Plugs.Logger
  end

  plug :match
  plug :dispatch

  forward "/feed.json",
    to: Feed.Router,
    init_opts: [feed_builder: Micro.FeedBuilder]

  forward "/p", to: Micro.Post.Router
  redirect "/", to: "/p"

  match _, do: not_found(conn)
end
