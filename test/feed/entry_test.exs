defmodule Feed.ItemTest do
  use ExUnit.Case, async: true

  describe ".encode/2" do
    test "it encodes the feed without the nil attributes" do
      id = Faker.Code.isbn
      content_html = Faker.Lorem.sentence
      feed = %Feed.Item{id: id, content_html: content_html}

      nil_attributes =
        feed
        |> Map.from_struct
        |> Enum.filter(fn {_, v} -> is_nil(v) end)
        |> Map.new
        |> Map.keys

      {:ok, encoded_feed} = Poison.encode(feed)
      {:ok, decoded_feed} = Poison.decode(encoded_feed)

      key_not_in_decoded_feed = fn(key) -> !Map.has_key?(decoded_feed, key) end

      assert Enum.all?(nil_attributes, key_not_in_decoded_feed)
    end
  end
end
