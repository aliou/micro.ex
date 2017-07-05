defmodule Micro do
  @moduledoc false

  defmodule Router do
    @moduledoc """
    The router for the Micro application. This will dispatch the actual routes
    to other plugs.
    """

    use Plug.Router

    alias Micro.{Post, Repo}

    plug Logster.Plugs.Logger
    plug :match
    plug :dispatch

    forward "/feed.json", to: Feed.Router,
      init_opts: [feed_builder: Micro.FeedBuilder]

    # TODO: Extract this into its own router, and forward requests from `/p/?*`
    # to it.
    get "/p/:id" do
      case Repo.get(Post, conn.params["id"]) do
        # TODO: This feels weird? But I don't think there are other ways to
        # pattern match on a type.
        %Post{} = post -> resp_html(conn, Post.content_to_html(post))
        nil            -> send_resp(conn, 404, "")
      end
    end

    match _ do
      send_resp(conn, 404, "")
    end

    defp resp_html(conn, content, status \\ 200) do
      conn
      |> put_resp_content_type("text/html")
      |> send_resp(status, content)
    end
  end
end
