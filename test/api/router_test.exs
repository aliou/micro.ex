defmodule Micro.Api.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @options Micro.Api.Router.init([])
  @valid_api_key "hey"

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Micro.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(Micro.Repo, {:shared, self()})
  end

  describe "POST /" do
    test "it creates a post when the required params are present" do
      post_params = Poison.encode!(%{content: Faker.Lorem.sentence})
      conn = conn(:post, "/", post_params)

      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put_req_header("authorization", @valid_api_key)
        |> Micro.Api.Router.call(@options)

      assert conn.state == :sent
      assert conn.status == 201
    end

    test "it doesn't create a post when the required params are missing" do
      conn = conn(:post, "/", ~s({}))

      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put_req_header("authorization", @valid_api_key)
        |> Micro.Api.Router.call(@options)

      assert conn.state == :sent
      assert conn.status == 422
    end
  end
end
