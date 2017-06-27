defmodule Micro.Post do
  @moduledoc """
  Schema representing a post in the database.
  For now, we store the content in Markdown. Down the line, we might store the
  HTML representation as well.
  """

  use Ecto.Schema

  @derive {Poison.Encoder, only: [:id, :content]}
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "posts" do
    field :content, :string
    timestamps()
  end

  def changeset(post, params \\ %{}) do
    post
    |> Ecto.Changeset.cast(params, [:content])
    |> Ecto.Changeset.validate_required([:content])
  end

  # TODO: Figure out a more "Elixiry" way to do this.
  @spec content_to_html(Micro.Post) :: String.t
  def content_to_html(post) do
    Cmark.to_html(post.content)
  end
end
