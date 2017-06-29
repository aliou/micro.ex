defmodule Feed.Builder do
  @moduledoc """
  Behaviour defining what is a Feed builder
  """

  @callback build_items() :: [Feed.Item.t]

  @callback build_feed() :: Feed.t
end
