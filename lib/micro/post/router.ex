defmodule Micro.Post.Router do
  use Plug.Router

  import Micro.Router.Utils, only: [not_found: 1, resp_html: 2]

  plug :match
  plug :dispatch

  get "/" do
    posts =
      conn
      |> extract_page_number
      |> Micro.Posts.paginated_posts()

    render(conn, "posts", posts: posts, pagination: %{})
  end

  # TODO: Redirect to the slug if present ?
  get "/:id" do
    case Micro.Posts.friendly_find(conn.params["id"]) do
      :not_found ->
        not_found(conn)

      {:ok, post} ->
        render(conn, "post", post)
    end
  end

  match _, do: not_found(conn)

  # TODO: better than this pls
  defp extract_page_number(conn) do
    conn = Plug.Conn.fetch_query_params(conn)
    Map.get(conn.query_params, "page", "1") |> String.to_integer()
  end

  defp render(conn, template, variable) do
    conn |> resp_html(Micro.Template.render(template, variable))
  end
end
