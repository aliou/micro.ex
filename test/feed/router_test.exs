defmodule Feed.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  defmodule TestFeedBuilder do
    @behaviour Feed.Builder

    def build_feed do
      %Feed{
        title: Faker.Lorem.sentence(),
        feed_url: Faker.Internet.url(),
        home_page_url: Faker.Internet.url()
      }
    end

    def build_items, do: []
  end

  @invalid_options Feed.Router.init([])
  @valid_options Feed.Router.init(feed_builder: TestFeedBuilder)

  describe ".call/2" do
    test "it raises when the feed builder option is missing" do
      conn = conn(:get, "/")

      assert_raise KeyError, ~r/key :feed_builder not found in/, fn ->
        Feed.Router.call(conn, @invalid_options)
      end
    end

    test "it stores the feed builder in the conn when present" do
      conn = conn(:get, "/")
      conn = Feed.Router.call(conn, @valid_options)

      assert conn.private.feed_builder == TestFeedBuilder
    end
  end

  describe "GET /" do
    test "it returns the top level attributes of a feed" do
      top_level_key = ["title", "feed_url", "home_page_url"]

      conn = conn(:get, "/")
      conn = Feed.Router.call(conn, @valid_options)

      {:ok, parsed_body} = Poison.decode(conn.resp_body)

      key_in_feed = fn key -> Map.has_key?(parsed_body, key) end
      assert Enum.all?(top_level_key, key_in_feed)
    end
  end
end
