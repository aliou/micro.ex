defmodule Feed do
  @moduledoc """
  Defines a Feed. By default we use the version 1, and require the feed title
  following the spec.
  """

  @enforce_keys [:title]
  @default_feed_version "https://jsonfeed.org/version/1"

  defstruct [
    :title,
    version: @default_feed_version,
    home_page_url: nil,
    feed_url: nil,
    items: []
  ]

  @type t :: %__MODULE__{
          version: String.t(),
          title: String.t(),
          home_page_url: String.t(),
          feed_url: String.t(),
          items: [Feed.Item.t()]
        }
end

# Remove the nil values from the JSON representation of the Feed.
defimpl Poison.Encoder, for: Feed do
  def encode(feed, options) do
    feed
    |> Map.from_struct()
    |> Enum.reject(fn {_, v} -> is_nil(v) end)
    |> Map.new()
    |> Poison.Encoder.encode(options)
  end
end
