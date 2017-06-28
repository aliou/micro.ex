defmodule Feed.Router do
  @moduledoc """
  The router handling the Feed web requests.
  """

  use Plug.Router

  plug :match
  plug :dispatch

  def call(conn, options) do
    builder = Keyword.fetch!(options, :feed_builder)
    conn = put_private(conn, :feed_builder, builder)

    super(conn, options)
  end

  get "/" do
    builder = conn.private.feed_builder
    feed = builder.build_feed()
    entries = builder.build_entries()

    feed = %{feed | entries: entries}

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(feed))
  end
end
