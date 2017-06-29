defmodule Micro.FeedBuilder do
  @moduledoc """
  Feedbuilder for the Micro Application. This implements the Feed Builder
  behavior.

  TODO: I think this still needs work and tests.
  """
  @behaviour Feed.Builder

  import Ecto.Query, only: [order_by: 2]

  @impl Feed.Builder
  def build_feed do
    # TODO: Move this into config file?
    %Feed{
      title: "Aliou's Micro blog",
      feed_url: "https://micro.aliou.me/feed.json",
      home_page_url: "https://micro.aliou.me"
    }
  end

  @impl Feed.Builder
  def build_items do
    fetch_posts()
    |> Enum.map(&entry_from_post/1)
  end

  defp fetch_posts do
    Micro.Post |> order_by(desc: :inserted_at) |> Micro.Repo.all()
  end

  defp entry_from_post(post) do
    content_html = Micro.Post.content_to_html(post)
    date_modified =
      if post.inserted_at != post.updated_at, do: post.updated_at, else: nil

      %Feed.Item{
        id: post.id,
        content_html: content_html,
        date_published: post.inserted_at,
        date_modified: date_modified
      }
  end
end
