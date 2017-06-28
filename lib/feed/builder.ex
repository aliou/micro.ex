defmodule Feed.Builder do
  @moduledoc """
  Behaviour defining what is a Feed builder
  """

  @callback build_entries() :: [Feed.Entry.t]

  @callback build_feed() :: Feed.t
end
