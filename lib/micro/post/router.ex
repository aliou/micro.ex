defmodule Micro.Post.Router do
  use Plug.Router

  import Micro.Router.Utils, only: [not_found: 1, resp_html: 2]
  alias Micro.{Post, Repo}

  if Mix.env() != :test do
    plug Logster.Plugs.Logger
  end

  plug :match
  plug :dispatch

  get "/" do
    resp_html(conn, "<h3>A list of posts</h3>")
  end

  get "/:id" do
    case Repo.get(Post, conn.params["id"]) do
      nil -> not_found(conn)
      post -> resp_html(conn, Post.content_to_html(post))
    end
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
