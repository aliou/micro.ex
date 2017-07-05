defmodule MicroTest do
  use ExUnit.Case, async: true
  use Plug.Test

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Micro.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(Micro.Repo, {:shared, self()})
  end

  @lint false
  describe "GET /p/:id" do
    test "it returns a 404 when the post is not found" do
      id = Ecto.UUID.generate()
      path = "/p/" <> id
      conn = conn(:get, path) |> Micro.Router.call([])

      assert conn.status == 404
    end

    test "it returns 200 and the HTML version of the body when the post is found" do
      content = Faker.Lorem.sentence
      post =
        %Micro.Post{}
        |> Micro.Post.changeset(%{content: content})
        |> Micro.Repo.insert!()

      path = "/p/" <> post.id
      conn = conn(:get, path) |> Micro.Router.call([])

      assert conn.status == 200
      assert conn.resp_body == Micro.Post.content_to_html(post)
    end
  end
end
