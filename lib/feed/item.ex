defmodule Feed.Item do
  @moduledoc """
  Defines a Feed entry. By default, we require the id and the content in HTML,
  following the spec.
  """

  @enforce_keys [:id, :content_html]

  defstruct [
    :id,
    :content_html,
    url: nil,
    external_url: nil,
    title: nil,
    content_text: nil,
    summary: nil,
    date_published: nil,
    date_modified: nil,
    author: nil,
    tags: []
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          url: String.t(),
          external_url: String.t(),
          title: String.t(),
          content_html: String.t(),
          content_text: String.t(),
          summary: String.t(),
          date_published: DateTime.t(),
          date_modified: DateTime.t(),
          tags: [String.t()]
        }
end

# Remove the nil values from the JSON representation of the Feed entry.
defimpl Poison.Encoder, for: Feed.Item do
  def encode(item, options) do
    date_published = format_date(item.date_published)
    date_modified = format_date(item.date_modified)

    item
    |> Map.from_struct()
    |> Map.put(:date_published, date_published)
    |> Map.put(:date_modified, date_modified)
    |> Enum.reject(fn {_, v} -> is_nil(v) end)
    |> Map.new()
    |> Poison.Encoder.encode(options)
  end

  defp format_date(nil), do: nil

  defp format_date(date) do
    {:ok, formatted_date} =
      date
      |> DateTime.from_naive!("Etc/UTC")
      |> Feed.RFC3339.format()

    formatted_date
  end
end
