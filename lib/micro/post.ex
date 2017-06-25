defmodule Micro.Post do
  @moduledoc """
  Schema representing a post in the database.
  For now, we store the content in Markdown. Down the line, we might store the
  HTML representation as well.
  """

  use Ecto.Schema

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
end
