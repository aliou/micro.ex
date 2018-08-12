defmodule Micro.Post.Router do
  use Plug.Router

  import Micro.Router.Utils, only: [not_found: 1, resp_html: 2]
  alias Micro.Post

  if Mix.env() != :test do
    plug Logster.Plugs.Logger
  end

  plug :match
  plug :dispatch

  get "/" do
    resp_html(conn, "<h3>A list of posts</h3>")
  end

  # TODO: Redirect to the slug if present ?
  get "/:id" do
    case Micro.Posts.friendly_find(conn.params["id"]) do
      :not_found -> not_found(conn)
      {:ok, post} -> resp_html(conn, Post.content_to_html(post))
    end
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
