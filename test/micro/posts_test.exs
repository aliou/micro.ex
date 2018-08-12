defmodule Micro.PostsTest do
  use ExUnit.Case, async: true

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Micro.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(Micro.Repo, {:shared, self()})

    :ok
  end

  describe "friendly_find/2" do
    test "returns the post with the given uuid" do
      id = Ecto.UUID.generate()
      post = insert_post(%{id: id, content: Faker.Lorem.sentence()})

      assert Micro.Posts.friendly_find(id) == {:ok, post}
    end

    test "returns the post with the given slug" do
      slug = Faker.Lorem.word()
      post = insert_post(%{slug: slug, content: Faker.Lorem.sentence()})

      assert Micro.Posts.friendly_find(slug) == {:ok, post}
    end

    test "returns an error when the post does not exist" do
      id = Ecto.UUID.generate()

      assert Micro.Posts.friendly_find(id) == :not_found
    end

    # NOTE: The database prevents us from this case.
    # test "returns the post with the give term as id in priority" do
    #   slug = Ecto.UUID.generate()
    #   post_slug = insert_post(%{slug: slug, content: Faker.Lorem.sentence()})
    #   post_id = insert_post(%{id: slug, content: Faker.Lorem.sentence()})

    #   assert Micro.Posts.friendly_find(slug) == post_id
    # end
  end

  defp insert_post(attributes) do
    Ecto.Changeset.change(%Micro.Post{}, attributes) |> Micro.Repo.insert!()
  end
end
