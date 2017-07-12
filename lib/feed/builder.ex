defmodule Feed.Builder do
  @moduledoc """
  Behaviour for creating a Feed builder.

  ## Example
        defmodule Feed.CustomBuilder do
          @behaviour Feed.Builder

          @impl Feed.Builder
          def build_feed do
            %Feed{
              title: "My Custom Feed",
            }
          end

          @impl Feed.Builder
          def build_items do
            [
              %Feed.Item{
                id: "this-is-an-id",
                content_html: "<h1>This a some content</h1>"
              }
            ]
          end
        end
  """

  @callback build_items() :: [Feed.Item.t]

  @callback build_feed() :: Feed.t
end
