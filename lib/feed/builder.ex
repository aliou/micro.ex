defmodule Feed.Builder do
  @moduledoc """
  Behaviour defining what is a Feed builder
  """

  @callback build_entries() :: [Feed.Item.t]

  @callback build_feed() :: Feed.t
end
