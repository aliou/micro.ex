defmodule Micro.Api.AuthorizedRequestPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @valid_api_key "hey"
  @invalid_api_key "nope"

  defmodule TestRouter do
    use Plug.Router

    @valid_api_key "hey"

    plug Micro.Api.AuthorizedRequestPlug, api_key: @valid_api_key
    plug :match
    plug :dispatch

    get "/" do
      conn
      |> send_resp(200, "")
    end
  end

  @options TestRouter.init([])

  test "returns 403 when missing the api key" do
    conn = conn(:get, "/", "")
    conn = TestRouter.call(conn, @options)

    assert conn.status == 403
  end

  test "returns 403 when the api key is incorrect" do
    conn = conn(:get, "/")
    conn = conn
           |> put_req_header("authorization", @invalid_api_key)
           |> TestRouter.call(@options)

    assert conn.status == 403
  end

  test "returns 200 when the api key correct" do
    conn = conn(:get, "/")
    conn = conn
           |> put_req_header("authorization", @valid_api_key)
           |> TestRouter.call(@options)

    assert conn.status == 200
  end
end
