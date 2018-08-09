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
    field :slug, :string
    timestamps()
  end

  def changeset(post, params \\ %{}) do
    post
    |> Ecto.Changeset.cast(params, [:content, :slug])
    |> Ecto.Changeset.validate_required([:content])
    |> Ecto.Changeset.validate_length(:slug, max: 25)
    |> Micro.Changeset.nullable_unique_constraint(:slug)
  end

  # TODO: Figure out a more "Elixiry" way to do this.
  @spec content_to_html(Micro.Post) :: String.t()
  def content_to_html(post) do
    Earmark.as_html!(post.content)
  end
end
